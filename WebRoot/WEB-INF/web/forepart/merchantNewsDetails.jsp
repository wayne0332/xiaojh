<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'merchantNewsDetails.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<table>
		<tr>
			<td>标题:</td>
			<td><s:property value="merchantNews.tittle" /></td>
		</tr>
		<tr>
			<td>时间:</td>
			<td><s:date name="merchantNews.datetime"
					format="yyyy-MM-dd hh:mm:ss" /></td>
		</tr>
		<tr>
			<td>内容:</td>
			<td><s:property value="merchantNews.text" /></td>
		</tr>
		<tr>
			<td>媒体:</td>
			<td><s:if
					test="merchantNews.url!=null&&!merchantNews.url.trim().equals('')&&merchantNews.urlType.toString()=='PICTURE'">
					<img src="${merchantNews.url}" />
				</s:if> <s:elseif
					test="merchantNews.url!=null&&!merchantNews.url.trim().equals('')&&merchantNews.urlType.toString()=='VIDEO'">
			     ${merchantNews.url}
			</s:elseif></td>
		</tr>
	</table>
</body>
</html>
