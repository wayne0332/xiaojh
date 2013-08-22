<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ads" uri="fineTu/ads"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<base href="<%=basePath%>" />

<title>校江湖 - 线上活动</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

<script type="text/javascript" src="<%=path%>/js/ajax.js"></script>

</head>
<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />

		<div class="main fl cf mt75">
			<div class="w fl">
				<a href="<%=path%>/addOnlineActivityJsp"
					class="single_bt1 w100 mt5 ml5 fl shadow_l_5">发表线上活动</a> <a
					href="myActivity" class="single_bt2 w100 fl mt10 shadow_l_5">查看线下活动</a><br />
				<br /> <a href="#" class="fr mr20">时间排序</a> <a href="#"
					class="fr mr10">热度排序</a>
			</div>

			<s:property value="message" />

			<s:iterator value="oacs" id="oac">
				<div
					class="myActivity_box w700 mt15 ml5 p10 cf fl shadow_l_10 bg_fff">
					<!--  活动 封面： -->
					<h2 class="w335 fr">
						<a href="getOnlineActivityById?onlineactivity.id=${id}"><s:property
								value="tittle" /> </a>
					</h2>
					<div class="myActivity_img w335 fl">
						<img src="${titleImgPath}" class="w335 fl" />
					</div>
					<ul class="w335 fr mt10">
						<li><label>活动来源：</label>${ac.club.name}${ac.merchant.name}${datetime}</li>
						<li><label>活动状态： </label> <s:property value="status.name" />
						</li>
						<li><label>参与人数：</label>${participantCount}</li>
						<li><label>活动热度：</label>${heat}</li>
						<li><label>分享次数：</label>${talking.shareDetails.shareCount}</li>
						<li class="fr"><a
							href="<%=path %>/preShareTalking?talking.id=${talking.id}">分享</a>
							<span id="zan${talking.id}"> <a href="javascript:void(0);"
								onclick="zanTalking(${talking.id});">赞(${talking.shareDetails.praiseCount})</a>
						</span><a href="#">我要参与</a></li>
						<s:if test="actionName.equals('userOnlineActivity')">
							<a href="preModifyOnlineActivity?onlineactivity.id=${id}">删除</a>
							<a href="deleteOnlineActivity?onlineactivity.id=${id}">修改</a>
						</s:if>
					</ul>
				</div>
			</s:iterator>

			<ul class="w300 fl mt20">
				<li class="w60 fr">共${page.pageNumber}页</li>
				<li class="w60 fr">当前第${page.currentPage}页</li>
				<li class="w60 fl"><a
					href="<%=path%>/${actionName}?condition=${condition}&currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}&club.id=${club.id}&merchant.id=${merchant.id}"
					target="_self">上一页</a>
				</li>
				<li class="w60 fl"><a
					href="<%=path%>/${actionName}?condition=${condition}&currentPage=${page.currentPage+1}&totalPageNumber=${page.pageNumber}&club.id=${club.id}&merchant.id=${merchant.id}"
					target="_self">下一页</a></li>
			</ul>
		</div>
	</div>
</body>
</html>
