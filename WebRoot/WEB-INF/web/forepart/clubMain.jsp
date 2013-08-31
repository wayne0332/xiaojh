<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>校江湖 - 社团</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

<style type="text/css">
.rectRow {
	background-color: #dde;
}

.rectBlock {
	float: left;
	width: 340px;
}

.rectBlock a {
	text-decoration: none;
}

.left {
	float: left;
	width: 680px;
}

.right {
	float: right;
	margin: 0 0;
	padding: 0 0;
	width: 220px;
}

.rightBlock {
	float: left;
}

.portrait {
	width: 44px;
	float: left;
	margin-top: 20px;
}

.portraitImg {
	padding-top: 5px;
}
</style>

</head>

<body>
	<div class="container">
		<!-- <jsp:include page="head.jsp" /> -->

		<div class="main fl cf">
			<div class="club_secNav w pl5 pr5">
				<a
					href="clubPostList?club.id=<s:property value="club.id" />&pageNum=1">进入贴吧</a>
				<s:a href="clubMembers?club.id=%{club.id}">社团成员<s:if
						test="#request.clubMember != null && #request.clubMember.role.name() != 'NORMAL' && #request.userRequestCount != 0">
							(<s:property value="#request.userRequestCount" />)
						</s:if>
				</s:a>
				<s:if test="#request.clubMember != null">
					<a href="addActivityJsp">发布活动</a>
					<a href="preAddonlineActivity?club.id=<s:property value="club.id" />">发布线上活动</a>
					<a href="activitys?flage=0">所有活动</a>
					<a href="activitys?flage=1">正在申请的活动</a>
					<a href="activitys?flage=2">已经通过审核的活动</a>
					<a href="activitys?flage=3">被拒绝的活动</a>
					<s:if test="#request.clubMember.status.name() == 'NO_CHECK'">
					等待确认
					</s:if>
					<s:else>
						<s:a href="clubAnnouncements?club.id=%{club.id}">社团通告</s:a>
					</s:else>
				</s:if>
				<s:else>
					<s:a href="userAddClub?club.id=%{club.id}">申请加入</s:a>
				</s:else>
			</div>
			<div class="club_panel fl m5 p10 bg_fff">
				<div>
					<s:property value="club.name" />
				</div>
				<img src="<s:property value="club.logoPath" />" class="logoImg" />
				<div>
					<s:property value="club.introduction" />
				</div>
			</div>
			<div class="club_panel fl m5 p10 bg_fff">
				<div>活动展示</div>
				<s:iterator value="acs" id="ac">
					<div
						style="display: inline-block; border:1px solid;width:80%;margin:20px; overflow:hidden;">
						活动标题：
						<s:property value="tittle" />
						<br /> ${text}<br/> 活动举办地点：${place}<br />
						参与人数：${participantCount} <br /> 活动主办方：${club.name}${merchant.name}
						<br /> &nbsp;<a
							href="<%=path %>/preShareTalking?talking.id=${talking.id}">分享</a>
						<span id="zan${talking.id}"> <a href="javascript:void(0);"
							onclick="zanTalking(${talking.id});">赞(${talking.shareDetails.praiseCount})</a>
						</span>
						<s:if test="actionName.equals('adminFindOneActivity')">
							<a href="<%=path%>/deleteActivity?activity.id=${id}">删除</a>
							<a href="preModifyActivity?activity.id=${id}">修改</a>
						</s:if>
					</div>
				</s:iterator>
			</div>
			<div class="club_panel fl m5 p10 bg_fff">
				<div>社团贴吧</div>
				<s:iterator value="#request.clubPostList.clubPostList">
					<div class="title">
						<a href="clubPostContent?postId=<s:property value="id" />"> <s:property
								value="tittle" />&nbsp;&nbsp;&nbsp; <s:property
								value="user.name" />&nbsp;&nbsp;&nbsp; <s:date name="date"
								format="YYYY-MM-DD" /> </a>
					</div>
				</s:iterator>
			</div>
			<div class="club_panel fl m5 p10 bg_fff">
				<div>
					关注商家： <a href="clubFocus?type=2">更多</a>
				</div>
				<s:iterator value="#request.focusMerchantList">
					<div class="portrait">
						<div class="portraitImg"></div>
						<div class="userName">
							<s:property value="name" />
						</div>
					</div>
				</s:iterator>
			</div>
		</div>
	</div>
	<div class="left_bar fr cf">
		<div class="rightBlock">
			<div>
				关注社团&nbsp;&nbsp;&nbsp;&nbsp;<a href="clubFocus?type=1&pageNum=1">更多</a>
				<s:property value="" />
			</div>
			<div>
				<s:iterator value="#request.focusClubList">
					<div class="portrait">
						<div class="portraitImg">
							<s:if test="logoPath==''">
								<img src="<s:property value="portraitPath" />" width="40px" />
							</s:if>
							<s:else>
								<img src="upload/portrait/auto_photo.png" width="40px" />
							</s:else>
						</div>
						<div class="userName">
							<s:property value="name" />
						</div>
					</div>
				</s:iterator>
			</div>
		</div>
	</div>
</body>
</html>
