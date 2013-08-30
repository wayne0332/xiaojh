package com.tjxjh.action;

import java.io.File;
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

import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.OnlineActivity;
import com.tjxjh.po.Talking;
import com.tjxjh.po.User;
import com.tjxjh.service.ClubService;
import com.tjxjh.service.MerchantService;
import com.tjxjh.service.OnlineActivityService;
import com.tjxjh.service.TalkingService;
import com.tjxjh.util.Auth;


@ParentPackage("struts-default")
@Namespace("/")
public class OnlineActivityAction extends BaseAction{
	protected final static String UPLOAD_IMAGE_PATH="/upload/images/";
	private static final long serialVersionUID = 1L;
	
	private File uploadImage;
	private String uploadImageFileName;// 文件名
	//上传视频
	private File uploadVideo;
	private String uploadVideoFileName;// 文件名
	
	protected HttpServletRequest request=ServletActionContext.getRequest();
	private OnlineActivity  onlineactivity=new OnlineActivity();
	private Merchant merchant=new Merchant();
	private Club club;
	private List<OnlineActivity> oacs=new ArrayList<OnlineActivity>();
	@Resource
	private	OnlineActivityService onlineActivityService = null;
	@Resource
	private TalkingService talkingService = null;
	@Resource
	private MerchantService merchantService=null;
	@Resource
	private ClubService ClubService=null;
	private String message;//提示信息
	
	private Page page;
	private Integer eachPageNumber=4;
	private Integer currentPage=1;
	private Integer totalPageNumber=0;
	User user=new User();
	private String actionName;
	/**
	 * 活动尚未关联到社团对应的虚拟用户
	 * 社团、商家发布活动 action
	 * 执行功能：上传图片，缩放，裁剪生成缩略图
	 * 
	 * 
	 * @return
	 * @throws Exception
	 */
	@Action(value = "addOnlineActivity", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "success.jsp")})
	public String add(){
		merchant=Auth.getMerchantFromSession();
		user=Auth.getUserFromSession();
		boolean upimg=onlineActivityService.uploadImage(onlineactivity,uploadImage, uploadImageFileName, UPLOAD_IMAGE_PATH+uploadImageFileName);
		onlineActivityService.uploadVideo(onlineactivity,uploadVideo, uploadVideoFileName, UPLOAD_IMAGE_PATH+uploadVideoFileName);
		if(upimg){
			if(merchant!=null&&merchant.getId()!=null){
				merchant=merchantService.merchantById(merchant);
				onlineactivity.setUser(merchant.getUser());
			}
			else if(club!=null&&club.getId()!=null&&Auth.hasRole()){
				club=ClubService.clubById(club);
				onlineactivity.setUser(club.getUser());
			}
			else if(user!=null&&user.getId()!=null){
				onlineactivity.setUser(user);
			}else {
				return ERROR;
			} 
			Talking talking=onlineActivityService.initTalking(onlineactivity,onlineactivity.getUser());
			onlineActivityService.add(talking,onlineactivity);
			return SUCCESS;
		}else{
			message="图片上传失败,图片不允许为空";
			return ERROR;
		}
	}
	@Action(value = "preAddonlineActivity", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "addOnlineActivity.jsp")})
	public String preAddOnlineActivityById(){
		if(club!=null&&club.getId()!=null){
			return SUCCESS;
		}return ERROR;
		
}
	//根据用户所在社团，所关注的社团，关注的商家 查出发布的OnlingActivity, 尚未添加关注的用户活动
		@Action(value = "relativeOnlineActivity", results = {
				@Result(name = SUCCESS, location = BaseAction.FOREPART + "myOnlineActivity.jsp")})
		public String findRelativeOnlineActivity(){
			user=Auth.getUserFromSession();
			page=onlineActivityService.getRelativeOnlineActivityPageByHql(user,eachPageNumber,currentPage,totalPageNumber);
			oacs=onlineActivityService.findRelativeOnlineActivityByHql(page,user);
			actionName="relativeOnlineActivity";
			return SUCCESS;
			
		}

	@Action(value = "getOnlineActivityById", results = {
				@Result(name = SUCCESS, location = BaseAction.FOREPART + "onlineActivity.jsp")})
		public String getOnlineActivityById(){
			onlineactivity=onlineActivityService.findById(onlineactivity.getId());
			return SUCCESS;
	}
	//根据商家用户id，社团用户id，用户id查找在线活动
	@Action(value = "findOnlineActivity", results = {
				@Result(name = SUCCESS, location = BaseAction.FOREPART + "myOnlineActivity.jsp")})
	public String findOnlineActivity(){
		merchant=Auth.getMerchantFromSession();
		user=Auth.getUserFromSession();
		pageAndoacs();
		actionName="findOnlineActivity";
		return SUCCESS;
	}
	//商家，社团 用户 查找在线活动,需要添加拦截器
		@Action(value = "userOnlineActivity", results = {
					@Result(name = SUCCESS, location = BaseAction.FOREPART + "myOnlineActivity.jsp")})
		public String userOnlineActivity(){
			user=Auth.getUserFromSession();
			club=Auth.getCluFromSession ();
			merchant=Auth.getMerchantFromSession();
			pageAndoacs();
			actionName="userOnlineActivity";
			return SUCCESS;
		}
		//校江湖管理员根据id查找在线活动
		@Action(value = "adminOnlineActivity", results = {
					@Result(name = SUCCESS, location = BaseAction.FOREPART + "myOnlineActivity.jsp")})
		public String adminOnlineActivity(){
//			user.setId(1);
//			club.setId(1);
			merchant.setId(1);
			pageAndoacs();
			actionName="adminOnlineActivity";
			return SUCCESS;
		}

	//社团管理员、商家、用户删除所在社团的onlineActivity
	@Action(value = "deleteOnlineActivity", results = {
			@Result(name = SUCCESS,type = REDIRECT_ACTION, location ="userOnlineActivity")})
		public String deleteClubNews(){
			user=Auth.getUserFromSession();
			merchant=Auth.getMerchantFromSession();
			club=Auth.getCluFromSession ();
			onlineactivity=onlineActivityService.findByHql(user,merchant,club,onlineactivity);
			if(onlineactivity!=null){
				onlineActivityService.delete(onlineactivity);
			}
			return SUCCESS;
	}	
	//管理员、商家 、社团 修改社团发布的Activity
	@Action(value = "preModifyOnlineActivity", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "modifyOnlineActivity.jsp")})
		public String preModifyOnlineActivity(){
			user=Auth.getUserFromSession();
			merchant=Auth.getMerchantFromSession();
			club=Auth.getCluFromSession ();
			onlineactivity=onlineActivityService.findByHql(user,merchant,club,onlineactivity);
			return SUCCESS;
	}	
	//校江湖挂了员、商家 、社团管理员 修改社团发布的OnlineActivity
		@Action(value = "modifyOnlineActivity", results = {
				@Result(name = SUCCESS, location = BaseAction.FOREPART + "myOnlineActivity.jsp")})
			public String modifyOnlineActivity(){
				user=Auth.getUserFromSession();
				merchant=Auth.getMerchantFromSession();
				club=Auth.getCluFromSession ();
				OnlineActivity oldonlineactivity=onlineActivityService.findByHql(user,merchant,club,onlineactivity);
				if(oldonlineactivity==null){
					return ERROR;
				}
				boolean upimg=onlineActivityService.uploadImage(onlineactivity,uploadImage, uploadImageFileName, UPLOAD_IMAGE_PATH+uploadImageFileName);
				onlineActivityService.uploadVideo(onlineactivity,uploadVideo, uploadVideoFileName, UPLOAD_IMAGE_PATH+uploadVideoFileName);
				if(!upimg){
					return ERROR;
				}
				onlineactivity.setId(oldonlineactivity.getId());
				onlineactivity.setTalking(oldonlineactivity.getTalking());
				onlineactivity.setPraiseCount(oldonlineactivity.getPraiseCount());
				onlineactivity.setDatetime(oldonlineactivity.getDatetime());
				onlineactivity.setHeat(oldonlineactivity.getHeat());
				onlineactivity.setParticipantCount(oldonlineactivity.getParticipantCount());
				onlineactivity.setUser(oldonlineactivity.getUser());
				Talking talking=new Talking();
				talking=onlineActivityService.initTalking(onlineactivity,oldonlineactivity.getTalking());
				onlineActivityService.update(talking,onlineactivity);
				return SUCCESS;
			}	
		
	private void pageAndoacs() {
		page=onlineActivityService.getOneOnlineActivityPageByHql(eachPageNumber,currentPage,totalPageNumber,club,merchant,user);
		oacs=onlineActivityService.findOneClubOnlineActivityByHql(page,club,merchant,user);
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
	public File getUploadVideo() {
		return uploadVideo;
	}
	public void setUploadVideo(File uploadVideo) {
		this.uploadVideo = uploadVideo;
	}
	public String getUploadVideoFileName() {
		return uploadVideoFileName;
	}
	public void setUploadVideoFileName(String uploadVideoFileName) {
		this.uploadVideoFileName = uploadVideoFileName;
	}
	public HttpServletRequest getRequest() {
		return request;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	public Merchant getMerchant() {
		return merchant;
	}
	public void setMerchant(Merchant merchant) {
		this.merchant = merchant;
	}
	public Club getClub() {
		return club;
	}
	public void setClub(Club club) {
		this.club = club;
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
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getActionName() {
		return actionName;
	}
	public void setActionName(String actionName) {
		this.actionName = actionName;
	}
	public OnlineActivity getOnlineactivity() {
		return onlineactivity;
	}
	public void setOnlineactivity(OnlineActivity onlineactivity) {
		this.onlineactivity = onlineactivity;
	}
	public OnlineActivityService getOnlineActivityService() {
		return onlineActivityService;
	}
	public void setOnlineActivityService(OnlineActivityService onlineActivityService) {
		this.onlineActivityService = onlineActivityService;
	}
	public MerchantService getMerchantService() {
		return merchantService;
	}
	public void setMerchantService(MerchantService merchantService) {
		this.merchantService = merchantService;
	}
	public ClubService getClubService() {
		return ClubService;
	}
	public void setClubService(ClubService clubService) {
		ClubService = clubService;
	}
	public List<OnlineActivity> getOacs() {
		return oacs;
	}
	public void setOacs(List<OnlineActivity> oacs) {
		this.oacs = oacs;
	}
	

}
