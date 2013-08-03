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
<title>首页——校江湖</title>
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

.main .left {
	width: 200px;
	min-height: 500px;
	background: #DDDDDD;
	float: left;
}

.main .right {
	width: 780px;
	min-height: 500px;
	background: #999999;
	float: right;
}
</style>
<script type="text/javascript">

</script>
</head>

<body>
	<jsp:include page="head.jsp" />
	<div class="main">
		<div class="left">
			${school.name}<br>
			<img src="${school.logoPath}" width="80px" height="80px"/>
		</div>
		<div class="right">
		</div>
	</div>
</body>
</html>
