<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'updateUser.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />
<script type="text/javascript" src="js/ajax.js"></script>

</head>

<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		<div class="left_bar w270 cf mt75">
			<jsp:include page="userMessage.jsp" />
		</div>
		<div class="main w730 cf mt75">
			<a href="changeUserPasswordInput">修改密码</a>
			<form action="updateUser" method="post" enctype="multipart/form-data">
				name:
				<s:property value="#session.user.name" />
				<br> school:
				<s:property
					value="#application.schools[#session.user.school.id].name" />
				<br> email:
				<s:property value="#session.user.email" />
				<br> sex:
				<s:property value="#session.user.sex.name" />
				<br>grade:
				<s:property value="#session.user.grade" />
				<br>
				<hr>
				real_name:
				<s:textfield type="text" name="user.realName"
					value="%{#session.user.realName}" />
				<br> subject:
				<s:textfield type="text" name="user.subject"
					value="%{#session.user.subject}" />
				<br> profession:
				<s:textfield type="text" name="user.profession"
					value="%{#session.user.profession}" />
				<br> birthday: <input type="text" name="user.birthday"
					onFocus="WdatePicker({isShowClear:false,readOnly:true})"
					class="Wdate" onClick="WdatePicker()"
					value="<s:date name="#session.user.birthday" format="yyyy-MM-dd"/>" />
				<br> phone:
				<s:textfield type="text" name="user.phone"
					value="%{#session.user.phone}" />
				<br> qq:
				<s:textfield type="text" name="user.qq" value="%{#session.user.qq}" />
				<br> portrait:
				<s:if
					test="#session.user.portraitPath != null && #session.user.portraitPath != ''">
					<img src="<s:property value="#session.user.portraitPath"/>">
					<br> 重新上传头像:</s:if>
				<input type="file" name="portrait"><br>
				<s:hidden name="user.id" value="%{#session.user.id}" />
				<input type="submit" value="submit">
			</form>
		</div>
	</div>
</body>
</html>
