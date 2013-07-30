package com.tjxjh.enumeration;

public enum ClubStatus
{
	NO_CHECK("未审核"), PASSED("已通过审核"), NO_PASSED("没通过审核");
	private final String name;
	
	private ClubStatus(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}
