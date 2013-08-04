<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="fineTu/ads" prefix="ads" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>广告内容管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<link rel=stylesheet type=text/css href="css/index_black.css"/>
	<script src="js/jquery.min.js"></script>
	<script src="js/index2.js"></script>
	
  </head>
  
<body>
    <div>
    	<form method="post" action="addContent" enctype="multipart/form-data"  >
    		描述：<input type="text" name="content.description" />
    		广告文件：<input type="file" name="uploadFile" />
    		广告链接：<input type="text" name="content.code" />
    		<input type="hidden" name="adsId" value="<s:property value="adsId" />" />
    		<input type="hidden" name="type" value="<s:property value="type" />" />
    		<input type="submit" value="添加广告内容" />
    	</form>
    </div>
    <div>
    <s:if test="%{type=='JS'}" >
    	<s:iterator value="contentList" >
    		<div>
	    		<span><s:property value="description" /></span>&nbsp;&nbsp;&nbsp;&nbsp;
	    		<span><a href="removeContent?contentId=<s:property value="id" />&type=<s:property value="type" />&adsId=<s:property value="adsId" />" >删除广告</a></span>
	    	</div>
    		<a href="<s:property value="code" />" ><img src="<s:property value="contentPath.substring(1)" />" title="<s:property value="description" />" width="980px" height="290px" /></a>
    	</s:iterator>
    </s:if>
    <s:else>
    	<s:iterator value="contentList" >
	    	<div>
	    		<span><s:property value="description" /></span>&nbsp;&nbsp;&nbsp;&nbsp;
	    		<span><a href="removeContent?contentId=<s:property value="id" />&type=<s:property value="type" />&adsId=<s:property value="adsId" />" >删除广告</a></span>
	    	</div>
	    	<div>
	    		<ads:adver adsId="${adsId}" contentId = "${id}" />
	    	</div>
	    </s:iterator>
    </s:else>
    
    </div>
</body>
</html>
