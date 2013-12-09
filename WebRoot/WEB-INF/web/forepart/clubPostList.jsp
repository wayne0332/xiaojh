<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="/webSupportTag" prefix="w"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>

<title>校江湖 - 社团</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-club.css" />

</head>

<body>

	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		<div class="main w730 cf mt75">
			<div class="clearfix">
				<h2 class="h2_title">社团贴吧</h2>
				<a href="initAddClubPost?club.id=<s:property value="#request.club.id" />" class="fatie shadow_l_3">发帖</a>
			</div>
			<ul class="tiezi_ul">
				<s:iterator value="#request.clubPostList.clubPostList">
					<li>
						<div class="title">
							<a href="clubPostContent?postId=<s:property value="id" />"> <s:property
									value="tittle" />&nbsp;&nbsp;&nbsp; <s:property
									value="user.name" />&nbsp;&nbsp;&nbsp; <s:date name="date"
									format="YYYY-MM-DD" /> </a>
						</div>
					</li>
				</s:iterator>
			</ul>
		</div>
		<div class="left_bar fr cf mt75">
			<div class="my_info w240 h90 p5 m5 shadow_l_10 bg_box">
				<img src="images/head/head1.jpg"
					class="fl mt5 ml10 circle_80 shadow_l_5" />
				<ul class="fl w135 p5 pl10 text_r">
					<li class="w135 text_l f14"><a href="updateUserInput"><s:property
								value="#session.user.name" /> </a>
					</li>
					<li><s:property value="#session.user.grade" /></li>

					<li><s:property value="#session.user.grade % 2000" />级</li>
					<li><s:property
							value="#application.schools[#session.user.school.id].name" />
					</li>
					<!-- <li>凤凰社</li> -->
				</ul>
			</div>
		</div>

	</div>
</body>
</html>
