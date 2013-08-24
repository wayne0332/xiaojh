<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>社团论坛</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
	<body>
	<div><a href="initAddClubPost?club.id=<s:property value="#request.club.id" />">发帖</a></div>
    <s:iterator value="#request.clubPostList.clubPostList">
    	<div class="post">
    		<div class="title">
    			<a href="clubPostContent?postId=<s:property value="id" />">
    			<s:property value="tittle" />&nbsp;&nbsp;&nbsp;
    			<s:property value="user.name" />&nbsp;&nbsp;&nbsp;
    			<s:date name="date" format="YYYY-MM-DD" />
    			</a>
    		</div>
    	</div>
    </s:iterator>
    	<div>
    		<span><a href="clubPostList?pageNum=<s:property value="clubPostList.page.currentPage-1" />">上一页</a></span>&nbsp;
			<span><a href="clubPostList?pageNum=<s:property value="clubPostList.page.currentPage+1" />">下一页</a></span>
			<span>共 <s:property value="clubPostList.page.pageNumber" />页</span>
    	</div>
	</body>
</html>
