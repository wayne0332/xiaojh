package com.tjxjh.pojo;

import java.util.List;
import cn.cafebabe.autodao.pojo.Page;
import com.tjxjh.po.OnlineActivity;
public class OnlineActivityList {
	private List<OnlineActivity> oacs;
	private Page page;
	
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public List<OnlineActivity> getOacs() {
		return oacs;
	}
	public void setOacs(List<OnlineActivity> oacs) {
		this.oacs = oacs;
	}
	
	
}
