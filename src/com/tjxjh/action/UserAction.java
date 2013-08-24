package com.tjxjh.action;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Actions;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.enumeration.OnlineActivityStatus;
import com.tjxjh.enumeration.UserStatus;
import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.OnlineActivity;
import com.tjxjh.po.Picture;
import com.tjxjh.po.Talking;
import com.tjxjh.po.User;
import com.tjxjh.service.ClubService;
import com.tjxjh.service.OnlineActivityService;
import com.tjxjh.service.PictureService;
import com.tjxjh.service.TalkingService;
import com.tjxjh.service.UserService;
import com.tjxjh.util.CodeUtil;

@ParentPackage("struts-default")
@Namespace("/")
public class UserAction extends BaseAction
{
	static final String MANAGER_LOGIN = "managerLogin";
	static final String MANAGER_LOGIN_INPUT = "managerLoginInput";
	static final String MY_INVITED = "myInvited";
	static final String LOGOUT = "logout";
	static final String UPDATE_USER_INPUT = "updateUserInput";
	static final String UPDATE_USER = "updateUser";
	static final String REFRESH_USER = "refresh";
	static final String REGISTER = "register";
	static final String USER_LOGIN = "userLogin";
	static final String REGISTER_INPUT = "registerInput";
	static final String LOGIN_INPUT = "loginInput";
	static final String MAIN = "userHome";
	static final String CENTER = "userCenter";
	public final static String PORTRAIT_FOLDER = "upload/portrait/";
	private static final long serialVersionUID = 7096555953593277984L;
	// 分页信息
	private Page page;
	private Integer eachPageNumber = 10;
	private Integer currentPage = 1;
	private Integer totalPageNumber = 0;
	// talking
	private List<Talking> taks = new ArrayList<Talking>();
	private String message = "";
	// 相册
	private List<Picture> pics = new ArrayList<Picture>();
	//线上活动
	private List<OnlineActivity> onlineActs = new ArrayList<OnlineActivity>();
	@Resource
	private PictureService pictureService = null;
	@Resource
	private TalkingService talkingService = null;
	@Resource
	private UserService userService = null;
	@Resource
	private ClubService clubService = null;
	@Resource
	private OnlineActivityService onlineActivityService = null;
	private User user = null;
	protected File portrait = null;
	protected String portraitFileName = null;
	private Integer type;
	
	@Action(value = USER_LOGIN, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = IndexAction.INDEX),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = LOGIN_INPUT, params = {
					"msg", "用户名或密码错误!"})})
	public String userLogin()
	{
		return login(UserStatus.VALIDATED);
	}

	private String login(UserStatus status)
	{
		super.clearSession();
		if((user = userService.login(user, status)) != null)
		{
			super.saveUser(user);
			//将相关的用户id存入session
			super.getSessionMap().put("relativeUsers", talkingService.preGetRelativeUserId(user));
			
			return SUCCESS;
		}
		else
		{
			return INPUT;
		}
	}
	
	@Action(value = MANAGER_LOGIN, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "manageIndex"),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = MANAGER_LOGIN_INPUT, params = {
					"msg", "用户名或密码错误!"})})
	public String managerLogin()
	{
		return login(UserStatus.ADMIN);
	}
	
	@Action(value = REGISTER, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "emailLoginJsp", params = {
					"email", "${#request.email}"}),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = REGISTER_INPUT, params = {
					"msg", "请正确输入信息!"})})
	public String register()
	{
		if(portrait != null)
		{
			fillPortraitPathToUser(user.getName());
		}
		String[] email = user.getEmail().split("@");
		if(email.length != 2)
		{
			return INPUT;
		}
		super.getRequestMap().put("email", email[1]);
		return super.successOrInput(userService.register(user, portrait));
	}
	
	@Action(value = UPDATE_USER, results = {@Result(name = SUCCESS, type = REDIRECT_ACTION, location = REFRESH_USER
			+ MAIN)})
	public String updateUser()
	{
		if(portrait != null)
		{
			User currentUser = currentUser();
			userService.deleteOldPortraitPath(currentUser.getPortraitPath());
			fillPortraitPathToUser(currentUser.getName());
		}
		userService.update(user, portrait);
		return SUCCESS;
	}
	
	private void fillPortraitPathToUser(String userName)
	{
		user.setPortraitPath(PORTRAIT_FOLDER + CodeUtil.md5(userName)
				+ portraitFileName.substring(portraitFileName.indexOf('.')));
	}
	
	@Action(value = LOGOUT, results = {@Result(name = SUCCESS, type = REDIRECT_ACTION, location = IndexAction.INDEX)})
	public String logout()
	{
		super.clearSession();
		return SUCCESS;
	}
	//main :userHome
	@Action(value = MAIN, results = {@Result(name = SUCCESS, location = BaseAction.FOREPART
	+ MAIN + JSP)})
		public String home()
		{
			/************************** TT *******************************************/
			List<User> focusUserList = userService.getFocusList(User.class,
					(User) getSessionMap().get("user"));
			if(focusUserList.size() > 9)
			{
				focusUserList = focusUserList.subList(0, 9);
			}
			getRequestMap().put("focusUserList", focusUserList);
			List<Club> focusClubList = userService.getFocusList(Club.class,
					(User) getSessionMap().get("user"));
			if(focusClubList.size() > 9)
			{
				focusClubList = focusClubList.subList(0, 9);
			}
			getRequestMap().put("focusClubList", focusClubList);
			List<Merchant> focusMerchantList = userService.getFocusList(
					Merchant.class, (User) getSessionMap().get("user"));
			if(focusMerchantList.size() > 9)
			{
				focusMerchantList = focusMerchantList.subList(0, 9);
			}
			getRequestMap().put("focusMerchantList", focusMerchantList);
			super.getRequestMap().put("allUsers", userService.allUsers());
			
			if(null==user||null==user.getId()){
				user=(User) getSessionMap().get("user");
				user=userService.findById(user.getId());
			}else{
				user=userService.findById(user.getId());
			}
			/************************** 指定用户相册 *******************************************/
			
			page = pictureService.getMyPageByHql(user,1, currentPage, 1);
			pics = pictureService.findMyPictureByHql(page, user);
			
			/***************************指定用户线上活动*****************************************/
			page = onlineActivityService.getOneOnlineActivityPageByHql(4, currentPage, 1,null,null,user);
			onlineActs=onlineActivityService.findOneClubOnlineActivityByHql(page,null,null, user);
			/**************************指定用户说说说说 *******************************************/
			
			page = talkingService.getMyPageByHql(user,10, currentPage, 1);
			taks = talkingService.findMyTalkingByHql(page,user);
			
			return SUCCESS;
		}
	@Action(value = CENTER, results = {@Result(name = SUCCESS, location = BaseAction.FOREPART
			+ CENTER + JSP)})
	public String center()
	{
		/************************** TT *******************************************/
		List<User> focusUserList = userService.getFocusList(User.class,
				(User) getSessionMap().get("user"));
		if(focusUserList.size() > 9)
		{
			focusUserList = focusUserList.subList(0, 9);
		}
		getRequestMap().put("focusUserList", focusUserList);
		List<Club> focusClubList = userService.getFocusList(Club.class,
				(User) getSessionMap().get("user"));
		if(focusClubList.size() > 9)
		{
			focusClubList = focusClubList.subList(0, 9);
		}
		getRequestMap().put("focusClubList", focusClubList);
		List<Merchant> focusMerchantList = userService.getFocusList(
				Merchant.class, (User) getSessionMap().get("user"));
		if(focusMerchantList.size() > 9)
		{
			focusMerchantList = focusMerchantList.subList(0, 9);
		}
		getRequestMap().put("focusMerchantList", focusMerchantList);
		super.getRequestMap().put("allUsers", userService.allUsers());
		user=(User) getSessionMap().get("user");
		/************************** 相册 *******************************************/
		page=pictureService.getRelativeByHql(eachPageNumber,currentPage,totalPageNumber);
		pics=pictureService.findRelativePictureByHql(page);
		
		/*************************相关说说 *******************************************/
		
		page = talkingService.getRelativePageByHql(user,eachPageNumber, currentPage, 1);
		taks = talkingService.findRelativeTalkingByHql(page,user);
		
		return SUCCESS;
	}
	
	@Action(value = MY_INVITED, results = {@Result(name = SUCCESS, location = FOREPART
			+ MY_INVITED + JSP)})
	public String myInvited()
	{
		super.getRequestMap().put(MY_INVITED,
				clubService.myInvited(super.currentUser()));
		return SUCCESS;
	}
	
	@Action(value = REFRESH_USER + "*", results = {@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "{1}")})
	public String refreshUser()
	{
		super.saveUser(userService.refresh(currentUser()));
		return SUCCESS;
	}
	
	@Action(value = "myFocus", results = {@Result(name = SUCCESS, location = BaseAction.FOREPART
			+ "myFocus.jsp")})
	public String myFocus()
	{
		// List<User> focusList = sessionUser.getUsersForTargetUserId();
		switch(type)
		{
			case (0):
				List<User> userList = userService.getFocusList(User.class,
						(User) getSessionMap().get("user"));
				getRequestMap().put("focusList", userList);
				// for(User u:userList){
				// checkList.add(u.getId());
				// }
				// getRequestMap().put("checkList", checkList);
				break;
			case (1):
				List<Club> clubList = userService.getFocusList(Club.class,
						(User) getSessionMap().get("user"));
				getRequestMap().put("focusList", clubList);
				// for(Club u:clubList){
				// checkList.add(u.getId());
				// }
				// getRequestMap().put("checkList", checkList);
				break;
			case (2):
				List<Merchant> merchantList = userService.getFocusList(
						Merchant.class, (User) getSessionMap().get("user"));
				getRequestMap().put("focusList", merchantList);
				// for(Merchant u:merchantList){
				// checkList.add(u.getId());
				// }
				// getRequestMap().put("checkList", checkList);
				break;
		}
		return SUCCESS;
	}
	
	@Actions({
			@Action(value = LOGIN_INPUT, results = {@Result(name = SUCCESS, location = BaseAction.FOREPART
					+ "login.jsp")}),
			@Action(value = MANAGER_LOGIN_INPUT, results = {@Result(name = SUCCESS, location = BaseAction.MANAGE
					+ "login.jsp")}),
			@Action(value = REGISTER_INPUT, results = {@Result(name = SUCCESS, location = BaseAction.FOREPART
					+ "register.jsp")}),
			@Action(value = UPDATE_USER_INPUT, results = {@Result(name = SUCCESS, location = BaseAction.FOREPART
					+ UPDATE_USER + JSP)}),
			@Action(value = "manageIndex", results = {@Result(name = SUCCESS, location = "/WEB-INF/web/manage/index.jsp")}),
			@Action(value = "manageTop", results = {@Result(name = SUCCESS, location = "/WEB-INF/web/manage/admin_top.jsp")}),
			@Action(value = "manageLeft", results = {@Result(name = SUCCESS, location = "/WEB-INF/web/manage/left.jsp")}),
			@Action(value = "manageRight", results = {@Result(name = SUCCESS, location = "/WEB-INF/web/manage/right.jsp")})})
	public String page()
	{
		return SUCCESS;
	}
	
	public void setUserService(UserService userService)
	{
		this.userService = userService;
	}
	
	public void setPortrait(File portrait)
	{
		this.portrait = portrait;
	}
	
	public void setPortraitFileName(String portraitFileName)
	{
		this.portraitFileName = portraitFileName;
	}
	
	public File getPortrait()
	{
		return portrait;
	}
	
	public String getPortraitFileName()
	{
		return portraitFileName;
	}
	
	public User getUser()
	{
		return user;
	}
	
	public void setUser(User user)
	{
		this.user = user;
	}
	
	public Integer getType()
	{
		return type;
	}
	
	public void setType(Integer type)
	{
		this.type = type;
	}
	
	public Page getPage()
	{
		return page;
	}
	
	public void setPage(Page page)
	{
		this.page = page;
	}
	
	public Integer getEachPageNumber()
	{
		return eachPageNumber;
	}
	
	public void setEachPageNumber(Integer eachPageNumber)
	{
		this.eachPageNumber = eachPageNumber;
	}
	
	public Integer getCurrentPage()
	{
		return currentPage;
	}
	
	public void setCurrentPage(Integer currentPage)
	{
		this.currentPage = currentPage;
	}
	
	public Integer getTotalPageNumber()
	{
		return totalPageNumber;
	}
	
	public void setTotalPageNumber(Integer totalPageNumber)
	{
		this.totalPageNumber = totalPageNumber;
	}
	
	public List<Talking> getTaks()
	{
		return taks;
	}
	
	public void setTaks(List<Talking> taks)
	{
		this.taks = taks;
	}
	
	public String getMessage()
	{
		return message;
	}
	
	public void setMessage(String message)
	{
		this.message = message;
	}
	
	public List<Picture> getPics()
	{
		return pics;
	}
	
	public void setPics(List<Picture> pics)
	{
		this.pics = pics;
	}
	
	public PictureService getPictureService()
	{
		return pictureService;
	}
	
	public void setPictureService(PictureService pictureService)
	{
		this.pictureService = pictureService;
	}
	
	public TalkingService getTalkingService()
	{
		return talkingService;
	}
	
	public void setTalkingService(TalkingService talkingService)
	{
		this.talkingService = talkingService;
	}
	
	public void setClubService(ClubService clubService)
	{
		this.clubService = clubService;
	}

	public List<OnlineActivity> getOnlineActs() {
		return onlineActs;
	}

	public void setOnlineActs(List<OnlineActivity> onlineActs) {
		this.onlineActs = onlineActs;
	}

	public void setOnlineActivityService(OnlineActivityService onlineActivityService) {
		this.onlineActivityService = onlineActivityService;
	}
	
	
}
