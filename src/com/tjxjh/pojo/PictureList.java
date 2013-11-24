package com.tjxjh.pojo;

import java.util.List;
import cn.cafebabe.autodao.pojo.Page;
import com.tjxjh.po.Activity;
import com.tjxjh.po.Picture;
public class PictureList {
	private List<Picture> pics;
	private Page page;
	
	
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public List<Picture> getPics() {
		return pics;
	}
	public void setPics(List<Picture> pics) {
		this.pics = pics;
	}
	
}
