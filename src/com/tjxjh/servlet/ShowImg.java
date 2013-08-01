package com.tjxjh.servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Deprecated
public class ShowImg extends HttpServlet
{
	private static final long serialVersionUID = -4589767962478862713L;
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		String imgPath = null;
		if((imgPath = request.getParameter("img")) != null
				&& !(imgPath = imgPath.trim()).equals(""))
		{
			imgPath = new String(imgPath.getBytes("ISO8859-1"), "UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			response.setContentType("image/jpeg"); // 设置图片格式格式，这里可以忽略
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
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		this.doGet(request, response);
	}
}
