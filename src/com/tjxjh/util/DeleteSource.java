package com.tjxjh.util;

import java.io.File;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.struts2.ServletActionContext;


public class DeleteSource {
	public static void deleteImg(String inputStr){
		try{
			String str="<img\\s*src=[\"|\']?/?([\\w|\\d]*/?)*\\.\\w*\\s*";
			Pattern pattern = Pattern.compile(str,Pattern.CASE_INSENSITIVE);
			Matcher matcher = pattern.matcher(inputStr);
			while (matcher.find())
			{
				String imgString=matcher.group().replace("<img","").replace("src=", "").replace("\"", "").replace("\'", "").trim().substring(7);
				File file=new File(ServletActionContext.getServletContext().getRealPath(imgString));
				file.delete();
			}
		}catch (Exception e){
			System.out.println(e+"------------DeleteSource----------");
		}
	}
	public static void deleteVideo(String inputStr){
		try{
			String str="flashvars=\'f=/?([\\w|\\d]*/?)*\\.[\\w|\\d]*\\s*";
			Pattern pattern = Pattern.compile(str,Pattern.CASE_INSENSITIVE);
			Matcher matcher = pattern.matcher(inputStr);
			while (matcher.find())
			{
				String imgString=matcher.group().replace("flashvars='f=","").replace("src=", "").replace("\"", "").replace("\'", "").trim().substring(7);
				File file=new File(ServletActionContext.getServletContext().getRealPath(imgString));
				file.delete();
			}
		}catch (Exception e){
			System.out.println(e+"------------DeleteSource----------");
		}
	}
	public static void delete(String inputStr){
		try{
		File file=new File(ServletActionContext.getServletContext().getRealPath(inputStr.trim().substring(7)));
		file.delete();
		}catch (Exception e){
			System.out.println(e+"------------DeleteSource----------");
		}
	}
}
