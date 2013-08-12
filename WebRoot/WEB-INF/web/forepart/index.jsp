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
<title>校江湖</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

<link rel="stylesheet" type="text/css" href="css/index_black.css" />

</head>

<body>
	<div class="container">
		<jsp:include page="head.jsp" />

		<!-- <ads:adver contentId="0" adsId="1"></ads:adver>  -->

		<div class="cityMap w700 mt75 fl">
			<button class="index_Abt circle_100 shadow_l_5">切换到活动</button>
			<ul>
				<li class="cityMap_nankai circle_200 shadow_l_5">南开 和平</li>
				<li class="cityMap_hexi circle_150 shadow_l_5">河西 大港</li>
				<li class="cityMap_xiqing circle_150 shadow_l_5">西青 静海</li>
				<li class="cityMap_hebei circle_120 shadow_l_5">河北 河东</li>
				<li class="cityMap_beicheng circle_100 shadow_n_5">北辰 红桥</li>
				<li class="cityMap_wuqing circle_120 shadow_n_5">武清 宝坻 蓟县</li>
				<li class="cityMap_dongli circle_100 shadow_l_5">东丽 塘沽</li>
			</ul>
		</div>
		<div class="mapBar w300 mt75 fr">
			<div class="w250 mt50 ml10 cf shadow_l_5">
				<s:if test="#session.user == null">
					<jsp:include page="login.jsp" />
				</s:if>
				<s:else>
				</s:else>
			</div>
			<ul class="campusList w250 h200 mt15 ml10 shadow_l_5">
				<li class="campusList_li1 h30 pl10 pr10">天津市 - 西青区</li>
				<li><a href="#" class="w230 h30 pl10 pr10">天津工业大学</a></li>
				<li><a href="#" class="w230 h30 pl10 pr10">天津师范法学</a></li>
				<li><a href="#" class="w230 h30 pl10 pr10">天津理工法学</a></li>
				<li><a href="#" class="w230 h30 pl10 pr10">天津城建学院</a></li>
			</ul>
		</div>

		<div class="index_sideCol w135 cf fl">
			<s:iterator value="ics" id="cs">
				<img src="${club.logoPath}" title="${club.name}"
					onclick="displayClubActivity(${club.id})"
					class="mt5 ml5 shadow_l_10 radius_6" />
			</s:iterator>
		</div>

		<div class="w730 fl">
			<!-- 商家活动 -->
			<label class="activity_title mt5 ml10 pl5 fl shadow_n_5b">社团动向</label>
			<div class="index_update_panel">
				<s:iterator value="ims" status="ms">
					<!-- 循环商家 -->
					<div id="merchantactivity${merchant.id}"
						style="<s:if test="#ms.getIndex()!=0">display:none;</s:if>">
						<!-- 默认显示第一个商家的活动，其他不显示 -->
						<s:iterator value="acs" status="child">
							<!--显示 商家对应的activity -->
							<div class="index_activityBox cf m10 bg_fff shadow_l_5 radius_6">
								<div class="fl">
									<img src="${titleImgPath}" class="w100" />
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

			<!-- 社团活动 -->
			<label class="activity_title mt10 ml10 pr5 fl shadow_n_5b text_r">商家动向</label>
			<div class="index_update_panel">
				<s:iterator value="ics" status="cs">
					<!-- 循环社团 -->
					<div id="clubactivity${club.id}"
						style="<s:if test="#cs.getIndex()!=0">display:none;</s:if>">
						<!-- 默认显示第一个社团的活动，其他不显示 -->
						<s:iterator value="acs" status="child">
							<!--显示 社团对应的activity -->
							<div class="index_activityBox cf m10 bg_fff shadow_l_5 radius_6">
								<div class="fr">
									<img src="${titleImgPath}" class="w100" />
								</div>
								<div class="fl ml5">
									标题：<a href="activity?activity.id=${id}">${tittle}</a><br />发布时间：${datetime}&nbsp;参与人数：${participantCount}
								</div>
							</div>
						</s:iterator>
					</div>
				</s:iterator>
			</div>
			<!-- End:社团活动 -->
		</div>

		<div class="index_sideCol w135 cf fr">
			<s:iterator value="ims" id="im">
				<img src="${merchant.logoPath}"
					onclick="displayMerchantActivity(${merchant.id})"
					title="${merchant.name}" class="mt5 ml5 shadow_l_10 radius_6" />
			</s:iterator>
		</div>

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
