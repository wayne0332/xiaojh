package com.tjxjh.pojo;

import java.util.List;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.Merchant;

public class MerchantList {
	private List<Merchant> merchantList = null;
	private Page page;
	public List<Merchant> getMerchantList() {
		return merchantList;
	}
	public void setMerchantList(List<Merchant> merchantList) {
		this.merchantList = merchantList;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	
}
