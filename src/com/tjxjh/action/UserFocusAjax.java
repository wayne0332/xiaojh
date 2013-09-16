package com.tjxjh.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import com.tjxjh.annotation.Auth;
import com.tjxjh.auth.AuthEnum;
import com.tjxjh.enumeration.UserStatus;
import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.User;
import com.tjxjh.service.UserService;

@ParentPackage("myPackage")
@Namespace("/")
public class UserFocusAjax extends BaseAction{
	@Resource
	private UserService userService = null;
	private int id;
	@Action(value = "focusUser", results = {
			@Result(name = SUCCESS, type = "xslt")})
	@Auth(auths={AuthEnum.USER})
	public String focusUser(){
		int flag = 1;
		User user = (User)getSessionMap().get("user");
		User target = new User();
		if(id==0){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = userService.focusUser(user,target);
			if(b){
				flag = 1;
			}else{
				flag = 0;
			}
		}
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("pragma","no-cache");
		response.setHeader("cache-control","no-cache");
		response.setHeader("expires","0");
		response.setContentType("text/xml;charset=utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.print("<?xml version='1.0' encoding='utf-8'?>");
		out.print("<isSuccess>"+flag+"</isSuccess>");
		return null;
	}
	@Action(value = "cancelFocusUser", results = {
			@Result(name = SUCCESS, type = "xslt")})
	@Auth(auths={AuthEnum.USER})
	public String cancelFocus(){
		int flag = 1;
		User user = (User)getSessionMap().get("user");
		User target = new User();
		if(id==0){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = userService.cancelFocusUser(user,target);
			if(b){
				flag = 1;
			}else{
				flag = 0;
			}
		}
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("pragma","no-cache");
		response.setHeader("cache-control","no-cache");
		response.setHeader("expires","0");
		response.setContentType("text/xml;charset=utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.print("<?xml version='1.0' encoding='utf-8'?>");
		out.print("<isSuccess>"+flag+"</isSuccess>");
		return null;
	}
	
	@Action(value = "focusClub", results = {
			@Result(name = SUCCESS, type = "xslt")})
	@Auth(auths={AuthEnum.USER})
	public String focusClub(){
		int flag = 1;
		User user = (User)getSessionMap().get("user");
		Club target = new Club();
		if(id==0){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = userService.focusClub(user,target);
			if(b){
				flag = 1;
			}else{
				flag = 0;
			}
		}
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("pragma","no-cache");
		response.setHeader("cache-control","no-cache");
		response.setHeader("expires","0");
		response.setContentType("text/xml;charset=utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.print("<?xml version='1.0' encoding='utf-8'?>");
		out.print("<isSuccess>"+flag+"</isSuccess>");
		return null;
	}
	
	@Action(value = "cancelFocusClub", results = {
			@Result(name = SUCCESS, type = "xslt")})
	@Auth(auths={AuthEnum.USER})
	public String cancelFocusClub(){
		int flag = 1;
		User user = (User)getSessionMap().get("user");
		Club target = new Club();
		if(id==0){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = userService.cancelFocusClub(user,target);
			if(b){
				flag = 1;
			}else{
				flag = 0;
			}
		}
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("pragma","no-cache");
		response.setHeader("cache-control","no-cache");
		response.setHeader("expires","0");
		response.setContentType("text/xml;charset=utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.print("<?xml version='1.0' encoding='utf-8'?>");
		out.print("<isSuccess>"+flag+"</isSuccess>");
		return null;
	}
	
	@Action(value = "focusMerchant", results = {
			@Result(name = SUCCESS, type = "xslt")})
	@Auth(auths={AuthEnum.USER})
	public String focusMerchant(){
		int flag = 1;
		User user = (User)getSessionMap().get("user");
		Merchant target = new Merchant();
		if(id==0){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = userService.focusMerchant(user,target);
			if(b){
				flag = 1;
			}else{
				flag = 0;
			}
		}
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("pragma","no-cache");
		response.setHeader("cache-control","no-cache");
		response.setHeader("expires","0");
		response.setContentType("text/xml;charset=utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.print("<?xml version='1.0' encoding='utf-8'?>");
		out.print("<isSuccess>"+flag+"</isSuccess>");
		return null;
	}
	
	@Action(value = "cancelFocusMerchant", results = {
			@Result(name = SUCCESS, type = "xslt")})
	@Auth(auths={AuthEnum.USER})
	public String cancelFocusMerchant(){
		int flag = 1;
		User user = (User)getSessionMap().get("user");
		Merchant target = new Merchant();
		if(id==0){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = userService.cancelFocusMerchant(user,target);
			if(b){
				flag = 1;
			}else{
				flag = 0;
			}
		}
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("pragma","no-cache");
		response.setHeader("cache-control","no-cache");
		response.setHeader("expires","0");
		response.setContentType("text/xml;charset=utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.print("<?xml version='1.0' encoding='utf-8'?>");
		out.print("<isSuccess>"+flag+"</isSuccess>");
		return null;
	}
	
	@Action(value = "denyUser", results = {@Result(name = SUCCESS, type = "xslt")})
	@Auth(auths={AuthEnum.ADMIN})
		public String denyUser(){
			int flag = 1;
			User target = new User();
			if(id==0){
				flag = 0;
			}else{
				target.setId(id);
				boolean b = userService.changeUserStatus(target, UserStatus.DENIED);
				if(b){
					flag = 1;
				}else{
					flag = 0;
				}
			}
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setHeader("pragma","no-cache");
			response.setHeader("cache-control","no-cache");
			response.setHeader("expires","0");
			response.setContentType("text/xml;charset=utf-8");
			PrintWriter out = null;
			try {
				out = response.getWriter();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			out.print("<?xml version='1.0' encoding='utf-8'?>");
			out.print("<isSuccess>"+flag+"</isSuccess>");
			return null;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
}
