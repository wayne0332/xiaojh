<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>


<!DOCTYPE html">
<html>
<head>

<title>校江湖 - 个人主页</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />
</head>

<body>
	<div class="container cf">
		<jsp:include page="head.jsp" />

		<div class="left_bar w270 cf mt75">
			<div class="my_info w240 h90 p5 m5 shadow_l_3 bg_box">
				<img src="${merchant.logoPath }" class="fl mt5 ml10 circle_80 shadow_l_5" />
				<ul class="fl w135 p5 pl10 text_r">
					<li class="w135 text_l f14">${merchant.name}</li>
					<li><a href="focusMerchant?id=${merchant.id}">关注</a></li>
				</ul>
			</div>
			
			<label class="Clearfix w250 ml5 mt50">关注社团<a href="merchantFocus?type=1&pageNum=1" class="fr">更多</a></label>
			<div class="l_box w240 p5 m5 cf shadow_l_3 radius_6 bg_box">
				<s:iterator value="#request.focusClubList">
					<div class="fl p5">
						<s:if test="portrait==''">
							<a href="javascript:void(0);"><img src="<s:property value="portraitPath" />" class="w50 h50 Clearfix" /></a>
						</s:if>
						<s:else>
							<a href="javascript:void(0);"><img src="upload/portrait/auto_photo.png" class="w50 h50 Clearfix" /></a>
						</s:else>
						<label class="Clearfix mb5 w50"><s:property value="name" />
						</label>
					</div>
				</s:iterator>
			</div>
			
			<label class="Clearfix w250 ml5 mt20">关注商家 <a href="merchantFocus?type=2&pageNum=1" class="fr">更多</a></label>
			<div class="l_box w240 p5 m5 cf shadow_l_3 radius_6 bg_box">
				<s:iterator value="#request.focusMerchantList">
					<div class="fl">
						<s:if test="logoPath==null||logoPath.trim.equals('')">
							<a href="merchantMain?merchantMain.id=${id}"><img
								src="upload/portrait/auto_photo.png" class="w50 h50 Clearfix" />
							</a>
						</s:if>
						<s:else>
							<a href="merchantMain?merchantMain.id=${id}"><img
								src="<s:property value="logoPath" />" class="w50 h50 Clearfix" />
							</a>
						</s:else>
						<label class="Clearfix mb10"> <s:property value="name" />
						</label>
					</div>
				</s:iterator>
			</div>

		</div>

		<div class="main w730 cf mt75">
			<s:iterator value="acs" id="ac">
				<div class="myActivity_box w700 mt5 ml5 p10 cf  shadow_l_3 bg_fff">
					<h2 class="w335 fr">
						<a href="activity?activity.id=${id}" class="f16 a_no"><s:property
								value="tittle" /> </a>
					</h2>
					<div class="myActivity_img w335 fl">
						<img src="${titleImgPath}" class="w335 fl" />
					</div>
					<ul class="w335 fr mt10">
						<li><label>组织单位：</label>${organizer}</li>
						<li><label>主办单位：</label>${club.name}${merchant.name}</li>
						<li><label>发布时间：</label>${datetime}</li>
						<li><label>资金预算：</label>${budget}元</li>
						<li><label>举办地点：</label>${place}</li>
						<li><label>活动状态： </label> <s:property value="status.name" />
						</li>

						<li><label>活动热度：</label>${heat}</li>
						<li><label>分享次数：</label>${talking.shareDetails.shareCount}</li>
						<li><a href="/preShareTalking?talking.id=${talking.id}">分享</a>
							<span id="zan${talking.id}"> <a href="javascript:void(0);"
								onclick="zanTalking(${talking.id});">赞(${talking.shareDetails.praiseCount})</a>
						</span>
						</li>
					</ul>
				</div>
			</s:iterator>
			<br> <a href="activitys?merchant.id=${merchant.id}">更多活动</a>
		</div>
	</div>
</body>
</html>
