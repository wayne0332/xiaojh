<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'AllClubPost.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="社团帖子总览">
  </head>
	<body>
		<div>社团帖子管理</div>
    	<table>
    		<tr>
    			<td>id号</td>
    			<td>社团名称</td>
    			<td>标题</td>
    			<td>发帖人</td>
    			<td>时间</td>
    			<td>回复数</td>
    			<td>删帖</td>
    		</tr>
    	<s:iterator value="#request.clubPostList.clubPostList" >
    		<tr>
    			<td><s:property value="id" /></td>
    			<td><s:property value="club.name" /></td>
    			<td><a href="clubPostContent?postId=<s:property value="id" />" ><s:property value="tittle" /></a></td>
    			<td><s:property value="user.name" /></td>
    			<td><s:property value="datetime" /></td>
    			<td><s:property value="clubPostComments.size" /></td>
    			<td><a href="javascript:if(confirm('确认删除 吗?'))document.location='adminDeleteClubPost?post.id=<s:property value="id" />'" >删帖</a></td>
    		</tr>
    	</s:iterator>
    		<tr>
    			<td colspan="7" >
    				<span><a href="allClubPost?pageNum=<s:property value="#request.clubPostList.page.currentPage-1" />">上一页</a></span>&nbsp;
					<span><a href="allClubPost?pageNum=<s:property value="#request.clubPostList.page.currentPage+1" />">下一页</a></span>
					<span>共 <s:property value="#request.clubPostList.page.pageNumber" />页</span>
    			</td>
    		</tr>
    	</table>
	</body>
</html>
