package com.tjxjh.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.struts2.ServletActionContext;

public class GetRequsetResponse {
	public static PrintWriter getAjaxPrintWriter(){
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType( "text/html" );
		response.setCharacterEncoding( "UTF-8" );
//		response.setHeader("pragma","no-cache");
//		response.setHeader("cache-control","no-cache");
//		response.setHeader("expires","0");
		PrintWriter out =null;
		try {
			out = response.getWriter();
			return out;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
	public static HttpServletResponse getResponse(){
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType( "text/html" );
		response.setCharacterEncoding( "UTF-8" );
		return response;
	}
	public static HttpServletRequest getRequest(){
		HttpServletRequest request=ServletActionContext.getRequest();
		return request;
	}
}
