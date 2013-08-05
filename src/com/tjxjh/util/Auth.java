package com.tjxjh.util;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.User;

public class Auth {
	public static User getUserFromSession (){
		ActionContext context = ActionContext.getContext();  
	    Map<String, Object> session = context.getSession();
	    User user=new User();
	    //user=(User) session.get("user");
	    user.setId(2);
	    return user;
	}
	public static Club getClubFromSession (){
		ActionContext context = ActionContext.getContext();  
	    Map<String, Object> session = context.getSession();
	    Club club=new Club();
	   // user=(User) session.get("");
	    club.setId(1);
	    return club;
	}
	public static Merchant getMerchantFromSession (){
		ActionContext context = ActionContext.getContext();  
	    Map<String, Object> session = context.getSession();
	    Merchant merchant=new Merchant();
	   // user=(User) session.get("");
	    merchant.setId(1);
	    return merchant;
	}

}
