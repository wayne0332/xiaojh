<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>" />

<title>校江湖 - 好友</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

</head>

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

					<li><s:property value="#session.user.grade % 2000" />级</li>
					<li><s:property
							value="#application.schools[#session.user.school.id].name" /></li>
					<!-- <li>凤凰社</li> -->
				</ul>
			</div>
		</div>

		<div class="main cf mt75">
			<div class="friendList cf">

				<div>
					<span>朋友</span>
					<a href="searchUser?searchText=<s:property value="#request.searchText" />&pageNum=1&club.id=<s:property value="club.id" />">更多结果</a>
				</div>
				
				<div class="cf">
					<s:iterator value="#request.searchResult.userList">
	
						<div class="friendBox shadow_l_3 school_${school.id }">
							<s:if test="portrait==''">
								<a href="userHome?user.id=${id}"><img
									src="images/head/head1.jpg" class="fl logoImg" /> </a>
							</s:if>
							<s:else>
								<a href="userHome?user.id=${id}"><img
									src="images/head/head1.jpg" class="fl logoImg" /> </a>
							</s:else>
							<ul class="frd_box_info">
								<li class="frd_name"><s:property value="name" />
								</li>
								<li><s:property value="school.name" />
								</li>
								<li><s:property value="grade" />&nbsp;<s:property value="sex" />
								</li>
							</ul>
							<a class="send_msg clear_a op_btn_yellow_green hov" href="personalLetterInput?targetUser.id=${id}&targetUser.name=${name}">发私信</a>
							<s:if test="%{#session.user.id!=id}">
								<span class="no_focus">
									<s:if test="%{#request.userMap[id]==null}">
										<a class="hov" id="<s:property value="id" />" onclick="focusUser(<s:property value="id" />)">取消关注</a>
									</s:if>
									<s:else>
										已关注
									</s:else>
								</span>
							</s:if>
						</div>
	
					</s:iterator>
				</div>
				
				<div>
					<span>社团</span>
					<a href="searchUser?searchText=<s:property value="#request.searchText" />&pageNum=1&club.id=<s:property value="club.id" />">更多结果</a>
				</div>
				
				<div class="cf">
					<s:iterator value="#request.searchResult.clubList">
	
						<div class="schoolBox shadow_l_3">
							<s:if test="portrait==''">
								<a href="javascript:;"><img src="<s:property value="logoPath" />" class="fl logoImg" /></a>
							</s:if>
							<s:else>
								<a href="javascript:;"><img src="upload/portrait/auto_photo.png" class="fl logoImg" /></a>
							</s:else>
							<ul class="frd_box_info">
								<li class="frd_name"><s:property value="name" /></li>
								<li><s:property value="school.name" /></li>
								<li><s:property value="briefIntroduction" /></li>
							</ul>
							<span class="send_msg clear_a op_btn_yellow_green"><s:property value="memberNumber" />人</span>
							<s:if test="%{#session.user.id!=id}">
								<span class="no_focus">
									<s:if test="%{#session.user!=null}">
										<s:if test="%{id in #request.checkListC}">
											<a id="uc_<s:property value="id" />" disabled="disabled">已关注</a>
										</s:if>
										<s:else>
											<a id="uc_<s:property value="id" />" onclick="focusClub(<s:property value="id" />)" >关注</a>
										</s:else>
									</s:if>
									<s:elseif test="%{#session.merchant!=null}">
										<s:if test="%{id in #request.checkListC}">
											<a id="mc_<s:property value="id" />" disabled="disabled">已关注</a>
										</s:if>
										<s:else>
											<a id="mc_<s:property value="id" />" onclick="merchantFocusClub(<s:property value="id" />)">关注</a>
										</s:else>
									</s:elseif>
								</span>
							</s:if>
						</div>
	
					</s:iterator>
				</div>
				
				<div>
					<span>商家</span>
					<a href="searchMerchant?searchText=<s:property value="searchText" />&pageNum=1&club.id=<s:property value="club.id" />">更多结果</a>
				</div>
				
				<div class="cf">
					<s:iterator value="#request.searchResult.merchantList">
	
						<div class="schoolBox shadow_l_3">
							<s:if test="portrait==''">
								<a href="javascript:;"><img src="<s:property value="logoPath" />" class="fl logoImg" /></a>
							</s:if>
							<s:else>
								<a href="javascript:;"><img src="upload/portrait/auto_photo.png" class="fl logoImg" /></a>
							</s:else>
							<ul class="frd_box_info">
								<li class="frd_name"><s:property value="name" /></li>
								<li><s:property value="type" /></li>
								<li><s:property value="business" /></li>
								<li><s:property value="connectorName" /></li>
								<li><s:property value="connectorPhone" /></li>
							</ul>
							<span class="send_msg clear_a op_btn_yellow_green"><s:property value="memberNumber" />人</span>
							<s:if test="%{#session.user.id!=id}">
								<span class="no_focus">
									<s:if test="%{#session.user!=null}">
										<s:if test="%{id in #request.checkListC}">
											<a id="uc_<s:property value="id" />" disabled="disabled">已关注</a>
										</s:if>
										<s:else>
											<a id="uc_<s:property value="id" />" onclick="focusClub(<s:property value="id" />)" >关注</a>
										</s:else>
									</s:if>
									<s:elseif test="%{#session.merchant!=null}">
										<s:if test="%{id in #request.checkListC}">
											<a id="mc_<s:property value="id" />" disabled="disabled">已关注</a>
										</s:if>
										<s:else>
											<a id="mc_<s:property value="id" />" onclick="merchantFocusClub(<s:property value="id" />)">关注</a>
										</s:else>
									</s:elseif>
								</span>
							</s:if>
						</div>
	
					</s:iterator>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
	function focusUser(userId) {
  		$.post("focusUser?id="+userId,
  			function(xml){
  				var aLink = $("#"+userId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function focusClub(clubId) {
  		$.post("focusClub?id="+clubId,
  			function(xml){
  				var aLink = $("#uc_"+clubId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function focusMerchant(merchantId) {
  		$.post("focusMerchant?id="+merchantId,
  			function(xml){
  				var aLink = $("#um_"+merchantId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function clubFocusClub(sourceId,clubId) {
  		$.post("clubFocusClub?id="+clubId+"&club.id="+sourceId,
  			function(xml){
  				var aLink = $("#c_"+clubId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("社团已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function clubFocusMerchant(sourceId,merchantId) {
  		$.post("clubFocusMerchant?id="+merchantId+"&club.id="+sourceId,
  			function(xml){
  				var aLink = $("#c_"+merchantId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("社团已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function merchantFocusClub(clubId) {
  		$.post("merchantFocusClub?id="+clubId,
  			function(xml){
  				var aLink = $("#mc_"+clubId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function merchantFocusMerchant(merchantId) {
  		$.post("merchantFocusMerchant?id="+merchantId,
  			function(xml){
  				var aLink = $("#mm_"+merchantId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("disabled","disabled");
  					aLink.val("已关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	</script>
</body>
</html>
