package com.tjxjh.enumeration;

public enum ClubMemberSource
{
	CLUB_TO_USER("社团"),USER_TO_CLUB("用户");
	private final String name;
	
	private ClubMemberSource(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}
