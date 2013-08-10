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

</head>

<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		<div class="left_bar w270 cf mt75">
			<div class="my_info w240 h90 p5 m5 shadow_l_10 bg_box">
				<img src="images/head/head1.jpg"
					class="fl mt5 ml10 circle_80 shadow_l_5" />
				<ul class="fl w135 p5 pl10 text_r">
					<li class="w135 text_l f14"><a href="updateUserInput"><s:property
								value="#session.user.name" /> </a></li>
					<li><s:property value="#session.user.grade" />
					</li>
					<li><s:property
							value="#application.schools[#session.user.school.id].name" />
					</li>
					<li>凤凰社</li>
				</ul>
			</div>
			<form action="searchAll" method="post"
				class="l_search w250 m5 shadow_l_10">
				<input name="searchText" type="text" class="w200 h30 pl5" />
				<button type="submit" class="w40 h30 fr shadow_l_5">搜索</button>
			</form>

			<label class="Clearfix w250 ml5 mt50">我的门客<a
				href="myFocus?type=0" class="fr">更多</a> </label>
			<div class="l_box w240 p5 m5 cf shadow_l_10 radius_6 bg_box">
				<s:iterator value="#request.focusUserList">
					<div class="fl p5">
						<s:if test="portrait==''">
							<img src="<s:property value="portraitPath" />"
								class="w50 h50 Clearfix" />
						</s:if>
						<s:else>
							<img src="upload/portrait/auto_photo.png"
								class="w50 h50 Clearfix" />
						</s:else>
						<label class="Clearfix mb5 w50"><s:property value="name" />
						</label>
					</div>
				</s:iterator>
			</div>

			<label class="Clearfix w250 ml5 mt20">我的社团 <a
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
			<!-- 发布说说-->
			<form action="addTalking" method="post" enctype="multipart/form-data"
				class="userHome_box w700 m5 p10 cf shadow_l_10 radius_6">
				<label class="userBox_title w pl10 pr10 h30">发状态</label>
				<textarea class="h100 mt10 mb5 f14 p5"></textarea>
				媒体链接：<input type="text" name="talking.url" /><br /> 图片：<input
					type="file" name="uploadImage" />
				<button type="submit" class="fr">发布</button>
			</form>
			<!--END： 发布说说-->
			<!-- 相册-->
			<div class="userHome_box w700 m5 p10 cf shadow_l_10 radius_6">
				<label>最新相册</label>
				<s:iterator value="pics">
					<span style="display: inline-block;"> <a
						href="<%=path%><s:property  value="path.replace('st_', '')" />"
						target="_blank"><img src="<%=path%>/${path}" width="190px" />
					</a> <br /> ${name}&nbsp; From:<a href="#">${user.name}</a> </span>
				</s:iterator>
				<a href="<%=path%>/findAllPicture" target="_self" class="fr">更多</a>
			</div>
			<!-- END:相册-->
			<!-- 说说 -->
			<div class="userHome_box w700 m5 mt30 p10 cf shadow_l_10 radius_6">
				<label class="userBox_title w pl10 pr10 h30">江湖动态</label>
				<s:iterator value="taks" id="tak">
					<div id="${id}" class="user_dongtai_div cf w700 mt10 pt10 pb15">
						<div class="w60 h fl">
							<img src="images/head/head1.jpg" class="w60 h60 fl" />
						</div>
						<s:if test="talking==null">
							<label class="fr w630 f14"><s:property value="text" /> </label>
							<div class="cf w630 mt5 fr">
								<s:if
									test="url!=null&&!url.trim().equals('')&&urlType.toString()=='PICTURE'">
									<img src="${url}" />
								</s:if>
								<!-- 说说 -->
								<s:elseif
									test="url!=null&&!url.trim().equals('')&&urlType.toString()=='VIDEO'">
								     			${url}
										     </s:elseif>
							</div>
						</s:if>
						<s:elseif test="talking!=null">
							<label><a>${talking.user.name}</a>分享：<s:property
									value="text" /> </label>
							<div class="cf">
								<s:property value="talking.text" />
								<s:if
									test="talking.turl!=null&&talking.urlType.toString()=='PICTURE'">
									<img src="${takling.url}" width="200px" />
								</s:if>
								<!-- 说说 -->
								<s:elseif
									test="talking.url!=null&&talking.urlType.toString()=='VIDEO'">
									<s:property
										value="talking.url.replace('400', '260').replace('480', '280')"
										escape="false" />
								</s:elseif>
							</div>
						</s:elseif>

						<div id="zan${id}" class="fr w630 mt5">
							<s:if test="shareDetails!=null">
								<!-- like -->
								<a href="javascript:void(0);" onclick="zanTalking(${id});">赞(${shareDetails.praiseCount})</a>
							</s:if>
							<s:else>
								<a href="javascript:void(0);" onclick="zanTalking(${id});">赞(${talking.shareDetails.praiseCount})</a>
							</s:else>
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
