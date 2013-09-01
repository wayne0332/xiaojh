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
    
     	<form action="shareTalking" method="post">
     	<!-- 尚未被分享过的原始说说 -->
     	<s:if test="origntalking.talking==null">
     		<input type="hidden" name="talkingid" value="${origntalking.id}"/>
	     	说说内容：<textarea  name="talking.text" cols="20" rows="5">@${origntalking.user.name}:${message}</textarea><br/>
			<br>
			原始说说：
			<div style="background:#dddddd; border:1px; width:80%;margin:0 auto;">
				${origntalking.text}<br>
				<s:if test="origntalking.url!=null&&origntalking.urlType.toString()=='PICTURE'">
	     			<img src="${origntalking.url}" />
	     		</s:if>
	     		<!-- 说说 -->
	     		<s:elseif test="origntalking.url!=null&&origntalking.urlType.toString()=='VIDEO'">
	     			${origntalking.url}
			    </s:elseif>
		    </div>
		</s:if>
		<!-- 该说说引用别的说说 -->
		<s:else>
			<input type="hidden" name="talkingid" value="${origntalking.talking.id}"/>
			说说内容：<textarea  name="talking.text" cols="20" rows="5">#@${origntalking.user.name}:${origntalking.text}#</textarea><br>
			<br>
			原始说说：
			<div style="background:#dddddd; border:1px; width:80%;margin:0 auto;">
				<s:if test="origntalking.talking.turl!=null&&origntalking.talking.urlType.toString()=='PICTURE'">
	     			<img src="${origntalking.takling.url}" />
	     		</s:if>
	     		<!-- 说说 -->
	     		<s:elseif test="origntalking.talking.url!=null&&origntalking.talking.urlType.toString()=='VIDEO'">
	     			${origntalking.talking.url}
			    </s:elseif>
		    </div>
		</s:else>
		<input type="submit" value="分享"/>
     	</form>
     </div>
  </body>
</html>
