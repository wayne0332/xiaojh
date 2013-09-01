package com.tjxjh.enumeration;

public enum MerchantStatus
{
	NO_CHECK("未审核"), PASSED("已通过审核"), NO_PASSED("没通过审核"),DENIED("被封号");
	private final String name;
	
	private MerchantStatus(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}
