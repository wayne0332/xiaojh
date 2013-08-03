<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'clubManage.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<style type="text/css">
body {
	margin: 0 auto;
	padding: 0 0;
}

.header span {
	float: right;
}

.clearfloat {
	clear: both
}

.container {
	margin: 0 auto;
	padding: 0 0;
	width: 920px;
}

.main {
	
}

.top {
	
}

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

.header {
	
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
		<jsp:include page="head.jsp" />
		<div class="clearfloat"></div>
		<div class="main">
			<div class="top">
				<a
					href="clubPostList?clubId=<s:property value="club.id" />&pageNum=1">进入贴吧</a>
				<s:a href="clubMembers?club.id=%{club.id}">社团成员<s:if
						test="#request.clubMember != null && #request.clubMember.role.name() != 'NORMAL' && #request.userRequestCount != 0">
							(<s:property value="#request.userRequestCount" />)
						</s:if>
				</s:a>
				<s:if test="#request.clubMember != null">
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
			<div class="clearfloat"></div>
			<div class="left">
				<div class="rectRow">
					<div class="rectBlock">
						<div>
							<s:property value="club.name" />
						</div>
						<img src="<s:property value="club.logoPath" />">
						<div>
							<s:property value="club.introduction" />
						</div>
					</div>
					<div class="rectBlock">
						<div>活动展示</div>
						<s:iterator value="acs" id="ac">
							<div
								style="display: inline-block; border:1px solid;width:80%;margin:20px; overflow:hidden;">
								活动标题：
								<s:property value="tittle" />
								<br> ${text}<br> 活动举办地点：${place}<br>
								参与人数：${participantCount}<br>
								活动主办方：${club.name}${merchant.name}<br> &nbsp;<a
									href="<%=path %>/preShareTalking?talking.id=${talking.id}">分享</a>
								<span id="zan${talking.id}"> <a
									href="javascript:void(0);" onclick="zanTalking(${talking.id});">赞(${talking.shareDetails.praiseCount})</a>
								</span>
								<s:if test="actionName.equals('adminFindOneActivity')">
									<a href="<%=path%>/deleteActivity?activity.id=${id}">删除</a>
									<a href="preModifyActivity?activity.id=${id}">修改</a>
								</s:if>
							</div>
						</s:iterator>
					</div>
				</div>
				<div class="clearfloat"></div>
				<div class="rectRow">
					<div class="rectBlock">
						<div>社团贴吧</div>
						<s:iterator value="#request.clubPostList.clubPostList">
							<div class="title">
								<a href="clubPostContent?postId=<s:property value="id" />">
									<s:property value="tittle" />&nbsp;&nbsp;&nbsp; <s:property
										value="user.name" />&nbsp;&nbsp;&nbsp; <s:date name="date"
										format="YYYY-MM-DD" /> </a>
							</div>
						</s:iterator>
					</div>
					<div class="rectBlock">
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
			<div class="right">
				<div class="rightBlock">
					<div>
						关注社团&nbsp;&nbsp;&nbsp;&nbsp;<a href="clubFocus?type=1">更多</a>
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
				<div class="rightBlock"></div>
			</div>


		</div>
	</div>
	<div>
		<div></div>
		<div class="clearfloat"></div>
		<div>
			<div></div>
		</div>
		<div></div>
	</div>
</body>
</html>
