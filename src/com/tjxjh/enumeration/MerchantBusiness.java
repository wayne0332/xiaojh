package com.tjxjh.enumeration;

public enum MerchantBusiness
{
	ELECTRON("电子");
	private final String name;
	
	private MerchantBusiness(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}
