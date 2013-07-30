<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'myFocus.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
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
	<style type="text/css">
		body{margin:0 auto;padding:0 0;}
		.header span{float:right;}
		.clearfloat{clear:both}
		.container{margin:0 auto;padding:0 0;width:920px;}
		.main{}
		.header{}
		.left{float:left; width:620px;}
		.list{float:left; width:610px;}
		.right{float:right; width:270px;}
		.portrait_big{width:60px;float:left;}
		.userItem{width:540px;}
		.infoItem{margin-top:5px;width:200px;}
	</style>
  </head>
	<body>
		<div class="container">
			<div class="header">
				<span>
					<a href="registerInput">注册</a>&nbsp;&nbsp;<a href="logout">登出</a>
				</span>
				<span>
					<a href="receivedLetters">飞鸽传书(<s:property
							value="#session.user.receiveLetterCount" />)</a>
				</span>
			</div>
			<div class="clearfloat"></div>
			<div class="main">
				<div class="left">
					<div class="list">
						<s:property value="#request.focusList" />
						<s:property value="type" />
						
						<s:if test="type==0">
						<s:iterator value="#request.focusList">
							<div class="listItem">
							<div class="portrait_big">
									<s:if test="portrait==''">
										<img src="<s:property value="portraitPath" />" width="40px" />
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
										<s:property value="sex" />
									</div>
									<div>
										<s:property value="school.name" />
									</div>
									<div>
										<s:property value="profession" />
									</div>
									<div>
										<s:property value="grade" />
									</div>
									<div>
										<s:property value="signature" />
									</div>
								</div>
								<input id="<s:property value="id" />" type="button" value="取消关注" onclick="cancelFocus(<s:property value="id" />,0)" />
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
								<input id="<s:property value="id" />" type="button" value="取消关注" onclick="cancelFocus(<s:property value="id" />,1)" />
	    					</div>
	    				</s:iterator>
						</s:elseif>
						<s:elseif test="type==2">
						<s:iterator value="#request.focusList">
							<div class="listItem">
							<div class="portrait_big">
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
								<input id="<s:property value="id" />" type="button" value="取消关注" onclick="cancelFocus(<s:property value="id" />,2)" />
	    					</div>
	    				</s:iterator>
						</s:elseif>
					</div>
				</div>
				<div class="right">
				</div>
			</div>
			<div class="clearfloat"></div>
			<div class="footer">
			</div>
		</div>
	</body>
</html>
