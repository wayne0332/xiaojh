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
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var currentYear = new Date().getFullYear();
		var select = $("select[name='user.grade']");
		for ( var i = 0; i != 9; ++i) {
			gradeAddOption(select, currentYear - i);
		}
		checkUserName("input[name='user.name']", "#userMsg", "用户");
		checkEmail("input[name='user.email']", "#userEmail");
		$("#user").css("display", "none");
		$("input:radio[name='registerType']").click(function() {
			$("div").css("display", "inline");
			$("#" + $(this).val()).css("display", "none");
		});
	});

	function gradeAddOption(select, year) {
		select.append("<option value='" + year + "'>" + year + "</option>");
	}
</script>
</head>

<body>
	<jsp:include page="head.jsp" />
	<div>
		<table>
			<tr>
				<td>注册类型:</td>
				<td><input type="radio" name="registerType" value="user"
					checked="checked">普通用户</td>
				<td><input type="radio" name="registerType" value="merchant">商家用户</td>
			</tr>
		</table>
	</div>
	<div id="merchant">
		<wst:parameter value="msg" />
		<form action="register" method="post" enctype="multipart/form-data">
			用户名:<input type="text" name="user.name"><label id="userMsg"
				style="display:none;color:red;"></label><br> 密码:<input
				type="text" name="user.password"><br> 学校:
			<s:select name="user.school.id" list="#application.schools"
				listKey="key" listValue="value.name" />
			<br> 邮箱(这个要填好 不然注册不了- -):<input type="text" name="user.email"><label
				id="userEmail" style="display:none;color:red;"></label><br> 性别:
			<s:select name="user.sex" list="@com.tjxjh.enumeration.Sex@values()"
				listKey="name()" listValue="name" />
			<br>入学年份:<select name="user.grade"></select><br>
			<hr>
			真实姓名:<input type="text" name="user.realName"><br> 学院:<input
				type="text" name="user.subject"><br> 专业:<input
				type="text" name="user.profession"><br> 生日:<input
				type="text" name="user.birthday" readonly="readonly" class="Wdate"
				onClick="WdatePicker()"><br> 电话:<input type="text"
				name="user.phone"><br> qq:<input type="text"
				name="user.qq"><br> 头像:<input type="file"
				name="portrait"><br> <input type="submit" value="注册">
		</form>
	</div>
	<div id="user">
		<jsp:include page="applyMerchant.jsp" />
	</div>
</body>
</html>
