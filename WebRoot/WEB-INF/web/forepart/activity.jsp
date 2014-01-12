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
				
					<h1><s:property value="activity.tittle" /></h1>
					
					<div class="video">${activity.videoUrl}</div>
					
					<div class="coverImg">
						<img src="${activity.titleImgPath}" />
					</div>
					
				</div>
			</div>
			<div class="dt_sidebar">
				<ul class="acti-info card shadow_l_3">
					<li><span class="status ongoing"><s:property value="activity.status.name" /></span></li>
					<li class="clearfix">
						<span class="at-school">${activity.place}</span>
						<span class="join-count">${activity.participantCount}&nbsp;人参与</span>
					</li>
					<li>${activity.text}</li>
					<li><label>预算：</label>${activity.budget}元</li>
					<li><label>主办方：</label>${activity.club.name}&nbsp;${activity.merchant.name}</li>
					<li><label>来自：</label>${activity.club.name}&nbsp;${activity.merchant.name}</li>
					<li><div class="mt10 tr">${activity.datetime}</div></li>
					<li class="tr">
						<s:if test="#session.user != null">
							<a href="<%=path %>/preShareTalking?talking.id=${activity.talking.id}">分享(${activity.talking.shareDetails.shareCount})</a>
							<span id="zan${activity.talking.id}"><a href="javascript:void(0);" onclick="zanTalking(${activity.talking.id});">赞(${activity.talking.shareDetails.praiseCount})</a></span>
							<span id="canyu${activity.id}"><a href="javascript:void(0);" onclick="canyu(${activity.id});">我要参与(${activity.participantCount})</a></span>
						</s:if>
					</li>
				</ul>
			</div>
		</div>
	
	</div>	
</body>
</html>
