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

import com.tjxjh.annotation.Auth;
import com.tjxjh.auth.AuthEnum;
import com.tjxjh.po.Activity;
import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.MerchantNews;
import com.tjxjh.pojo.MerchantList;
import com.tjxjh.pojo.MerchantNewsList;
import com.tjxjh.service.ActivityService;
import com.tjxjh.service.MerchantService;
import com.tjxjh.util.CodeUtil;
import com.tjxjh.util.MerchantPurposeUtil;

@ParentPackage("myPackage")
@Namespace("/")
public class MerchantAction extends BaseAction
{
	static final String DELETE_MERCHANT_NEWS = "deleteMerchantNews";
	static final String MERCHANT_NEWS_DETAILS = "merchantNewsDetails";
	static final String ADD_MERCHANT_NEWS = "addMerchantNews";
	static final String ADD_MERCHANT_NEWS_INPUT = "addMerchantNewsInput";
	static final String MERCHANT_NEWS = "merchantNews";
	static final String MERCHANT_MAIN = "merchantMain";
	static final String MERCHANT_LOGIN = "merchantLogin";
	static final String CHECK_MERCHANT = "checkMerchant";
	static final String APPLY_MERCHANT = "applyMerchant";
	static final String APPLY_MERCHANT_INPUT = "applyMerchantInput";
	private static final long serialVersionUID = -4939845530658262045L;
	@Resource
	private MerchantService merchantService = null;
	@Resource
	private ActivityService activityService = null;
	
	private Merchant merchant = null;
	private String[] purpose = null;
	private Page page = null;
	private File media = null;
	private String mediaFileName = null;
	private MerchantNews merchantNews = null;
	private int type;
	private int pageNum;
	protected File logo = null;
	protected String logoFileName = null;
	private List<Activity> acs=new ArrayList<Activity>();
	
	@Actions({
			@Action(value = APPLY_MERCHANT_INPUT, results = {@Result(name = SUCCESS, location = FOREPART
					+ APPLY_MERCHANT + JSP)}),
			@Action(value = ADD_MERCHANT_NEWS_INPUT, results = {@Result(name = SUCCESS, location = FOREPART
					+ ADD_MERCHANT_NEWS + JSP)})})
	@Auth(auths={AuthEnum.NO_NEED})
	public String page()
	{
		return SUCCESS;
	}
	
	@Action(value = APPLY_MERCHANT, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = CHECK_MERCHANT, params = {
					"merchant.id", "${merchant.id}"}),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = APPLY_MERCHANT_INPUT)})
	@Auth(auths={AuthEnum.NO_NEED})
	public String applyMerchant()
	{
		merchant.setLogoPath(new StringBuilder("upload/merchantLogo/")
				.append(CodeUtil.md5(merchant.getName()))
				.append(logoFileName.substring(logoFileName.indexOf('.')))
				.toString());
		merchant.setPurpose(MerchantPurposeUtil.transformPurpose(purpose));
		return super.successOrInput(merchantService.applyMerchant(merchant, logo));
	}
	
//	@Action(value = CHECK_MERCHANT, results = {@Result(name = SUCCESS, type = REDIRECT_ACTION, location = UserAction.LOGIN_INPUT)})
//	public String checkMerchant()
//	{
//		merchantService.checkMerchant(merchant, isPass==1?true:false);
//		return SUCCESS;
//	}
	
	@Action(value = MERCHANT_LOGIN, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = MERCHANT_MAIN),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = UserAction.LOGIN_INPUT)})
	@Auth(auths={AuthEnum.NO_NEED})
	public String merchantLogin()
	{
		super.clearSession();
		if((merchant = merchantService.login(merchant)) != null)
		{
			super.saveMerchant(merchant);
			return SUCCESS;
		}
		else
		{
			return INPUT;
		}
	}
	
	@Action(value = "allMerchant", results = {
			@Result(name = SUCCESS, location = MANAGE+"allMerchant.jsp")})
	@Auth(auths={AuthEnum.ADMIN})
	public String allMerchant(){
		Page page = new Page(pageNum*Page.getDefaultPageNumber()+1);
		page.setCurrentPage(pageNum);
		MerchantList merchantList = new MerchantList();
		merchantList.setMerchantList(merchantService.allMerchant(page));
		for(Merchant m:merchantList.getMerchantList()){
			m.getActivities().size();
		}
		merchantList.setPage(merchantService.merchantNum(page));
		getRequestMap().put("merchantList", merchantList);
		return SUCCESS;
	}
	
	@Action(value = MERCHANT_MAIN, results = {@Result(name = SUCCESS, location = FOREPART
			+ MERCHANT_MAIN + JSP)})
	@Auth(auths={AuthEnum.USER})
	public String merchantMain()
	{
		return SUCCESS;
	}
	//商家主页
	@Action(value = "merchant", results = {@Result(name = SUCCESS, location = FOREPART
			+ MERCHANT_MAIN + JSP)})
	public String merchant()
	{
		merchant=merchantService.merchantById(merchant);
		if(page == null)
		{
			page = merchantService.merchantNewsPage(merchant);
		}
		super.getRequestMap().put(MERCHANT_NEWS,
				merchantService.merchantNews(merchant, page));
		page=activityService.getOneClubPageByHql(8,0,1,null,merchant,2);
		acs=activityService.getOneClubActivityByHql(page,null,merchant,"datetime",2);
		return SUCCESS;
	}
	
	@Action(value = "allMerchantNews", results = {
			@Result(name = SUCCESS,location = MANAGE+"allMerchantNews.jsp")})
	@Auth(auths={AuthEnum.ADMIN})
	public String allMerchantNews(){
		Page page = new Page(pageNum*Page.getDefaultPageNumber()+1);
		page.setCurrentPage(pageNum);
		MerchantNewsList merchantNewsList = new MerchantNewsList();
		merchantNewsList.setMerchantNewsList(merchantService.allMerchantNews(page));
		merchantNewsList.setPage(merchantService.merchantNewsNum(page));
		for(MerchantNews c:merchantNewsList.getMerchantNewsList()){
			c.getMerchant().getName();
			c.getMerchant().getId();
		}
		getRequestMap().put("merchantNewsList", merchantNewsList);
		return SUCCESS;
	}
	
	@Action(value = MERCHANT_NEWS, results = {@Result(name = SUCCESS, location = FOREPART
			+ MERCHANT_NEWS + JSP)})
	@Auth(auths={AuthEnum.USER})
	public String merchantNews()
	{
		if(page == null)
		{
			page = merchantService.merchantNewsPage(super.currentMerchant());
		}
		super.getRequestMap().put(MERCHANT_NEWS,
				merchantService.merchantNews(super.currentMerchant(), page));
		return SUCCESS;
	}
	
	@Action(value = ADD_MERCHANT_NEWS, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = MERCHANT_NEWS),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = ADD_MERCHANT_NEWS_INPUT)})
	@Auth(auths={AuthEnum.MERCHANT})
	public String addMerchantNews()
	{
		merchantNews.setMerchant(super.currentMerchant());
		return super.successOrInput(merchantService.save(merchantNews));
	}
	
	@Action(value = MERCHANT_NEWS_DETAILS, results = {
			@Result(name = SUCCESS, location = FOREPART + MERCHANT_NEWS_DETAILS
					+ JSP),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = MERCHANT_NEWS)})
	@Auth(auths={AuthEnum.USER})
	public String merchantNewsDetails()
	{
		if(isMerchantNewsEmpty())
		{
			return INPUT;
		}
		merchantNews.setMerchant(super.currentMerchant());
		merchantNews = merchantService.merchantNewsDetails(merchantNews);
		return super.successOrInput(merchantNews != null);
	}
	
	@Action(value = DELETE_MERCHANT_NEWS, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = MERCHANT_NEWS),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = MERCHANT_NEWS)})
	@Auth(auths={AuthEnum.MERCHANT})
	public String deleteMerchantNews()
	{
		if(isMerchantNewsEmpty())
		{
			return INPUT;
		}
		merchantNews.setMerchant(super.currentMerchant());
		return super.successOrInput(merchantService
				.deleteMerchantNews(merchantNews));
	}
	//后台管理方法
	@Action(value = "adminDeleteMerhcantNews", results = {
			@Result(name = SUCCESS,type = REDIRECT_ACTION, location ="allMerchantNews", params={"pageNum","${pageNum}"})})
	@Auth(auths={AuthEnum.ADMIN})
	public String adminDeleteMerhcantNews(){
		merchantNews.setMerchant(merchant);
		merchantService.deleteMerchantNews(merchantNews);
		return SUCCESS;
	}
			
	@Action(value = "merchantFocus", results = {@Result(name = SUCCESS, location = BaseAction.FOREPART
			+ "merchantFocus.jsp")})
	@Auth(auths={AuthEnum.USER})
	public String merchantFocus()
	{
		// List<User> focusList = sessionUser.getUsersForTargetUserId();
		Merchant merchant = (Merchant) getSessionMap().get("merchant");
		switch(type)
		{
			case (1):
				List<Club> clubList = merchantService.getFocusList(Club.class,
						merchant);
				getRequestMap().put("focusList", clubList);
				break;
			case (2):
				List<Merchant> merchantList = merchantService.getFocusList(
						Merchant.class, merchant);
				getRequestMap().put("focusList", merchantList);
				break;
		}
		return SUCCESS;
	}
	
	private boolean isMerchantNewsEmpty()
	{
		return merchantNews == null || merchantNews.getId() == null;
	}
	
	public Merchant getMerchant()
	{
		return merchant;
	}
	
	public void setMerchant(Merchant merchant)
	{
		this.merchant = merchant;
	}
	
	public MerchantService getMerchantService()
	{
		return merchantService;
	}
	
	public void setMerchantService(MerchantService merchantService)
	{
		this.merchantService = merchantService;
	}
	
	public String[] getPurpose()
	{
		return purpose;
	}
	
	public void setPurpose(String[] purpose)
	{
		this.purpose = purpose;
	}
	
	public Page getPage()
	{
		return page;
	}
	
	public void setPage(Page page)
	{
		this.page = page;
	}
	
	public File getMedia()
	{
		return media;
	}
	
	public void setMedia(File media)
	{
		this.media = media;
	}
	
	public MerchantNews getMerchantNews()
	{
		return merchantNews;
	}
	
	public void setMerchantNews(MerchantNews merchantNews)
	{
		this.merchantNews = merchantNews;
	}
	
	public int getType()
	{
		return type;
	}
	
	public void setType(int type)
	{
		this.type = type;
	}
	
	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public String getMediaFileName()
	{
		return mediaFileName;
	}
	
	public void setMediaFileName(String mediaFileName)
	{
		this.mediaFileName = mediaFileName;
	}
	
	public File getLogo()
	{
		return logo;
	}
	
	public void setLogo(File logo)
	{
		this.logo = logo;
	}
	
	public String getLogoFileName()
	{
		return logoFileName;
	}
	
	public void setLogoFileName(String logoFileName)
	{
		this.logoFileName = logoFileName;
	}

	public List<Activity> getAcs() {
		return acs;
	}

	public void setAcs(List<Activity> acs) {
		this.acs = acs;
	}
	
}
