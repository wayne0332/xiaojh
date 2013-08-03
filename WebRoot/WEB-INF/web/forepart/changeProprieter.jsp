<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'changeProprieter.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<jsp:include page="head.jsp" />
	<table>
		<tr>
			<td>名字</td>
			<td>身份</td>
			<td>加入时间</td>
			<td>操作</td>
		</tr>
		<s:iterator value="#request.changeProprieter">
			<tr>
				<td><s:property value="user.name" />
				</td>
				<td><s:property value="role.name" /></td>
				<td><s:date name="datetime" format="yyyy-MM-dd hh:mm:ss" />
				</td>
				<td><s:a href="changeProprieter?user.id=%{user.id}&club.id=%{club.id}">成为新社长</s:a>
				</td>
			</tr>
		</s:iterator>
	</table>
	<wst:page url="changeProprieterInput" />
</body>
</html>
