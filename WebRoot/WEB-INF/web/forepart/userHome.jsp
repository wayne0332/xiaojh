<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html">
<html>
<head>

<base href="<%=basePath%>" />

<title>校江湖 - 个人主页</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />
<script type="text/javascript" src="<%=path%>/js/ajax.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
</head>

<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		<jsp:include page="userHomeLeft.jsp" />
		<div class="main w730 cf mt75">
			<!-- 导航-->
			<div class="userHome_box w700 m5 p10 cf shadow_l_10 radius_6">
				<a href="<%=path%>/photos?user.id=${user.id}" ><label>相册</label> </a> <a href="javascript:void(0)"><label>说说</label>
				</a> <a href="onlineActivity?user.id=${user.id}"><label>活动</label> </a>
			</div>
			<!-- END:相册-->
			<jsp:include page="userHomeTalking.jsp" />
			
		</div>
		<div class="footer"></div>
	</div>
	
</body>
</html>
