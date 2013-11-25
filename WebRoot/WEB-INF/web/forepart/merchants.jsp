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
<base href="<%=basePath%>" />

<title>校江湖</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
</head>
<body>
	<div class="container cf">
		<jsp:include page="head.jsp" />

		<div class="left_bar mt75">
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

		<div class="main cf mt75">
			<div class="friendList cf">
				<s:iterator value="#request.merchantList.merchantList">

						<div class="friendBox shadow_l_3">
							<s:if test="logoPath==''">
								<a href="#"><img
									src="images/head/head1.jpg" class="fl logoImg" /> </a>
							</s:if>
							<s:else>
								<a href="#"><img
									src="<s:property value="logoPath" />" class="fl logoImg" /> </a>
							</s:else>
							<ul class="frd_box_info">
								<li class="frd_name"><a href="merchant?merchant.id=<s:property value="id" />"><s:property value="name" /> </a>
								</li>
								<li><s:property value="type.getName()" />
								</li>
								<li><s:property value="address" />
								</li>
							</ul>
							<a class="send_msg clear_a op_btn_yellow_green hov"
								href="personalLetterInput?targetUser.id=${id }&targetUser.name=${name}">发私信</a>
							<span class="no_focus"> <a class="hov"
								id="<s:property value="id" />"
								onclick="cancelFocus(<s:property value="id" />,0)">取消关注</a> </span>
						</div>

				</s:iterator>
			</div>
			<w:page url="merchants" value="#request.merchantList.page" />
		</div>
	</div>

</body>
</html>
