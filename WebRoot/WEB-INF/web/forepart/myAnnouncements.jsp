<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE html>
<html>
<head>
<title>校江湖</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

</head>

<body>
	<div class="container cf">
		<jsp:include page="head.jsp" />
		<table class="mt75">
			<tr>
				<td>标题</td>
				<td>时间</td>
				<td>通知者</td>
				<td>内容</td>
			</tr>
			<s:iterator value="#request.myAnnouncements">
				<tr>
					<td><s:property value="title" />
					</td>
					<td><s:date name="datetime" format="yyyy-MM-dd hh:mm:ss" />
					</td>
					<td><s:if test="club != null">
						社团:<s:property value="club.name" />
						</s:if> <s:else>
						系统通知
					</s:else></td>
					<td><s:property value="text" />
					</td>
				</tr>
			</s:iterator>
		</table>
		<wst:page url="myAnnouncements" />
	</div>
</body>
</html>
