<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>个人用户管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="社团帖子总览">
	<link rel="stylesheet" type="text/css" href="css/base-min.css" />
	<link rel="stylesheet" type="text/css" href="css/common.css" />
	<link rel="stylesheet" type="text/css" href="css/page-user.css" />
	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
	function denyUser(userId) {
  		$.post("denyUser?id="+userId,
  			function(xml){
  				var aLink = $("#"+userId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已封号");
  				}else{
  					alert("封号失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	</script>
  </head>
	<body>
		<div>社团帖子管理</div>
    	<table>
    		<tr>
    			<td>id号</td>
    			<td>头像</td>
    			<td>用户名</td>
    			<td>真实姓名</td>
    			<td>学校</td>
    			<td>邮箱</td>
    			<td>参加社团数</td>
    			<td>说说数</td>
    			<td>线上活动数</td>
    			<td>发私信</td>
    			<td>封帐号</td>
    		</tr>
    	<s:iterator value="#request.userList.userList" >
    		<tr>
    			<td><s:property value="id" /></td>
    			<td>
    			<s:if test="portraitPath==''">
					<img src="images/head/head1.jpg" class="fl logoImg" />
				</s:if>
				<s:else>
					<img src="<s:property value="portraitPath" />"  class="fl logoImg" />
				</s:else>
				</td>
    			<td><a href="userHome?user.id=<s:property value="id" />" ><s:property value="name" /></a></td>
    			<td><s:property value="realName" /></td>
    			<td><s:property value="school.name" /></td>
    			<td><s:property value="email" /></td>
    			<td><s:property value="joinClubs.size" /></td>
    			<td><s:property value="talkings.size" /></td>
    			<td><s:property value="onlineActivities.size" /></td>
    			<td><s:a href="personalLetterInput?targetUser.id=%{id}&targetUser.name=%{name}" >发私信</s:a></td>
    			<s:if test="%{status.name()=='DENIED'}" >
    				<td>解封(功能待添加)</td>
    			</s:if>
    			<s:else>
    				<td><input id="<s:property value="id" />" type="button" value="封帐号" onclick="javascript:if(confirm('确认删除 吗?')) denyUser(${id})" /></td>
    			</s:else>
    		</tr>
    	</s:iterator>
    		<tr>
    			<td colspan="7" >
    				<span><a href="allUser?pageNum=<s:property value="#request.userList.page.currentPage-1" />">上一页</a></span>&nbsp;
					<span><a href="allUser?pageNum=<s:property value="#request.userList.page.currentPage+1" />">下一页</a></span>
					<span>共 <s:property value="#request.userList.page.pageNumber" />页</span>
    			</td>
    		</tr>
    	</table>
	</body>
</html>
