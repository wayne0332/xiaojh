package com.tjxjh.enumeration;

public enum ClubMemberStatus
{
	NO_CHECK("未处理"), PASSED("已通过"), NO_PASSED("未通过"), DELETE("已离开");
	private final String name;
	
	private ClubMemberStatus(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}
