<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'userMessage.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<div class="my_info w240 h90 p5 m5 shadow_l_10 bg_box">
		<img src="<s:property value="#session.user.portraitPath"/>"
			class="fl mt5 ml10 circle_80 shadow_l_5" />
		<ul class="fl w135 p5 pl10 text_r">
			<li class="w135 text_l f14"><a href="updateUserInput"><s:property
						value="#session.user.name" /> </a>
			</li>
			<li><s:property value="#session.user.grade" /></li>
			<li><s:property
					value="#application.schools[#session.user.school.id].name" /></li>
			<!-- <li>凤凰社</li>(这里要闹哪样...) -->
		</ul>
	</div>
</body>
</html>
