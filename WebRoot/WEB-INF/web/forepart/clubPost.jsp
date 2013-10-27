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

		<div class="main fl cf mt75">
			<div
				style="display: inline-block; border:1px solid;width:80%;margin:20px; overflow:hidden;">
				<s:if test="#request.clubPostContent.page.currentPage==1">
					<div>
						<s:property value="#request.clubPostContent.clubPost.tittle" />
						&nbsp;&nbsp;
						<s:property value="#request.clubPostContent.clubPost.user.name" />
						&nbsp;&nbsp;&nbsp;
						<s:date name="#request.clubPost.datetime" />
					</div>
					<div>
						${requestScope.clubPostContent.clubPost.text}
						<!-- <s:property value="#request.clubPostContent.clubPost.text" /> -->
					</div>
					<hr />
				</s:if>
				<div>
					<s:iterator value="#request.clubPostContent.commentList">
						<div>
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
						</div>
					</s:iterator>
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
				</div>
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
	</div>
</body>
</html>
