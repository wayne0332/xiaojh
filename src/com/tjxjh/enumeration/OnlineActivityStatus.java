package com.tjxjh.enumeration;

public enum OnlineActivityStatus
{
	UNDERWAY("正在进行..."),END("活动已结束");
	private final String name;
	
	private OnlineActivityStatus(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
	
}
