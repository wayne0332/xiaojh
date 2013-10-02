<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>


<!DOCTYPE html>
<html>
<head>

<title>校江湖 </title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

</head>

<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		<div class="mt75">
			<!-- <a href="initSearch">写私信</a> -->
			<form action="searchAll" method="post" class="mt75">
			<input name="searchText" type="text" /> <input type="submit"
				value="找个小伙伴发信息" />
				<a href="myFocus?type=0&pageNum=1">给小伙伴发信息</a>
		</form>
			<table>
				<tr>
					<td>序号</td>
					<td>标题</td>
					<td>头像</td>
					<td>时间</td>
					<td>发布人姓名</td>
					<td>内容</td>
					<td>状态</td>
					<td>操作</td>
				</tr>
				<s:iterator value="#request.receivedLetters" status="status">
					<tr>
						<td><s:property
								value="(page.currentPage - 1) * page.eachPageNumber + #status.count" />
						</td>
						<td><s:a href="personalLetter?letter.id=%{id}">
								<s:property value="title" />
							</s:a>
						</td>
						<td><img alt="头像" title="头像"
							src="<s:property value="userBySourceUserId.portraitPath"/>" />
						</td>
						<td><s:date name="datetime" format="yyyy-MM-dd" /> <br /> <s:date
								name="datetime" format="HH:mm:ss" />
						</td>
						<td><s:property value="userBySourceUserId.name" />
						</td>
						<td><s:property value="text" />
						</td>
						<td><s:property value="status.name" />
						</td>
						<td><s:a href="deleteLetter?letter.id=%{id}">
						删除
					</s:a> <s:a
								href="personalLetterInput?targetUser.id=%{userBySourceUserId.id}&targetUser.name=%{userBySourceUserId.name}">回复</s:a>
						</td>
					</tr>
				</s:iterator>
			</table>
			<wst:page url="receivedLetters" />
		</div>
	</div>
</body>
</html>
