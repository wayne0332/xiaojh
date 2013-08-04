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
		context.getServletContext().setAttribute(
				"schools",
				schoolsMap(SpringUtil
						.springContext(context.getServletContext())
						.getBean(CommonService.class).schools()));
		School school = new School();
		school.setId(1);
		UserService userService = SpringUtil.springContext(
				context.getServletContext()).getBean(UserService.class);
		AuthInterceptor.setClubService(SpringUtil.springContext(
				context.getServletContext()).getBean(ClubService.class));
		if(!userService.exist(new User(school, "test0", null, null, null, null,
				null, null, null, null, null, null, null, null, null, null,
				null, null, null, null)))
		{
			for(int i = 0; i < 10; i ++)
			{
				User user = new User(school, "test" + i, "test" + i, null,
						null, "test@126.com", Sex.MAN, null, null, null, 2013,
						null, null, null, null, null, null, null,
						UserStatus.NO_VALIDATE, null);
				userService.register(user, null);
				// clubService.applyClub(
				// new Club(school, user, "test", "test" + i,
				// new StringBuilder(
				// "upload/clubLogo/school_1_test" + i
				// + ".png").toString(), null,
				// ClubType.Music, ClubStatus.PASSED, null,
				// "test", null),
				// user,
				// new File(context.getServletContext().getRealPath(
				// "/" + UserAction.PORTRAIT_FOLDER
				// + UserService.DEFAULT_PORTRAIT)));
			}
		}
		/*初始化广告位信息*/
		AdService adService = SpringUtil.springContext(context.getServletContext()).getBean(AdService.class);
		context.getServletContext().setAttribute("adsList", adService.allAdsMap());
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
