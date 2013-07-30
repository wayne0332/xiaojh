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
    <title>上传图片</title>
    <link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
  </head>
  <body>
  <div class="div">
   	<div>
  	 	<!-- 提示信息 -->
     	<s:property value="message"/>
     	<a href="findAllPicture" target="_self">查看相册</a>
    </div>
  	<form action="addPicture" method= "post" enctype="multipart/form-data">
 		图片:<input type = "file" name="uploadImage"/>
 		<input type="submit" value="提交"/>
 	</form>
  </div>
  </body>
</html>
