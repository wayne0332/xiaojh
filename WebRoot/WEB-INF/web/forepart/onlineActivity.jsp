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
     	<a href="<%=path %>/addOnlineActivityJsp">发表线上活动</a>
     	<h2>在线活动显示页</h2>
     	<s:property value="message"/><br/>
     	<div style="display: inline-block; border:1px solid;width:80%;margin:20px; overflow:hidden;">
     			 活动标题：<a href="getOnlineActivityById?onlineactivity=${onlineactivity.id}"><s:property value="tittle"/></a><br>
     			 活动 封面：<br>
			     <img src="${onlineactivity.titleImgPath}" /><br>
			     ${onlineactivity.text}<br>
			     ${onlineactivity.videoUrl}<br>
	     		参与人数：${onlineactivity.participantCount}<br>
	     		活动状态：<s:property value="onlineactivity.status.name"/><br>
				 来自：${onlineactivity.user.name}&nbsp;
		     	 ${onlineactivity.datetime}&nbsp;
		   		 分享次数：${onlineactivity.talking.shareDetails.shareCount}
		        &nbsp;<a href="<%=path %>/preShareTalking?talking.id=${onlineactivity.talking.id}">分享</a>
		     	<span id="zan${onlineactivity.talking.id}">
		     			<a href="javascript:void(0);" onclick="zanTalking(${onlineactivity.talking.id});">赞(${onlineactivity.talking.shareDetails.praiseCount})</a>
		     	</span>
		 		<s:if test="actionName.equals('adminFindOneActivity')">
		     		<a href="<%=path%>/deleteActivity?activity.id=${onlineactivity.id}">删除</a> <a href="preModifyActivity?activity.id=${onlineactivity.id}">修改</a>
		    	</s:if> 
     	</div>
     	<div>
     		<a href="activityPostList?activityId=<s:property value="onlineactivity.id" />&pageNum=1" >进入活动论坛</a>
     	</div>
     	<br>
     	
     </div>
  </body>
</html>
