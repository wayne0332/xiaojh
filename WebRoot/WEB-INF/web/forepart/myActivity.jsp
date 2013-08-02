<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'success.jsp' starting page</title>
   <link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
   <script type="text/javascript" src="<%=path%>/js/ajax.js"></script>
  </head>
  <body>
     <div class="div">
     	<!-- 提示信息 -->
     	<a href="<%=path %>/addActivityJsp">发表活动</a>
     	<s:property value="message"/><br/>
     	<s:iterator value="acs" id="ac">
     	<div style="display: inline-block; border:1px solid;width:80%;margin:20px; overflow:hidden;">
     			 活动标题：<a href="activity?activity.id=${id}"><s:property value="tittle"/></a><br>
     			 活动 封面：<br>
			     <img src="${titleImgPath}" /><br>
			     ${text}<br>
			     ${videoUrl}<br>
			         活动预算资金：${budget}元<br>
	     		活动组织者：${organizer}<br>
	     		活动举办地点：${place}<br>
	     		参与人数：${participantCount}<br>
	     		活动状态：<s:property value="status.name"/><br>
	     		活动主办方：${club.name}${merchant.name}<br>
				  来自：${ac.club.name}${ac.merchant.name}&nbsp;
		     	 ${datetime}&nbsp;
		   		 分享次数：${talking.shareDetails.shareCount}
		        &nbsp;<a href="<%=path %>/preShareTalking?talking.id=${talking.id}">分享</a>
		     	<span id="zan${talking.id}">
		     			<a href="javascript:void(0);" onclick="zanTalking(${talking.id});">赞(${talking.shareDetails.praiseCount})</a>
		     	</span>
		 		<s:if test="actionName.equals('adminFindOneActivity')">
		     		<a href="<%=path%>/deleteActivity?activity.id=${id}">删除</a> <a href="preModifyActivity?activity.id=${id}">修改</a>
		    	</s:if> 
     	</div>
     	</s:iterator>
     	<br>
     	当前第${page.currentPage}页&nbsp;共${page.pageNumber}页
     	<a href="<%=path%>/${actionName}?currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}" target="_self">上一页</a>&nbsp; 
     	<a href="<%=path%>/${actionName}?currentPage=${page.currentPage+1}&totalPageNumber=${page.pageNumber}" target="_self">下一页</a>
     </div>
  </body>
</html>
