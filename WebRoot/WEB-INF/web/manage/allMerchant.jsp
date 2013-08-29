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
	<meta http-equiv="description" content="商家用户总览">
	<link rel="stylesheet" type="text/css" href="css/base-min.css" />
	<link rel="stylesheet" type="text/css" href="css/common.css" />
	<link rel="stylesheet" type="text/css" href="css/page-user.css" />
	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
	function denyMerchant(merchantId) {
  		$.post("denyMerchant?id="+merchantId,
  			function(xml){
  				var aLink = $("#"+merchantId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已封号");
  				}else{
  					alert("封号失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function checkMerchant(merchantId,isPass) {
  		$.post("checkMerchant?merchant.id="+merchantId+"&isPass="+isPass,
  			function(xml){
  				var td = document.getElementById("td_"+merchantId);
  				var span = document.getElementById("sp_"+merchantId);
  				if ($(xml).find("isSuccess").text()=="1"&&isPass==1) {
  					span.innerHTML="已通过审核";
  					td.innerHTML='<input id="<s:property value="id" />" type="button" value="封帐号" onclick="javascript:if(confirm(\'确认封杀此ID吗?\')) denyMerchant(${id})" />';
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
		<div>商家用户管理</div>
    	<table>
    		<tr>
    			<td>id号</td>
    			<td>头像</td>
    			<td>用户名</td>
    			<td>类型</td>
    			<td>地址</td>
    			<td>联系人</td>
    			<td>联系人电话</td>
    			<td>邮箱</td>
    			<td>线下活动数</td>
    			<td>状态</td>
    			<td>发私信</td>
    			<td>封帐号</td>
    		</tr>
    	<s:iterator value="#request.merchantList.merchantList" >
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
    			<td><a href="javascript:void()" ><s:property value="name" /></a></td>
    			<td><s:property value="type.getName()" /></td>
    			<td><s:property value="address" /></td>
    			<td><s:property value="connectorName" /></td>
    			<td><s:property value="connectorPhone" /></td>
    			<td><s:property value="connectorEmail" /></td>
    			<td><s:property value="activities.size()" /></td>
    			<td><span id="sp_<s:property value="id" />"><s:property value="status.getName()" /></span></td>
    			<td><s:a href="javascript:void()" >发私信</s:a></td>
    			<s:if test="%{status.name()=='DENIED'}" >
    				<td>解封(功能待添加)</td>
    			</s:if>
    			<s:elseif test="%{status.name()=='NO_CHECK'}">
    				<td id="td_<s:property value="id" />">
    					<input id="pass_<s:property value="id" />" type="button" value="通过审查" onclick="javascript:if(confirm('确认通过审查吗?')) checkMerchant(${id},1)" />
    					<input id="noPass_<s:property value="id" />" type="button" value="不通过" onclick="javascript:if(confirm('确认不通过审查吗?')) checkMerchant(${id},0)" />
    				</td>
    			</s:elseif >
    			<s:else>
    				<td><input id="<s:property value="id" />" type="button" value="封帐号" onclick="javascript:if(confirm('确认封杀此ID吗?')) denyMerchant(${id})" /></td>
    			</s:else>
    		</tr>
    		
    	</s:iterator>
    		<tr>
    			<td colspan="7" >
    				<span><a href="allMerchant?pageNum=<s:property value="#request.merchantList.page.currentPage-1" />">上一页</a></span>&nbsp;
					<span><a href="allMerchant?pageNum=<s:property value="#request.merchantList.page.currentPage+1" />">下一页</a></span>
					<span>共 <s:property value="#request.merchantList.page.pageNumber" />页</span>
    			</td>
    		</tr>
    	</table>
	</body>
</html>
