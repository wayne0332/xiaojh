package com.tjxjh.pojo;

import java.util.List;
import cn.cafebabe.autodao.pojo.Page;
import com.tjxjh.po.Activity;
public class ActivityList {
	private List<Activity> acs;
	private Page page;
	
	public List<Activity> getAcs() {
		return acs;
	}
	public void setAcs(List<Activity> acs) {
		this.acs = acs;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	
}
