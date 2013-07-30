package com.tjxjh.enumeration;

public enum ClubType
{
	MUSIC("音乐");
	private final String name;
	
	private ClubType(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}
