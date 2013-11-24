package com.tjxjh.interceptor;

import java.util.Map;

import org.apache.struts2.ServletActionContext;

import cn.cafebabe.websupport.util.SpringUtil;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.tjxjh.service.ClubService;

public abstract class BaseInterceptor extends AbstractInterceptor
{
	protected static Map<String, Object> getSessionMap()
	{
		return ActionContext.getContext().getSession();
	}
	
	protected static Map<String, Object> getApplicationMap()
	{
		return ActionContext.getContext().getApplication();
	}
	
	@SuppressWarnings("unchecked")
	protected static Map<String, Object> getRequestMap()
	{
		return (Map<String, Object>) ActionContext.getContext().get("request");
	}
	
	protected static <T> T getService(Class<T> clazz)
	{
		return SpringUtil.springContext(
				ServletActionContext.getServletContext()).getBean(clazz);
	}
}
