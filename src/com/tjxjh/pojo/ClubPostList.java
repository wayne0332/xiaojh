package com.tjxjh.pojo;

import java.util.List;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.ClubPost;

public class ClubPostList {
	private List<ClubPost> clubPostList = null;
	private Page page = null;
	
	public List<ClubPost> getClubPostList() {
		return clubPostList;
	}
	public void setClubPostList(List<ClubPost> clubPostList) {
		this.clubPostList = clubPostList;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
}
