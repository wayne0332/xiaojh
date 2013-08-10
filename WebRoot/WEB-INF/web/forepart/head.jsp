<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ads" uri="fineTu/ads"%>

<div class="header shadow_n_5">
	<div class="logo w200 h800">
		<img src="images/icon/logo.png" id="logo_img" class="w135" />
	</div>

	<s:if test="#session.user == null">
		<div class="nav_bar bc">
		<ul class="fr">
			<li><a href="index" class="a_bt">主页</a>
			<li><a href="registerInput" class="a_bt">注册</a></li>
		</ul></div>
	</s:if>

	<s:else>
		<div class="nav_bar bc">
			<ul class="fr">
				<li><a href="logout" class="a_bt">注销</a></li>
				<li><a href="registerInput" class="a_bt">注册</a></li>
				<li><a href="myAnnouncements" class="a_bt">通知(<s:property
							value="#session.user.announcementCount" />)</a></li>
			</ul>
			<ul class="fl">
				<li><a href="index" class="a_bt">主页</a></li>
				<li><a href="myClubs" class="a_bt">我的社团</a></li>
				<li><a href="#" class="a_bt">店铺</a></li>
				<li><a href="myActivity" class="a_bt">活动</a></li>
				<li><a href="myFocus?type=0" class="a_bt">好友</a></li>
				<li><a href="userHome" class="a_bt">个人主页</a></li>
				<li><a href="receivedLetters" class="a_bt">飞鸽传书 (<s:property
							value="#session.user.receiveLetterCount" />)</a></li>
			</ul>
		</div>
	</s:else>
</div>
