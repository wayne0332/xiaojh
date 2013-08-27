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
    					<td >
    					<!-- 如果从club页面进入，有club操作   -->
    					<s:if test="#request.clubMember != null">
    						<s:if test="#request.clubMember.role.name() == 'NORMAL'">
								无
							</s:if> <s:else>
								<s:if test="#request.clubMembers[id] == null">
									<s:a
										href="clubAddUser?user.id=%{id}&text=%{#request.searchText}&club.id=%{club.id}&pageNum=%{searchResult.page.currentPage}">添加</s:a>
								</s:if>
								<s:elseif test="#request.clubMembers[id].role.name() == 'NORMAL'">
									<s:if test="#request.clubMembers[id].status.name() == 'NO_CHECK'">
										<s:if
											test="#request.clubMembers[id].source.name() == 'CLUB_TO_USER'">
											已发出邀请
										</s:if>
										<s:else>
											<s:a href="clubAcceptInvited?user.id=%{id}&text=%{#request.searchText}&club.id=%{club.id}&pageNum=%{searchResult.page.currentPage}">接受申请</s:a>
											<s:a href="clubRefuseInvited?user.id=%{id}&text=%{#request.searchText}&club.id=%{club.id}&pageNum=%{searchResult.page.currentPage}">拒绝</s:a>
										</s:else>
									</s:if>
									<s:else>
										<s:if test="#request.clubMember.role.name() == 'PROPRIETER'">
											<s:a
												href="updateMemberToManager?user.id=%{id}&club.id=%{club.id}">变为管理员</s:a>
										</s:if>
										<s:a href="fireClubMember?user.id=%{id}&club.id=%{club.id}">开除</s:a>
									</s:else>
								</s:elseif>
								<s:else>
									<s:if test="#request.clubMember.role.name() != 'PROPRIETER'">
										无
									</s:if>
									<s:else>
										<s:if
											test="#request.clubMembers[id].role.name() == 'PROPRIETER'">
											<a href="changeProprieterInput?club.id=${club.id }">换社长</a>
										</s:if>
										<s:else>
											<s:a
												href="updateMemberToNormal?user.id=%{id}&club.id=%{club.id}">取消管理权限</s:a>
											<s:a href="fireClubMember?user.id=%{id}&club.id=%{club.id}">开除</s:a>
										</s:else>
									</s:else>
								</s:else>
							</s:else>
    					</s:if>
    					<!-- 否则，从其他入口进入，无club操作 -->
    					<s:elseif test="%{#session.user.id!=id}">
    						<s:if test="%{#request.userMap[id]==null}">
	    						<input id="<s:property value="id" />" type="button" value="关注" onclick="focusUser(<s:property value="id" />)"/>
	    					</s:if>
	    					<s:else>
	    						<input id="<s:property value="id" />" type="button" disabled="disabled" value="已关注"/>
	    					</s:else>
    					</s:elseif>
    					</td>
    					<td>
    					<s:if test="%{#session.user.id!=id}">
    						<s:a href="personalLetterInput?targetUser.id=%{id}&targetUser.name=%{name}" >发私信</s:a>
    					</s:if>
    					</td>
    				</tr>
    				</s:iterator>
    			</table>
				<div id="pageController">
					<span><a href="searchUser?searchText=<s:property value="#request.searchText" />&pageNum=<s:property value="searchResult.page.currentPage-1" />&club.id=<s:property value="club.id"/>">上一页</a></span>&nbsp;
					<span><a href="searchUser?searchText=<s:property value="#request.searchText" />&pageNum=<s:property value="searchResult.page.currentPage+1" />&club.id=<s:property value="club.id"/>">下一页</a></span>
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
    						<!-- 若入口为社团页，且role不是普通社员，则显示社团操作 -->
	    					<s:if test="%{#request.clubMember != null&&club.id != id&&#request.clubMember.role.name()!='NORMAL'}">
	    						<s:if test="id in #request.clubCheckList">
	    							<input id="c_<s:property value="id" />" type="button" disabled="disabled" value="社团已关注"/>
	    						</s:if>
	    						<s:else>
	    							<input id="c_<s:property value="id" />" type="button" value="社团关注" onclick="clubFocusClub(<s:property value="club.id" />,<s:property value="id" />)"/>
	    						</s:else>
	    					</s:if>
	    					<!-- 否则非社团入口，用户操作 -->
	    					<s:else>
	    						<s:if test="%{id in #request.checkList}">
		    						<input id="u_<s:property value="id" />" type="button" disabled="disabled" value="已关注"/>
		    					</s:if>
		    					<s:else>
		    						<input id="u_<s:property value="id" />" type="button" value="关注" onclick="focusClub(<s:property value="id" />)"/>
		    					</s:else>
	    					</s:else>
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
					<span><a href="searchClub?searchText=<s:property value="#request.searchText" />&pageNum=<s:property value="searchResult.page.currentPage-1" />&club.id=<s:property value="club.id"/>">上一页</a></span>&nbsp;
					<span><a href="searchClub?searchText=<s:property value="#request.searchText" />&pageNum=<s:property value="searchResult.page.currentPage+1" />&club.id=<s:property value="club.id"/>">下一页</a></span>
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
    					
	    				<s:if test="%{#request.clubMember!=null&&#request.clubMember.role.name()!='NORMAL'}">
	    					<s:if test="id in #request.clubCheckList">
	    						<input id="c_<s:property value="id" />" type="button" disabled="disabled" value="社团已关注"/>
	    					</s:if>
	    					<s:else>
	    						<input id="c_<s:property value="id" />" type="button" value="社团关注" onclick="clubFocusMerchant(<s:property value="club.id" />,<s:property value="id" />)"/>
	    					</s:else>
	    				</s:if>
	    				<s:else>
	    					<s:if test="%{id in #request.checkList}">
		    					<input id="u_<s:property value="id" />" type="button" disabled="disabled" value="已关注"/>
		    				</s:if>
		    				<s:else>
		    					<input id="u_<s:property value="id" />" type="button" value="关注" onclick="focusMerchant(<s:property value="id" />)"/>
		    				</s:else>
	    				</s:else>
    				</s:if>
    				<s:elseif test="%{#session.merchant!=null&&#session.merchant.id!=id}">
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
				<span><a href="searchMerchant?searchText=<s:property value="#request.searchText" />&pageNum=<s:property value="searchResult.page.currentPage-1" />&club.id=<s:property value="club.id"/>">上一页</a></span>&nbsp;
				<span><a href="searchMerchant?searchText=<s:property value="#request.searchText" />&pageNum=<s:property value="searchResult.page.currentPage+1" />&club.id=<s:property value="club.id"/>">下一页</a></span>
				<span>共 <s:property value="searchResult.page.pageNumber" />页</span>
			</div>
			</s:elseif>
		</div>
	</body>
</html>
