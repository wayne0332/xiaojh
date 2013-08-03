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
<script type="text/javascript" src="js/index2.js"></script>
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

.main .center {
	width: 580px;
	min-height: 500px;
	background: #F6F6FF;
	float: left;
}

.main .right {
	width: 200px;
	min-height: 500px;
	background: #DDDDDD;
	float: right;
}

.main .left img {
	width: 80px;
	height: 80px;
	float: left;
	margin: 10px;
}

.main .right img {
	width: 80px;
	height: 80px;
	float: left;
	margin: 10px;
}

.oneactiviyts {
	width: 100%:  height:60px;
	padding: 10px;
	border: 1px dotted #DDDDDD;
	background: #EEEEEE;
	overflow: hidden;
}

.oneactivitys img {
	width: 60px;
	height: 60px;
}
;
</style>
<script type="text/javascript">
	function displayClubActivity(id){
		var caid='#clubactivity'+id;
		$(".clubactivity").fadeOut(100);
		$(caid).delay(100).fadeIn(300);
	}
	function displayMerchantActivity(id){
		var caid='#merchantactivity'+id;
		$(".merchantactivity").fadeOut(100);
		$(caid).delay(100).fadeIn(300);
	}
</script>
</head>

<body>
	<jsp:include page="head.jsp" />
	
	<div class="main">
		<div class="left">
			<s:iterator value="ics" id="cs">
				<img src="${club.logoPath}" title="${club.name}" onclick="displayClubActivity(${club.id})" />
			</s:iterator>

		</div>
		<div class="center">
		<!-- 社团活动 -->
			<div style="background:#999999;height:250px; overflow:hidden;">
				<s:iterator value="ics" status="cs">
					<!-- 循环社团 -->
					<div id="clubactivity${club.id}" class="clubactivity"
						style="<s:if test="#cs.getIndex()!=0">display:none;</s:if>">
						<!-- 默认显示第一个社团的活动，其他不显示 -->
						<s:iterator value="acs" status="child">
							<!--显示 社团对应的activity -->
							<div class="oneactivitys">
								<div style="float:left;">
									<img src="${titleImgPath}" />
								</div>
								<div style="float:left">
									标题：<a href="activity?activity.id=${id}">${tittle}</a><br>发布时间：${datetime}&nbsp;参与人数：${participantCount}
								</div>
								<div style="clear:both;"></div>
							</div>
						</s:iterator>
					</div>
				</s:iterator>
			</div>
		<!-- End:社团活动 -->
		<!-- 商家活动 -->
			<div style="background:#9999FF;height:250px; overflow:hidden;">
				<s:iterator value="ims" status="ms">
					<!-- 循环商家 -->
					<div id="merchantactivity${merchant.id}" class="merchantactivity"
						style="<s:if test="#ms.getIndex()!=0">display:none;</s:if>">
						<!-- 默认显示第一个商家的活动，其他不显示 -->
						<s:iterator value="acs" status="child">
							<!--显示 商家对应的activity -->
							<div class="oneactivitys">
								<div style="float:left;">
									<img src="${titleImgPath}" />
								</div>
								<div style="float:left">
									标题：<a href="activity?activity.id=${id}">${tittle}</a><br>发布时间：${datetime}&nbsp;参与人数：${participantCount}
								</div>
								<div style="clear:both;"></div>
							</div>
						</s:iterator>
					</div>
				</s:iterator>
			</div>
		<!-- End:商家活动 -->

		</div>
		<div class="right">
			<s:iterator value="ims" id="im">
				<img src="${merchant.logoPath}" onclick="displayMerchantActivity(${merchant.id})" title="${merchant.name}" />
			</s:iterator>
		</div>
	</div>
</body>
</html>
