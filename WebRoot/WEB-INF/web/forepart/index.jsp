<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ads" uri="fineTu/ads"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>首页——校江湖</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

<link rel="stylesheet" type="text/css" href="css/index_black.css" />

<style type="text/css">
.oneactivitys img {
	width: 60px;
	height: 60px;
}
;
</style>
</head>

<body>
	<div class="container">
		<jsp:include page="head.jsp" />
		<ads:adver contentId="0" adsId="1"></ads:adver>

		<div class="index_sideCol w140 p5 cf fl">
			<s:iterator value="ics" id="cs">
				<img src="${club.logoPath}" title="${club.name}"
					onclick="displayClubActivity(${club.id})" class="m5" />
			</s:iterator>
		</div>

		<!-- 社团活动 -->
		<div class="index_update_box w340 p5 fl">
			<s:iterator value="ics" status="cs">
				<!-- 循环社团 -->
				<div id="clubactivity${club.id}"
					style="<s:if test="#cs.getIndex()!=0">display:none;</s:if>">
					<!-- 默认显示第一个社团的活动，其他不显示 -->
					<s:iterator value="acs" status="child">
						<!--显示 社团对应的activity -->
						<div class="index_activityBox cf m5 p5 bg_fff">
							<div class="fl">
								<img src="${titleImgPath}" class="w60 h60" />
							</div>
							<div class="fl">
								标题：<a href="activity?activity.id=${id}">${tittle}</a><br />发布时间：${datetime}&nbsp;参与人数：${participantCount}
							</div>
						</div>
					</s:iterator>
				</div>
			</s:iterator>
		</div>
		<!-- End:社团活动 -->


		<div class="index_sideCol w140 p5 cf fr">
			<s:iterator value="ims" id="im">
				<img src="${merchant.logoPath}"
					onclick="displayMerchantActivity(${merchant.id})"
					title="${merchant.name}" class="m5" />
			</s:iterator>
		</div>
		<!-- 商家活动 -->
		<div class="index_update_box w340 p5 fr">
			<s:iterator value="ims" status="ms">
				<!-- 循环商家 -->
				<div id="merchantactivity${merchant.id}"
					style="<s:if test="#ms.getIndex()!=0">display:none;</s:if>">
					<!-- 默认显示第一个商家的活动，其他不显示 -->
					<s:iterator value="acs" status="child">
						<!--显示 商家对应的activity -->
						<div class="index_activityBox cf m5 p5 bg_fff">
							<div class="fl">
								<img src="${titleImgPath}" class="w60 h60" />
							</div>
							<div class="fl">
								标题：<a href="activity?activity.id=${id}">${tittle}</a><br />发布时间：${datetime}&nbsp;参与人数：${participantCount}
							</div>
						</div>
					</s:iterator>
				</div>
			</s:iterator>
		</div>
		<!-- End:商家活动 -->


	</div>

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

	<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
	<script type="text/javascript" src="js/index2.js"></script>
</body>
</html>
