<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<div class="header">
	<div class="logo w240 h fl">
		<img id="logo_img" />
	</div>
	<s:if test="#session.user == null">
		<ul class="top_bar w760 fl">
			<li><a href="registerInput" class="a_bt">注册</a>
			<li><a href="index" class="a_bt">主页</a></li>
		</ul>
		<jsp:include page="login.jsp" />
	</s:if>
	<s:else>
		<ul class="top_bar w760 fl">
			<li><a href="logout" class="a_bt">注销</a></li>
			<li><a href="registerInput" class="a_bt">注册</a></li>
			<li><a href="myAnnouncements" class="a_bt">通知(<s:property
						value="#session.user.announcementCount" />)</a></li>
		</ul>
		<ul class="nav_bar w760 fl">
			<li><a href="index" class="a_bt">主页</a></li>
			<li><a href="myClubs" class="a_bt">我的社团</a></li>
			<li><a href="#" class="a_bt">店铺</a></li>
			<li><a href="#" class="a_bt">活动</a></li>
			<li><a href="#" class="a_bt">好友</a></li>
			<li><a href="userHome" class="a_bt">个人主页</a></li>
			<li><a href="receivedLetters" class="a_bt">飞鸽传书 (<s:property
						value="#session.user.receiveLetterCount" />)</a></li>
		</ul>

	</s:else>
</div>
