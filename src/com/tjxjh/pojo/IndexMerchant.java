package com.tjxjh.pojo;

import java.util.List;

import com.tjxjh.po.Activity;
import com.tjxjh.po.Merchant;


public class IndexMerchant implements java.io.Serializable
{

	private static final long serialVersionUID = 1L;
	private List<Activity> acs;
	private Merchant merchant;
	public List<Activity> getAcs() {
		return acs;
	}
	public void setAcs(List<Activity> acs) {
		this.acs = acs;
	}
	public Merchant getMerchant() {
		return merchant;
	}
	public void setMerchant(Merchant merchant) {
		this.merchant = merchant;
	}


	
	
}
