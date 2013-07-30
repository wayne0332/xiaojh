package com.tjxjh.enumeration;

public enum MerchantType
{
	STATE_OWNED("国企");
	private final String name;
	
	private MerchantType(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}
