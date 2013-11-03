<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>


<!DOCTYPE html>
<html>
<head>

<title>校江湖</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

</head>

<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		
		<div class="left_bar w270 cf mt75">
			<div class="my_info w240 h90 p5 m5 shadow_l_3 bg_box">
				<img src="<s:property value="#session.user.portraitPath"/>" class="fl mt5 ml10 circle_80 shadow_l_5" />
				<ul class="fl w135 p5 pl10 text_r">
					<li class="w135 text_l f14">
						<a href="updateUserInput"><s:property value="#session.user.name" /></a>
					</li>
					<li><s:property value="#session.user.grade" /></li>
					<li><s:property value="#application.schools[#session.user.school.id].name" /></li>
				</ul>
			</div>
			<s:if test="#session.clubMember.role.name() != 'NORMAL'">
				<a class="sendToFrd op_btn_yellow_green hov clear_a" href="addAnnouncementInput?path=clubAnnouncements&club.id=${param['club.id'] }">发布社团通告</a>
			</s:if>
		</div>
		
		<div class="main mt75">
			
			<jsp:include page="announcementsDisplay.jsp" />
			
			<wst:page url="receivedLetters" />
		</div>
		
	</div>
</body>
</html>
