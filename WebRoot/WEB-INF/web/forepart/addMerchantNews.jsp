<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'addMerchantNews.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<wst:parameter value="msg" />
	<form action="addMerchantNews" method="post"
		enctype="multipart/form-data">
		<table>
			<tr>
				<td>标题:</td>
				<td><input type="text" name="merchantNews.tittle">
				</td>
			</tr>
			<tr>
				<td>内容:</td>
				<td><textarea rows="5" cols="30" name="merchantNews.text"></textarea>
				</td>
			</tr>
			<tr>
				<td>上传:</td>
				<td>媒体链接:<input type="text" name="merchantNews.url" /><br>
					媒体上传:<input type="file" name="media" /><br>
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="发布">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
