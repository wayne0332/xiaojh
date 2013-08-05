<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>测试页面——校江湖</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="<%=path%>/js/jquery-1.8.1.min.js"></script>
<style type="text/css">
.main {
	width: 980px;
	min-height: 500px;
	margin: 0 auto;
	border: 1px solid #DDDDDD;
}
</style>
</head>

<body>
	<div class="main">
		1.发布说说页面：<a href="<%=path %>/addTalkingJsp">addTalkingJsp</a>对应页面addTalking.jsp，默认添加至user1的数据中,用户主页也可以发布说说<br>
		2.我的说说：<a href="<%=path %>/myTalking">myTalking</a>对应页面myTalking.jsp查看user1所有关注的用户、社团、商家的说说<br>
		3.添加活动：<a href="<%=path %>/addActivityJsp">addActivityJsp</a>对应页面addActivity.jsp 添加活动  默认活动添加至社团1的数据中<br>
		4.查看一个活动：<a href="<%=path %>/activity?activity.id=2">activity?activity.id=2</a>对应页面activity.jsp 根据传人的id查看某个活动<br>
		5.查看活动：<a href="<%=path %>/myActivity">myActivity</a>对应页面myActivity.jsp 查看那user1所关注的社团、商家活动<br>
		7.查看活动：<a href="<%=path %>/adminFindOneActivity?club.id=1">adminFindOneActivity?club.id=1</a>对应页面myActivity.jsp 管理员查看那所关注的社团、商家活动<br>
		8.学校主页：<a href="<%=path %>/school?school.id=1">school?school.id=1</a>对应页面school.jsp <br>
	
	</div>
</body>
</html>
