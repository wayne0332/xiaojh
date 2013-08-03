package com.tjxjh.util;

public class StringUtil
{
	public static boolean isEmpty(String text)
	{
		return text == null ? true : text.trim().equals("");
	}
}
