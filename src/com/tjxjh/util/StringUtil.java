package com.tjxjh.util;

public class StringUtil
{
	public static boolean isNotEmpty(String text)
	{
		return text != null ? !text.trim().equals("") : false;
	}
	
	public static boolean isNotEmpty(String[] strings)
	{
		return strings != null && strings.length > 0;
	}
}
