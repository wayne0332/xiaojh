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
  </head>
  <body>
     <div class="div">
     	<!-- 提示信息 -->
     	<div>
     		<s:property value="message"/>
     		<a href="uploadPictureJsp" target="_self">上传照片</a>
     	</div>
     	<img src="<%=path%>/${picture.path}"><br/>
     	原名称：${picture.name}<br/>
     	上传日期：${picture.datetime}
     	<form action="updatePicture?picture.id=${picture.id}" method="post">
     	<input type="text" name="picture.name"/>
     	<input type="submit" value="修改"/>
     	</form>
     </div>
  </body>
</html>
