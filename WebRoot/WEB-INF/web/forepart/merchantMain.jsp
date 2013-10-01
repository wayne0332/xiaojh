<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'merchantMain.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<jsp:include page="head.jsp" />
	<div style="border:1px;">
		商家名称：${merchant.name}&nbsp;&nbsp;<a
			href="focusMerchant?id=${merchant.id}">关注</a> <br>商家logo:<img
			src="${merchant.logoPath }">
	</div>
	<a href="merchantNews">更多新闻</a>
	<div class="left_bar fr cf mt75">
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
	<div class="club_panel fl m5 p10 bg_fff shadow_l_3">
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
</body>
</html>
