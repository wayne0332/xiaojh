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
    			<td>标题：</td>
    			<td>组织单位：</td>
    			<td>主办单位：</td>
    			<td>发布时间：</td>
    			<td>资金预算：</td>
    			<td>举办地点：</td>
    			<td>活动状态：</td>
    			<td>参与人数：</td>
    			<td>活动热度：</td>
    			<td>操作：</td>
    		</tr>
    		<s:iterator value="acs" id="ac">
    		<tr>
    			<td><a href="activity?activity.id=${id}">${tittle}</a></td>
    			<td>${organizer}</td>
    			<td>${club.name}${merchant.name}</td>
    			<td>${datetime}</td>
    			<td>${budget}元</td>
    			<td>${place}</td>
    			<td><s:property value="status.name" /></td>
    			<td>${participantCount}</td>
    			<td>${heat}</td>
    			<td>
    				<a href="preModifyActivity?activity.id=${id}">修改</a>
    				<a href="adminDeleteActivity?activity.id=${id}&condition=${condition}&currentPage=${page.currentPage}&totalPageNumber=${page.pageNumber}&flage=${flage}">删除</a>
    			</td>
    			
    		</tr>
    		</s:iterator>
    		<tr>
    			<td colspan="7" >
    				<span>共${page.pageNumber}页</span><span>当前第${page.currentPage}页</span>
    				<span><a href="${actionName}?condition=${condition}&currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}&flage=${flage}">上一页</a></span>&nbsp;
					<span><a href="${actionName}?condition=${condition}&currentPage=${page.currentPage+1}&totalPageNumber=${page.pageNumber}&flage=${flage}">下一页</a></span>&nbsp;
					
    			</td>
    		</tr>
    	</table>
	</body>
</html>
