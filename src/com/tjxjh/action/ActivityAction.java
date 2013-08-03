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

import com.tjxjh.enumeration.ActivityStatus;
import com.tjxjh.po.Activity;
import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.Talking;
import com.tjxjh.po.User;
import com.tjxjh.service.ActivityService;
import com.tjxjh.service.TalkingService;
import com.tjxjh.util.Auth;


@ParentPackage("struts-default")
@Namespace("/")
public class ActivityAction extends BaseAction{
	protected final static String UPLOAD_IMAGE_PATH="/upload/images/";
	private static final long serialVersionUID = 1L;
	
	private File uploadImage;
	private String uploadImageFileName;// 文件名
	//上传视频
	private File uploadVideo;
	private String uploadVideoFileName;// 文件名
	
	protected HttpServletRequest request=ServletActionContext.getRequest();
	private Activity  activity=new Activity();
	private Merchant merchant =new Merchant();
	private Club club =new Club();
	private List<Activity> acs=new ArrayList<Activity>();
	@Resource
	private	ActivityService activityService = null;
	@Resource
	private TalkingService talkingService = null;
	private String message;//提示信息
	 //活动排序条件
	private String condition="datetime";
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
	 * 所有用户尚未从session中获取，直接关联到id为1的用户上
	 * @return
	 * @throws Exception
	 */
	@Action(value = "addActivity", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "success.jsp")})
	public String add(){
		club=Auth.getClubFromSession();
		merchant=Auth.getMerchantFromSession();
		user=Auth.getUserFromSession();
		boolean upimg=activityService.uploadImage(activity,uploadImage, uploadImageFileName, UPLOAD_IMAGE_PATH+uploadImageFileName);
		activityService.uploadVideo(activity,uploadVideo, uploadVideoFileName, UPLOAD_IMAGE_PATH+uploadVideoFileName);
		if(upimg){
			if(club!=null&&club.getId()!=null){
				activity.setClub(club);
			}else if(merchant!=null&&merchant.getId()!=null){
				activity.setMerchant(merchant);
			}else{
				return ERROR;
			} 
			Talking talking=new Talking();
			talking.setId(1);//尚未通过审核，系统默认说说
			activity.setTalking(talking);
			activityService.add(activity);
			return SUCCESS;
		}else{
			message="图片上传失败,图片不允许为空";
			return ERROR;
		}
	}
	//activityid 查找一个activity
			@Action(value = "activity", results = {
					@Result(name = SUCCESS, location = BaseAction.FOREPART + "activity.jsp")})
			public String activity(){
				activity=activityService.findById(activity.getId());
				return SUCCESS;
				
			}
	/**
	 * 校江湖管理人员发布的活动
	 * @return
	 */
	@Action(value = "addActivityByadmin", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "success.jsp")})
	public String addByAdmin(){
		//校江湖管理人员判断
		
		boolean upimg=activityService.uploadImage(activity,uploadImage, uploadImageFileName, UPLOAD_IMAGE_PATH+uploadImageFileName);
		activityService.uploadVideo(activity,uploadVideo, uploadVideoFileName, UPLOAD_IMAGE_PATH+uploadVideoFileName);
		if(upimg){
			Talking talking=activityService.initTalking(activity);//校江湖管理人员发布，用户id为1
			activityService.add(talking,activity);
			return SUCCESS;
		}else{
			message="图片上传失败,图片不允许为空";
			return ERROR;
		}
	}
	//根据用户所在社团，所关注的社团，关注的商家 查出发布的activity
	@Action(value = "myActivity", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "myActivity.jsp")})
	public String findMyActivity(){
		user=Auth.getUserFromSession();
		page=activityService.getMyActivityPageByHql(user,eachPageNumber,currentPage,totalPageNumber);
		acs=activityService.findMyActivityByHql(page,user,condition);
		actionName="myActivity";
		return SUCCESS;
		
	}
	//用户根据社团id，商家id 查出社团发布的activity 
	@Action(value = "oneActivity", results = {
				@Result(name = SUCCESS, location = BaseAction.FOREPART + "myActivity.jsp")})
		public String findOneActivity(){
			//club.setId(1);
			//merchant.setId(1);
			page=activityService.getOneClubPageByHql(eachPageNumber,currentPage,totalPageNumber,club,merchant);
			acs=activityService.findOneClubActivityByHql(page,club,merchant,condition);
			actionName="oneActivity";
			return SUCCESS;
			
	}
	//商家，管理人员根据社团id，查出社团发布的activity 需要添加拦截器，非管理人员不能查看
	@Action(value = "adminFindOneActivity", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "myActivity.jsp")})
		public String adminFindOneClubActivity(){
			//club=Auth.getClubFromSession();
			//merchant=Auth.getMerchantFromSession();
			page=activityService.adminGetOneClubPageByHql(eachPageNumber,currentPage,totalPageNumber,club,merchant);
			acs=activityService.adminFindOneClubActivityByHql(page,club,merchant,condition);
			actionName="adminFindOneActivity";
			return SUCCESS;
				
	}
	//管理员删除所在社团的Activity
	@Action(value = "deleteActivity", results = {
			@Result(name = SUCCESS,type = REDIRECT_ACTION, location ="adminFindOneActivity")})
		public String deleteClubNews(){
			user=Auth.getUserFromSession();
			merchant=Auth.getMerchantFromSession();
			activity=activityService.findByHql(user,merchant, activity);
			activityService.delete(activity);
			return SUCCESS;
	}	
	//管理员、商家 、社团 修改社团发布的Activity
	@Action(value = "preModifyActivity", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "modifyActivity.jsp")})
		public String preModifyActivity(){
			user=Auth.getUserFromSession();
			merchant=Auth.getMerchantFromSession();
			activity=activityService.findByHql(user,merchant, activity);
			if(1==1){//判断用户是否为校江湖管理人员
				actionName="admin";
			}
			return SUCCESS;
		}	
		//商家 、社团 修改社团发布的Activity
		@Action(value = "modifyActivity", results = {
				@Result(name = SUCCESS, location = BaseAction.FOREPART + "myActivity.jsp")})
			public String modifyActivity(){
				user=Auth.getUserFromSession();
				merchant=Auth.getMerchantFromSession();
				Activity oldactivity=new Activity();
				oldactivity.setId(activity.getId());
				oldactivity=activityService.findByHql(user,merchant, oldactivity);
				if(oldactivity==null||!oldactivity.getStatus().equals(ActivityStatus.APPLY)){
					return ERROR;//在活动审核通过或拒绝之后，商家不可以再改动
				}
					boolean upimg=activityService.uploadImage(activity,uploadImage, uploadImageFileName, UPLOAD_IMAGE_PATH+uploadImageFileName);
					activityService.uploadVideo(activity,uploadVideo, uploadVideoFileName, UPLOAD_IMAGE_PATH+uploadVideoFileName);
					if(!upimg){
						return ERROR;
					}
					activity.setTalking(oldactivity.getTalking());
					activity.setClub(oldactivity.getClub());
					activity.setStatus(oldactivity.getStatus());
					activity.setMerchant(oldactivity.getMerchant());
					activity.setDatetime(oldactivity.getDatetime());
					activity.setHeat(oldactivity.getHeat());
					activity.setParticipantCount(oldactivity.getParticipantCount());
				activityService.update(activity);
				return SUCCESS;
			}	
		//校江湖管理修改社团发布的Activity
		@Action(value = "adminModifyActivity", results = {
				@Result(name = SUCCESS, location = BaseAction.FOREPART + "myActivity.jsp")})
			public String adminModifyActivity(){
				user=Auth.getUserFromSession();
				//merchant=Auth.getMerchantFromSession();
				Activity oldactivity=new Activity();
				oldactivity.setId(activity.getId());
				oldactivity=activityService.findByHql(user,merchant, oldactivity);
				if(oldactivity!=null){
					activity.setTalking(oldactivity.getTalking());
					activity.setClub(oldactivity.getClub());
					activity.setMerchant(oldactivity.getMerchant());
					activity.setDatetime(oldactivity.getDatetime());
					activity.setHeat(oldactivity.getHeat());
					activity.setParticipantCount(oldactivity.getParticipantCount());
				}else{
					return ERROR;
				}
				boolean upimg=activityService.uploadImage(activity,uploadImage, uploadImageFileName, UPLOAD_IMAGE_PATH+uploadImageFileName);
				activityService.uploadVideo(activity,uploadVideo, uploadVideoFileName, UPLOAD_IMAGE_PATH+uploadVideoFileName);
				if(!upimg){
					return ERROR;
				}
				if(!activity.getStatus().equals("REFUSE")&&
						!activity.getStatus().equals("APPLY"))
				{
					Talking talking=activityService.initTalking(activity, oldactivity);
					activityService.addOrUpdate(talking, activity);
				}
				//activityService.update(activity);
				return SUCCESS;
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
	public Activity getActivity() {
		return activity;
	}
	public void setActivity(Activity activity) {
		this.activity = activity;
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
	
	public List<Activity> getAcs() {
		return acs;
	}
	public void setAcs(List<Activity> acs) {
		this.acs = acs;
	}
	public ActivityService getActivityService() {
		return activityService;
	}
	public void setActivityService(ActivityService activityService) {
		this.activityService = activityService;
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
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	

}
