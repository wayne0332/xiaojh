<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/webSupportTag" prefix="w" %>
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

<title>校江湖 </title>

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

					<li><s:property value="#session.user.grade % 2000" />级</li>
					<li><s:property
							value="#application.schools[#session.user.school.id].name" /></li>
					<!-- <li>凤凰社</li> -->
				</ul>
			</div>
		</div>

		<div class="main cf mt75">
			<div class="friendList cf">
				<!-- 
				<s:property value="#request.focusList" />
				<s:property value="type" /> -->

				<s:if test="type==0">
					<form action="searchAll" method="post" class="cf frd_form shadow_l_3">
						<input name="searchText" type="text" class="frd_inputText" /> <input class="frd_submit hov" type="submit"
							value="找" />
					</form>
					<s:iterator value="#request.focusList.userList">

						<div class="friendBox shadow_l_3 school_${school.id }">
							<s:if test="portrait==''">
								<a href="userHome?user.id=${id}"><img src="images/head/head1.jpg" class="fl logoImg" /> </a>
							</s:if>
							<s:else>
								<a href="userHome?user.id=${id}"><img src="images/head/head1.jpg" class="fl logoImg" /> </a>
							</s:else>
							<ul class="frd_box_info">
								<li class="frd_name"><s:property value="name" /></li>
								<li><s:property value="school.name" /></li>
								<li><s:property value="grade" /></li>
							</ul>
							<a class="send_msg clear_a op_btn_yellow_green hov" href="personalLetterInput?targetUser.id=${id }&targetUser.name=${name}">发私信</a>
							<span class="no_focus">
								<a class="hov" id="<s:property value="id" />" onclick="cancelFocus(<s:property value="id" />,0)">取消关注</a>
							</span>
						</div>
						
					</s:iterator>
				</s:if>
				<s:elseif test="type==1">
					<s:iterator value="#request.focusList.clubList">
					
						<div class="schoolBox shadow_l_3 school_${school.id }">
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
							<span class="no_focus">
								<a class="hov" id="<s:property value="id" />" onclick="cancelFocus(<s:property value="id" />,1)">取消关注</a>
							</span>
						</div>
						
					</s:iterator>
				</s:elseif>
				<s:elseif test="type==2">
					<s:iterator value="#request.focusList.merchantList">
					
						<div class="schoolBox shadow_l_3">
							<s:if test="portrait==''">
								<a href="javascript:;"><img src="images/head/head1.jpg" class="fl logoImg" /></a>
							</s:if>
							<s:else>
								<a href="javascript:;"><img src="images/head/head1.jpg" class="fl logoImg" /></a>
							</s:else>
							<ul class="frd_box_info">
								<li class="frd_name"><s:property value="name" /></li>
								<li><s:property value="type" /></li>
								<li><s:property value="business" /></li>
								<li><s:property value="connectorName" /></li>
								<li><s:property value="connectorPhone" /></li>
							</ul>
							<span class="send_msg clear_a op_btn_yellow_green">人气：<s:property value="popularity" /></span>
							<span class="no_focus">
								<a class="hov" id="<s:property value="id" />" onclick="cancelFocus(<s:property value="id" />,2)">取消关注</a>
							</span>
						</div>
						
					</s:iterator>

				</s:elseif>
				<div>
					<%-- <span><a
						href="myFocus?type=<s:property value="type" />&pageNum=<s:property value="#request.focusList.page.currentPage-1" />">上一页</a>
					</span>&nbsp; <span><a
						href="myFocus?type=<s:property value="type" />&pageNum=<s:property value="#request.focusList.page.currentPage+1" />">下一页</a>
					</span> <span>共 <s:property
							value="#request.focusList.page.pageNumber" />页</span> --%>
					<w:page url="myFocus?type=%{type}" useSingleProperty="false" pageNumberPropertyName="pageNum" value="#request.focusList.page" />
				</div>
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
