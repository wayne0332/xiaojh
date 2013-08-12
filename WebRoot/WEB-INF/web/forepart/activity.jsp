<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<base href="<%=basePath%>" />

<title>校江湖 - 活动</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

<script type="text/javascript" src="js/ajax.js"></script>

</head>
<body>
	<div class="div">
		活动标题：
		<s:property value="activity.tittle" />
		<br> 活动 封面：<br> <img src="${activity.titleImgPath}" /><br>
			${activity.text}
		<br> ${activity.videoUrl}
		<br> 活动预算资金：${activity.budget}元
		<br> 活动组织者：${activity.organizer}
		<br> 活动举办地点：${activity.place}
		<br> 参与人数：${activity.participantCount}
		<br> 活动状态：
		<s:property value="activity.status.name" />
		<br> 活动主办方：${activity.club.name}${activity.merchant.name}
		<br> 来自：${activity.club.name}${activity.merchant.name}&nbsp;
			${activity.datetime}&nbsp;
			分享次数：${activity.talking.shareDetails.shareCount} &nbsp;
		<a href="<%=path %>/preShareTalking?talking.id=${activity.talking.id}">分享</a>
		<span id="zan${activity.talking.id}"> <a
			href="javascript:void(0);"
			onclick="zanTalking(${activity.talking.id});">赞(${activity.talking.shareDetails.praiseCount})</a>
		</span>
	</div>
</body>
</html>
