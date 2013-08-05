<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<wst:parameter value="msg" />
<form id="login" action="userLogin" method="post">
	用户名:<input id="name" type="text" name="user.name" /> 密码:<input
		id="password" type="password" name="user.password" /> <input
		type="radio" name="role" value="user" checked="checked">普通用户 <input
		type="radio" name="role" value="merchant">商家用户<input
		type="submit" value="登陆">

</form>

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
