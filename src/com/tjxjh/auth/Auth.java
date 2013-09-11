package com.tjxjh.auth;

import com.opensymphony.xwork2.ActionInvocation;

public interface Auth {
	public abstract boolean isPass(ActionInvocation ai);
}
