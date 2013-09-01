package com.tjxjh.action;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.ActivityPost;
import com.tjxjh.po.ActivityPostComment;
import com.tjxjh.po.OnlineActivity;
import com.tjxjh.po.User;
import com.tjxjh.pojo.ActivityPostContent;
import com.tjxjh.pojo.ActivityPostList;
import com.tjxjh.service.ActivityPostService;

@ParentPackage("struts-default")
@Namespace("/")
public class ActivityPostAction extends BaseAction{
	@Resource
	private ActivityPostService service = null;
	private ActivityPost post = null;
	private int activityId;
	private int postId;
	private int pageNum;
	private ActivityPostComment comment = null;
	
	@Action(value = "initAddActivityPost", results = {
			@Result(name = SUCCESS, location = FOREPART+"addActivityPost.jsp")})
	public String initAddActivityPost(){
		return SUCCESS;
	}
	
	@Action(value = "addActivityPost", results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "activityPostList"),
			@Result(name = INPUT, location = FOREPART+"historyBack.jsp")})
	public String addActivityPost(){
		if(!(post==null
				||post.getTitle()==null
				||"".equals(post.getTitle())
				||post.getTitle().length()>100
				||post.getText()==null
				||"".equals(post.getText())
				||post.getText().length()>8000)){
			OnlineActivity activity = new OnlineActivity();
			activity.setId(activityId);
			post.setOnlineActivity(activity);
			post.setUser((User)getSessionMap().get("user"));
			service.addActivityPost(post);
		}else{
			return INPUT;
		}
		return SUCCESS;
	}
	
	@Action(value = "allActivityPost", results = {
			@Result(name = SUCCESS,location = MANAGE+"allActivityPost.jsp")})
	public String allActivityPost(){
		Page page = new Page(pageNum*Page.getDefaultPageNumber()+1);
		page.setCurrentPage(pageNum);
		ActivityPostList activityPostList = new ActivityPostList();
		activityPostList.setActivityPostList(service.allActivityPost(page));
		activityPostList.setPage(service.activityPostNum(0, page));
		for(ActivityPost c:activityPostList.getActivityPostList()){
			c.getOnlineActivity().getTittle();
			c.getUser().getName();
			c.getActivityPostComments().size();
		}
		activityPostList.setPage(service.activityPostNum(0, page));
		getRequestMap().put("activityPostList", activityPostList);
		return SUCCESS;
	}
	
	@Action(value = "activityPostList", results = {
			@Result(name = SUCCESS, location = FOREPART+"activityPostList.jsp")})
	public String activityPostList(){
		Page page = new Page(pageNum*7+1);
		page.setCurrentPage(pageNum);
		ActivityPostList activityPostList = new ActivityPostList();
		activityPostList.setActivityPostList(service.activityPostList(activityId, page));
		activityPostList.setPage(service.activityPostNum(activityId, page));
		getRequestMap().put("activityPostList", activityPostList);
		return SUCCESS;
	}
	
	@Action(value = "activityPostContent", results = {
			@Result(name = SUCCESS, location = FOREPART+"activityPost.jsp")})
	public String activityPostContent(){
		Page page = new Page(pageNum*Page.getDefaultPageNumber()+1);
		page.setCurrentPage(pageNum);
		ActivityPostContent activityPostContent = service.activityPostContent(postId,page);
		getRequestMap().put("activityPostContent", activityPostContent);
		return SUCCESS;
	}
	
	@Action(value = "addActivityComment", results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "activityPostContent",params = {
					"postId", "${#request.postId}","pageNum", "${#request.pageNum}"})})
	public String addComment(){
		comment.setUser((User)getSessionMap().get("user"));
		ActivityPost targetPost = new ActivityPost();
		targetPost.setId(postId);
		comment.setActivityPost(targetPost);
		if(service.addComment(comment)){
			return SUCCESS;
		}else{
			return INPUT;
		}
	}
	
	@Action(value = "deleteActivityPost", results = {
			@Result(name = SUCCESS,type=REDIRECT_ACTION, location = "activityPostList", params={"activityId","${activityId}","pageNum","${pageNum}"})})
	public String deleteActivityPost(){
		if(service.deleteActivityPost(post)){
			return SUCCESS;
		}
		return INPUT;
	}
	
	@Action(value = "adminDeleteActivityPost", results = {
			@Result(name = SUCCESS,type=REDIRECT_ACTION, location = "allActivityPost", params={"pageNum","${pageNum}"})})
	public String adminDeleteActivityPost(){
		if(service.deleteActivityPost(post)){
			return SUCCESS;
		}
		return INPUT;
	}
	
	@Action(value = "deleteActivityComment", results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "activityPostContent",params = {
					"postId", "${#request.postId}","pageNum", "${#request.pageNum}"})})
	public String deleteComment(){
		
		if(service.deleteComment(comment)){
			return SUCCESS;
		}else{
			return INPUT;
		}
		
	}
	public ActivityPost getPost() {
		return post;
	}
	public void setPost(ActivityPost post) {
		this.post = post;
	}
	public int getActivityId() {
		return activityId;
	}
	public void setActivityId(int activityId) {
		this.activityId = activityId;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public ActivityPostComment getComment() {
		return comment;
	}
	public void setComment(ActivityPostComment comment) {
		this.comment = comment;
	}
	public void setService(ActivityPostService service) {
		this.service = service;
	}
	
	
}
