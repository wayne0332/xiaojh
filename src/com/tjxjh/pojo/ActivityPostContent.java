package com.tjxjh.pojo;

import java.util.List;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.ActivityPost;
import com.tjxjh.po.ActivityPostComment;

public class ActivityPostContent {
	private ActivityPost activityPost = null;
	private List<ActivityPostComment> commentList = null;
	private Page page = null;
	
	public ActivityPost getActivityPost() {
		return activityPost;
	}
	public void setActivityPost(ActivityPost activityPost) {
		this.activityPost = activityPost;
	}
	public List<ActivityPostComment> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<ActivityPostComment> commentList) {
		this.commentList = commentList;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	
}
