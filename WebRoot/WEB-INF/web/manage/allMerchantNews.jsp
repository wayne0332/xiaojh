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
	<meta http-equiv="description" content="商家新闻总览">
  </head>
	<body>
		<div>商家新闻管理</div>
    	<table>
    		<tr>
    			<td>id号</td>
    			<td>商家名称</td>
    			<td>标题</td>
    			<td>时间</td>
    			<td>删帖</td>
    		</tr>
    	<s:iterator value="#request.merchantNewsList.merchantNewsList" >
    		<tr>
    			<td><s:property value="id" /></td>
    			<td><s:property value="merchant.name" /></td>
    			<td><a href="javascript:void()" ><s:property value="tittle" /></a></td>
    			<td><s:property value="datetime" /></td>
    			<td><a href="javascript:if(confirm('确认删除吗?'))document.location='adminDeleteMerhcantNews?merchantNews.id=<s:property value="id" />&merchant.id=<s:property value="merchant.id" />'" >删帖</a></td>
    		</tr>
    	</s:iterator>
    		<tr>
    			<td colspan="7" >
    				<span><a href="allMerchantNews?pageNum=<s:property value="#request.MerchantNewsList.page.currentPage-1" />">上一页</a></span>&nbsp;
					<span><a href="allMerchantNews?pageNum=<s:property value="#request.MerchantNewsList.page.currentPage+1" />">下一页</a></span>
					<span>共 <s:property value="#request.MerchantNewsList.page.pageNumber" />页</span>
    			</td>
    		</tr>
    	</table>
	</body>
</html>
