<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'login.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="js/userMsg.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("input:radio[name='role']").click(function() {
			$("#name").attr("name", $(this).val() + ".name");
			$("#password").attr("name", $(this).val() + ".password");
			$("#login").attr("action", $(this).val() + "Login");
		});
	});
</script>

</head>

<body>
	<wst:parameter value="msg" />
	<form id="login" action="userLogin" method="post">
		<table>
			<tr>
				<td>用户名:</td>
				<td><input id="name" type="text" name="user.name" />
				</td>
			</tr>
			<tr>
				<td>密码:</td>
				<td><input id="password" type="password" name="user.password" />
				</td>
			</tr>
			<tr>
				<td><input type="radio" name="role" value="user"
					checked="checked">普通用户</td>
				<td><input type="radio" name="role" value="merchant">商家用户</td>
			</tr>
			<tr>
				<td><input type="submit" value="登陆">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
