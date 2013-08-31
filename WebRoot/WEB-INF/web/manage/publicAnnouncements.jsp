<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'publicAccouncements.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<h1>不登陆发东西会出错!(以后记得删掉这句话- -)</h1>
	<a href="addAnnouncementInput?path=publicAnnouncements">发布通告</a>
	<jsp:include page="../forepart/announcementsDisplay.jsp" />
	<wst:page url="publicAnnouncements" />
</body>
</html>
