package com.tjxjh.pojo;

import java.util.List;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.ClubNews;

public class ClubNewsList {
	private List<ClubNews> clubNewsList;
	private Page page;
	public List<ClubNews> getClubNewsList() {
		return clubNewsList;
	}
	public void setClubNewsList(List<ClubNews> clubNewsList) {
		this.clubNewsList = clubNewsList;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	
}
