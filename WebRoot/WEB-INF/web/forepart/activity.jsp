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
     	活动标题：<s:property value="activity.tittle"/><br>
     			 活动 封面：<br>
			     <img src="${activity.titleImgPath}" /><br>
			     ${activity.text}<br>
			     ${activity.videoUrl}<br>
			         活动预算资金：${activity.budget}元<br>
	     		活动组织者：${activity.organizer}<br>
	     		活动举办地点：${activity.place}<br>
	     		参与人数：${activity.participantCount}<br>
	     		活动状态：<s:property value="activity.status.name"/><br>
	     		活动主办方：${activity.club.name}${activity.merchant.name}<br>
				  来自：${activity.club.name}${activity.merchant.name}&nbsp;
		     	 ${activity.datetime}&nbsp;
		   		 分享次数：${activity.talking.shareDetails.shareCount}
		        &nbsp;<a href="<%=path %>/preShareTalking?talking.id=${activity.talking.id}">分享</a>
		     	<span id="zan${activity.talking.id}">
		     			<a href="javascript:void(0);" onclick="zanTalking(${activity.talking.id});">赞(${activity.talking.shareDetails.praiseCount})</a>
		 </span>
     </div>
  </body>
</html>
