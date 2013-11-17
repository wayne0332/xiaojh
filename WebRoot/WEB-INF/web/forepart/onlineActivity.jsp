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

<script type="text/javascript" src="js/ajax.js"></script>

</head>
<body>
	<div class="container">
		<jsp:include page="head.jsp" />
		
		<div class="dt_body clearfix">
			<div class="dt_main">
				<div class="content card shadow_l_3">
				
					<h1><s:property value="onlineactivity.tittle" /></h1>
					
					<div class="video">${onlineactivity.videoUrl}</div>
					
					<div class="coverImg">
						<img src="${onlineactivity.titleImgPath}" />
					</div>
					
				</div>
			</div>
			<div class="dt_sidebar">
				<ul class="acti-info card shadow_l_3">
					<li><span class="status ongoing"><s:property value="activity.status.name" /></span></li>
					<li class="clearfix">
						<span class="at-school">${onlineactivity.user.name}</span>
						<span class="join-count">${onlineactivity.participantCount}&nbsp;人参与</span>
					</li>
					<li>${onlineactivity.text}</li>
					<li><div class="mt10 tr">${onlineactivity.datetime}</div></li>
					<li class="tr">
						<a href="<%=path %>/preShareTalking?talking.id=${onlineactivity.talking.id}">分享(${onlineactivity.talking.shareDetails.shareCount})</a>
						<span id="zan${onlineactivity.talking.id}"><a href="javascript:void(0);" onclick="zanTalking(${onlineactivity.talking.id});">赞(${onlineactivity.talking.shareDetails.praiseCount})</a></span>
						<span id="canyu${onlineactivity.id}"><a href="javascript:void(0);" onclick="canyu(${onlineactivity.id});">我要参与(${onlineactivity.participantCount})</a></span>
					</li>
				</ul>
			</div>
		</div>
     	
	</div>
</body>
</html>
