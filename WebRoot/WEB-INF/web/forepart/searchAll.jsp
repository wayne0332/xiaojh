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

  </head>
	<body>
    	<div>
    		<div>
    			<div>"<s:property value="#request.searchText" />" 的搜索结果</div>
    			<table>
    				<tr>
    					<td colspan="5">找人：</td>
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
    					<td>
    						<s:a href="personalLetterInput?targetUser.id=%{id}&targetUser.name=%{name}" >发私信</s:a>
    					</td>
    				</tr>
    				</s:iterator>
    			</table>
    		</div>
    	</div>
    	<div>
    		<div>
    			<table>
    				<tr>
    					<td colspan="5">找社团：</td>
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
    				</tr>
    				</s:iterator>
    			</table>
    		</div>
    	</div>
    	<div>
    		<table>
    			<tr>
    				<td colspan="5">找商家：</td>
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
    			</tr>
    			</s:iterator>
    		</table>
    	</div>
	</body>
</html>
