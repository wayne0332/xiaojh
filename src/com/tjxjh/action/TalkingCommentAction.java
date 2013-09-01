package com.tjxjh.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import com.tjxjh.po.TalkingComment;
import com.tjxjh.po.User;
import com.tjxjh.service.TalkingCommentService;
import com.tjxjh.util.Auth;
import com.tjxjh.util.GetRequsetResponse;


@ParentPackage("struts-default")
@Namespace("/")
public class TalkingCommentAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	@Resource
	private TalkingCommentService talkingCommentService = null;
	private TalkingComment talkingComment=new TalkingComment();
	private String message;//提示信息
	User user=new User();
	private int userid; //评论用户id
	private String actionName;
	private List<TalkingComment> tcs=new ArrayList<TalkingComment>();
	@Action(value = "addTalkingComment", results = {})
	public String add(){
		user=Auth.getUserFromSession();
		talkingComment.setUser(user);
		boolean b=talkingCommentService.add(talkingComment,userid);
		PrintWriter out =GetRequsetResponse.getAjaxPrintWriter();
		StringBuilder temp=new StringBuilder();
		if(b){
			temp.append("<div id='tc"+talkingComment.getId()+"' class='user_pinglun_div w610 cb tc_detail'><div class='w40 h40 mt5 mr10 fl '> <a href='userHome?user.id=");
			temp.append(user.getId()+"' target='_blank' class='f12 user_name_color'>");
			temp.append("<img src='");
			temp.append(user.getPortraitPath());
			temp.append("' class='w40 h40 shadow_l_10 radius_6' /></a></div><div class='fl w560'><a href='userHome?user.id=");
			temp.append(user.getId()+"' target='_blank' class='f12 user_name_color'>"+user.getName()+"</a>：");
			temp.append(talkingComment.getText()+"<br/><div class='fl color_gray'>");
			temp.append(talkingComment.getDatetime().toString().substring(5,16));
			temp.append("&nbsp;&nbsp;&nbsp;</div><a href='javascript:void(0);' onclick=\"huifu(");
			temp.append(talkingComment.getTalking().getId()+",'"+user.getName()+"',"+user.getId());
			temp.append(");\" class='f12 user_name_color'>回复</a>");
			temp.append("<span class='delete_tc'>&nbsp;&nbsp;<a href='javascript:void(0);' onclick='deleteTalkingComment("+talkingComment.getId()+");' class='f12 user_name_color'>删除</a></span>");
			temp.append("</div><div class='cb'></div></div>");
			out.print(temp.toString());
			out.flush();
			out.close();
			return null;
		}else{
			out.print("0");
			out.flush();
			out.close();
			return null;
		}
	}
	@Action(value = "deleteTalkingcomment", results = {})
	public String deleteTalkingComment(){
			PrintWriter out =GetRequsetResponse.getAjaxPrintWriter();
			user=Auth.getUserFromSession();
			talkingComment=talkingCommentService.findOneByHql(new Object[]{talkingComment.getId(),user.getId()});
			if(talkingComment==null)
			{
				out.print("0");
				out.flush();
				out.close();
				return null;
			}else{
				talkingCommentService.delete(talkingComment);
				out.print("1");
				out.flush();
				out.close();
				return null;
			}
	}
	@Action(value = "admindeleteTalkingcomment", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "success.jsp")})
	public String adminDeleteTalkingComment(){
			user=Auth.getUserFromSession();
			talkingComment=talkingCommentService.findOneByHql(new Object[]{talkingComment.getId(),user.getId()});
			if(talkingComment==null)
			{
				message="删除失败！该文件不存在，或你正在非法删除数据";
				return SUCCESS;
			}
			talkingCommentService.delete(talkingComment);
	    	message="删除成功";
			return SUCCESS;
	}
	
	public TalkingCommentService getTalkingCommentService() {
		return talkingCommentService;
	}
	public void setTalkingCommentService(TalkingCommentService talkingCommentService) {
		this.talkingCommentService = talkingCommentService;
	}
	public TalkingComment getTalkingComment() {
		return talkingComment;
	}
	public void setTalkingComment(TalkingComment talkingComment) {
		this.talkingComment = talkingComment;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
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
	public List<TalkingComment> getTcs() {
		return tcs;
	}
	public void setTcs(List<TalkingComment> tcs) {
		this.tcs = tcs;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	

}
