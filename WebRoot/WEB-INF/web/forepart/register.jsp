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
		checkUserName("input[name='user.name']", "label", "用户");
	});

	function gradeAddOption(select, year) {
		select.append("<option value='" + year + "'>" + year + "</option>");
	}
</script>
</head>

<body>
	<wst:parameter value="msg" />
	<form action="register" method="post" enctype="multipart/form-data">
		name:<input type="text" name="user.name"><label
			style="display:none;color:red;"></label><br> password:<input
			type="text" name="user.password"><br> school:
		<s:select name="user.school.id" list="#application.schools"
			listKey="key" listValue="value.name" />
		<br> email(这个要填好 不然注册不了- -):<input type="text" name="user.email"><br>
		sex:
		<s:select name="user.sex" list="@com.tjxjh.enumeration.Sex@values()"
			listKey="name()" listValue="name" />
		<br>grade:<select name="user.grade"></select><br>
		<hr>
		real_name:<input type="text" name="user.realName"><br>
		subject:<input type="text" name="user.subject"><br>
		profession:<input type="text" name="user.profession"><br>
		birthday:<input type="text" name="user.birthday" readonly="readonly"
			class="Wdate" onClick="WdatePicker()"><br> phone:<input
			type="text" name="user.phone"><br> qq:<input type="text"
			name="user.qq"><br> portrait:<input type="file"
			name="portrait"><br> <input type="submit" value="submit">
	</form>
</body>
</html>
