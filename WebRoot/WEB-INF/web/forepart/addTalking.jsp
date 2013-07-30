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
     	<s:property value="message"/><br/>
    
     	<form action="addTalking" method="post" enctype="multipart/form-data">
	     	说说内容：<textarea  name="talking.text" cols="20" rows="5"></textarea><br>
	     	媒体链接:<input type="text" name="talking.url"/><br>
	     	图片:<input type = "file" name="uploadImage"/><br>
			<br>
	     	<input type="submit" value="发表"/>
     	</form>
     </div>
  </body>
</html>
