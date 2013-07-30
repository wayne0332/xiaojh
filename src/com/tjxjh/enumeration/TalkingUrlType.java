package com.tjxjh.enumeration;

public enum TalkingUrlType
{
	PICTURE("图片"), VIDEO("视频");
	private final String name;
	
	private TalkingUrlType(String name)
	{
		this.name = name;
	}
	
	public String getName()
	{
		return name;
	}
}
