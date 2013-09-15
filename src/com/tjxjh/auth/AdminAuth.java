package com.tjxjh.auth;

import com.opensymphony.xwork2.ActionInvocation;
import com.tjxjh.enumeration.UserStatus;

class AdminAuth extends UserAuth {

	AdminAuth() {
		super();
	}

	@Override
	public boolean isPass(ActionInvocation ai) {
		if (super.isPass(ai)) {
			if (currentUser().getStatus() == UserStatus.ADMIN) {
				return true;
			}
		}
		return false;
	}
}
