package com.tjxjh.action;

import cn.cafebabe.websupport.struts2.BaseStruts2Action;

import com.tjxjh.po.ClubMember;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.User;

public class BaseAction extends BaseStruts2Action
{
	private static final long serialVersionUID = 7843015707793846122L;
	final static String FOREPART = SECRET_PAGE_PATH + "forepart/",
			MANAGE = SECRET_PAGE_PATH + "manage/", CLUB_MEMBER = "clubMember",
			ERROR_PAGE = "error_500.jsp", USER = "user", MERCHANT = "merchant";
	
	protected User currentUser()
	{
		return (User) super.getSessionMap().get(USER);
	}
	
	protected void saveUser(User user)
	{
		super.getSessionMap().put(USER, user);
	}
	
	protected void clearSession()
	{
		super.getSessionMap().remove(USER);
		super.getSessionMap().remove(MERCHANT);
	}
	
	protected void saveClubMember(ClubMember clubMember)
	{
		super.getRequestMap().put(CLUB_MEMBER, clubMember);
	}
	
	protected void saveMerchant(Merchant merchant)
	{
		super.getSessionMap().put(MERCHANT, merchant);
	}
	
	protected Merchant currentMerchant()
	{
		return (Merchant) super.getSessionMap().get(MERCHANT);
	}
}
