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
    
    <title>My JSP 'myFocusClub.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
	<script type="text/javascript">
	function focusUser(userId) {
  		$.post("focusUser?userId="+userId,
  			function(xml){
  				var aLink = $("#"+userId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("onclick","cancelFocus("+userId+")");
  					aLink.val("取消关注");
  				}else{
  					alert("关注失败，请稍后再试。");
  				}
  			}
  		, "xml");
	};
	function cancelFocus(userId) {
  		$.post("cancelFocus?userId="+userId,
  			function(xml){
  				var aLink = $("#"+userId);
  				if ($(xml).find("isSuccess").text()=="1") {
  					aLink.attr("onclick","focusUser("+userId+")");
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
					<a href="receivedLetters">飞鸽传书(<s:property value="#session.user.receiveLetterCount" />)</a>
				</span>
			</div>
			<div class="clearfloat"></div>
			<div class="main">
				<div class="left">
					<div class="list">
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
		    					<s:if test="%{#request.userMap[id]==null}">
		    						<input id="<s:property value="id" />" type="button" value="关注" onclick="focusUser(<s:property value="id" />)"/>
		    					</s:if>
		    					<s:else>
		    						<input id="<s:property value="id" />" type="button" value="取消关注" onclick="cancelFocus(<s:property value="id" />)" />
		    					</s:else>
	    					</div>
						</s:iterator>
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
