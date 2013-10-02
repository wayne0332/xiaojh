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
	<div class="container cf">
		<jsp:include page="head.jsp" />
		<div class="cityMap w mt75 mb50 fl">
				<button class="index_Abt circle_100 mt50 shadow_l_5 fl hov"
					id="advToMap" <s:if test="#session.user == null">style="display: none;"</s:if>>切换到地图</button>
				<button class="index_Abt circle_100 hov shadow_l_5 fl <s:if test="#session.user != null">none</s:if>" id="mapToAdv">切换到活动</button>
				<ul class="cityMapUl w700 h400 fl cf <s:if test="#session.user != null">none</s:if>" id="mapPanel">
					<li class="cityMap_nankai circle_200 shadow_l_5">南开 和平</li>
					<li class="cityMap_hexi circle_150 shadow_l_5">河西 大港</li>
					<li class="cityMap_xiqing circle_150 shadow_l_5">西青 静海</li>
					<li class="cityMap_hebei circle_120 shadow_l_5">河北 河东</li>
					<li class="cityMap_beicheng circle_100 shadow_n_5">北辰 红桥</li>
					<li class="cityMap_wuqing circle_120 shadow_n_5">武清 宝坻 蓟县</li>
					<li class="cityMap_dongli circle_100 shadow_l_5">东丽 塘沽</li>
				</ul>
				<div class="mapBar w300 fl <s:if test="#session.user != null && #session.merchant == null">none</s:if>" id="mapBar">
					<div class="w250 mt50 ml30 cf shadow_l_5">
						<s:if test="#session.user == null && #session.merchant == null">
							<jsp:include page="login.jsp" />
						</s:if>
						<s:else>
						</s:else>
					</div><ul class="campusList w250 mt15 ml30 pb50 cf shadow_l_5 ulNankai">
						<li class="campusList_li1 h30 pl10 pr10">天津市 - 南开区 和平区</li>
						<li><a href="school?school.id=2" class="w230 h30 pl10 pr10">天津大学</a></li>
						<li><a href="school?school.id=1" class="w230 h30 pl10 pr10">南开大学</a></li>
						<li><a href="school?school.id=10" class="w230 h30 pl10 pr10">天津中医药大学</a></li>
						<li><a href="school?school.id=11" class="w230 h30 pl10 pr10">天津外国语大学</a></li>
						<li><a href="school?school.id=12" class="w230 h30 pl10 pr10">天津财经大学（和平）</a></li>
						<li><a href="school?school.id=13" class="w230 h30 pl10 pr10">天津医科大学</a></li>
					</ul>
					<ul class="campusList w250 mt15 ml30 pb50 cf shadow_l_5 ulXiqing none">
						<li class="campusList_li1 h30 pl10 pr10">天津市 - 西青区 静海区</li>
						<li><a href="school?school.id=3" class="w230 h30 pl10 pr10">天津工业大学</a></li>
						<li><a href="school?school.id=5" class="w230 h30 pl10 pr10">天津师范大学</a></li>
						<li><a href="school?school.id=4" class="w230 h30 pl10 pr10">天津理工大学</a></li>
						<li><a href="school?school.id=6" class="w230 h30 pl10 pr10">天津城建学院</a></li>
						<li><a href="school?school.id=7" class="w230 h30 pl10 pr10">天津农学院</a></li>
						<li><a href="school?school.id=8" class="w230 h30 pl10 pr10">天津宝德商学院</a></li>
						<li><a href="school?school.id=14" class="w230 h30 pl10 pr10">天津仁爱学院</a></li>
					</ul>
					<ul class="campusList w250 mt15 ml30 pb50 cf shadow_l_5 ulHexi none">
						<li class="campusList_li1 h30 pl10 pr10">天津市 - 河西区 大港区</li>
						<li><a href="school?school.id=15" class="w230 h30 pl10 pr10">天津科技大学</a></li>
						<li><a href="school?school.id=16" class="w230 h30 pl10 pr10">天津体育学院</a></li>
						<li><a href="school?school.id=17" class="w230 h30 pl10 pr10">天津职业技术师范大学</a></li>
						<li><a href="school?school.id=18" class="w230 h30 pl10 pr10">天津医科大学临床医学院</a></li>
						<li><a href="school?school.id=19" class="w230 h30 pl10 pr10">天津财经大学（河西）</a></li>
					</ul>
					<ul class="campusList w250 mt15 ml30 pb50 cf shadow_l_5 ulHebei none">
						<li class="campusList_li1 h30 pl10 pr10">天津市 - 河北区 河东区</li>
						<li><a href="school?school.id=20" class="w230 h30 pl10 pr10">天津美术学院</a></li>
						<li><a href="school?school.id=21" class="w230 h30 pl10 pr10">天津音乐学院</a></li>
					</ul>
					<ul class="campusList w250 mt15 ml30 pb50 cf shadow_l_5 ulBeicheng none">
						<li class="campusList_li1 h30 pl10 pr10">天津市 - 北辰区 红桥区</li>
						<li><a href="school?school.id=22" class="w230 h30 pl10 pr10">天津商业学院</a></li>
						<li><a href="school?school.id=23" class="w230 h30 pl10 pr10">河北工业大学</a></li>
					</ul>
					<ul class="campusList w250 mt15 ml30 pb50 cf shadow_l_5 ulWuqing none">
						<li class="campusList_li1 h30 pl10 pr10">天津市 - 武清区</li>
						<li><a href="school?school.id=9" class="w230 h30 pl10 pr10">天津天狮大学</a></li>
					</ul>
					<ul class="campusList w250 mt15 ml30 pb50 cf shadow_l_5 ulDongli none">
						<li class="campusList_li1 h30 pl10 pr10">天津市 - 东丽区 塘沽区</li>
						<li><a href="school?school.id=24" class="w230 h30 pl10 pr10">中国民航大学</a></li>
						<li><a href="school?school.id=25" class="w230 h30 pl10 pr10">南大滨海</a></li>
					</ul>
				</div>
				<div class="p10 m5 mt30 cf shadow_l_5" id="advPanel"
					<s:if test="#session.user == null || #session.merchant == null">style="display: none;"</s:if>>
					<ads:adver contentId="0" adsId="1"></ads:adver>
				</div>
		</div>


		<div class="index_sideCol w135 mt5 cf fl">
			<img src="images/icon/shetuan_icon.png" class="w70 ml5" /><br />
			<s:iterator value="ics" id="cs">
				<img src="${club.logoPath}" title="${club.name}"
					onmouseover="clubmouseOver(${club.id})"
					onmouseout="mouseOut();"
					class="logoImg logoImgcursor mt10 ml5 shadow_l_10 radius_6" />
			</s:iterator>
		</div>

		<div class="w730 fl mt75">
			<!-- 社团活动 -->
			<label class="activity_title mt5 ml10 pl5 fl shadow_n_5b">社团动向</label>
			<div class="index_update_panel">
				<s:iterator value="ics" status="cs">
					<div id="clubactivity${club.id}" style="<s:if test="#cs.getIndex()!=0">display:none;</s:if>">
						<s:iterator value="acs" status="child">
							<div class="index_activityBox cf m7 ml10 mr10 bg_fff shadow_l_5 radius_6">
								<div class="fl">
									<img src="${titleImgPath}"  class="w40 h50" />
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
			<!-- 商家活动 -->
			<label class="activity_title mt5 ml10 pr5 fl shadow_n_5b text_r">商家动向</label>
			<div  class="index_update_panel">
				<s:iterator value="ims" status="ms">
					<div id="merchantactivity${merchant.id}" style="<s:if test="#ms.getIndex()!=0">display:none;</s:if>">
						<s:iterator value="acs" status="child">
							<div class="index_activityBox cf m7 ml10 mr10 bg_fff shadow_l_5 radius_6">
								<div class="fr">
									<img src="${titleImgPath}" class="w40 h50" />
								</div>
								<div class="fl  ml5">
									标题：<a href="activity?activity.id=${id}">${tittle}</a><br />发布时间：${datetime}&nbsp;参与人数：${participantCount}
								</div>
							</div>
						</s:iterator>
					</div>
				</s:iterator>
			</div>
			<!-- End:商家活动 -->

			
		</div>

		<div class="index_sideCol w135 mt5 cf fr">
			<img src="images/icon/dianpu_icon.png" class="w70 fr mr5" /><br />
			<s:iterator value="ims" id="im">
				<img src="${merchant.logoPath}"
					onmouseover="merchantmouseOver(${merchant.id})"
					onmouseout="mouseOut();"
					title="${merchant.name}"
					class="logoImg logoImgcursor mt10 ml5 shadow_l_10 radius_6" />
			</s:iterator>
		</div>

	</div>

	<script type="text/javascript">
		var coid=${ics[0].club.id};
		function displayClubActivity(id){
			var caid='#clubactivity'+id;
			var coaid='#clubactivity'+coid;
			if(caid!=coaid){
				$(coaid).fadeOut(300);
				$(caid).delay(300).fadeIn(500);
				coid=id;
			}
		}
		var moid=${ims[0].merchant.id};
		function displayMerchantActivity(id){
			var caid='#merchantactivity'+id;
			var coaid='#merchantactivity'+moid;
			if(caid!=coaid){
				$(coaid).fadeOut(300);
				$(caid).delay(300).fadeIn(500);
				moid=id;
			}
		}
	var meizz; //声明一个页面级全局变量
	function merchantmouseOver(id)
	{
	    meizz = setTimeout("displayMerchantActivity("+id+")", 800); //设定程序延迟一秒钟执行
	}
	function clubmouseOver(id)
	{
	    meizz = setTimeout("displayClubActivity("+id+")", 800); //设定程序延迟一秒钟执行
	}
	
	function mouseOut()
	{
	    clearTimeout(meizz);
	}
					</script>

	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="js/page_action.js"></script>
	<script type="text/javascript" src="js/index2.js"></script>
</body>
</html>
