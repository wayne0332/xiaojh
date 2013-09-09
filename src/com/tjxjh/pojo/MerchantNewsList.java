package com.tjxjh.pojo;

import java.util.List;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.MerchantNews;

public class MerchantNewsList {
	private List<MerchantNews> merchantNewsList = null;
	private Page page = null;
	public List<MerchantNews> getMerchantNewsList() {
		return merchantNewsList;
	}
	public void setMerchantNewsList(List<MerchantNews> merchantNewsList) {
		this.merchantNewsList = merchantNewsList;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
}
