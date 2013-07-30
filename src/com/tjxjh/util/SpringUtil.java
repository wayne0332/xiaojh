package com.tjxjh.util;

import javax.servlet.ServletContext;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class SpringUtil
{
	public static WebApplicationContext springContext(
			ServletContext servletContext)
	{
		return WebApplicationContextUtils
				.getWebApplicationContext(servletContext);
	}
}
