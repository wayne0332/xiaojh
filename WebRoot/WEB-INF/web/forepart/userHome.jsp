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

<title>校江湖 - 个人主页</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />
<script type="text/javascript" src="<%=path%>/js/ajax.js"></script>
</head>

<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		<div class="left_bar w270 cf mt75">			
			<div class="my_info w240 h90 p5 m5 shadow_l_10 bg_box">
				<img src="<s:property value="#session.user.portraitPath"/>"
					class="fl mt5 ml10 circle_80 shadow_l_5" />
				<ul class="fl w135 p5 pl10 text_r">
					<li class="w135 text_l f14">${user.name}</li>
					<li>${user.grade}
					</li>
					<li>${user.school.name}
					</li>
				</ul>
			</div>

			<label class="Clearfix w250 ml5 mt20">相册 <a
				href="<%=path%>/findAllPicture" class="fr">更多</a> </label>
			<div class="l_box w240 p5 m5 cf shadow_l_10 radius_6 bg_box">
					<span style="display: inline-block;"> 
						<s:if test="pics.size()==0">
							暂无相册……
						</s:if>
						<s:else>
							<a href="<%=path%>/findAllPicture"><img src="<%=path%>/${pics[0].path}" width="240px" /></a>
						</s:else>
					</span>
			</div>
			
			<label class="Clearfix w250 ml5 mt20">线上活动 <a
				href="#" class="fr">更多</a> </label>
			<div class="l_box w240 p5 m5 cf shadow_l_10 radius_6 bg_box">
				<s:iterator value="onlineActs">
					<div class="fl">
						<img src="${titleImgPath}"  class="w40 h50" />
					</div>
					<div class="fl">
						标题：<a href="getOnlineActivityById?onlineactivity.id=${id}">${tittle}</a>
						<br/>发布时间:${datetime}
					</div>
				</s:iterator>
				<s:if test="onlineActs.size()==0">
							暂无线上活动……
				</s:if>
			</div>
				
			<label class="Clearfix w250 ml5 mt20">关注社团 <a
				href="myFocus?type=1" class="fr">更多</a> </label>
			<div class="l_box w240 p5 m5 cf shadow_l_10 radius_6 bg_box">
				<s:iterator value="#request.focusClubList">
					<div class="fl p5">
						<s:if test="logoPath==''">
							<img src="<s:property value="portraitPath" />"
								class="w50 h50 Clearfix" />
						</s:if>
						<s:else>
							<img src="upload/portrait/auto_photo.png"
								class="w50 h50 Clearfix" />
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
						<%-- <s:if test="portrait==''">
									<img src="<s:property value="portraitPath" />" width="40px" />
								</s:if>
								<s:else>
									<img src="upload/portrait/auto_photo.png" width="40px" />
								</s:else> --%>
						<label class="Clearfix mb10"> <s:property value="name" />
						</label>
					</div>
				</s:iterator>
			</div>
		</div>

		<div class="main w730 cf mt75">
			
			<!-- 导航-->
			<div class="userHome_box w700 m5 p10 cf shadow_l_10 radius_6">
				<a href="#"><label>相册</label></a>
				<a href="#"><label>说说</label></a>
				<a href="#"><label>活动</label></a>
			</div>
			<!-- END:相册-->
			<!-- 说说 -->
			<div class="userHome_box w700 m5 mt30 p10 cf shadow_l_10 radius_6">
				<label class="userBox_title w pl10 pr10 h30">江湖动态</label>
				<s:iterator value="taks" id="tak">
					<div id="${id}" class="user_dongtai_div cf w700 mt10 pt10 pb15">
						<div class="w60 h fl">
							<img src="${user.portraitPath}" class="w60 h60 fl shadow_l_10 radius_6" />
						</div>
						<div class="fr w610 mt5 mr15 user_talking_detail_div">
							<s:if test="talking==null">
								<label class="fr w610 f16 lh150 user_name_color">${user.name}</label>
								<label class="fr w610 f14"><s:property value="text" /> </label>
								<div class="cf w610 mt5 fr">
									<s:if test="url!=null&&!url.trim().equals('')&&urlType.toString()=='PICTURE'">
										<img src="${url}" class="maw400 mah300"/>
									</s:if>
									<s:elseif test="url!=null&&!url.trim().equals('')&&urlType.toString()=='VIDEO'">
									    <s:property
											value="url.replace('400', '300').replace('480', '360')"
											escape="false" />
								    </s:elseif>
								</div>
							</s:if>
							<s:elseif test="talking!=null">
								<label class="fr w610 f16 lh150 user_name_color">${user.name}</label>
								<label><s:property value="text" /> </label>
								<div class="p10 mt5 user_talking_share_div ">
									${talking.user.name} :<s:property value="talking.text" /><br/>
									<s:if
										test="talking.url!=null&&talking.urlType.toString()=='PICTURE'">
										<img src="${talking.url}" class="maw400 mah300"/>
									</s:if>
									<!-- 说说 -->
									<s:elseif test="talking.url!=null&&talking.urlType.toString()=='VIDEO'">
										<s:property
											value="talking.url.replace('400', '300').replace('480', '360')"
											escape="false" />
									</s:elseif>
								</div>
							</s:elseif>
						</div>
						<!-- like -->
						<div class="fr w610 mt5 mr15">
							<span id="zan${id}">
								<s:if test="shareDetails!=null">
									<!-- like -->
									<a href="javascript:void(0);" onclick="zanTalking(${id});">赞(${shareDetails.praiseCount})</a>
								</s:if>
								<s:else>
									<a href="javascript:void(0);" onclick="zanTalking(${id});">赞(${talking.shareDetails.praiseCount})</a>
								</s:else>
							</span>
							<a href="<%=path %>/preShareTalking?talking.id=${id}">分享<s:if
									test="shareDetails!=null">(${shareDetails.shareCount})</s:if> <s:else>(${talking.shareDetails.shareCount})</s:else>
							</a><a href="#">评论</a> 来自：${user.name} <label>${datetime}</label>
						</div>
						<!-- like end -->
					</div>
				</s:iterator>
				<br> <a href="<%=path%>/allTalking" target="_self">更多</a>&nbsp;




















































			</div>
			<!-- END：说说 -->
		</div>
		<div class="clearfloat"></div>
		<div class="footer"></div>
	</div>
</body>
</html>
