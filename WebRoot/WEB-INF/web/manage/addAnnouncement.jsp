<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'addAnnouncement.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<form action="addAnnouncement" method="post">
		<table>
			<tr>
				<td>标题:</td>
				<td><input type="text" name="announcement.title">
				</td>
			</tr>
			<tr>
				<td>内容:</td>
				<td><textarea rows="5" cols="20" name="announcement.text"></textarea>
				</td>
			</tr>
			<tr>
				<td><s:hidden name="path" value="%{path}" /><input
					type="hidden" name="club.id" value="${param['club.id'] }"><input
					type="submit" value="发布"></td>
			</tr>
		</table>
	</form>
</body>
</html>
