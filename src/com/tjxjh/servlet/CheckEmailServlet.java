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
import com.tjxjh.service.MailService;

public class CheckEmailServlet extends HttpServlet
{
	private static final long serialVersionUID = -1199577134038813213L;
	private MailService mailService = null;
	
	@Override
	public void init(ServletConfig config) throws ServletException
	{
		super.init(config);
		mailService = SpringUtil.springContext(config.getServletContext())
				.getBean(MailService.class);
	}
	
	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException
	{
		// request.setCharacterEncoding("gbk");
		// response.setCharacterEncoding("gbk");;
		response.setContentType("application/x-json");
		// response.setContentType("text/html;charset=gbk");
		String email = request.getParameter("email");
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		if(email != null)
		{
			email = new String(email.getBytes("ISO8859-1"), "utf-8");
			if(!(email = email.trim()).equals("") && !KeywordInterceptor.getKeywordScreening().isHasFilterWord(email)
					&& mailService.checkEmail(email))
			{
				json.accumulate("error", false);
				json.accumulate("hadRegister", mailService.isRegister(email));
			}
			else
			{
				json.accumulate("error", true);
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
