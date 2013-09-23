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

<base href="<%=basePath%>" />

<title>校江湖 -userHomeLeft</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />
</head>
<body>
		<div class="left_bar w270 cf mt75">
			<div class="my_info w240 h90 p5 m5 shadow_l_10 bg_box">
				<img src="<s:property value="user.portraitPath"/>"
					class="fl mt5 ml10 circle_80 shadow_l_5" />
				<ul class="fl w135 p5 pl10 text_r">
					<li class="w135 text_l f14">${user.name}</li>
					<li>${user.grade}</li>
					<li>${user.school.name}</li>
				</ul>
			</div>

			<label class="Clearfix w250 ml5 mt20">相册 
				<a href="<%=path%>/photos?user.id=${user.id}" class="fr">更多</a> </label>
			<div class="l_box w240 p5 m5 cf shadow_l_10 radius_6 bg_box">
				<span style="display: inline-block;"> 
						<s:if test="#request.pics.size()==0">
							暂无相册……
						</s:if> 
						<s:else>
							<a href="<%=path%>/photos?user.id=${user.id}">
								<img src="<%=path%>/${requestScope.userHomePics[0].path}" width="240px" />
							</a>
						</s:else> 
				</span>
			</div>

			<label class="Clearfix w250 ml5 mt20">线上活动 <a href="#"
				class="fr">更多</a> </label>
			<div class="l_box w240 p5 m5 cf shadow_l_10 radius_6 bg_box">
				<s:iterator value="#request.onlineActs">
					<div class="fl mt5 mr5">
						<img src="${titleImgPath}" class="w40 h50 shadow_l_10" />
					</div>
					<div class="fl mt5">
						标题：<a href="getOnlineActivityById?onlineactivity.id=${id}">${tittle}</a>
						<br />发布时间:
						<s:property value="datetime.toString().substring(0,16)" />
					</div>
					<div class="cb"></div>
				</s:iterator>
				<s:if test="#request.onlineActs.size()==0">
							暂无线上活动……
				</s:if>
			</div>

			<label class="Clearfix w250 ml5 mt20">关注社团 <a
				href="myFocus?type=1" class="fr">更多</a> </label>
			<div class="l_box w240 p5 m5 cf shadow_l_10 radius_6 bg_box">
				<s:iterator value="#request.focusClubList">
					<div class="fl p5">
						<s:if test="logoPath==null||logoPath.trim.equals('')">
							<a href="clubMain?club.id=${id}"><img
								src="upload/portrait/auto_photo.png" class="w50 h50 Clearfix" />
							</a>
						</s:if>
						<s:else>
							<a href="clubMain?club.id=${id}"><img
								src="<s:property value="logoPath" />" class="w50 h50 Clearfix" />
							</a>

						</s:else>
						<label class="Clearfix mb5 w50"> <s:property value="name" />
						</label>
					</div>
				</s:iterator>
			</div>
			<label class="Clearfix w250 ml5 mt20">关注商家 <a
				href="myFocus?type=2" class="fr">更多</a> </label>
			<div class="l_box w240 p5 m5 cf shadow_l_10 radius_6 bg_box">
			
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
</body>
</html>
