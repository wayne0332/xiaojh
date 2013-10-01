<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<base href="<%=basePath%>" />

<title>校江湖 - 个人主页</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/ajax.js"></script>
</head>

<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		<div class="left_bar w270 cf mt75">
			<div class="my_info w240 h90 p5 m5 shadow_l_3 bg_box">
				<img src="<s:property value="#session.user.portraitPath"/>"
					class="fl mt5 ml10 circle_80 shadow_l_5" />
				<ul class="fl w135 p5 pl10 text_r">
					<li class="w135 text_l f14"><a href="updateUserInput"><s:property
								value="#session.user.name" />(修改信息) </a></li>
					<li><s:property value="#session.user.grade" />
					</li>
					<li><s:property value="#session.user.grade" /></li>
					<li><s:property
							value="#application.schools[#session.user.school.id].name" />
					</li>
				</ul>
			</div>
			<form action="searchAll" method="post"
				class="l_search w250 m5 shadow_l_10">
				<input name="searchText" type="text" class="w200 h30 pl5" />
				<button type="submit" class="w40 h30 fr shadow_l_5">搜索</button>
			</form>

			<label class="Clearfix w250 ml5 mt50">我的门客<a

				href="myFocus?type=0&pageNum=1" class="fr">更多</a> </label>
			<div class="l_box w240 p5 m5 cf shadow_l_10 radius_6 bg_box">
				<s:iterator value="#request.focusUserList">
					<div class="fl p5">
						<s:if test="portrait==''">
							<a href="userHome?user.id=${id}"><img
								src="<s:property value="portraitPath" />"
								class="w50 h50 Clearfix" /> </a>
						</s:if>
						<s:else>
							<a href="userHome?user.id=${id}"><img
								src="upload/portrait/auto_photo.png" class="w50 h50 Clearfix" />
							</a>
						</s:else>
						<label class="Clearfix mb5 w50"><s:property value="name" />
						</label>
					</div>
				</s:iterator>
			</div>

			<label class="Clearfix w250 ml5 mt20">关注社团 <a
				href="myFocus?type=1&pageNum=1" class="fr">更多</a> </label>
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
				href="myFocus?type=2&pageNum=1" class="fr">更多</a> </label>
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

		<div class="main w730 cf mt75">
			<!-- 发布说说-->
			<form action="addTalking" method="post" enctype="multipart/form-data"
				class="userHome_box w700 m5 p10 cf shadow_l_10 radius_6">
				<label class="userBox_title w pl10 pr10 h30">发状态</label>
				<textarea class="h100 mt10 mb5 f14 p5" name="talking.text"></textarea>
				<div class="fl w500">
					媒体链接：<input type="text" name="talking.url" /> 上传媒体：<input
						type="file" name="uploadImage" />
				</div>
				<div id="loading" class="fl mt5 none">
					文件上传中...&nbsp;&nbsp;<img src="images/loading.gif" />
				</div>
				<button type="submit" onclick="return loading();" class="fr">发布</button>
			</form>
			<!--END： 发布说说-->
			<!-- 相册-->
			<div class="userHome_box w700 m5 p10 cf shadow_l_10 radius_6">
				<label>最新相册</label>

				<jsp:include page="photoBook.jsp" />
			</div>
			<!-- END:相册-->
			<jsp:include page="userHomeTalking.jsp" />
		</div>
		<div class="clearfloat"></div>
		<div class="footer"></div>
	</div>


	<script type="text/javascript">
	
		function huifu(id,name,userid){
			var pl_t='#pl_t'+id;
			var user_id='#user_id'+id;
			$(pl_t).val("@"+name+":");
			$(user_id).val(userid);
			$(pl_t).focus();
		}
		
		function loading(){
			$("#loading").css('display','block'); 
			return true;
		}
	</script>

</body>
</html>
