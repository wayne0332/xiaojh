package com.tjxjh.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

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
			_purposes.append(processPurpose(purpose)).append(",");
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
	
	private static String processPurpose(String purpose)
	{
		return new StringBuilder("'").append(purpose).append("'").toString();
	}
	
	public static boolean isContainsPurpose(String merchantPurposes,
			String thePurpose)
	{
		return merchantPurposes.contains(processPurpose(thePurpose));
	}
	
	public static List<String> purposeToList(String purposes)
	{
		List<String> result = new ArrayList<String>();
		for(String purpose : StringUtils.split(purposes,","))
		{
			result.add(StringUtils.remove(purpose, "'"));
		} 
		return result;
	}
}
