package com.tjxjh.enumeration;

public enum Sex
{
	MAN("男"), WOMEN("女");
	private final String name;
	
	private Sex(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}
