package com.tjxjh.keyword;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@SuppressWarnings("rawtypes")
public class KeywordScreening
{
	private final char endTag = (char) (1); // 关键词结束符
	private Map<Character, HashMap> filterMap = new HashMap<Character, HashMap>(
			1024);
	
	public KeywordScreening(KeywordService service)
	{
		service.setKeywordScreening(this);
	}
	
	public void rebuildKeywordMap(String[] filterWordList)
	{
		rebuildKeywordMap(Arrays.asList(filterWordList));
	}
	
	@SuppressWarnings("unchecked")
	public void rebuildKeywordMap(Iterable<String> filterWordList)
	{
		for(String filterWord : filterWordList)
		{
			char[] charArray = filterWord.trim().toCharArray();
			int len = charArray.length;
			if(len > 0)
			{
				Map<Character, HashMap> subMap = filterMap;
				for(int i = 0; i < len - 1; i ++)
				{
					Map<Character, HashMap> obj = subMap.get(charArray[i]);
					if(obj == null)
					{
						// 新索引，增加HashMap
						int size = (int) Math.max(2, 16 / Math.pow(2, i));
						HashMap<Character, HashMap> subMapTmp = new HashMap<Character, HashMap>(
								size);
						subMap.put(charArray[i], subMapTmp);
						subMap = subMapTmp;
					}
					else
					{
						// 索引已经存在
						subMap = obj;
					}
				}
				// 处理最后一个字符
				Map<Character, HashMap> obj = subMap.get(charArray[len - 1]);
				if(obj == null)
				{
					// 新索引，增加HashMap，并设置结束符
					int size = (int) Math.max(2, 16 / Math.pow(2, len - 1));
					HashMap<Character, HashMap> subMapTmp = new HashMap<Character, HashMap>(
							size);
					subMapTmp.put(endTag, null);
					subMap.put(charArray[len - 1], subMapTmp);
				}
				else
				{
					// 索引已经存在,设置结束符
					obj.put(endTag, null);
				}
			}
		}
	}
	
	// 返回是否包含需要过滤的词,匹配到最短的关键词就返回结果
	@SuppressWarnings("unchecked")
	public boolean isHasFilterWord(String info)
	{
		if(info == null || info.length() == 0)
		{
			return false;
		}
		char[] charArray = info.toCharArray();
		int len = charArray.length;
		for(int i = 0; i < len; i ++)
		{
			int index = i;
			Map<Character, HashMap> sub = filterMap.get(charArray[index]);
			while(sub != null)
			{
				if(sub.containsKey(endTag))
				{
					// 匹配结束
					return true;
				}
				else
				{
					index ++;
					if(index >= len)
					{
						// 字符串结束
						return false;
					}
					sub = sub.get(charArray[index]);
				}
			}
		}
		return false;
	}
	
	// 将字符串中包含的关键字过滤并替换为*，然后退回替换后的字符串
	public String getFilterString(String info)
	{
		return getFilterString(info, "*");
	}
	
	// 将字符串中包含的关键词过滤并替换为指定字符串，然后退回替换后的字符串
	// 尽量匹配最长的关键词再替换，关键词最长不超过maxKeyWordLen
	@SuppressWarnings("unchecked")
	public String getFilterString(String info, String replaceTag)
	{
		if(info == null || info.length() == 0 || replaceTag == null
				|| replaceTag.length() == 0)
		{
			return info;
		}
		char[] charArray = info.toCharArray();
		int len = charArray.length;
		String newInfo = "";
		int i = 0;
		while(i < len)
		{
			int end = -1;
			int index;
			Map<Character, HashMap> sub = filterMap;
			for(index = i; index < len; index ++)
			{
				sub = sub.get(charArray[index]);
				if(sub == null)
				{
					// 匹配失败，将已匹配的最长字符进行替换
					if(end == -1)
					{
						// 没匹配到任何关键词
						newInfo += charArray[i];
						i ++;
						break;
					}
					else
					{
						// 将最长匹配字符串替换为特定字符
						for(int j = i; j <= end; j ++)
						{
							newInfo += replaceTag;
						}
						i = end + 1;
						break;
					}
				}
				else
				{
					if(sub.containsKey(endTag))
					{
						// 匹配
						end = index;
					}
				}
			}
			if(index >= len)
			{
				// 字符串结束
				if(end == -1)
				{
					// 没匹配到任何关键词
					newInfo += charArray[i];
					i ++;
				}
				else
				{
					// 将最长匹配字符串替换为特定字符
					for(int j = i; j <= end; j ++)
					{
						newInfo += replaceTag;
					}
					i = end + 1;
				}
			}
		}
		return newInfo;
	}
}
