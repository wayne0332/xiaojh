package com.tjxjh.enumeration;

public enum TalkingStatus
{
	SHARE("可分享"), DELETE("删除");
	private final String name;
	
	private TalkingStatus(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}
