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
				<img src="<s:property value="#session.user.portraitPath"/>"
					class="fl mt5 ml10 circle_80 shadow_l_5" />
				<ul class="fl w135 p5 pl10 text_r">
					<li class="w135 text_l f14"><a href="updateUserInput"><s:property
								value="#session.user.name" /> </a>
					</li>
					<li><s:property value="#session.user.grade" /></li>
					<li><s:property
							value="#application.schools[#session.user.school.id].name" /></li>
				</ul>
			</div>
			<a class="sendToFrd op_btn_yellow_green hov clear_a"
				href="myFocus?type=0&pageNum=1">给小伙伴发信息</a>
		</div>
		<div class="main mt75">
			<ul class="letter_list">
				<s:iterator value="#request.receivedLetters" status="status">
					<li class="letter_box cf">
						<div class="lette_box_left">
							<%-- <s:a href="personalLetter?letter.id=%{id}">
								<s:property value="title" />
							</s:a> 标题不用了 --%>
							<s:a href="personalLetter?letter.id=%{id}">
								<img alt="头像" title="头像" src="images/head/head1.jpg"
									class="logoImg shadow_l_3" />
								<s:property value="userBySourceUserId.name" />
								<s:date name="datetime" format="MM/dd HH:mm" />
							</s:a>
						</div>
						<div class="lette_box_right shadow_l_3">
							<div>
								<p class="letter_content">
									<s:property value="text" />
								</p>
							</div>
							<div>
								<span class="letter_name"> <span> <s:a
											href="personalLetterInput?targetUser.id=%{userBySourceUserId.id}&targetUser.name=%{userBySourceUserId.name}">回复</s:a>
										<s:a href="deleteLetter?letter.id=%{id}">删除</s:a> </span> </span> <span
									class="letter_state"> <s:property value="status.name" />
								</span>
							</div>
						</div></li>
				</s:iterator>
			</ul>
			<s:property value="page.pageNumber" />
			<wst:page url="receivedLetters" />
		</div>
	</div>
</body>
</html>
