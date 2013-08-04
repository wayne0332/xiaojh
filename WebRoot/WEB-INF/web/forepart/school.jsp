<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>首页——校江湖</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="<%=path%>/js/jquery-1.8.1.min.js"></script>
<style type="text/css">
.main {
	width: 980px;
	min-height: 500px;
	margin: 0 auto;
	border: 1px solid #DDDDDD;
}

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
<script type="text/javascript">

</script>
</head>

<body>
	<jsp:include page="head.jsp" />
	<div class="main">
		<div class="left">
			学校：${school.name}<br>
			<img src="${school.logoPath}" width="80px" height="80px"/>
			<br>
			按热度排序：<a href="school?school.id=${school.id}">查看</a><br>
			按类型查看：<b r>
			<s:iterator value="@com.tjxjh.enumeration.ClubType@values()" id="ac">
				<a href="school?school.id=${school.id}&clubType=<s:property value="name()"/>">${name}</a><br>
			</s:iterator>
		</div>
		<div class="right">
		所属分类:
			<s:iterator value="@com.tjxjh.enumeration.ClubType@values()" id="ac">
				<s:if test="name().equals(clubType)">${name}<br>    </s:if>
			</s:iterator>
			<s:property value="@com.tjxjh.enumeration.ClubType@getChineseName(clubType)" /><br>
			<s:iterator value="clubs" id="ac">
				<img src="${logoPath}" width="80px" height="80px"/><br>
				<a href="#">${name}</a><br>
				帮主:${user.name}<br>
				帮众:${memberNumber}<br>
				简介：${briefIntroduction}<br>
				类型：<s:property value="type.name"/><br>
				人气：${popularity}<br>
				活跃度:${liveness}<br>
			</s:iterator>
			<br>
     	当前第${page.currentPage}页&nbsp;共${page.pageNumber}页
     	<a href="<%=path%>/school?school.id=${school.id}&clubType=${clubType}&currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}" target="_self">上一页</a>&nbsp; 
     	<a href="<%=path%>/school?school.id=${school.id}&clubType=${clubType}&currentPage=${page.currentPage+1}&totalPageNumber=${page.pageNumber}" target="_self">下一页</a>
		</div>
		
	</div>
</body>
</html>
