package com.tjxjh.action;

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


@ParentPackage("struts-default")
@Namespace("/")
public class TalkingCommentAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	@Resource
	private TalkingCommentService talkingCommentService = null;
	private TalkingComment talkingComment=new TalkingComment();
	private String message;//提示信息
	User user=new User();
	private String actionName;
	private List<TalkingComment> tcs=new ArrayList<TalkingComment>();
	@Action(value = "addTalkingComment", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "success.jsp")})
	public String add(){
		user=Auth.getUserFromSession();
		talkingComment.setUser(user);
		if(talkingCommentService.add(talkingComment)){
			message="评论成功";
			return SUCCESS;
		}
		message="评论失败";
		return SUCCESS;
    	
	}
	@Action(value = "deleteTalkingcomment", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "success.jsp")})
	public String deleteTalkingComment(){
			user=Auth.getUserFromSession();
			talkingComment=talkingCommentService.findOneByHql(new Object[]{user.getId(),talkingComment.getId()});
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
	

}
