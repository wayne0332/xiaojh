package com.tjxjh.enumeration;

import com.tjxjh.action.UserAction;

public enum MailValidateType
{
	REGISTER_VALIDATE("注册验证", UserAction.REGISTER_VALIDATE), CHANGE_USER_PASSWORD(
			"重置用户密码", UserAction.RESET_USER_PASSWORD_INPUT);
	private final String name, path;
	
	private MailValidateType(String name, String path)
	{
		this.name = name;
		this.path = path;
	}
	
	public String getName()
	{
		return name;
	}
	
	public String getPath()
	{
		return path;
	}
}
