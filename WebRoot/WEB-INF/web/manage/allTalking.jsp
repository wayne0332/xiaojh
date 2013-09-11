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
    
    <title>My JSP 'AllClubNews.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="社团帖子总览">
  </head>
	<body>
		<div>说说管理</div>
    	<table>
    		<tr>
    			<td>id号</td>
    			<td>用户名</td>
    			<td>内容</td>
    			<td>时间</td>
    			<td>操作</td>
    		</tr>
    	<s:iterator value="taks" id="tak">
    		<tr>
    			<td>${t.id}</td>
    			<td>${t.user.name}</td>
    			<td><s:property value="t.text" escape="false"/></td>
    			<td><s:property value="t.datetime" /></td>
    			<td><a href="javascript:if(confirm('确认删除吗?'))document.location='deleteTalking?talking.id=<s:property value="t.id" />&currentPage=${page.currentPage}&totalPageNumber=${page.pageNumber}'" >删除</a></td>
    		</tr>
    	</s:iterator>
    		<tr>
    			<td colspan="7" >
    				<span>共${page.pageNumber}页</span><span>当前第${page.currentPage}页</span>
    				<span><a href="${actionName}?currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}">上一页</a></span>&nbsp;
					<span><a href="${actionName}?currentPage=${page.currentPage+1}&totalPageNumber=${page.pageNumber}">下一页</a></span>&nbsp;
					
    			</td>
    		</tr>
    	</table>
	</body>
</html>
