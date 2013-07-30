package com.tjxjh.util;

import java.text.SimpleDateFormat;
import java.util.Date;
/**
 * 根据输入的字符串，日期，日期格式返回相应的日期字符串
 * @author TT
 *
 */
public class DateFormartUtil {
	public static String getDateByFormat()
	{
		return getDateByFormat(new Date(),"yyyy-MM-dd");
	}
	public static String getDateByFormat(String daf){
		return getDateByFormat(new Date(),daf);
	}
	public static String getDateByFormat(SimpleDateFormat daf){
		return   getDateByFormat(new Date(),daf);
	}
	public static String getDateByFormat(Date date,String daf){
		SimpleDateFormat dafe=new SimpleDateFormat(daf);
		return getDateByFormat(date,dafe);
	}
	public static String getDateByFormat(Date date,SimpleDateFormat daf){
		String dateStr=daf.format(date);
		return  dateStr;
	}
	
}
