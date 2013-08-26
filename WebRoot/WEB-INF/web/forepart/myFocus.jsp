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

<title>校江湖 - 好友</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

</head>
<body>

	<div class="container cf zoom">
		<jsp:include page="head.jsp" />

		<div class="left_bar mt75">
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
		</div>

		<div class="main cf mt75">
			<div class="friendList cf shadow_l_10 m10 mt5 bg_fff">
				<!-- 
				<s:property value="#request.focusList" />
				<s:property value="type" /> -->

				<s:if test="type==0">
					<s:iterator value="#request.focusList">
						<div class="friendBox">
							<s:if test="portrait==''">
								<img src="images/head/head1.jpg" class="fl logoImg" />
							</s:if>
							<s:else>
								<img src="images/head/head1.jpg"  class="fl logoImg" />
							</s:else>
							<ul class="fl">
								<li class="infoItem"><s:property value="name" /></li>
								<li><s:property value="sex" /></li>
								<li><s:property value="school.name" /></li>
								<li><s:property value="profession" /></li>
								<li><s:property value="grade" /></li>
								<li><s:property value="signature" /></li>
							</ul>
							<input id="<s:property value="id" />" type="button" value="取消关注"
								onclick="cancelFocus(<s:property value="id" />,0)" />
						</div>
					</s:iterator>
				</s:if>
				<s:elseif test="type==1">
					<s:iterator value="#request.focusList">
						<div class="listItem">
							<div class="portrait_big">
								<s:if test="logoPath==''">
									<img src="<s:property value="logoPath" />" width="40px" />
								</s:if>
								<s:else>
									<img src="upload/portrait/auto_photo.png" width="40px" />
								</s:else>
							</div>
							<div class="userItem">
								<div class="infoItem">
									<s:property value="name" />
								</div>
								<div>
									<s:property value="school.name" />
								</div>
								<div>
									<s:property value="briefIntroduction" />
								</div>
								<div>
									<s:property value="user.name" />
								</div>
								<div>
									<s:property value="memberNumber" />
								</div>
							</div>
							<input id="<s:property value="id" />" type="button" value="取消关注"
								onclick="cancelFocus(<s:property value="id" />,1)" />
						</div>
					</s:iterator>
				</s:elseif>
				<s:elseif test="type==2">
					<s:iterator value="#request.focusList">
						<div class="listItem">
							<div class="portrait_big">
								<s:if test="portrait==''">
									<img src="images/head/head1.jpg" class="fl logoImg" />
								</s:if>
								<s:else>
									<img src="images/head/head1.jpg"  class="fl logoImg" />
								</s:else>
							</div>
							<div class="userItem">
								<div class="infoItem">
									<s:property value="name" />
								</div>
								<div>
									<s:property value="type" />
								</div>
								<div>
									<s:property value="business" />
								</div>
								<div>
									<s:property value="connectorName" />
								</div>
								<div>
									<s:property value="connectorPhone" />
								</div>
								<div>
									<s:property value="popularity" />
								</div>
							</div>
							<input id="<s:property value="id" />" type="button" value="取消关注"
								onclick="cancelFocus(<s:property value="id" />,2)" />
						</div>
					</s:iterator>
				</s:elseif>
			</div>
		</div>
		<div class="left_bar fr cf"></div>
		<div class="footer"></div>
	</div>


	<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
	<script type="text/javascript">
	function addFocus(userId,type) {
		if(type==0){
			url = "focusUser?id="+userId;
		}else if(type==1){
			url = "focusClub?id="+userId;
		}else if(type==2){
			url = "focusMerchant?id="+userId;
		}
  		$.post(url,
  			function(xml){
  				var aLink = $("#"+userId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("onclick","cancelFocus("+userId+","+type+")");
  					aLink.val("取消关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function cancelFocus(userId,type) {
		var url;
		if(type==0){
			url = "cancelFocusUser?id="+userId;
		}else if(type==1){
			url = "cancelFocusClub?id="+userId;
		}else if(type==2){
			url = "cancelFocusMerchant?id="+userId;
		}
  		$.post(url,
  			function(xml){
  				var aLink = $("#"+userId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("onclick","addFocus("+userId+","+type+")");
  					aLink.val("关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	</script>
</body>
</html>
