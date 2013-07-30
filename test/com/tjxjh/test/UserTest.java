package com.tjxjh.test;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.tjxjh.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class UserTest
{
	@Resource
	private UserService userService = null;
	
	@Test
	public void test()
	{
//		userService.test();
	}
	
	public void setUserService(UserService userService)
	{
		this.userService = userService;
	}
}
