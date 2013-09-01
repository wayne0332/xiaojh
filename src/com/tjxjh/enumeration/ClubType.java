package com.tjxjh.enumeration;

public enum ClubType
{
	MUSIC("音乐类"),SPORT("体育类"),LITERATURE("文学类"),ART("艺术类"),
	SCIENCE("科技类"),WELFARE("公益类"),COMMERCE("商业类"),STARTBUSINESS("创业类"),LEARNING("学术类"),IT("IT信息类"),OTHERS("其他类");
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
