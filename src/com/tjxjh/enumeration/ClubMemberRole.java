package com.tjxjh.enumeration;

public enum ClubMemberRole
{
	NORMAL("普通社员"), MANAGER("管理员"), PROPRIETER("社长");
	private final String name;
	
	private ClubMemberRole(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}
