package com.tjxjh.pojo;

import java.util.List;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.ClubPost;
import com.tjxjh.po.ClubPostComment;

public class ClubPostContent {
	private ClubPost clubPost = null;
	private List<ClubPostComment> commentList = null;
	private Page page = null;
	
	
	public ClubPost getClubPost() {
		return clubPost;
	}
	public void setClubPost(ClubPost clubPost) {
		this.clubPost = clubPost;
	}
	public List<ClubPostComment> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<ClubPostComment> commentList) {
		this.commentList = commentList;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	
}
