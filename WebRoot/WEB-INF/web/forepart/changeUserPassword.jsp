<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'changeUserPassword.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<wst:parameter value="msg" />
	<form action="changeUserPassword" method="post">
		<table>
			<tr>
				<td>旧密码:</td>
				<td><input type="password" name="user.password">
				</td>
			</tr>
			<tr>
				<td>新密码:</td>
				<td><input type="password" name="code">
				</td>
			</tr>
			<tr>
				<td>再次输入新密码:</td>
				<td><input type="password" name="psdConfirm">
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="提交">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
