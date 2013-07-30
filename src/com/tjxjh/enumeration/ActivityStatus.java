package com.tjxjh.enumeration;

public enum ActivityStatus
{
	APPLY("正在申请..."), UNDERWAY("正在进行..."),END("活动已结束"),REFUSE("申请被拒绝");
	private final String name;
	
	private ActivityStatus(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
	
}
