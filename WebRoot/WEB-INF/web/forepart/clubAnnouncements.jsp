<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'clubAnnouncement.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<jsp:include page="head.jsp" />
	<s:if test="#session.clubMember.role.name() != 'NORMAL'">
		<a href="addClubAnnouncementInput?path=clubAnnouncements&club.id=${param['club.id'] }">发布社团通告</a>
	</s:if>
	<jsp:include page="announcementsDisplay.jsp"/>
	<wst:page url="clubAnnouncements" />
</body>
</html>
