<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<base href="<%=basePath%>" />

<title>校江湖 - 个人主页</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

</head>

<body>
	<div>
		<a
			href="initAddActivityPost?activityId=<s:property value="#request.activityId" />">为活动发帖</a>
	</div>
	<s:iterator value="#request.activityPostList.activityPostList">
		<div class="post">
			<div class="title">
				<a href="activityPostContent?postId=<s:property value="id" />">
					<s:property value="title" />&nbsp;&nbsp;&nbsp; <s:property
						value="user.name" />&nbsp;&nbsp;&nbsp; <s:date name="date"
						format="YYYY-MM-DD" /> </a>
			</div>
		</div>
	</s:iterator>
	<div>
		<span><a
			href="activityPostList?pageNum=<s:property value="activityPostList.page.currentPage-1" />">上一页</a>
		</span>&nbsp; <span><a
			href="activityPostList?pageNum=<s:property value="activityPostList.page.currentPage+1" />">下一页</a>
		</span> <span>共 <s:property value="activityPostList.page.pageNumber" />页</span>
	</div>
</body>
</html>
