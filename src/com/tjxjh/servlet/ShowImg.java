package com.tjxjh.servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShowImg extends HttpServlet
{
	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		String imgPath = null;
		if((imgPath = request.getParameter("img")) != null)
		{
			imgPath = new String(imgPath.getBytes("ISO8859-1"), "UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			// response.setContentType("image/jpeg"); // 设置图片格式格式，这里可以忽略
			FileInputStream fis = new FileInputStream(request.getSession()
					.getServletContext().getRealPath(imgPath));
			OutputStream os = response.getOutputStream();
			try
			{
				int count = 0;
				byte[] buffer = new byte[1024 * 1024];
				while((count = fis.read(buffer)) != -1)
					os.write(buffer, 0, count);
			}
			catch(IOException e)
			{
				e.printStackTrace();
			}
			finally
			{
				if(os != null)
					os.close();
				if(fis != null)
					fis.close();
			}
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		this.doGet(request, response);
	}
}
