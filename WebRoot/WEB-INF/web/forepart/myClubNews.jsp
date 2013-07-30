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
     	<a href="<%=path %>/addClubNewsJsp">发表社团信息</a>
     	<s:property value="message"/><br/>
     	<s:iterator value="cns" id="cn">
     	<div style="display: inline-block; border:1px solid;width:80%;margin:20px; overflow:hidden;">
     			 标题：<s:property value="tittle"/><br>
     			 封面：<br>
			     <img src="${titleImgPath}" /><br>
			     ${text}<br>
			     ${videoUrl}<br>
				  来自：${cn.club.name}&nbsp;
		     	 ${datetime}&nbsp;
		   		 分享次数：${talking.shareDetails.shareCount}
		        &nbsp;<a href="<%=path %>/preShareTalking?talking.id=${talking.id}">分享</a>
		     	<span id="zan${talking.id}">
		     			<a href="javascript:void(0);" onclick="zanTalking(${talking.id});">赞(${talking.shareDetails.praiseCount})</a>
		     	</span>
		 		<s:if test="actionName.equals('adminFindOneClubNews')">
		     		<a href="<%=path%>/deleteClubNews?clubnews.id=${id}">删除</a> <a href="preModifyClubNews?clubnews.id=${id}">修改</a>
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
