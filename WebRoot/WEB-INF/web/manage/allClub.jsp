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
    
    <title>社团管理</title>
    
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
	function denyClub(clubId) {
  		$.post("denyClub?id="+clubId,
  			function(xml){
  				var aLink = $("#"+clubId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已封号");
  				}else{
  					alert("封号失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function checkClub(clubId,isPass) {
  		$.post("checkClub?club.id="+clubId+"&isPass="+isPass,
  			function(xml){
  				var td = document.getElementById("td_"+clubId);
  				var span = document.getElementById("sp_"+clubId);
  				if ($(xml).find("isSuccess").text()=="1"&&isPass==1) {
  					span.innerHTML="已通过审核";
  					td.innerHTML='<input id="<s:property value="id" />" type="button" value="封社团" onclick="javascript:if(confirm(\'确认封杀此社团吗?\')) denyClub(${id})" />';
  				}else if($(xml).find("isSuccess").text()=="1"&&isPass==0){
  					span.innerHTML="未通过审核";
  					td.innerHTML="<span>无操作</span>";
  				}else{
  					alert("审核失败，请稍后再试。");
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
    			<td>社团名</td>
    			<td>创建人</td>
    			<td>学校</td>
    			<td>社团人数</td>
    			<td>当前状态</td>
    			<td>社团操作</td>
    			
    		</tr>
    	<s:iterator value="#request.clubList.clubList" >
    		<tr>
    			<td><s:property value="id" /></td>
    			<td>
    			<s:if test="logoPath==''">
					<img src="images/head/head1.jpg" class="fl logoImg" />
				</s:if>
				<s:else>
					<img src="<s:property value="logoPath" />"  class="fl logoImg" />
				</s:else>
				</td>
    			<td><a href="clubMain?club.id=%{id}" ><s:property value="name" /></a></td>
    			<td><s:property value="proprieter。name" /></td>
    			<td><s:property value="school.name" /></td>
    			<td><s:property value="memberNumber" /></td>
    			<td><span id="sp_<s:property value="id" />"><s:property value="status.getName()" /></span></td>
    			<s:if test="%{status.name()=='DENIED'}" >
    				<td>解封(功能待添加)</td>
    			</s:if>
    			<s:elseif test="%{status.name()=='NO_CHECK'}">
    				<td id="td_<s:property value="id" />">
    					<input id="pass_<s:property value="id" />" type="button" value="通过审查" onclick="javascript:if(confirm('确认通过审查吗?')) checkClub(${id},1)" />
    					<input id="noPass_<s:property value="id" />" type="button" value="不通过" onclick="javascript:if(confirm('确认不通过审查吗?')) checkClub(${id},0)" />
    				</td>
    			</s:elseif >
    			<s:else>
    				<td id="td_<s:property value="id" />"><input id="<s:property value="id" />" type="button" value="封社团" onclick="javascript:if(confirm('确认封杀此社团吗?')) denyClub(${id})" /></td>
    			</s:else>
    		</tr>
    	</s:iterator>
    		<tr>
    			<td colspan="7" >
    				<span><a href="clubFocus?type=1&pageNum=<s:property value="#request.clubList.page.currentPage-1" />">上一页</a></span>&nbsp;
					<span><a href="clubFocus?type=1&pageNum=<s:property value="#request.clubList.page.currentPage+1" />">下一页</a></span>
					<span>共 <s:property value="#request.clubList.page.pageNumber" />页</span>
    			</td>
    		</tr>
    	</table>
	</body>
</html>
