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
    
    <title></title>
	<link rel="stylesheet" type="text/css" href="css/base-min.css" />
	<link rel="stylesheet" type="text/css" href="css/common.css" />
	<link rel="stylesheet" type="text/css" href="css/page-user.css" />
	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
  </head>
	<body>
		<div class="container cf">
		<jsp:include page="head.jsp" />
		<div class="cityMap mt75 mb50">
    			<s:iterator value="#request.merchantList.merchantList" >
    			
    				<s:if test="logoPath==''">
					<img src="images/head/head1.jpg" class="logoImg" />
				</s:if>
				<s:else>
					<img src="<s:property value="logoPath" />"  class="logoImg" />
				</s:else>
				
    			<a href="merchant?merchant.id=<s:property value="id" />" ><s:property value="name" /></a>
    			<s:property value="type.getName()" />
    			<s:property value="address" />
    			<s:property value="connectorName" />
    			<s:property value="connectorPhone" />
    			<s:property value="connectorEmail" />
    			
    			
    			<s:a href="javascript:void()" >发私信</s:a><br>
    		
    	</s:iterator>
    				<span><a href="merchants?pageNum=<s:property value="#request.merchantList.page.currentPage-1" />">上一页</a></span>&nbsp;
					<span><a href="merchants?pageNum=<s:property value="#request.merchantList.page.currentPage+1" />">下一页</a></span>
					<span>共 <s:property value="#request.merchantList.page.pageNumber" />页</span>
    		</div>
    		</div>
    	
	</body>
</html>
