<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE html>
<html>
<head>

<title>校江湖</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

</head>

<body>

	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		<div class="mt75">
			<s:if test="#session.clubMember.role.name() != 'NORMAL'">
				<a
					href="addAnnouncementInput?path=clubAnnouncements&club.id=${param['club.id'] }">发布社团通告</a>
			</s:if>
			<jsp:include page="announcementsDisplay.jsp" />
			<wst:page url="clubAnnouncements" />
		</div>
	</div>
</body>
</html>
