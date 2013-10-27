<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE html>
<html>
<head>
<title>校江湖 - 社团</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-club.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

</head>

<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		
		<div class="left_bar mt75">
			<div class="my_info w240 h90 p5 m5 shadow_l_10 bg_box">
				<img src="images/head/head1.jpg"
					class="fl mt5 ml10 circle_80 shadow_l_5" />
				<ul class="fl w135 p5 pl10 text_r">
					<li class="w135 text_l f14"><a href="updateUserInput"><s:property
								value="#session.user.name" /> </a></li>
					<li><s:property value="#session.user.grade" />
					</li>

					<li><s:property value="#session.user.grade % 2000" />级</li>
					<li><s:property
							value="#application.schools[#session.user.school.id].name" /></li>
					<!-- <li>凤凰社</li> -->
				</ul>
			</div>
		</div>
		
		<div class="main cf mt75">
			<div class="friendList cf">
				<form action="searchUser" method="post" class="cf frd_form shadow_l_3">
					<input type="hidden" name="pageNum" value="1" />
					<input type="hidden" name="club.id" value="<s:property value="club.id" />" />
					<input name="searchText" type="text" class="frd_inputText" />
					<input class="frd_submit hov" type="submit" value="找" />
				</form>
				<!--<form action="searchUser">
				<input type="hidden" name="pageNum" value="1" />
				<input type="hidden" name="club.id" value="<s:property value="club.id" />" />
				<input name="searchText" type="text" /><input type="submit" value="搜索人员" />
				<s:a href="searchUserToManage?club.id=%{club.id}">搜索人员</s:a> 
				</form>-->
				<s:iterator value="#request.clubMembers">

						<div class="friendBox shadow_l_3">
							<s:if test="portrait==''">
								<a href="userHome?user.id=${id}">
									<img src="images/head/head1.jpg" class="fl logoImg" />
								</a>
							</s:if>
							<s:else>
								<a href="userHome?user.id=${id}">
									<img src="images/head/head1.jpg" class="fl logoImg" />
								</a>
							</s:else>
							<ul class="frd_box_info">
								<li class="frd_name">
									<s:property value="user.name" /><s:if test="user.id == #session.user.id">(我)</s:if>
								</li>
								<li><s:property value="role.name" /></li>
								<s:date name="datetime" format="yyyy-MM-dd" />
							</ul>
							<a class="send_msg clear_a op_btn_yellow_green hov" href="personalLetterInput?targetUser.id=${id }&targetUser.name=${name}">发私信</a>
							<span class="no_focus">
								<s:if test="#request.clubMember.role.name() == 'NORMAL'">无</s:if>
								<s:else>
									<s:if test="role.name() == 'NORMAL'">
										<s:if test="status.name() == 'NO_CHECK'">
											<s:if test="source.name() == 'CLUB_TO_USER'">已发出邀请</s:if>
											<s:else>
												<s:a href="clubAcceptInvited?user.id=%{user.id}&club.id=%{club.id}">接受申请</s:a>
												<s:a href="clubRefuseInvited?user.id=%{user.id}&club.id=%{club.id}">拒绝</s:a>
											</s:else>
										</s:if>
										<s:else>
											<s:if test="#request.clubMember.role.name() == 'PROPRIETER'">
							 					<s:a href="updateMemberToManager?user.id=%{user.id}&club.id=%{club.id}">变为管理员</s:a>
							 				</s:if>
											<s:a href="fireClubMember?user.id=%{user.id}&club.id=%{club.id}">开除</s:a>
										</s:else>
									</s:if>
									<s:else>
										<s:if test="#request.clubMember.role.name() != 'PROPRIETER'">无</s:if>
										<s:else>
											<s:if test="role.name() == 'PROPRIETER'">
												<a href="changeProprieterInput?club.id=${club.id }">换社长</a>
											</s:if>
											<s:else>
												<s:a href="updateMemberToNormal?user.id=%{user.id}&club.id=%{club.id}">取消管理权限</s:a>
												<s:a href="fireClubMember?user.id=%{user.id}&club.id=%{club.id}">开除</s:a>
											</s:else>
										</s:else>
									</s:else>
								</s:else>
							</span>

						</div>
					</s:iterator>
			
					<wst:page url="clubMembers?club.id=%{club.id}" />
			</div>
		</div>
	</div>
</body>
</html>
