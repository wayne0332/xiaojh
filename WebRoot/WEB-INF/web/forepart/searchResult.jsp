<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib prefix="wst" uri="/webSupportTag"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'searchResult.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
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
  				var aLink = $("#u_"+clubId);
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
  				var aLink = $("#u_"+merchantId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function clubFocusClub(clubId) {
  		$.post("clubFocusClub?id="+clubId,
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
	function clubFocusMerchant(merchantId) {
  		$.post("clubFocusMerchant?id="+merchantId,
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
  				var aLink = $("#m_"+clubId);
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
  				var aLink = $("#m_"+merchantId);
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
			<s:property value="#request.type" />
			<s:if test="%{#request.type==0}">
				<table>
    				<tr>
    					<td colspan="8">找人：</td>
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
    				</tr>
    				</s:iterator>
    			</table>
				<div id="pageController">
					<span><a href="searchUser?searchText=<s:property value="#request.searchText" />&pageNum=<s:property value="searchResult.page.currentPage-1" />">上一页</a></span>&nbsp;
					<span><a href="searchUser?searchText=<s:property value="#request.searchText" />&pageNum=<s:property value="searchResult.page.currentPage+1" />">下一页</a></span>
					<span>共 <s:property value="searchResult.page.pageNumber" />页</span>
					<%-- <s:if test="#request.searchResult.userList.size() != 0">
						<s:if test="%{#request.searchResult.page.currentPage != 1}">
							<span class="prev"> <a onclick="">首页</a> </span>
							<span class="prev"> <a
								onclick="submitForm(<s:property value="page.currentPage - 1"/>);">
									&lt;前页</a> </span>
						</s:if>
						<span>当前第<s:property value="page.currentPage" />页</span>
						<s:if test="%{page.currentPage != page.totalPageNum}">
							<span class="next"> <a
								onclick="submitForm(<s:property value="page.currentPage + 1"/>);">后页&gt;</a>
							</span>
							<span class="next"> <a
								onclick="submitForm(<s:property value="page.totalPageNum"/>);">尾页</a>
							</span>
						</s:if>
						<span>共<s:property value="page.pageNumber" />页</span>
					</s:if> --%>
				</div>
			</s:if>
			<s:elseif test="%{#request.type==1}">
				<table>
    				<tr>
    					<td colspan="7">找社团：</td>
    				</tr>
    				<s:iterator value="#request.searchResult.clubList" >
    				<tr>	
    					<td>
    						<s:property value="name" />
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
    						<s:property value="%{id in #request.checkList}" />
    					</td>
    					<td>
    					<s:if test="%{#session.user!=null}" >
	    					<s:if test="%{id in #request.checkList}">
	    						<input id="u_<s:property value="id" />" type="button" disabled="disabled" value="已关注"/>
	    					</s:if>
	    					<s:else>
	    						<input id="u_<s:property value="id" />" type="button" value="关注" onclick="focusClub(<s:property value="id" />)"/>
	    					</s:else>
	    					<s:if test="%{#session.clubMember!=null&&#session.clubMember.role.name()!='NORMAL'}">
	    						<s:if test="id in #request.clubCheckList">
	    							<input id="c_<s:property value="id" />" type="button" disabled="disabled" value="社团已关注"/>
	    						</s:if>
	    						<s:else>
	    							<input id="c_<s:property value="id" />" type="button" value="社团关注" onclick="clubFocusClub(<s:property value="id" />)"/>
	    						</s:else>
	    					</s:if>
    					</s:if>
    					<s:elseif test="%{#session.merchant!=null}">
    						<s:if test="%{id in #request.checkList}">
	    						<input id="m_<s:property value="id" />" type="button" disabled="disabled" value="已关注"/>
	    					</s:if>
	    					<s:else>
	    						<input id="m_<s:property value="id" />" type="button" value="关注" onclick="merchantFocusClub(<s:property value="id" />)"/>
	    					</s:else>
    					</s:elseif>
    					</td>
    				</tr>
    				</s:iterator>
    			</table>
    			<div>
					<span><a href="searchClub?searchText=<s:property value="#request.searchText" />&pageNum=<s:property value="searchResult.page.currentPage-1" />">上一页</a></span>&nbsp;
					<span><a href="searchClub?searchText=<s:property value="#request.searchText" />&pageNum=<s:property value="searchResult.page.currentPage+1" />">下一页</a></span>
					<span>共 <s:property value="searchResult.page.pageNumber" />页</span>
				</div>
			</s:elseif>
			<s:elseif test="%{#request.type==2}">
				<table>
    			<tr>
    				<td colspan="7">找商家：</td>
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
    					<s:if test="%{id in #request.checkList}">
	    					<input id="u_<s:property value="id" />" type="button" disabled="disabled" value="已关注"/>
	    				</s:if>
	    				<s:else>
	    					<input id="u_<s:property value="id" />" type="button" value="关注" onclick="focusMerchant(<s:property value="id" />)"/>
	    				</s:else>
	    				<s:if test="%{#session.clubMember!=null&&#session.clubMember.role.name()!='NORMAL'}">
	    					<s:if test="id in #request.clubCheckList">
	    						<input id="c_<s:property value="id" />" type="button" disabled="disabled" value="社团已关注"/>
	    					</s:if>
	    					<s:else>
	    						<input id="c_<s:property value="id" />" type="button" value="社团关注" onclick="clubFocusMerchant(<s:property value="id" />)"/>
	    					</s:else>
	    				</s:if>
    				</s:if>
    				<s:elseif test="%{#session.merchant!=null}">
    					<s:if test="%{id in #request.checkList}">
	    					<input id="m_<s:property value="id" />" type="button" disabled="disabled" value="已关注"/>
	    				</s:if>
	    				<s:else>
	    					<input id="m_<s:property value="id" />" type="button" value="关注" onclick="merchantFocusMerchant(<s:property value="id" />)"/>
	    				</s:else>
    				</s:elseif>
    				</td>
    			</tr>
    			</s:iterator>
    		</table>
    		<div>
				<span><a href="searchMerchant?searchText=<s:property value="#request.searchText" />&pageNum=<s:property value="searchResult.page.currentPage-1" />">上一页</a></span>&nbsp;
				<span><a href="searchMerchant?searchText=<s:property value="#request.searchText" />&pageNum=<s:property value="searchResult.page.currentPage+1" />">下一页</a></span>
				<span>共 <s:property value="searchResult.page.pageNumber" />页</span>
			</div>
			</s:elseif>
		</div>
	</body>
</html>
