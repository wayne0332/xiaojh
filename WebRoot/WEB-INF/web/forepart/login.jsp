<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<wst:parameter value="msg" />
<form id="login" action="userLogin" method="post" class="loginForm">
	<ul>
		<li class="loginForm_li"><label class="w50 pl5">用户名：</label><input
			id="name" type="text" name="user.name"
			class="loginForm_text w200 h30 pl5 pr5" />
		</li>
		<li class="loginForm_li"><label class="w50 pl5">密码：</label><input
			id="password" type="password" name="user.password"
			class="loginForm_text w200 h30 pl5 pr5" /></li>
		<li><input type="radio" name="role" value="user"
			checked="checked" class="input_radio ml5"><label
			class="pl5 mr5">普通用户</label><input type="radio" name="role"
			value="merchant" class="input_radio ml5"><label
			class="pl5 mr5">商家用户</label></li>
		<li><input type="submit" value="登陆"
			class="loginForm_submit h30 ml10"><label class="w50 pl5"><a
				href="findUserPasswordInput">忘记密码</a>
		</label>
		</li>
	</ul>
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
