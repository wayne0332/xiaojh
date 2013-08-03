package com.tjxjh.enumeration;

public enum AuthType
{
	NONE(0), USER(0), CLUB_MEMBER(0);
	private final int authLv;
	
	private AuthType(int authLv)
	{
		this.authLv = authLv;
	}
	
	public int getAuthLv()
	{
		return authLv;
	}
}
