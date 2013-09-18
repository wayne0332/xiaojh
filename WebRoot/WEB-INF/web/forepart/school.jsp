<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>校江湖 - 社团</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
<style type="text/css">
.main .left {
	width: 200px;
	min-height: 500px;
	background: #DDDDDD;
	float: left;
}

.main .right {
	width: 780px;
	min-height: 500px;
	background: #999999;
	float: right;
}
</style>
</head>

<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		<div class="left_bar mt75">
			<div class="ml10 mr10 shadow_l_10 p10 bg_box">
				<div class="cf">
					<img src="xiaowei/nankai.png" width="90px" height="90px" class="fl" />
					<span class="f16 fl pl20 mt30">${school.name}</span>
				</div>
				<div class="mt30">
					按热度排序：<a href="school?school.id=${school.id}">查看</a>
				</div>
				<div class="club_category cf">
					<span>按类型查看：</span><br />
					<s:iterator value="@com.tjxjh.enumeration.ClubType@values()"
						id="ac">
						<a class="shadow_l_5"
							href="school?school.id=${school.id}&clubType=<s:property value="name()"/>">${name}</a>
					</s:iterator>
				</div>
			</div>
		</div>
		<div class="main mt75">
			<div class="shadow_l_10 ml10 mr10">
				<span>所属分类:</span>

				<s:iterator value="@com.tjxjh.enumeration.ClubType@values()" id="ac">
					<s:if test="name().equals(clubType)">${name}<br />
					</s:if>
				</s:iterator>
		
				<br />
				<s:iterator value="clubs" id="ac">
					<img src="${logoPath}" width="80px" height="80px" />
					<br />
					<a href="#">${name}</a>
					<br /> 帮主:${user.name}<br />
							帮众:${memberNumber}<br /> 简介：${briefIntroduction}<br /> 类型：<s:property
						value="type.name" />
					<br /> 人气：${popularity} <br />
					活跃度:${liveness}
				<br />
				</s:iterator>
				<br /> 当前第${page.currentPage}页&nbsp;共${page.pageNumber}页 <a
					href="<%=path%>/school?school.id=${school.id}&clubType=${clubType}&currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}"
					target="_self">上一页</a>&nbsp; <a
					href="<%=path%>/school?school.id=${school.id}&clubType=${clubType}&currentPage=${page.currentPage+1}&totalPageNumber=${page.pageNumber}"
					target="_self">下一页</a>
			</div>
		</div>
	</div>
</body>
</html>
