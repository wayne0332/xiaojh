<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>活动帖子</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
<body>
	<div class="div">
     	<div style="display: inline-block; border:1px solid;width:80%;margin:20px; overflow:hidden;">
     		<s:if test="#request.activityPostContent.page.currentPage==1">
     			<div><s:property value="#request.activityPostContent.activityPost.tittle" />&nbsp;&nbsp;<s:property value="#request.activityPostContent.activityPost.user.name" />&nbsp;&nbsp;&nbsp;<s:date name="#request.activityPost.datetime"/></div>
     			<div><s:property value="#request.activityPostContent.activityPost.text" /></div>
     			<hr/>
     		</s:if>
     		<div>
     		<s:iterator value="#request.activityPostContent.commentList">
     		<div>
     			<div>
     				<s:property value="user.name" />&nbsp;&nbsp;&nbsp;
     				<s:date name="datetime"/>&nbsp;&nbsp;&nbsp;
     				<s:if test="%{#session.user.id==#request.activityPostContent.activityPost.user.id}">
     					<a href="deleteActivityComment?comment.id=<s:property value="id" />&postId=<s:property value="#request.activityPostContent.activityPost.id" />&pageNum=<s:property value="#request.activityPostContent.page.currentPage-1" />">删除</a>
     				</s:if>
     			</div>
     			<div>
     				<s:property value="text" />
     			</div>
     		</div>
     		</s:iterator>
     		<div>
     		<s:if test="#session.user==null">
     			<div>评论请登录！</div>
     		</s:if>
     		<s:else>
     		<div>
     			<form action="addActivityComment?postId=<s:property value="#request.activityPostContent.activityPost.id" />" method="post" >
     				<input type="text" name="comment.text" />
     				<input type="submit" value="回帖" />
     			</form>
     		</div>
     		</s:else>
     		</div>
     	</div>
     	</div>
     	
     	<div>
    		<span><a href="activityPostContent?postId=<s:property value="#request.activityPostContent.activityPost.id" />&pageNum=<s:property value="#request.activityPostContent.page.currentPage-1" />">上一页</a></span>&nbsp;
			<span><a href="activityPostContent?postId=<s:property value="#request.activityPostContent.activityPost.id" />&pageNum=<s:property value="#request.activityPostContent.page.currentPage+1" />">下一页</a></span>
			<span>共 <s:property value="#request.activityPostContent.page.pageNumber" />页</span>
    	</div>
    	
     </div>
</body>
</html>
