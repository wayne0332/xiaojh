package com.tjxjh.listener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import cn.cafebabe.websupport.util.SpringUtil;

import com.tjxjh.enumeration.Sex;
import com.tjxjh.enumeration.UserStatus;
import com.tjxjh.interceptor.AuthInterceptor;
import com.tjxjh.interceptor.KeywordInterceptor;
import com.tjxjh.keyword.KeywordService;
import com.tjxjh.po.School;
import com.tjxjh.po.User;
import com.tjxjh.service.AdService;
import com.tjxjh.service.ClubService;
import com.tjxjh.service.CommonService;
import com.tjxjh.service.UserService;

public class ContextListener implements ServletContextListener
{
	@Override
	public void contextDestroyed(ServletContextEvent context)
	{}
	
	@Override
	public void contextInitialized(ServletContextEvent context)
	{
		/* 初始化学校信息 */
		context.getServletContext().setAttribute(
				"schools",
				schoolsMap(SpringUtil
						.springContext(context.getServletContext())
						.getBean(CommonService.class).schools()));
		School school = new School();
		school.setId(1);
		/* 初始化广告位信息 */
		AdService adService = SpringUtil.springContext(
				context.getServletContext()).getBean(AdService.class);
		context.getServletContext().setAttribute("adsList",
				adService.allAdsMap());
		// 在KeywordService里注册拦截器
		KeywordInterceptor.registerService(SpringUtil.springContext(
				context.getServletContext()).getBean(KeywordService.class));
	}
	
	private Map<Integer, School> schoolsMap(List<School> schools)
	{
		Map<Integer, School> schoolsMap = new HashMap<Integer, School>();
		for(School school : schools)
		{
			schoolsMap.put(school.getId(), school);
		}
		return schoolsMap;
	}
}
