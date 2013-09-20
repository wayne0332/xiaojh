<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'merchantMain.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<div style="border:1px;">
	商家名称：${merchant.name}&nbsp;&nbsp;<a href="focusMerchant?id=${merchant.id}">关注</a>
	<br>商家logo:<img src="${merchant.logoPath }">
	</div>
	<a href="merchantNews">更多新闻</a>
	<jsp:include page="merchantNews.jsp" />
	<jsp:include page="includeNoPageActivitys.jsp" />
	
</body>
</html>
