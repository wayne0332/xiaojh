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
	<table>
		<tr>
			<td>社团名</td>
			<td>时间</td>
			<td>申请方</td>
			<td>操作</td>
		</tr>
		<s:iterator value="#request.clubRequest">
			<tr>
				<td><s:property value="user.name" /></td>
				<td><s:date name="datetime" format="yyyy-MM-dd hh:mm:ss" />
				</td>
				<td><s:property value="source.name" />
				</td>
				<td><s:if test="source.name() == 'USER_TO_CLUB'">
						<s:a href="clubAcceptInvited?user.id=%{user.id}">接受申请</s:a>
						<s:a href="clubRefuseInvited?user.id=%{user.id}">拒绝</s:a>
					</s:if> <s:else>
						等待接受
					</s:else></td>
			</tr>
		</s:iterator>
	</table>
</body>
</html>
