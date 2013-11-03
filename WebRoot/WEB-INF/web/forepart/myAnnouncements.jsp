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
	<div class="container cf">
		<jsp:include page="head.jsp" />
		
		<div class="main mt75">
			<jsp:include page="announcementsDisplay.jsp" />
			
			<wst:page url="myAnnouncements" />
		</div>
	</div>
</body>
</html>
