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

import com.tjxjh.enumeration.TalkingUrlType;
import com.tjxjh.po.Club;
import com.tjxjh.po.ClubNews;
import com.tjxjh.po.Talking;
import com.tjxjh.po.User;
import com.tjxjh.pojo.ClubNewsList;
import com.tjxjh.service.ClubNewsService;
import com.tjxjh.service.TalkingService;
import com.tjxjh.util.Auth;


@ParentPackage("struts-default")
@Namespace("/")
public class ClubNewsAction extends BaseAction{
	protected final static String UPLOAD_IMAGE_PATH="/upload/images/";
	private static final long serialVersionUID = 1L;
	
	private File uploadImage;
	private String uploadImageFileName;// 文件名
	//上传视频
	private File uploadVideo;
	private String uploadVideoFileName;// 文件名
	
	protected HttpServletRequest request=ServletActionContext.getRequest();
	private ClubNews  clubnews=new ClubNews();
	private Club club =new Club();
	private List<ClubNews> cns=new ArrayList<ClubNews>();
	@Resource
	private ClubNewsService clubNewsService = null;
	@Resource
	private TalkingService talkingService = null;
	private String message;//提示信息
	private Page page;
	private int pageNum;
	private Integer eachPageNumber=8;
	private Integer currentPage=1;
	private Integer totalPageNumber=0;
	User user=new User();
	private String actionName;
	/**
	 * 社团新闻尚未关联到说关联的虚拟用户
	 * 发布社团新闻action
	 * 执行功能：上传图片，缩放，裁剪生成缩略图
	 * 
	 * 
	 * @return
	 * @throws Exception
	 */
	@Action(value = "addClubNews", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "success.jsp")})
	public String add(){
		club=Auth.getCluFromSession ();
		//user=Auth.getUserFromSession();
		boolean upimg=clubNewsService.uploadImage(clubnews,uploadImage, uploadImageFileName, UPLOAD_IMAGE_PATH+uploadImageFileName);
		clubNewsService.uploadVideo(clubnews,uploadVideo, uploadVideoFileName, UPLOAD_IMAGE_PATH+uploadVideoFileName);
		if(upimg){
			clubnews.setClub(club);
			Talking talking=clubNewsService.initTalking(clubnews, club.getUser());
			clubNewsService.add(talking,clubnews);
			message="上传成功";
			return SUCCESS;
		}else{
			message="上传失败,图片不允许为空";
			return ERROR;
		}
	}
	@Action(value = "allClubNews", results = {
			@Result(name = SUCCESS,location = MANAGE+"allClubNews.jsp")})
	public String allClubNews(){
		Page page = new Page(pageNum*Page.getDefaultPageNumber()+1);
		page.setCurrentPage(pageNum);
		ClubNewsList clubNewsList = new ClubNewsList();
		clubNewsList.setClubNewsList(clubNewsService.allClubNews(page));
		clubNewsList.setPage(clubNewsService.clubNewsNum(page));
		for(ClubNews c:clubNewsList.getClubNewsList()){
			c.getClub().getName();
		}
		getRequestMap().put("clubNewsList", clubNewsList);
		return SUCCESS;
	}
	//根据用户所在社团，查出社团发布的clubnews
	@Action(value = "myClubNews", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "myClubNews.jsp")})
	public String findMyClubNews(){
		user=Auth.getUserFromSession();
		page=clubNewsService.getMyPageByHql(user,eachPageNumber,currentPage,totalPageNumber);
		cns=clubNewsService.findMyClubNewsByHql(page,user);
		actionName="myClubNews";
		return SUCCESS;
		
	}
	//查询某个社团的clubnews
	@Action(value = "oneClubNews", results = {
				@Result(name = SUCCESS, location = BaseAction.FOREPART + "myClubNews.jsp")})
		public String findOneClubNews(){
			if(club==null||club.getId()==null){
				club=Auth.getCluFromSession ();
			}
			page=clubNewsService.getOneClubPageByHql(eachPageNumber,currentPage,club,totalPageNumber);
			cns=clubNewsService.findOneClubNewsByHql(page,club);
			actionName="oneClubNews";
			return SUCCESS;
			
		}
	//管理员查看所在社团的clubnews,可以修、删除
		@Action(value = "adminFindOneClubNews", results = {
					@Result(name = SUCCESS, location = BaseAction.FOREPART + "myClubNews.jsp")})
			public String adminFindOneClubNews(){
				findOneClubNews();
				actionName="adminFindOneClubNews";
				return SUCCESS;
				
		}
		//管理员删除所在社团的Clubnews
		@Action(value = "deleteClubNews", results = {
				@Result(name = SUCCESS,type = REDIRECT_ACTION, location ="adminFindOneClubNews")})
			public String deleteClubNews(){
				user=Auth.getUserFromSession();
				clubnews=clubNewsService.findByHql(user, clubnews);
				if(clubnews!=null){
					clubNewsService.delete(clubnews);
				}
				actionName="adminFindOneClubNews";
				return SUCCESS;
						
		}
		//后台管理方法
		@Action(value = "adminDeleteClubNews", results = {
				@Result(name = SUCCESS,type = REDIRECT_ACTION, location ="allClubNews", params={"pageNum","${pageNum}"})})
			public String adminDeleteClubNews(){
				user=Auth.getUserFromSession();
				clubnews=clubNewsService.findByHql(user, clubnews);
				if(clubnews!=null){
					clubNewsService.delete(clubnews);
				}
				return SUCCESS;
						
		}
		//管理员修改社团发布的Clubnews
		@Action(value = "preModifyClubNews", results = {
				@Result(name = SUCCESS, location = BaseAction.FOREPART + "modifyClubNews.jsp")})
			public String preModifyClubNews(){
				user=Auth.getUserFromSession();
				clubnews=clubNewsService.findByHql(user, clubnews);
				if(clubnews!=null){
					return SUCCESS;
				}
				else{
					return ERROR;
				}
				
			}	
		//管理员修改社团发布的Clubnews 说说user 应改为社团对应的user
		@Action(value = "modifyClubNews", results = {
				@Result(name = SUCCESS,type = REDIRECT_ACTION, location ="adminFindOneClubNews")})
			public String modifyClubNews(){
			user=Auth.getUserFromSession();
			ClubNews oldclubnews=clubNewsService.findByHql(user, clubnews);
			if(oldclubnews==null){
				return ERROR;
			}
			boolean upimg=clubNewsService.uploadImage(clubnews,uploadImage, uploadImageFileName, UPLOAD_IMAGE_PATH+uploadImageFileName);
			clubNewsService.uploadVideo(clubnews,uploadVideo, uploadVideoFileName, UPLOAD_IMAGE_PATH+uploadVideoFileName);
			if(upimg){
				Talking talking=new Talking();
				talking=oldclubnews.getTalking();
				talking.setText(clubnews.getTittle());
				if(clubnews.getVideoUrl()==null||clubnews.getVideoUrl().equals("")){
					talking.setUrl(clubnews.getTitleImgPath());
					talking.setUrlType(TalkingUrlType.PICTURE);
				}else{
					talking.setUrl(clubnews.getVideoUrl());
					talking.setUrlType(TalkingUrlType.VIDEO);
				}
				clubnews.setClub(oldclubnews.getClub());
				clubnews.setTalking(talking);
				clubnews.setDatetime(oldclubnews.getDatetime());
				clubNewsService.update(talking,clubnews);
				return SUCCESS;
			}else{
				message="上传失败,图片不允许为空";
				return ERROR;
			}
		}	
	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public ClubNews getClubnews() {
		return clubnews;
	}

	public void setClubnews(ClubNews clubnews) {
		this.clubnews = clubnews;
	}

	public Club getClub() {
		return club;
	}

	public void setClub(Club club) {
		this.club = club;
	}

	public File getUploadImage() {
		return uploadImage;
	}
	public void setUploadImage(File uploadImage) {
		this.uploadImage = uploadImage;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getUploadImageFileName() {
		return uploadImageFileName;
	}
	public void setUploadImageFileName(String uploadImageFileName) {
		this.uploadImageFileName = uploadImageFileName;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
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

	public ClubNewsService getClubNewsService() {
		return clubNewsService;
	}

	public void setClubNewsService(ClubNewsService clubNewsService) {
		this.clubNewsService = clubNewsService;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public TalkingService getTalkingService() {
		return talkingService;
	}

	public void setTalkingService(TalkingService talkingService) {
		this.talkingService = talkingService;
	}
	public List<ClubNews> getCns() {
		return cns;
	}
	public void setCns(List<ClubNews> cns) {
		this.cns = cns;
	}
	public String getActionName() {
		return actionName;
	}
	public void setActionName(String actionName) {
		this.actionName = actionName;
	}
	

}
