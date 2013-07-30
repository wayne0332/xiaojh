<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'myAnnouncements.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<table>
		<tr>
			<td>标题</td>
			<td>时间</td>
			<td>通知者</td>
			<td>内容</td>
		</tr>
		<s:iterator value="#request.myAnnouncements">
			<tr>
				<td><s:property value="title" />
				</td>
				<td><s:date name="datetime" format="yyyy-MM-dd hh:mm:ss" />
				</td>
				<td><s:if test="club != null">
						社团:<s:property value="club.name" />
					</s:if> <s:else>
						系统通知
					</s:else></td>
				<td><s:property value="text" />
				</td>
			</tr>
		</s:iterator>
	</table>
	<wst:page url="myAnnouncements" />
</body>
</html>
