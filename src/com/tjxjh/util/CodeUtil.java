package com.tjxjh.util;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;

public class CodeUtil
{
	public static String encode(String code)
	{
		return new String(new Base64().encode(code.getBytes()));
	}
	
	public static String decode(String code)
	{
		return new String(new Base64().decode(code.getBytes()));
	}
	
	public static String md5(String text)
	{
		return DigestUtils.md2Hex(text);
	}
}
