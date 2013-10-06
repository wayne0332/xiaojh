<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'personalLetter.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<table>
		<tr>
			<td>收件人:</td>
			<td><s:property value="letter.userByTargetUserId.name" /></td>
		</tr>
		<tr>
			<td>发件人:</td>
			<td><s:property value="letter.userBySourceUserId.name" /></td>
		</tr>
		<%-- <tr>
			<td>标题:</td>
			<td><s:property value="letter.title" /></td>
		</tr> 标题不用了 --%>
		<tr>
			<td>发送时间:</td>
			<td><s:date name="letter.datetime" format="yyyy-MM-dd HH:mm:ss" />
			</td>
		</tr>
		<tr>
			<td>内容:</td>
			<td><s:property value="letter.text" />
			</td>
		</tr>
	</table>
</body>
</html>
