package com.tjxjh.enumeration;

public enum PersonalLetterStatus
{
	NO_READ("未读"), HAD_READ("已读"), DELETE("已删除");
	private final String name;
	
	private PersonalLetterStatus(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}
