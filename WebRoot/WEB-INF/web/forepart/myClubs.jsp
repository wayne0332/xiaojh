<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'myClubs.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<jsp:include page="head.jsp" />
	<a href="applyClubInput">申请社团</a>
	<s:if
		test="#request.clubInviteCount != null && #request.clubInviteCount != 0">
		<a href="myInvited" class="a_bt"> 我的邀请(<s:property
				value="#request.clubInviteCount" />) </a>
	</s:if>
	<table>
		<tr>
			<td>Logo</td>
			<td>社团名字</td>
			<td>身份</td>
			<td>操作</td>
		</tr>
		<s:iterator value="#request.myClubs">
			<tr>
				<td><img src="<s:property value="club.logoPath" />">
				</td>
				<td><s:property value="club.name" /></td>
				<td><s:property value="role.name" /> <s:if
						test="status.name() == 'NO_CHECK'">(<s:property
							value="status.name" />)</s:if></td>
				<td><s:a href="clubMain?club.id=%{club.id}">进入社团</s:a></td>
			</tr>
		</s:iterator>
	</table>
	<wst:page url="myClubs" />
</body>
</html>
