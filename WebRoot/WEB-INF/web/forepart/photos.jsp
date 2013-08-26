<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!-- <%@ taglib prefix="sd" uri="/struts-dojo-tags" %> -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'success.jsp' starting page</title>
   <link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
  </head>
  <body>
     <div class="div">
     	<!-- 提示信息 -->
     	<div>
     		<s:property value="message"/>
     		<a href="uploadPictureJsp" target="_self">上传照片</a>
     	</div>
     	<!-- 删除相片导致相册页数与真实页数不一致 ，将当总页数减一，并跳转至上一页-->
     	<s:if test="pics.size()==0&&currentPage!=1">
     		<script>　
     			alert("已经是最后一页"); 
				window.location = "<%=path%>/${actionName}?currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}";
			</script>
     	</s:if>
     	<s:iterator value="pics">
     	<span style="display: inline-block;">
     		<a href="<%=path%><s:property  value="path.replace('st_', '')" />" target="_blank"><img src="<%=path%>/${path}"></a>
     		<br>
     		${name}&nbsp;
     		<s:if test="actionName.equals('relativePicture')">
     			From:<a href="userHome?user.id=${user.id}">${user.name}</a>
     		</s:if>
     		<s:else>
	     		<a href="<%=path%>/deletePicture?picture.id=${id}">删除</a>
	     		<a href="<%=path%>/preUpdatePicture?picture.id=${id}">重命名</a>
     		</s:else>
     	</span>
     	</s:iterator>
     	
     	<br>
     	当当前第${page.currentPage}页&nbsp;共${page.pageNumber}页
     	<a href="<%=path%>/${actionName}?currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}" target="_self">上一页</a>&nbsp; 
     	<a href="<%=path%>/${actionName}?currentPage=${page.currentPage+1}&totalPageNumber=${page.pageNumber}" target="_self">下一页</a>
     </div>
  </body>
</html>
