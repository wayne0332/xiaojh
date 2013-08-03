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

import com.tjxjh.service.ClubService;

@Deprecated
public class CheckClubServlet extends HttpServlet
{
	private static final long serialVersionUID = 326251827157536656L;
	private ClubService clubService = null;
	
	@Override
	public void init(ServletConfig config) throws ServletException
	{
		super.init(config);
		clubService = SpringUtil.springContext(config.getServletContext())
				.getBean(ClubService.class);
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		response.setContentType("application/x-json");
		PrintWriter out = response.getWriter();
		String name = request.getParameter("name"), schoolId = request
				.getParameter("schoolId");
		JSONObject json = new JSONObject();
		if(name != null && schoolId != null)
		{
			json.accumulate("error", false);
		}
		else
		{
			json.accumulate("error", true);
		}
		if(!(name = name.trim()).equals("")
				&& !(schoolId = schoolId.trim()).equals(""))
		{
			json.accumulate("hadClub",
					clubService.hadClub(name, Integer.valueOf(schoolId)));
		}
		else
		{
			json.accumulate("hadClub", false);
		}
		out.println(json.toString());
		out.flush();
		out.close();
	}
}
