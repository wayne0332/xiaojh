package com.tjxjh.interceptor;

import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.tjxjh.annotation.Keyword;
import com.tjxjh.keyword.KeywordScreening;

public class KeywordInterceptor extends AbstractInterceptor
{
	private static final long serialVersionUID = 6633947501080287035L;
	private static KeywordScreening keywordScreening = null;
	
	@Override
	public String intercept(ActionInvocation ai) throws Exception
	{
		if(ai.getAction().getClass().getMethod(ai.getProxy().getMethod())
				.getAnnotation(Keyword.class) != null)
		{
			Map<String, Object> params = ai.getInvocationContext()
					.getParameters();
			for(String param : params.keySet())
			{
				if(checkParam(param))
				{
					Object paramValue = params.get(param);
					if(paramValue instanceof String)
					{
						params.put(param, keywordScreening
								.getFilterString((String) paramValue));
					}
					else if(paramValue instanceof String[])
					{
						String[] _paramValue = (String[]) paramValue;
						for(int i = 0; i < _paramValue.length; i ++)
						{
							_paramValue[i] = keywordScreening
									.getFilterString(_paramValue[i]);
						}
						params.put(param, _paramValue);
					}
				}
			}
		}
		return ai.invoke();
	}
	
	private boolean checkParam(String name)
	{
		// 这里可以改成选择个别parameter进行过滤
		return true;
	}
	
	@Override
	public void init()
	{
		// TODO:加载过滤词库
		keywordScreening = new KeywordScreening(new String[] {"你妈"});
	}
	
	public static KeywordScreening getKeywordScreening()
	{
		return keywordScreening;
	}
}
