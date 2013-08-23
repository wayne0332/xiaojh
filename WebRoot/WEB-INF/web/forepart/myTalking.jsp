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
     	
     	<a href="<%=path %>/addTalkingJsp">发表说说</a>
     	<a href="<%=path %>/myTalking">我的说说</a>
     	<a href="<%=path %>/relativeTalking">说说首页</a>
     	<s:property value="message"/><br/>
     	<!-- 删除说说导致说说页数与真实页数不一致 ，将当总页数减一，并跳转至上一页
     	<s:if test="pics.size()==0&&currentPage!=1">
     		<script>　 
				window.location = "<%=path%>/${actionName}?currentPage=${currentPage-1}&totalPageNumber=${totalPageNumber-1}";　 
			</script>
     	</s:if>-->
     	<s:iterator value="taks" id="tak">
     	<div style="display: inline-block; border:1px solid;width:80%;margin:20px;" id="${id}">
     			<s:if test="talking==null">
			     		<s:property value="text"/><br>
			     		 <s:if test="url!=null&&!url.trim().equals('')&&urlType.toString()=='PICTURE'">
			     			<img src="${url}" />
			     		 </s:if>
			     		 <!-- 说说 -->
			     		 <s:elseif test="url!=null&&!url.trim().equals('')&&urlType.toString()=='VIDEO'">
			     			${url}
					     </s:elseif>
				</s:if>
			     <s:elseif test="talking!=null">
			      	分享：<s:property value="text"/><br>
					<div style="background:#dddddd; border:1px; width:80%;margin:0 auto;">
						${talking.text}
						<s:if test="talking.url!=null&&talking.urlType.toString()=='PICTURE'">
			     			<img src="${talking.url}" width="200px" />
			     		</s:if>
			     		<!-- 说说 -->
			     		<s:elseif test="talking.url!=null&&talking.urlType.toString()=='VIDEO'">
			     			<s:property value="talking.url.replace('400', '260').replace('480', '280')" escape="false"/>
					    </s:elseif>
					    <br>来自：${talking.user.name}
				    </div>
			    </s:elseif>
		     <br>${datetime}
		     <s:if test="shareDetails!=null">
		     			&nbsp;分享次数：${shareDetails.shareCount}
		     </s:if>
		     <s:else>
		     			&nbsp;分享次数：${talking.shareDetails.shareCount}
		     </s:else>
		     <s:if test="actionName.equals('relativeTalking')">
		     	&nbsp;来自:${user.name}
		     	&nbsp;<a href="<%=path %>/preShareTalking?talking.id=${id}">分享</a>
		     	&nbsp;
		     	<span id="zan${id}">
		     	<s:if test="shareDetails!=null">
		     			<a href="javascript:void(0);" onclick="zanTalking(${id});">赞(${shareDetails.praiseCount})</a>
		     	</s:if>
		     	<s:else>
		     			<a href="javascript:void(0);" onclick="zanTalking(${id});">赞(${talking.shareDetails.praiseCount})</a>
		     	</s:else>
		     		
		     	</span>
		     	
		     </s:if>
		     <s:elseif test="actionName.equals('myTalking')">
		     	<a href="javascript:void(0);" onclick="deleteTalking(${id});">删除</a>
		     </s:elseif>
     	</div>
     	</s:iterator>
     	<br>
     	当前第${page.currentPage}页&nbsp;共${page.pageNumber}页
     	<a href="<%=path%>/${actionName}?currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}" target="_self">上一页</a>&nbsp; 
     	<a href="<%=path%>/${actionName}?currentPage=${page.currentPage+1}&totalPageNumber=${page.pageNumber}" target="_self">下一页</a>
     </div>
  </body>
</html>
