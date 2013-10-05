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
								value="#session.user.name" /> </a></li>
					<li><s:property value="#session.user.grade" />
					</li>
					<li><s:property
							value="#application.schools[#session.user.school.id].name" />
					</li>
				</ul>
			</div>
			<a class="sendToFrd op_btn_yellow_green hov clear_a" href="myFocus?type=0&pageNum=1">给小伙伴发信息</a>
		</div>
		<div class="main mt75">
			<ul class="letter_list">
				<s:iterator value="#request.receivedLetters" status="status">
					<li class="letter_box cf">
						<div class="lette_box_left">
							<s:a href="personalLetter?letter.id=%{id}">
								<s:property value="title" />
							</s:a>
							<img alt="头像" title="头像" src="images/head/head1.jpg" class="logoImg shadow_l_3" />
						</div>
						<div class="lette_box_right shadow_l_3">
							<div>
								<p class="letter_content">
									<!-- <s:property value="text" /> -->
									百科的内容是经过组织的，内容全面且富有层次，这是百度百科独一无二内容亮点。之前的目录功能仅展示一级目录，无法满足浏览者的快速获取内容的需求。新的词条页会将细致整理的目录结构直接展示在读者面前，既体现了百科词条的严密逻辑感，也使百科的阅读体验更接近书页，给浏览者更沉浸的阅读感受。
								</p>
							</div>
							<div>
								<span class="letter_name">
									<span>
										<s:a href="personalLetterInput?targetUser.id=%{userBySourceUserId.id}&targetUser.name=%{userBySourceUserId.name}">回复</s:a>
										<s:a href="deleteLetter?letter.id=%{id}">删除</s:a>
									</span>
									<span>
										<s:date name="datetime" format="MM/dd" />
										<s:date name="datetime" format="HH:mm" />
									</span>
								</span>
								<span class="letter_state">
									<s:property value="status.name" />
								</span>
							</div>
						</div>
					</li>
				</s:iterator>
			</ul>
			<wst:page url="receivedLetters" />
		</div>
	</div>
</body>
</html>
