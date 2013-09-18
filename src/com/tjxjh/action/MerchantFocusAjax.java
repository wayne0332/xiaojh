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
import com.tjxjh.enumeration.MerchantStatus;
import com.tjxjh.interceptor.AuthInterceptor.UserWithClubMemberAuth;
import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.service.MerchantService;
@ParentPackage("myPackage")
@Namespace("/")
public class MerchantFocusAjax extends BaseAction{
	@Resource
	private MerchantService service = null;
	private int id;
	private Merchant merchant;
	private int isPass;
	@Action(value = "merchantFocusClub", results = {
			@Result(name = SUCCESS, type = "xslt")})
	@Auth(auths={AuthEnum.MERCHANT})
	public String focusClub(){
		int flag = 1;
		Merchant merchant = (Merchant)getSessionMap().get("merchant");
		Club target = new Club();
		if(id==0||merchant==null){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = service.focusClub(merchant,target);
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
	
	@Action(value = "merchantCancelFocusClub", results = {
			@Result(name = SUCCESS, type = "xslt")})
	@Auth(auths={AuthEnum.MERCHANT})
	public String cancelFocusClub(){
		int flag = 1;
		Merchant merchant = (Merchant)getSessionMap().get("merchant");
		
		Club target = new Club();
		if(id==0||merchant==null){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = service.cancelFocusClub(merchant,target);
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
	
	@Action(value = "merchantFocusMerchant", results = {
			@Result(name = SUCCESS, type = "xslt")})
	@Auth(auths={AuthEnum.MERCHANT})
	public String focusMerchant(){
		int flag = 1;
		Merchant merchant = (Merchant)getSessionMap().get("merchant");
		Merchant target = new Merchant();
		if(id==0||merchant==null){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = service.focusMerchant(merchant,target);
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
	
	@Action(value = "merchantCancelFocusMerchant",  results = {
			@Result(name = SUCCESS, type = "xslt")})
	@Auth(auths={AuthEnum.MERCHANT})
	public String cancelFocusMerchant(){
		int flag = 1;
		Merchant merchant = (Merchant)getSessionMap().get("merchant");
		Merchant target = new Merchant();
		if(id==0||merchant==null){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = service.cancelFocusMerchant(merchant,target);
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
	
	@Action(value = "denyMerchant", results = {@Result(name = SUCCESS, type = "xslt")})
	@Auth(auths={AuthEnum.ADMIN})
	public String denyMerchant(){
		int flag = 1;
		Merchant target = new Merchant();
		if(id==0){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = service.changeMerchantStatus(target, MerchantStatus.DENIED);
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
	
	@Action(value = "checkMerchant", results = {@Result(name = SUCCESS, type = "xslt")})
	@Auth(auths={AuthEnum.ADMIN})
	public String checkMerchant(){
		int flag = 1;
		if(merchant.getId()==0){
			flag = 0;
		}else{
			boolean b = service.checkMerchant(merchant, isPass==1?true:false);
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

	public Merchant getMerchant() {
		return merchant;
	}

	public void setMerchant(Merchant merchant) {
		this.merchant = merchant;
	}

	public int getIsPass() {
		return isPass;
	}

	public void setIsPass(int isPass) {
		this.isPass = isPass;
	}

	public void setService(MerchantService service) {
		this.service = service;
	}
	
}
