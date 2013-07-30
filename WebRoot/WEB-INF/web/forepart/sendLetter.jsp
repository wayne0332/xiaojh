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
	<form action="sendLetter" method="post">
		<table>
			<tr>
				<td>收件人:</td>
				<td><s:property value="targetUser.name" />
				</td>
			</tr>
			<tr>
				<td>发件人:</td>
				<td><s:property value="#session.user.name" />
				</td>
			</tr>
			<!-- <tr>
				<td>标题:</td>
				<td><input type="text" name="letter.title"></td>
			</tr> -->
			<tr>
				<td>内容:</td>
				<td><textarea rows="10" cols="30" name="letter.text"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2"><s:hidden name="letter.userByTargetUserId.id"
						value="%{targetUser.id}" /> <s:hidden
						name="letter.userBySourceUserId.id" value="%{#session.user.id}" />
					<input type="hidden" name="letter.title"> <input
					type="submit" value="提交"></td>
			</tr>
		</table>
	</form>
</body>
</html>
