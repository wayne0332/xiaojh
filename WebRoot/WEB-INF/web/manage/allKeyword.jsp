<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'allKeyword.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<table>
		<tr>
			<td>关键字</td>
			<td>操作</td>
		</tr>
		<s:iterator value="#request.keywords" var="keyword">
			<tr>
				<td><s:property value="keyword" />
				</td>
				<td><form action="deleteKeyword" method="post">
						<s:hidden name="keyword" value="%{#keyword}" />
						<input type="submit" value="删除">
					</form>
				</td>
			</tr>
		</s:iterator>
		<form action="addKeyword" method="post">
		<tr>
			<td><input type="text" name="keyword"></td>
			<td><input type="submit" value="添加"></td>
		</tr>
		</form>
	</table>
</body>
</html>
