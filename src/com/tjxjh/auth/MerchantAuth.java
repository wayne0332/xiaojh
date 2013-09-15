package com.tjxjh.auth;

import com.opensymphony.xwork2.ActionInvocation;
import com.tjxjh.action.BaseAction;
import com.tjxjh.po.Merchant;

public class MerchantAuth extends UserAuth {
	MerchantAuth() {
		super();
	}

	@Override
	public boolean isPass(ActionInvocation ai) {
		if (currentMerchant() != null) {
			return true;
		}
		return false;
	}

	protected Merchant currentMerchant() {
		return (Merchant) getSessionMap().get(BaseAction.MERCHANT);
	}
}
