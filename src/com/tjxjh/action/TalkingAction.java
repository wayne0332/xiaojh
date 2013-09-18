package com.tjxjh.action;


import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import cn.cafebabe.autodao.pojo.Page;
import com.tjxjh.auth.AuthEnum;
import com.tjxjh.enumeration.UserStatus;
import com.tjxjh.po.Talking;
import com.tjxjh.po.User;
import com.tjxjh.pojo.IndexTalking;
import com.tjxjh.service.TaklingAndMerchantNewsUpload;
import com.tjxjh.service.TalkingCommentService;
import com.tjxjh.service.TalkingService;
import com.tjxjh.util.Auth;
import com.tjxjh.util.GetRequsetResponse;


@ParentPackage("struts-default")
@Namespace("/")
public class TalkingAction extends BaseAction
{
	private static final long serialVersionUID = 1L;
	protected final static String UPLOAD_IMAGE_PATH="/upload/images/";
	private static final String ERROR_PAGE=FOREPART+"success.jsp";
	protected HttpServletRequest request=ServletActionContext.getRequest();
	private List<IndexTalking> taks=new ArrayList<IndexTalking>();
	private Talking talking=new Talking();
	private Talking origntalking=new Talking();
	private User user=new User();
	
	private Integer talkingid;
	@Resource
	private TalkingService talkingService = null;
	private String message;//提示信息
	
	//分页信息
	private Page page;
	private Integer eachPageNumber=6;
	private Integer currentPage=1;
	private Integer totalPageNumber=0;
	private String actionName="myTalking";
	
	//图片上传
	private File uploadImage;
	private String uploadImageFileName;// 文件名
	private String uploadImageContentType;// 文件类型
	@Resource
	private TalkingCommentService talkingCommentService = null;
	@Action(value = "addTalking", results = {
	@Result(name = SUCCESS, type = REDIRECT_ACTION,location ="/userCenter"),
	@Result(name = INPUT, location = ERROR_PAGE),
	@Result(name = ERROR, location = ERROR_PAGE)})
	public String add()
	{
		user=Auth.getUserFromSession();
		talking.setUser(user);
		boolean flage=TaklingAndMerchantNewsUpload.upload(talking, null, uploadImage, UPLOAD_IMAGE_PATH, uploadImageFileName);
		if(!flage){
			message="媒体上传失败！";
			return ERROR;
		}
		if(talkingService.add(talking))
		{
			message="发表成功";
			return SUCCESS;
		}
		return ERROR;
	}
	//根据user id查找未删除的说说
	@Action(value = "talking", results = {
	@Result(name = SUCCESS, location = BaseAction.FOREPART + "myTalking.jsp"),
	@Result(name = INPUT, location = ERROR_PAGE)})
	public String talking()
	{
		if(user==null||user.getId()==null){
			user=Auth.getUserFromSession();
		}
		page=talkingService.getMyPageByHql(user,eachPageNumber,currentPage,totalPageNumber);
		List<Talking> temp = talkingService.findMyTalkingByHql(page,user);
		for(Talking t:temp){
			IndexTalking it=new IndexTalking();
			it.setTcs(talkingCommentService.findByHql(t.getId()));
			it.setT(t);
			taks.add(it);
		}
		actionName="talking";
		return SUCCESS;
	}
	@Action(value = "relativeTalking", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "myTalking.jsp"),
			@Result(name = INPUT, location = ERROR_PAGE)})
			public String relativeTalking()
			{
				//根据user id查找未删除的说说
				user=Auth.getUserFromSession();
				page=talkingService.getRelativePageByHql(user,eachPageNumber,currentPage,totalPageNumber);
				List<Talking> temp =talkingService.findRelativeTalkingByHql(page,user);
				for(Talking t:temp){
					IndexTalking it=new IndexTalking();
					it.setTcs(talkingCommentService.findByHql(t.getId()));
					it.setT(t);
					taks.add(it);
				}
				actionName="relativeTalking";
				return SUCCESS;
			}
	
	@Action(value = "allTalking", results = {
			@Result(name = SUCCESS, location = BaseAction.MANAGE + "allTalking.jsp"),
			@Result(name = INPUT, location = ERROR_PAGE)})
			public String allTalking()
			{
				user=Auth.getUserFromSession();
				page=talkingService.getAllPageByHql(eachPageNumber,currentPage,totalPageNumber);
				page=talkingService.getRelativePageByHql(user,eachPageNumber,currentPage,totalPageNumber);
				List<Talking> temp =talkingService.findAllTalkingByHql(page);
				for(Talking t:temp){
					IndexTalking it=new IndexTalking();
					it.setTcs(talkingCommentService.findByHql(t.getId()));
					it.setT(t);
					taks.add(it);
				}
				actionName="allTalking";
				return SUCCESS;
			}
	
			@Action(value = "preShareTalking", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "shareTalking.jsp"),
			@Result(name = INPUT, location = ERROR_PAGE)})
			@com.tjxjh.annotation.Auth(auths={AuthEnum.NO_NEED})
			public String preShare()
			{
				origntalking=talkingService.preShare(talking.getId(),Auth.getUserFromSession().getId());
				if(origntalking!=null)
				{
					return SUCCESS;
				}
				message="分享失败！不能分享自己的说说";
				return SUCCESS;
				
			}
			@Action(value = "shareTalking", results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION,location ="/allTalking"),
			@Result(name = INPUT, location = ERROR_PAGE)})
			public String shareTalking()
			{
				origntalking.setId(talkingid);
				talking.setTalking(origntalking);
				user=Auth.getUserFromSession();
				talking.setUser(user);
				if(talkingService.add(talking))
				{
					message="分享成功";
					return SUCCESS;
				}
				message="分享失败";
				return SUCCESS;
				
			}
	
			@Action(value = "deleteTalking", results = {
			})
			public String deleteTalking()
			{
				PrintWriter out =GetRequsetResponse.getAjaxPrintWriter();
				user=Auth.getUserFromSession();
				if(Auth.getUserFromSession().getStatus()!=UserStatus.ADMIN){
					talking=talkingService.findByHql(new Object[]{user.getId(),talking.getId()});
				}else{
					talking=talkingService.findById(talking.getId());
				}
				talking=talkingService.delete(talking);
				if(talking!=null){
					out.print("true");
					out.flush();
					out.close();
					return null;
				}else{
					out.print("");
					out.flush();
					out.close();
					return null;
				}
			}
			@Action(value = "zanTalking", results = {
			})
			public String zanTalking()
			{
				PrintWriter out =GetRequsetResponse.getAjaxPrintWriter();
				if(talkingService.getZanCookie(talking)==-1){
					out.print(-1);
					out.flush();
					out.close();
					return null;
				}
				Integer i=talkingService.zan(talking);
				talkingService.addZanCookie(talking);
					out.print(i);
					out.flush();
					out.close();
					return null;
			}
			@Action(value = "deletezan", results = {
			})
			public String deletezan()
			{
				PrintWriter out =GetRequsetResponse.getAjaxPrintWriter();
				Integer i=talkingService.deletezan(talking);
				talkingService.deleteZanCookie(talking);
					out.print(i);
					out.flush();
					out.close();
					return null;
			}
			
		
	public TalkingService getTalkingService() {
		return talkingService;
	}
	public void setTalkingService(TalkingService talkingService) {
		this.talkingService = talkingService;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public Integer getEachPageNumber() {
		return eachPageNumber;
	}
	public void setEachPageNumber(Integer eachPageNumber) {
		this.eachPageNumber = eachPageNumber;
	}
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public Integer getTotalPageNumber() {
		return totalPageNumber;
	}
	public void setTotalPageNumber(Integer totalPageNumber) {
		this.totalPageNumber = totalPageNumber;
	}
	public Talking getTalking() {
		return talking;
	}
	public void setTalking(Talking talking) {
		this.talking = talking;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public File getUploadImage() {
		return uploadImage;
	}
	public void setUploadImage(File uploadImage) {
		this.uploadImage = uploadImage;
	}
	public String getUploadImageFileName() {
		return uploadImageFileName;
	}
	public void setUploadImageFileName(String uploadImageFileName) {
		this.uploadImageFileName = uploadImageFileName;
	}
	public String getUploadImageContentType() {
		return uploadImageContentType;
	}
	public void setUploadImageContentType(String uploadImageContentType) {
		this.uploadImageContentType = uploadImageContentType;
	}
	public Integer getTalkingid() {
		return talkingid;
	}

	public void setTalkingid(Integer talkingid) {
		this.talkingid = talkingid;
	}

	

	public Talking getOrigntalking() {
		return origntalking;
	}

	public void setOrigntalking(Talking origntalking) {
		this.origntalking = origntalking;
	}

	public String getActionName() {
		return actionName;
	}

	public void setActionName(String actionName) {
		this.actionName = actionName;
	}


	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	public List<IndexTalking> getTaks() {
		return taks;
	}
	public void setTaks(List<IndexTalking> taks) {
		this.taks = taks;
	}
	public TalkingCommentService getTalkingCommentService() {
		return talkingCommentService;
	}
	public void setTalkingCommentService(TalkingCommentService talkingCommentService) {
		this.talkingCommentService = talkingCommentService;
	}
	
	
}
