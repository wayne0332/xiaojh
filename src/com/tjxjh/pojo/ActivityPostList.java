package com.tjxjh.pojo;

import java.util.List;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.ActivityPost;

public class ActivityPostList {
	private List<ActivityPost> activityPostList = null;
	private Page page = null;
	
	public List<ActivityPost> getActivityPostList() {
		return activityPostList;
	}
	public void setActivityPostList(List<ActivityPost> activityPostList) {
		this.activityPostList = activityPostList;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	
}
