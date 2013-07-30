package com.tjxjh.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.tjxjh.service.UserService;
import com.tjxjh.util.SpringUtil;

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
		response.setContentType("application/x-json");
		PrintWriter out = response.getWriter();
		String name = request.getParameter("name");
		JSONObject json = new JSONObject();
		if(name != null)
		{
			json.accumulate("error", false);
		}
		else
		{
			json.accumulate("error", true);
		}
		if(!(name = name.trim()).equals("")
				&& name != UserService.DEFAULT_PORTRAIT.split("\\.")[0])
		{
			json.accumulate("hadRegister", userService.isRegister(name));
		}
		else
		{
			json.accumulate("hadRegister", false);
		}
		out.println(json.toString());
		out.flush();
		out.close();
	}
}
