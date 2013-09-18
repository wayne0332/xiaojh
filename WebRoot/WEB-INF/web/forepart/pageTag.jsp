<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ads" uri="fineTu/ads"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<base href="<%=basePath%>" />

<title>校江湖 - 活动</title>
<jsp:include page="merchantNews.jsp" />
<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />
</head>
<body>
	<div>
			<ul class="w300 fl mt20">
				<li class="w60 fr">共${page.pageNumber}页</li>
				<li class="w60 fr">当前第${page.currentPage}页</li>
				<li class="w60 fl"><a
					href="<%=path%>/${actionName}?condition=${condition}&currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}&club.id=${club.id}&merchant.id=${merchant.id}"
					target="_self">上一页</a>
				</li>
				<li class="w60 fl"><a
					href="<%=path%>/${actionName}?condition=${condition}&currentPage=${page.currentPage+1}&totalPageNumber=${page.pageNumber}&club.id=${club.id}&merchant.id=${merchant.id}"
					target="_self">下一页</a></li>
			</ul>
	</div>
</body>
</html>
