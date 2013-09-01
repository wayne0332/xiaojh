<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'searchAll.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
	function focusUser(userId) {
  		$.post("focusUser?id="+userId,
  			function(xml){
  				var aLink = $("#"+userId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function focusClub(clubId) {
  		$.post("focusClub?id="+clubId,
  			function(xml){
  				var aLink = $("#uc_"+clubId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function focusMerchant(merchantId) {
  		$.post("focusMerchant?id="+merchantId,
  			function(xml){
  				var aLink = $("#um_"+merchantId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function clubFocusClub(sourceId,clubId) {
  		$.post("clubFocusClub?id="+clubId+"&club.id="+sourceId,
  			function(xml){
  				var aLink = $("#c_"+clubId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("社团已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function clubFocusMerchant(sourceId,merchantId) {
  		$.post("clubFocusMerchant?id="+merchantId+"&club.id="+sourceId,
  			function(xml){
  				var aLink = $("#c_"+merchantId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("社团已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function merchantFocusClub(clubId) {
  		$.post("merchantFocusClub?id="+clubId,
  			function(xml){
  				var aLink = $("#mc_"+clubId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function merchantFocusMerchant(merchantId) {
  		$.post("merchantFocusMerchant?id="+merchantId,
  			function(xml){
  				var aLink = $("#mm_"+merchantId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	</script>
  </head>
	<body>
    	<div>
    		<div>
    			<div>"<s:property value="#request.searchText" />" 的搜索结果</div>
    			<table>
    				<tr>
    					<td colspan="8">找人：</td>
    					<td><a href="searchUser?searchText=<s:property value="#request.searchText" />&pageNum=1&club.id=<s:property value="club.id" />">更多结果</a></td>
    				</tr>
    				<s:iterator value="#request.searchResult.userList">
    				<tr>	
    					<td>
    						<s:property value="name" />
    					</td>
    					<td>
    						<s:property value="sex" />
    					</td>
    					<td>
    						<s:property value="school.name" />
    					</td>
    					<td>
    						<s:property value="profession" />
    					</td>
    					<td>
    						<s:property value="grade" />
    					</td>
    					<td>
    						<s:property value="signature" />
    					</td>
    					<s:if test="%{#session.user.id!=id}">
    					<td>
    						
    							<s:if test="%{#request.userMap[id]==null}">
		    						<input id="<s:property value="id" />" type="button" value="关注" onclick="focusUser(<s:property value="id" />)"/>
		    					</s:if>
		    					<s:else>
		    						<input id="<s:property value="id" />" type="button" disabled="disabled" value="已关注"/>
		    					</s:else>
    					</td>
    					<td>
    						<s:a href="personalLetterInput?targetUser.id=%{id}&targetUser.name=%{name}" >发私信</s:a>
    					</td>
    					</s:if>
    				</tr>
    				</s:iterator>
    			</table>
    		</div>
    	</div>
    	<div>
    		<div>
    			<table>
    				<tr>
    					<td colspan="7">找社团：</td>
    					<td><a href="searchClub?searchText=<s:property value="searchText" />&pageNum=1&club.id=<s:property value="club.id" />">更多结果</a></td>
    				</tr>
    				<s:iterator value="#request.searchResult.clubList" >
    				<tr>	
    					<td>
    						<s:a href="clubMain?club.id=%{id}"><s:property value="name" /></s:a>
    					</td>
    					<td>
    						<s:property value="school.name" />
    					</td>
    					<td>
    						<s:property value="type" />
    					</td>
    					<td>
    						<s:property value="briefIntroduction" />
    					</td>
    					<td>
    						<s:property value="user.name" />
    					</td>
    					<td>
    						<s:property value="memberNumber" />
    					</td>
    					<td>
    					<s:if test="%{#session.user!=null}" >
    						<s:if test="%{id in #request.checkListC}">
		    					<input id="uc_<s:property value="id" />" type="button" disabled="disabled" value="已关注"/>
		    				</s:if>
		    				<s:else>
		    					<input id="uc_<s:property value="id" />" type="button" value="关注" onclick="focusClub(<s:property value="id" />)"/>
		    				</s:else>
    					</s:if>	
		    			<s:elseif test="%{#session.merchant!=null}">
	    					<s:if test="%{id in #request.checkListC}">
		    					<input id="mc_<s:property value="id" />" type="button" disabled="disabled" value="已关注"/>
		    				</s:if>
		    				<s:else>
		    					<input id="mc_<s:property value="id" />" type="button" value="关注" onclick="merchantFocusClub(<s:property value="id" />)"/>
		    				</s:else>
    					</s:elseif>
    					</td>
    				</tr>
    				</s:iterator>
    			</table>
    		</div>
    	</div>
    	<div>
    		<table>
    			<tr>
    				<td colspan="7">找商家：</td>
    				<td>
    					<a href="searchMerchant?searchText=<s:property value="searchText" />&pageNum=1">更多结果</a>
    				</td>
    			</tr>
    			<s:iterator value="#request.searchResult.merchantList" >
    			<tr>	
    				<td>
    					<s:property value="name" />
    				</td>
    				<td>
    					<s:property value="type" />
    				</td>
    				<td>
    					<s:property value="business" />
    				</td>
    				<td>
    					<s:property value="connectorName" />
    				</td>
    				<td>
    					<s:property value="connectorPhone" />
    				</td>
    				<td>
    					<s:property value="popularity" />
    				</td>
    				<td>
    				<s:if test="%{#session.user!=null}" >	    				
	    				<s:if test="%{id in #request.checkListM}">
		    				<input id="um_<s:property value="id" />" type="button" disabled="disabled" value="已关注"/>
		    			</s:if>
		    			<s:else>
		    				<input id="um_<s:property value="id" />" type="button" value="关注" onclick="focusMerchant(<s:property value="id" />)"/>
		    			</s:else>
    				</s:if>
    				<s:elseif test="%{#session.merchant!=null}">
    					<s:if test="%{id in #request.checkListM}">
	    					<input id="mm_<s:property value="id" />" type="button" disabled="disabled" value="已关注"/>
	    				</s:if>
	    				<s:else>
	    					<input id="mm_<s:property value="id" />" type="button" value="关注" onclick="merchantFocusMerchant(<s:property value="id" />)"/>
	    				</s:else>
    				</s:elseif>
    				</td>
    			</tr>
    			</s:iterator>
    		</table>
    	</div>
	</body>
</html>
