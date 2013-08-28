package com.tjxjh.enumeration;

public enum UserStatus
{
	NO_VALIDATE("未验证"), VALIDATED("已验证"), SYSTEM("系统用户"), ADMIN("超级管理员"),DENIED("账号被封");
	private final String name;
	
	private UserStatus(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}
