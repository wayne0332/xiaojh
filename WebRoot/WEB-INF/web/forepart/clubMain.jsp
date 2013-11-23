<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<title>校江湖 - 社团</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-club.css" />

</head>

<body>
	<div class="container">
		<jsp:include page="head.jsp" />

		<div class="main fl cf mt75">
			<s:if test="#session.user != null">
				<div class="club_secNav w pl5 pr5 shadow_l_3 clear_sub">
					<a
						href="clubPostList?club.id=<s:property value="club.id" />&pageNum=1">进入贴吧</a>
					<s:a href="clubMembers?club.id=%{club.id}">
					社团成员
					<s:if
							test="#request.clubMember != null && #request.clubMember.role.name() != 'NORMAL' && #request.userRequestCount != 0">
							(<s:property value="#request.userRequestCount" />)
					</s:if>
					</s:a>
					<s:if test="#request.clubMember != null">
						<a href="addActivityJsp">发布活动</a>
						<a
							href="preAddonlineActivity?club.id=<s:property value="club.id" />">发布线上活动</a>
						<a href="activitys?flage=0">所有活动</a>
						<a href="activitys?flage=1">正在申请的活动</a>
						<a href="activitys?flage=2">已经通过审核的活动</a>
						<a href="activitys?flage=3">被拒绝的活动</a>
						<a href="addClubNewsJsp">添加社团新闻</a>
						<s:if test="#request.clubMember.status.name() == 'NO_CHECK'">
						等待确认
					</s:if>
						<s:else>
							<s:a href="clubAnnouncements?club.id=%{club.id}">社团通告</s:a>
						</s:else>

						<s:if test="#request.clubMember.role.name() == 'PROPRIETER'">
							<s:a href="updateClubInput?club.id=%{club.id}">修改社团信息</s:a>
						</s:if>
					</s:if>
					<s:else>
						<s:a href="userAddClub?club.id=%{club.id}">申请加入</s:a>
					</s:else>
				</div>
			</s:if>

			<div class="clubmain_left">
				<div class="club_box1 shadow_l_3">
					<div>
						<img src="<s:property value="club.logoPath" />" class="logoImg" />
						<span class="club_name"> <p><s:property value="club.name" /></p>
						<p>人气:<s:property value="club.hot()" /></p>
						<p>知名度:${club.popularity }</p>
						</span>
					</div>
					<p class="club_info">
						<s:property value="club.briefIntroduction" />
					</p>
				</div>

				<div class="club_box1 shadow_l_3">
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
			</div>
			<div class="clubmain_left">
				<div class="club_box2 shadow_l_3">
					<s:iterator value="acs" id="ac">
						<div class="club_act_box">
							<div class="club_act_img">
								<img class="act_photo" alt="活动照片"
									src="http://y3.ifengimg.com/2013/0805/wm_9783f21b46072d9503a7bd2f8017f4b7.jpg">
							</div>
							<div class="club_act_info none">
								<span class="club_act_title">
									<a href="activity?activity.id=${id}" target="_blank"><s:property value="tittle" /></a>
								</span>
								 <p class="club_act_p">
									 <s:if test="text>50">
									 	<s:property value="text.substring(0,50)"/>...
									 </s:if>
									 <s:else>
										 ${text}
									 </s:else>
								  </p>
								<span class="club_act_li1">${place}</span> <span
									class="club_act_li1">${participantCount}人 已参与</span> <span
									class="club_act_li2">${club.name}${merchant.name} 主办</span> <span
									class="share"> <a
									href="<%=path %>/preShareTalking?talking.id=${talking.id}">分享</a>
								</span>
							</div>
							<div class="club_act_op">
								<span id="zan${talking.id}"> <a
									href="javascript:void(0);" onclick="zanTalking(${talking.id});">赞(${talking.shareDetails.praiseCount})</a>
								</span>
								<s:if test="actionName.equals('adminFindOneActivity')">
									<a href="<%=path%>/deleteActivity?activity.id=${id}">删除</a>
									<a href="preModifyActivity?activity.id=${id}">修改</a>
								</s:if>
							</div>
						</div>
					</s:iterator>
				</div>
			</div>
		</div>
	</div>

	<div class="left_bar fr cf mt75">
		<label class="Clearfix w250 ml5 mt20"> 关注社团 <a
			href="clubFocus?type=1&pageNum=1" class="fr">更多</a> </label>
		<div class="bg_box shadow_l_3 m5 cf">
			<s:iterator value="#request.focusClubList">
				<div class="fl people_box">
					<a href="clubMain?club.id=<s:property value="id" />"> <s:if
							test="logoPath==''">
							<img src="<s:property value="portraitPath" />"
								class="w50 h50 Clearfix" />
						</s:if> <s:else>
							<img src="upload/portrait/auto_photo.png"
								class="w50 h50 Clearfix" />
						</s:else> <label class="Clearfix mb5 w50"> <s:property value="name" />
					</label> </a>
				</div>
			</s:iterator>
		</div>
		<label class="Clearfix w250 ml5 mt20"> 关注商家 <a
			href="clubFocus?type=2" class="fr">更多</a> </label>
		<div class="bg_box shadow_l_3 m5 cf">
			<s:iterator value="#request.focusMerchantList">
				<div class="fl people_box">
					<a href="merchant?merchant.id=<s:property value="id" />"> <s:if
							test="logoPath==''">
							<img src="<s:property value="portraitPath" />"
								class="w50 h50 Clearfix" />
						</s:if> <s:else>
							<img src="upload/portrait/auto_photo.png"
								class="w50 h50 Clearfix" />
						</s:else> <label class="Clearfix mb5 w50"> <s:property value="name" />
					</label> </a>
				</div>
			</s:iterator>
		</div>
	</div>

	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="js/club_page_action.js"></script>

</body>
</html>
