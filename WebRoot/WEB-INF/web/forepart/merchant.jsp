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
		
		<div class="cityMap mt75 mb50">
			<div style="border:1px;">
				商家名称：${merchant.name}&nbsp;&nbsp;<a
					href="focusMerchant?id=${merchant.id}">关注</a> <br>商家logo:<img
					src="${merchant.logoPath }">
			</div>
			<a href="merchantNews">更多新闻</a>
			<div class="cf mt75">
					<label class="Clearfix w250 ml5 mt20">关注社团<a
						href="merchantFocus?type=1&pageNum=1" class="fr">更多</a> </label>
					<div class="bg_box shadow_l_3 m5 cf">
						<s:iterator value="#request.focusClubList">
							<div class="fl people_box">
								<s:if test="logoPath==''">
									<img src="<s:property value="portraitPath" />"
										class="w50 h50 Clearfix" />
								</s:if>
								<s:else>
									<img src="upload/portrait/auto_photo.png" class="w50 h50 Clearfix" />
								</s:else>
								<label class="Clearfix mb5 w50"> <s:property value="name" />
								</label>
							</div>
						</s:iterator>
					</div>
			</div>
			<div class="cf mt75">
				<div>
					关注商家： <a href="merchantFocus?type=2&pageNum=1">更多</a>
				</div>
				<s:iterator value="#request.focusMerchantList">
					<div class="portrait">
						<div class="portraitImg"></div>
						<div class="userName">
							<s:property value="name" />
						</div>
					</div>
				</s:iterator>
			</div>
			商家新闻<br>			
				<s:iterator value="#request.merchantNews" status="status">
						<s:a href="merchantNewsDetails?merchantNews.id=%{id}">
								<s:property value="tittle" />
						</s:a>
						<s:date name="datetime" format="yyyy-MM-dd hh:mm:ss" />
						
				</s:iterator>
				<br>
			<a href="newsOfMerchant?merchant.id=${merchant.id}">更多新闻</a>
			<br>商家活动<br>
			<s:iterator value="acs" id="ac">
						<div
							class="myActivity_box w700 mt15 ml5 p10 cf  shadow_l_3 bg_fff">
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
								<li><label>活动状态： </label>
								<s:property value="status.name" />
								</li>
								
								<li><label>活动热度：</label>${heat}</li>
								<li><label>分享次数：</label>${talking.shareDetails.shareCount}</li>
								<li><a
									href="/preShareTalking?talking.id=${talking.id}">分享</a>
									<span id="zan${talking.id}"> <a href="javascript:void(0);"
										onclick="zanTalking(${talking.id});">赞(${talking.shareDetails.praiseCount})</a>
								</span></li>
							</ul>
						</div>
					</s:iterator><br>
					<a href="activitys?merchant.id=${merchant.id}">更多活动</a>
			</div>
	</div>
</body>
</html>
