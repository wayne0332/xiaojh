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

import com.tjxjh.enumeration.ClubStatus;
import com.tjxjh.po.Club;
import com.tjxjh.po.ClubMember;
import com.tjxjh.po.Merchant;
import com.tjxjh.service.ClubService;

@ParentPackage("struts-default")
@Namespace("/")
public class ClubFocusAjax extends BaseAction{
	@Resource
	private ClubService service = null;
	private int id;
	private Club club;
	private int isPass;
	
	@Action(value = "clubFocusClub", results = {
			@Result(name = SUCCESS, type = "xslt")})
	public String focusClub(){
		int flag = 1;
		ClubMember clubMember = (ClubMember)getSessionMap().get("clubMember");
		Club target = new Club();
		if(id==0||clubMember==null){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = service.focusClub(clubMember,target);
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
	
	@Action(value = "clubCancelFocusClub", results = {
			@Result(name = SUCCESS, type = "xslt")})
	public String cancelFocusClub(){
		int flag = 1;
		ClubMember clubMember = (ClubMember)getSessionMap().get("clubMember");
		
		Club target = new Club();
		if(id==0||clubMember==null){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = service.cancelFocusClub(clubMember,target);
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
	
	@Action(value = "clubFocusMerchant", results = {
			@Result(name = SUCCESS, type = "xslt")})
	public String focusMerchant(){
		int flag = 1;
		ClubMember clubMember = (ClubMember)getSessionMap().get("clubMember");
		Merchant target = new Merchant();
		if(id==0||clubMember==null){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = service.focusMerchant(clubMember,target);
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
	
	@Action(value = "clubCancelFocusMerchant",  results = {
			@Result(name = SUCCESS, type = "xslt")})
	public String cancelFocusMerchant(){
		int flag = 1;
		ClubMember clubMember = (ClubMember)getSessionMap().get("clubMember");
		Merchant target = new Merchant();
		if(id==0||clubMember==null){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = service.cancelFocusMerchant(clubMember,target);
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
	
	@Action(value = "denyClub", results = {@Result(name = SUCCESS, type = "xslt")})
	public String denyClub(){
		int flag = 1;
		Club target = new Club();
		if(id==0){
			flag = 0;
		}else{
			target.setId(id);
			boolean b = service.changeClubStatus(target, ClubStatus.DENIED);
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
	
	@Action(value = "checkClub", results = {@Result(name = SUCCESS, type = "xslt")})
	public String checkClub()
	{
		
		int flag = 1;
		if(club.getId()==0){
			flag = 0;
		}else{
			boolean b = service.checkClub(club, isPass==1?true:false);
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
	public void setService(ClubService service) {
		this.service = service;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Club getClub() {
		return club;
	}

	public void setClub(Club club) {
		this.club = club;
	}

	public int getIsPass() {
		return isPass;
	}

	public void setIsPass(int isPass) {
		this.isPass = isPass;
	}
	
	
}
