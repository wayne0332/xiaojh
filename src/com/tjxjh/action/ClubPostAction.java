package com.tjxjh.action;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.Club;
import com.tjxjh.po.ClubPost;
import com.tjxjh.po.ClubPostComment;
import com.tjxjh.po.User;
import com.tjxjh.pojo.ClubPostContent;
import com.tjxjh.pojo.ClubPostList;
import com.tjxjh.service.ClubPostService;

@ParentPackage("struts-default")
@Namespace("/")
public class ClubPostAction extends BaseAction{
	@Resource
	private ClubPostService service = null;
	private ClubPost post = null;
	private int clubId;
	private int postId;
	private int pageNum;
	private ClubPostComment comment = null;
	@Action(value = "initAddClubPost", results = {
			@Result(name = SUCCESS, location = FOREPART+"addClubPost.jsp")})
	public String initAddClubPost(){
		return SUCCESS;
	}
	
	@Action(value = "addClubPost", results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "clubPostList"),
			@Result(name = INPUT, location = FOREPART+"historyBack.jsp")})
	public String addClubPost(){
		if(!(post==null
				||post.getTittle()==null
				||"".equals(post.getTittle())
				||post.getTittle().length()>100
				||post.getText()==null
				||"".equals(post.getText())
				||post.getText().length()>8000)){
			Club club = new Club();
			club.setId(clubId);
			post.setClub(club);
			post.setUser((User)getSessionMap().get("user"));
			service.addClubPost(post);
		}else{
			return INPUT;
		}
		return SUCCESS;
	}
	@Action(value = "clubPostList", results = {
			@Result(name = SUCCESS, location = FOREPART+"clubPostList.jsp")})
	public String clubPostList(){
		Page page = new Page(pageNum*7+1);
		page.setCurrentPage(pageNum);
		ClubPostList clubPostList = new ClubPostList();
		clubPostList.setClubPostList(service.clubPostList(clubId, page));
		clubPostList.setPage(service.clubPostNum(clubId, page));
		getRequestMap().put("clubPostList", clubPostList);
		return SUCCESS;
	}
	@Action(value = "clubPostContent", results = {
			@Result(name = SUCCESS, location = FOREPART+"clubPost.jsp")})
	public String clubPostContent(){
		Page page = new Page(pageNum*Page.getDefaultPageNumber()+1);
		page.setCurrentPage(pageNum);
		ClubPostContent clubPostContent = service.clubPostContent(postId,page);
		getRequestMap().put("clubPostContent", clubPostContent);
		return SUCCESS;
	}
	@Action(value = "addComment", results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "clubPostContent",params = {
					"postId", "${#request.postId}","pageNum", "${#request.pageNum}"})})
	public String addComment(){
		comment.setUser((User)getSessionMap().get("user"));
		ClubPost targetPost = new ClubPost();
		targetPost.setId(postId);
		comment.setClubPost(targetPost);
		if(service.addComment(comment)){
			return SUCCESS;
		}else{
			return INPUT;
		}
	}
	@Action(value = "deleteComment", results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "clubPostContent",params = {
					"postId", "${#request.postId}","pageNum", "${#request.pageNum}"})})
	public String deleteComment(){
		
		if(service.deleteComment(comment)){
			return SUCCESS;
		}else{
			return INPUT;
		}
		
	}
	public void setService(ClubPostService service) {
		this.service = service;
	}

	public ClubPost getPost() {
		return post;
	}

	public void setPost(ClubPost post) {
		this.post = post;
	}
	public int getClubId() {
		return clubId;
	}
	public void setClubId(int clubId) {
		this.clubId = clubId;
	}
	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public ClubPostService getService() {
		return service;
	}

	public int getPostId() {
		return postId;
	}

	public void setPostId(int postId) {
		this.postId = postId;
	}

	public ClubPostComment getComment() {
		return comment;
	}

	public void setComment(ClubPostComment comment) {
		this.comment = comment;
	}
	
	
}
