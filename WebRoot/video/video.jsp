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
<title>ckplayer</title>
</head>

<body>


 <embed src="<%=basePath %>/video/ckplayer/ckplayer.swf?p=0&c=1&i=<%=basePath %>/video/ckplayer/xiaojh.png" flashvars="f=<%=basePath %>/video/ckplayer/mandy.flv" quality="high" width="480" height="400" align="middle" allowScriptAccess="always" allowFullscreen="true" type="application/x-shockwave-flash"></embed>
</body>
</html>
