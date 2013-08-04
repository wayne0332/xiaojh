<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.tjxjh.enumeration.AdvertisementType" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'adsList.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
  </head>
  
<body>
	<div>
		添加新广告位：<br/>
	    <form method="post" action="addAds" >
	    	广告位名称：<input type="text" name="ads.name" />
	    	广告位类型：<select name="ads.type">
	    				<option value="IMG" ><%= AdvertisementType.IMG.getName() %></option>
	    				<option value="SWF"><%= AdvertisementType.SWF.getName() %></option>
	    				<option value="JS"><%= AdvertisementType.JS.getName() %></option>
					</select>
			广告尺寸:宽：<input type="text" size="30" style="width:40px;" name="ads.width" />
				        高：<input type="text" size="30" style="width:40px;" name="ads.height" />
			<input type="submit" value="添加" />
	    </form>
	</div>
	<s:iterator value="adsList">
		<div>
			<span><s:property value="name" /></span>&nbsp;&nbsp;
			<span><s:property value="type.name" /></span>&nbsp;&nbsp;
			<span><s:property value="width" />*<s:property value="height" /></span>&nbsp;&nbsp;
			<a href="contentList?adsId=<s:property value="id" />&type=<s:property value="type" />" >查看广告</a>
			<a href="javascript:if(confirm('确认删除 吗?'))window.location='removeAds?adsId=<s:property value="id" />">删除</a>
		</div>
	</s:iterator>
</body>
</html>
