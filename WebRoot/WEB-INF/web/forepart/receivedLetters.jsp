<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'receivedLetters.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<jsp:include page="head.jsp" />
	<a href="initSearch">写私信</a>
	<table>
		<tr>
			<td>序号</td>
			<td>标题</td>
			<td>头像</td>
			<td>时间</td>
			<td>发布人姓名</td>
			<td>内容</td>
			<td>状态</td>
			<td>操作</td>
		</tr>
		<s:iterator value="#request.receivedLetters" status="status">
			<tr>
				<td><s:property
						value="(page.currentPage - 1) * page.eachPageNumber + #status.count" />
				</td>
				<td><s:a href="personalLetter?letter.id=%{id}">
						<s:property value="title" />
					</s:a></td>
				<td><img alt="头像" title="头像"
					src="<s:property value="userBySourceUserId.portraitPath"/>">
				</td>
				<td><s:date name="datetime" format="yyyy-MM-dd" /> <br> <s:date
						name="datetime" format="HH:mm:ss" /></td>
				<td><s:property value="userBySourceUserId.name" /></td>
				<td><s:property value="text" /></td>
				<td><s:property value="status.name" /></td>
				<td><s:a href="deleteLetter?letter.id=%{id}">
						删除
					</s:a> <s:a
						href="personalLetterInput?targetUser.id=%{userBySourceUserId.id}&targetUser.name=%{userBySourceUserId.name}">回复</s:a>
				</td>
			</tr>
		</s:iterator>
	</table>
	<wst:page url="receivedLetters" />
</body>
</html>
