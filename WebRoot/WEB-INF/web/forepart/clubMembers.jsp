<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'clubMembers.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		<div class="mt75">
			<form action="searchUser">
				<input type="hidden" name="pageNum" value="1" /> <input
					type="hidden" name="club.id" value="<s:property value="club.id" />" />
				<input name="searchText" type="text" /><input type="submit"
					value="搜索人员" />
				<!-- <s:a href="searchUserToManage?club.id=%{club.id}">搜索人员</s:a> -->
			</form>
			<table>
				<tr>
					<td>名字</td>
					<td>身份</td>
					<td>加入时间</td>
					<td>操作</td>
				</tr>
				<s:iterator value="#request.clubMembers">
					<tr>
						<td><s:property value="user.name" /> <s:if
								test="user.id == #session.user.id">
						(我)
					</s:if>
						</td>
						<td><s:property value="role.name" /> <s:if
								test="status.name() == 'NO_CHECK'">(<s:property
									value="status.name" />)</s:if>
						</td>
						<td><s:date name="datetime" format="yyyy-MM-dd hh:mm:ss" />
						</td>

						<td><s:if test="#request.clubMember.role.name() == 'NORMAL'">
						无
					</s:if> <s:else>
								<s:if test="role.name() == 'NORMAL'">
									<s:if test="status.name() == 'NO_CHECK'">
										<s:if test="source.name() == 'CLUB_TO_USER'">
									已发出邀请
								</s:if>
										<s:else>
											<s:a
												href="clubAcceptInvited?user.id=%{user.id}&club.id=%{club.id}">接受申请</s:a>
											<s:a
												href="clubRefuseInvited?user.id=%{user.id}&club.id=%{club.id}">拒绝</s:a>
										</s:else>
									</s:if>
									<s:else>
										<s:if test="#request.clubMember.role.name() == 'PROPRIETER'">
											<s:a
												href="updateMemberToManager?user.id=%{user.id}&club.id=%{club.id}">变为管理员</s:a>
										</s:if>
										<s:a
											href="fireClubMember?user.id=%{user.id}&club.id=%{club.id}">开除</s:a>
									</s:else>
								</s:if>
								<s:else>
									<s:if test="#request.clubMember.role.name() != 'PROPRIETER'">
								无
							</s:if>
									<s:else>
										<s:if test="role.name() == 'PROPRIETER'">
											<a href="changeProprieterInput?club.id=${club.id }">换社长</a>
										</s:if>
										<s:else>
											<s:a
												href="updateMemberToNormal?user.id=%{user.id}&club.id=%{club.id}">取消管理权限</s:a>
											<s:a
												href="fireClubMember?user.id=%{user.id}&club.id=%{club.id}">开除</s:a>
										</s:else>
									</s:else>
								</s:else>
							</s:else></td>
					</tr>

				</s:iterator>
			</table>
			<wst:page url="clubMembers?club.id=%{club.id}" />
		</div>
	</div>
</body>
</html>
