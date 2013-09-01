package com.tjxjh.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import cn.cafebabe.websupport.util.SpringUtil;

import com.tjxjh.interceptor.KeywordInterceptor;
import com.tjxjh.service.UserService;

public class CheckUserServlet extends HttpServlet
{
	private static final long serialVersionUID = -1199577134038813213L;
	private UserService userService = null;
	
	@Override
	public void init(ServletConfig config) throws ServletException
	{
		super.init(config);
		userService = SpringUtil.springContext(config.getServletContext())
				.getBean(UserService.class);
	}
	
	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException
	{
		// request.setCharacterEncoding("gbk");
		// response.setCharacterEncoding("gbk");;
		response.setContentType("application/x-json");
		// response.setContentType("text/html;charset=gbk");
		String name = request.getParameter("name");
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		if(name != null)
		{
			name = new String(name.getBytes("ISO8859-1"), "utf-8");
			if(!(name = name.trim()).equals("")
					&& !name.equals(UserService.DEFAULT_PORTRAIT.split("\\.")[0]))
			{
				if(KeywordInterceptor.getKeywordScreening().isHasFilterWord(
						name))
				{
					json.accumulate("error", true);
				}
				else
				{
					json.accumulate("error", false);
					json.accumulate("hadRegister", userService
							.isRegister(KeywordInterceptor
									.getKeywordScreening()
									.getFilterString(name)));
				}
			}
			else
			{
				json.accumulate("error", false);
				json.accumulate("hadRegister", false);
			}
		}
		else
		{
			json.accumulate("error", true);
		}
		out.println(json.toString());
		out.flush();
		out.close();
	}
}
