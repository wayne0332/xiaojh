package com.tjxjh.action;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Actions;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import cn.cafebabe.autodao.pojo.Page;

import com.opensymphony.xwork2.ActionContext;
import com.tjxjh.annotation.Auth;
import com.tjxjh.annotation.Keyword;
import com.tjxjh.enumeration.UserStatus;
import com.tjxjh.interceptor.AuthInterceptor.AdminAuth;
import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.OnlineActivity;
import com.tjxjh.po.Picture;
import com.tjxjh.po.Talking;
import com.tjxjh.po.User;
import com.tjxjh.pojo.ClubList;
import com.tjxjh.pojo.IndexTalking;
import com.tjxjh.pojo.MerchantList;
import com.tjxjh.pojo.UserList;
import com.tjxjh.service.ClubService;
import com.tjxjh.service.MailService;
import com.tjxjh.service.OnlineActivityService;
import com.tjxjh.service.PictureService;
import com.tjxjh.service.TalkingCommentService;
import com.tjxjh.service.TalkingService;
import com.tjxjh.service.UserService;
import com.tjxjh.util.CodeUtil;

@ParentPackage("myPackage")
@Namespace("/")
public class UserAction extends BaseAction
{
	public static final String RESET_USER_PASSWORD_INPUT = "resetUserPasswordInput";
	static final String RESET_USER_PASSWORD = "resetUserPassword";
	static final String FIND_USER_PASSWORD_INPUT = "findUserPasswordInput";
	static final String FIND_USER_PASSWORD = "findUserPassword";
	static final String CHANGE_USER_PASSWORD_INPUT = "changeUserPasswordInput";
	static final String CHANGE_USER_PASSWORD = "changeUserPassword";
	public static final String REGISTER_VALIDATE = "registerValidate";
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
	private List<IndexTalking> taks = new ArrayList<IndexTalking>();
	private String message = "";
	// 相册
	private List<Picture> pics = new ArrayList<Picture>();
	// 线上活动
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
	private MailService mailService = null;
	@Resource
	private TalkingCommentService talkingCommentService = null;
	@Resource
	private OnlineActivityService onlineActivityService = null;
	private User user = null;
	protected File portrait = null;
	protected String portraitFileName = null, code = null;
	private Integer type = null;
	private int pageNum;
	
	@Action(value = "allUser", results = {@Result(name = SUCCESS, location = MANAGE
			+ "allUser.jsp")})
	@Auth(type = AdminAuth.class)
	public String allUser()
	{
		Page page = new Page(pageNum * Page.getDefaultPageNumber() + 1);
		page.setCurrentPage(pageNum);
		UserList userList = new UserList();
		userList.setUserList(userService.allUsers(page));
		userList.setPage(userService.userNum(page));
		getRequestMap().put("userList", userList);
		return SUCCESS;
	}
	
	@Action(value = USER_LOGIN, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = IndexAction.INDEX),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = IndexAction.INDEX, params = {
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
			saveUser(user);
			return SUCCESS;
		}
		else
		{
			return INPUT;
		}
	}
	
	@Override
	protected void saveUser(User user)
	{
		// 将相关的用户id存入session
		super.saveUser(user);
		super.getSessionMap().put("relativeUsers",
				talkingService.preGetRelativeUserId(user));
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
					"msg", "请正确输入信息!"}),
			@Result(name = ERROR, location = FOREPART + ERROR_PAGE)})
	@Keyword
	public String register()
	{
		super.clearSession();
		if(portrait != null)
		{
			fillPortraitPathToUser(user.getName());
		}
		if(!mailService.checkEmail(user.getEmail()))
		{
			return INPUT;
		}
		super.getRequestMap().put("email", user.getEmail().split("@")[1]);
		if(userService.register(user, portrait))
		{
			if(mailService.sendRegisterLetter(user))
			{
				return SUCCESS;
			}
			else
			{
				return ERROR;
			}
		}
		else
		{
			return INPUT;
		}
	}
	
	@Action(value = REGISTER_VALIDATE, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = REFRESH_USER
					+ IndexAction.INDEX),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = IndexAction.INDEX, params = {
					"msg", "注册验证失败(可能链接已过期)!"})})
	public String registerValidate()
	{
		return validateEmail();
	}
	
	private String validateEmail()
	{
		super.clearSession();
		User user = mailService.fromValidateEmail(code);
		if(user != null)
		{
			saveUser(user);
			return SUCCESS;
		}
		else
		{
			return INPUT;
		}
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
	
	@Action(value = CHANGE_USER_PASSWORD, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = REFRESH_USER
					+ CENTER),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = CHANGE_USER_PASSWORD_INPUT, params = {
					"msg", "密码错误!"})})
	public String changeUserPassword()
	{
		user.setId(super.currentUser().getId());
		user.setPassword(CodeUtil.md5(user.getPassword()));
		if(userService.exist(user))
		{
			userService.changeUserPassword(super.currentUser(), code);
			return SUCCESS;
		}
		return INPUT;
	}
	
	@Action(value = RESET_USER_PASSWORD, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = IndexAction.INDEX),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = IndexAction.INDEX, params = {
					"msg", "重置密码失败(可能链接已过期)!"})})
	public String resetUserPassword()
	{
		if(validateEmail().equals(SUCCESS))
		{
			userService.changeUserPassword(super.currentUser(),
					user.getPassword());
			super.clearSession();
			return SUCCESS;
		}
		return INPUT;
	}
	
	// @Action(value = RESET_USER_PASSWORD_INPUT, results = {
	// @Result(name = SUCCESS, location = FOREPART + RESET_USER_PASSWORD
	// + JSP),
	// @Result(name = INPUT, type = REDIRECT_ACTION, location =
	// IndexAction.INDEX, params = {
	// "msg", "重置密码失败(可能链接已过期)!"})})
	// public String resetUserPasswordInput()
	// {
	// return validateEmail();
	// }
	@Action(value = FIND_USER_PASSWORD, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "emailLoginJsp", params = {
					"email", "${#request.email}"}),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = FIND_USER_PASSWORD_INPUT, params = {
					"msg", "请输入正确的邮箱"}),
			@Result(name = NONE, type = REDIRECT_ACTION, location = FIND_USER_PASSWORD_INPUT, params = {
					"msg", "此邮箱未注册"}),
			@Result(name = ERROR, type = REDIRECT_ACTION, location = FOREPART
					+ ERROR_PAGE)})
	public String findUserPassword()
	{
		if(!mailService.checkEmail(user.getEmail()))
		{
			return INPUT;
		}
		super.getRequestMap().put("email", user.getEmail().split("@")[1]);
		if(!userService.exist(user))
		{
			return NONE;
		}
		if(mailService.sendFindUserPsdLetter(user))
		{
			return SUCCESS;
		}
		else
		{
			return NONE;
		}
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
	/**
	 * 我的相册或根据id查看好友相册
	 * 
	 * @return
	 * @throws Exception
	 */
	@Action(value = "photos", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "userHomePhotos.jsp")})
	public String findMyPicture(){
		if(user==null||user.getId()==null){
			user=(User) getSessionMap().get("user");
			user = userService.findById(user.getId());
			String temp=user.getSchool().getName();
			getRequestMap().put("my", "yes");
		}else{
			user = userService.findById(user.getId());
			String temp=user.getSchool().getName();
			User tmep=(User) getSessionMap().get("user");
			int i=user.getId();
			int j=tmep.getId();
			if(i==j){
				getRequestMap().put("my", "yes");
			}else{
				getRequestMap().put("my", "no");
			}
			
		}
		page=pictureService.getMyPageByHql(user,eachPageNumber,currentPage,totalPageNumber);
		pics=pictureService.findMyPictureByHql(page,user);
		return SUCCESS;
	}
	// main :userHome
	@Action(value = MAIN, results = {@Result(name = SUCCESS, location = BaseAction.FOREPART
			+ MAIN + JSP)})
	public String home()
	{
		initUserHome();
		
		/************************** 指定用户说说说说 *******************************************/
		page = talkingService.getMyPageByHql(user, 10, currentPage, 1);
		List<Talking> temp = talkingService.findMyTalkingByHql(page, user);
		for(Talking t : temp)
		{
			IndexTalking it = new IndexTalking();
			it.setT(t);
			it.setTcs(talkingCommentService.findByHql(t.getId()));
			taks.add(it);
		}
		return SUCCESS;
	}

	private void initUserHome() {
		if(user==null||user.getId()==null){
			user=(User) getSessionMap().get("user");
			user = userService.findById(user.getId());
			getRequestMap().put("my", "yes");
		}else{
			user = userService.findById(user.getId());
			User tmep=(User) getSessionMap().get("user");
			int i=user.getId();
			int j=tmep.getId();
			if(i==j){
				getRequestMap().put("my", "yes");
			}else{
				getRequestMap().put("my", "no");
			}
			
		}
		try{
			String temp=user.getSchool().getName();
		}catch(Exception e){
			
		}
		/************************** TT *******************************************/
		List<User> focusUserList = userService.getFocusList(User.class,user);
		if(focusUserList.size() > 9)
		{
			focusUserList = focusUserList.subList(0, 9);
		}
		getRequestMap().put("focusUserList", focusUserList);
		List<Club> focusClubList = userService.getFocusList(Club.class,user);
		if(focusClubList.size() > 9)
		{
			focusClubList = focusClubList.subList(0, 9);
		}
		getRequestMap().put("focusClubList", focusClubList);
		List<Merchant> focusMerchantList = userService.getFocusList(Merchant.class, user);
		if(focusMerchantList.size() > 9)
		{
			focusMerchantList = focusMerchantList.subList(0, 9);
		}
		getRequestMap().put("focusMerchantList", focusMerchantList);
		/************************** 指定用户相册 *******************************************/
		page = pictureService.getMyPageByHql(user, 1, currentPage, 1);
		pics = pictureService.findMyPictureByHql(page, user);
		
		/*************************** 指定用户线上活动 *****************************************/
		page = onlineActivityService.getOneOnlineActivityPageByHql(4,
				currentPage, 1, null, null, user);
		onlineActs = onlineActivityService.findOneClubOnlineActivityByHql(page,
				null, null, user);
		getRequestMap().put("onlineActs", onlineActs);
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
		// super.getRequestMap().put("allUsers", userService.allUsers());
		user = (User) getSessionMap().get("user");
		/************************** 相册 *******************************************/
		page = pictureService.getRelativeByHql(eachPageNumber, currentPage,
				totalPageNumber);
		pics = pictureService.findRelativePictureByHql(page);
		/************************* 相关说说 *******************************************/
		page = talkingService.getRelativePageByHql(user, eachPageNumber,
				currentPage, 1);
		List<Talking> temp = talkingService
				.findRelativeTalkingByHql(page, user);
		for(Talking t : temp)
		{
			IndexTalking it = new IndexTalking();
			it.setT(t);
			it.setTcs(talkingCommentService.findByHql(t.getId()));
			taks.add(it);
		}
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
		Page page = new Page(pageNum * eachPageNumber + 1);
		page.setEachPageNumber(eachPageNumber);
		page.setCurrentPage(pageNum);
		switch(type)
		{
			case (0):
				List<User> userList = userService.getFocusList(User.class,
						(User) getSessionMap().get("user"), page);
				UserList userListPojo = new UserList();
				userListPojo.setUserList(userList);
				userListPojo.setPage(userService.getFocusNum(User.class,
						(User) getSessionMap().get("user"), page));
				getRequestMap().put("focusList", userListPojo);
				// for(User u:userList){
				// checkList.add(u.getId());
				// }
				// getRequestMap().put("checkList", checkList);
				break;
			case (1):
				List<Club> clubList = userService.getFocusList(Club.class,
						(User) getSessionMap().get("user"), page);
				ClubList clubListPojo = new ClubList();
				clubListPojo.setClubList(clubList);
				clubListPojo.setPage(userService.getFocusNum(Club.class,
						(User) getSessionMap().get("user"), page));
				getRequestMap().put("focusList", clubListPojo);
				// for(Club u:clubList){
				// checkList.add(u.getId());
				// }
				// getRequestMap().put("checkList", checkList);
				break;
			case (2):
				List<Merchant> merchantList = userService.getFocusList(
						Merchant.class, (User) getSessionMap().get("user"),
						page);
				MerchantList merchantListPojo = new MerchantList();
				merchantListPojo.setMerchantList(merchantList);
				merchantListPojo.setPage(userService.getFocusNum(
						Merchant.class, (User) getSessionMap().get("user"),
						page));
				getRequestMap().put("focusList", merchantListPojo);
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
			@Action(value = RESET_USER_PASSWORD_INPUT, results = {@Result(name = SUCCESS, location = FOREPART
					+ RESET_USER_PASSWORD + JSP)}),
			@Action(value = CHANGE_USER_PASSWORD_INPUT, results = {@Result(name = SUCCESS, location = FOREPART
					+ CHANGE_USER_PASSWORD + JSP)}),
			@Action(value = FIND_USER_PASSWORD_INPUT, results = {@Result(name = SUCCESS, location = BaseAction.FOREPART
					+ FIND_USER_PASSWORD + JSP)}),
			@Action(value = "manageTop", results = {@Result(name = SUCCESS, location = "/WEB-INF/web/manage/admin_top.jsp")}),
			@Action(value = "manageLeft", results = {@Result(name = SUCCESS, location = "/WEB-INF/web/manage/left.jsp")}),
			@Action(value = "manageRight", results = {@Result(name = SUCCESS, location = "/WEB-INF/web/manage/right.jsp")})})
	public String page()
	{
		return SUCCESS;
	}
	
	@Action(value = "manageIndex", results = {@Result(name = SUCCESS, location = "/WEB-INF/web/manage/index.jsp")})
//	@Auth(type = AdminAuth.class)
	public String adminAuth()
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
	
	public List<IndexTalking> getTaks()
	{
		return taks;
	}
	
	public void setTaks(List<IndexTalking> taks)
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
	
	public void setMailService(MailService mailService)
	{
		this.mailService = mailService;
	}
	
	public void setCode(String code)
	{
		this.code = code;
	}
	
	public List<OnlineActivity> getOnlineActs()
	{
		return onlineActs;
	}
	
	public void setOnlineActs(List<OnlineActivity> onlineActs)
	{
		this.onlineActs = onlineActs;
	}
	
	public void setOnlineActivityService(
			OnlineActivityService onlineActivityService)
	{
		this.onlineActivityService = onlineActivityService;
	}
	
	public void setTalkingCommentService(
			TalkingCommentService talkingCommentService)
	{
		this.talkingCommentService = talkingCommentService;
	}
	
	public int getPageNum()
	{
		return pageNum;
	}
	
	public void setPageNum(int pageNum)
	{
		this.pageNum = pageNum;
	}
}
