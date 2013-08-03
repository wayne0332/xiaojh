<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'head.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />

</head>

<body>
	<div class="header">
		<div class="logo w240 h fl">
			<img id="logo_img" />
		</div>
		<s:if test="#session.user == null">
			<ul class="top_bar w760 fl">
				<li><a href="registerInput" class="a_bt">注册</a>
				<li><a href="index" class="a_bt">主页</a>
				</li>
			</ul>
			<jsp:include page="login.jsp" />
		</s:if>
		<s:else>
			<ul class="top_bar w760 fl">
				<li><a href="logout" class="a_bt">注销</a>
				</li>
				<li><a href="registerInput" class="a_bt">注册</a>
				</li>
				<li><a href="myAnnouncements" class="a_bt">通知(<s:property
							value="#session.user.announcementCount" />)</a>
				</li>
				<li><a href="index" class="a_bt">主页</a>
				</li>
				<li><a href="myClubs" class="a_bt">我的社团</a> 
				</li>
				<li><a href="#" class="a_bt">店铺</a>
				</li>
				<li><a href="#" class="a_bt">活动</a>
				</li>
				<li><a href="#" class="a_bt">好友</a>
				</li>
				<li><a href="userHome" class="a_bt">个人主页</a>
				</li>
				<li><a href="receivedLetters" class="a_bt">飞鸽传书 (<s:property
							value="#session.user.receiveLetterCount" />)</a>
				</li>
			</ul>
		</s:else>
	</div>
</body>
</html>
