<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ads" uri="fineTu/ads" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'success.jsp' starting page</title>
    <link rel="stylesheet" type="text/css" href="css/base-min.css" />
   <link rel="stylesheet" type="text/css" href="css/common.css" />
   <script type="text/javascript" src="<%=path%>/js/ajax.js"></script>
   <style type="text/css">
		 .left {
			width: 720px;
			min-height: 500px;
			background: #DDDDDD;
			float: left;
			text-align: center;
		}
		
		 .right {
			width: 280px;
			text-align:center;
			min-height: 500px;
			background: #999999;
			float: right;
		}
	</style>
  </head>
  <body>
  <div class="container">
     <div class="left">
     	<!-- 提示信息 -->
     	<a href="<%=path %>/addActivityJsp">发表活动</a>
     	<a href="<%=path %>/${actionName}?condition=datetime&club.id=${club.id}&merchant.id=${merchant.id}">时间排序</a>
     	<a href="<%=path %>/${actionName}?condition=heat&club.id=${club.id}&merchant.id=${merchant.id}">热度排序</a>
     	<s:property value="message"/><br/>
     	<s:iterator value="acs" id="ac">
     	<div style="display: inline-block; border:1px solid;width:80%;margin:20px; overflow:hidden;">
     			 活动标题：<a href="activity?activity.id=${id}"><s:property value="tittle"/></a><br>
     			 活动 封面：<br>
			     <img src="${titleImgPath}" width="100px" height="100px"/><br>
			         活动预算资金：${budget}元<br>
	     		活动组织者：${organizer}<br>
	     		活动举办地点：${place}<br>
	     		参与人数：${participantCount}<br>
	     		活动状态：<s:property value="status.name"/><br>
	     		活动主办方：${club.name}${merchant.name}<br>
				 来自：${ac.club.name}${ac.merchant.name}&nbsp;
		     	 ${datetime}&nbsp;
		     	 活动热度：${heat}<br>
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
     	<a href="<%=path%>/${actionName}?condition=${condition}&currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}&club.id=${club.id}&merchant.id=${merchant.id}" target="_self">上一页</a>&nbsp; 
     	<a href="<%=path%>/${actionName}?condition=${condition}&currentPage=${page.currentPage+1}&totalPageNumber=${page.pageNumber}&club.id=${club.id}&merchant.id=${merchant.id}" target="_self">下一页</a>
     </div>
     <div class="right">
     	随机广告:
     	<ads:adver adsId="2" contentId="0"></ads:adver>
     </div>
  </div>
  </body>
</html>
