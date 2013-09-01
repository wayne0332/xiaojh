<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'findUserPassword.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<label style="color:red;"><wst:parameter value="msg" /> </label>
	<form action="findUserPassword" method="post">
		<table>
			<tr>
				<td>请输入注册邮箱以重置密码:</td>
				<td><input type="text" name="user.email"></td>
			</tr>
			<tr>
				<td><input type="submit" value="提交"></td>
			</tr>
		</table>
	</form>
</body>
</html>
