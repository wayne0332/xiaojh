<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>
<head>

<base href="<%=basePath%>" />

<title>校江湖 - 活动</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-detail.css" />
</head>
<body>
	<div class="container">
		<jsp:include page="head.jsp" />
		<br>

		<div class="bc mt100 w200 pt50 pb50 bgfff shadow_l_3 tc">
			<!-- 提示信息 -->
			<s:property value="message" />
			<span>操作成功</span>
		</div>
	</div>
</body>
</html>
