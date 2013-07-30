package com.tjxjh.pojo;

import java.util.List;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.User;

public class SearchResult {
	private Page page = null;
	private List<User> userList = null;
	private List<Club> clubList = null;
	private List<Merchant> merchantList = null;
	
	
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public List<User> getUserList() {
		return userList;
	}
	public void setUserList(List<User> userList) {
		this.userList = userList;
	}
	public List<Club> getClubList() {
		return clubList;
	}
	public void setClubList(List<Club> clubList) {
		this.clubList = clubList;
	}
	public List<Merchant> getMerchantList() {
		return merchantList;
	}
	public void setMerchantList(List<Merchant> merchantList) {
		this.merchantList = merchantList;
	}
	
}
