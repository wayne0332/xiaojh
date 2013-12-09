<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="/webSupportTag" prefix="w"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<title>校江湖 - 社团</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-club.css" />

</head>

<body>
	<div class="container">
		<jsp:include page="head.jsp" />

		<div class="main w730 cf mt75">
			<div class="clearfix">
				<h2 class="h2_title">
					<s:property value="#request.clubPostContent.clubPost.tittle" />
				</h2>
			</div>
			<ul class="tiezi_ul">
				<s:iterator value="#request.clubPostContent.commentList">
					<li>
						<div>
							<s:property value="user.name" />
							&nbsp;&nbsp;&nbsp;
							<s:date name="datetime" />
							&nbsp;&nbsp;&nbsp;
							<s:if
								test="%{#session.user.id==#request.clubPostContent.clubPost.user.id}">
								<a
									href="deleteComment?comment.id=<s:property value="id" />&postId=<s:property value="#request.clubPostContent.clubPost.id" />&pageNum=<s:property value="#request.clubPostContent.page.currentPage-1" />">删除</a>
							</s:if>
						</div>
						<div>
							<s:property value="text" />
						</div>
					</li>
				</s:iterator>
			</ul>
			<div>
				<s:if test="#session.user==null">
					<div>评论请登录！</div>
				</s:if>
				<s:else>
					<div>
						<form
							action="addComment?postId=<s:property value="#request.clubPostContent.clubPost.id" />"
							method="post">
							<input type="text" name="comment.text" /> <input type="submit"
								value="回帖" />
						</form>
					</div>
				</s:else>
			</div>
			<div>
				<w:page
					url="clubPostContent?postId=%{#request.clubPostContent.clubPost.id}"
					useSingleProperty="false" pageNumberPropertyName="pageNum"
					value="#request.clubPostContent.page" />
				<%-- <span><a href="clubPostContent?postId=<s:property value="#request.clubPostContent.clubPost.id" />&pageNum=<s:property value="#request.clubPostContent.page.currentPage-1" />">上一页</a></span>&nbsp;
			<span><a href="clubPostContent?postId=<s:property value="#request.clubPostContent.clubPost.id" />&pageNum=<s:property value="#request.clubPostContent.page.currentPage+1" />">下一页</a></span>
			<span>共 <s:property value="#request.clubPostContent.page.pageNumber" />页</span> --%>
			</div>
		</div>
		

		<div class="left_bar fr cf mt75">
			<div class="my_info w240 h90 p5 m5 shadow_l_10 bg_box">
				<img src="images/head/head1.jpg"
					class="fl mt5 ml10 circle_80 shadow_l_5" />
				<ul class="fl w135 p5 pl10 text_r">
					<li class="w135 text_l f14"><a href="updateUserInput"><s:property
								value="#session.user.name" /> </a>
					</li>
					<li><s:property value="#session.user.grade" /></li>

					<li><s:property value="#session.user.grade % 2000" />级</li>
					<li><s:property
							value="#application.schools[#session.user.school.id].name" />
					</li>
					<!-- <li>凤凰社</li> -->
				</ul>
			</div>
		</div>
	</div>
</body>
</html>
