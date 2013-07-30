package com.tjxjh.interceptor;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public abstract class BaseInterceptor extends AbstractInterceptor
{
	private static final long serialVersionUID = 3859847522180887502L;
	
	@Override
	public abstract String intercept(ActionInvocation ai) throws Exception;
	
	protected Map<String, Object> getSessionMap()
	{
		return ActionContext.getContext().getSession();
	}
	
	protected Map<String, Object> getApplicationMap()
	{
		return ActionContext.getContext().getApplication();
	}
	
	@SuppressWarnings("unchecked")
	protected Map<String, Object> getRequestMap()
	{
		return (Map<String, Object>) ActionContext.getContext().get("request");
	}
}
