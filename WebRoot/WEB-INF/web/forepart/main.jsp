<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'success.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<a href="updateUserInput">修改信息</a> 新的私信:
	<a href="receivedLetters"> <s:property
			value="#session.user.receiveLetterCount" /> </a>
	<table>
		<thead>
			<label>userName:</label>
			<s:property value="#session.user.name" />
		</thead>
		<s:iterator value="#request.allUsers">
			<tr>
				<td><s:property value="id" /></td>
				<td><s:property value="name" /></td>
				<td><s:a
						href="personalLetterInput?targetUser.id=%{id}&targetUser.name=%{name}">
				发送私信</s:a></td>
			</tr>
		</s:iterator>
	</table>
</body>
</html>
