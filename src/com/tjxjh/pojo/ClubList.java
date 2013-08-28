package com.tjxjh.pojo;

import java.util.List;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.Club;

public class ClubList {
	private List<Club> clubList = null;
	private Page page = null;
	public List<Club> getClubList() {
		return clubList;
	}
	public void setClubList(List<Club> clubList) {
		this.clubList = clubList;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	
}
