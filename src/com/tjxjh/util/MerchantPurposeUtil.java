package com.tjxjh.util;

import java.util.HashMap;
import java.util.Map;

public class MerchantPurposeUtil
{
	public final static Map<String, String> purposesMap = new HashMap<String, String>();
	static
	{
		purposesMap.put("1", "校园赞助");
	}
	
	public static String transformPurpose(String[] purposes)
	{
		StringBuilder _purposes = new StringBuilder();
		for(String purpose : purposes)
		{
			_purposes.append(purpose).append(",");
		}
		if(_purposes.length() != 0)
		{
			return _purposes.substring(0, _purposes.length() - 1);
		}
		else
		{
			return "";
		}
	}
}
