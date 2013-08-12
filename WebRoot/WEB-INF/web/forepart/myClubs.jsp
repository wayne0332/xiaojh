<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>校江湖 - 社团主页</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

</head>

<body>

	<div class="container cf zoom">
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
					<td><img src="<s:property value="club.logoPath"/>" class="logoImg" /></td>
					<td><s:property value="club.name" /></td>
					<td><s:property value="role.name" /> <s:if
							test="status.name() == 'NO_CHECK'">(<s:property
								value="status.name" />)</s:if></td>
					<td><s:a href="clubMain?club.id=%{club.id}">进入社团</s:a></td>
				</tr>
			</s:iterator>
		</table>
		<wst:page url="myClubs" />
	</div>
</body>
</html>
