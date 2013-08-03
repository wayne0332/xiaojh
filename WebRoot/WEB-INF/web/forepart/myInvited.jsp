<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'myInvited.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<jsp:include page="head.jsp" />
	<table>
		<tr>
			<td>社团名</td>
			<td>时间</td>
			<td>申请方</td>
			<td>操作</td>
		</tr>
		<s:iterator value="#request.myInvited">
			<tr>
				<td><s:property value="club.name" /></td>
				<td><s:date name="datetime" format="yyyy-MM-dd hh:mm:ss" />
				</td>
				<td><s:property value="source.name" />
				</td>
				<td><s:if test="source.name() == 'USER_TO_CLUB'">
						等待通过
					</s:if> <s:else>
						<s:a href="userAcceptInvited?club.id=%{club.id}">接受</s:a>
						<s:a href="userRefuseInvited?club.id=%{club.id}">拒绝</s:a>
					</s:else></td>
			</tr>
		</s:iterator>
	</table>
</body>
</html>
