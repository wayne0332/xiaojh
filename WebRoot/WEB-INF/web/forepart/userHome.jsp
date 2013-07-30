<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'userHome.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
body {
	margin: 0 auto;
	padding: 0 0;
}

.header span {
	float: right;
}

.clearfloat {
	clear: both
}

.container {
	margin: 0 auto;
	padding: 0 0;
	width: 920px;
}

.main {
	
}

.header {
	
}

.left {
	float: left;
	width: 250px;
}

.right {
	float: right;
	width: 650px;
}

.people {
	width: 140px;
	margin-top: 20px;
	margin-bottom: 20px;
}

.club {
	width: 140px;
	margin-top: 20px;
	margin-bottom: 20px;
}

.merchant {
	width: 140px;
	margin-top: 20px;
	margin-bottom: 20px;
}

.portrait {
	width: 44px;
	float: left;
	margin-top: 20px;
}

.portraitImg {
	padding-top: 5px;
}
</style>
</head>

<body>
	<div class="container">
		<div class="header">
			<span> <a href="registerInput">注册</a>&nbsp;&nbsp;<a
				href="logout">登出</a> </span> <span><a href="myAnnouncements">通知(<s:property value="#session.user.announcementCount"/>)</a> <a href="receivedLetters">飞鸽传书(<s:property
						value="#session.user.receiveLetterCount" />)</a>&nbsp;&nbsp;<a
				href="myClubs">我的社团</a>
			<s:if test="#request.clubInviteCount != 0">
					<a href="myInvited">(<s:property value="#request.clubInviteCount" />)</a>
				</s:if>&nbsp;&nbsp;</span>
		</div>
		<div class="clearfloat"></div>
		<div class="main">
			<div class="left">
				<div class="userInfo">
					<img height="100px" width="80px" alt="头像" title="头像"
						src="showImg?img=<s:property value="#session.user.portraitPath"/>">
					姓名: <a href="updateUserInput"><s:property
							value="#session.user.name" /> </a> <br> 年级:
					<s:property value="#session.user.grade" />
					<br> 学校:
					<s:property
						value="#application.schools[#session.user.school.id].name" />
					<br>
				</div>
				<div class="clearfloat"></div>
				<div class="people">
					<form action="searchAll" method="post">
						<input name="searchText" type="text" /> <input type="submit"
							value="搜索" />
					</form>
				</div>
				<div class="clearfloat"></div>
				<div class="people">
					<div>
						我的门客：<a href="myFocus?type=0">更多</a>
					</div>
					<s:iterator value="#request.focusUserList">
						<div class="portrait">
							<div class="portraitImg">
								<s:if test="portrait==''">
									<img src="<s:property value="portraitPath" />" width="40px" />
								</s:if>
								<s:else>
									<img src="upload/portrait/auto_photo.png" width="40px" />
								</s:else>
							</div>
							<div class="userName">
								<s:property value="name" />
							</div>
						</div>
					</s:iterator>
					<div class="clearfloat"></div>
				</div>
				<div class="clearfloat"></div>
				<div class="club">
					<div>
						我的社团： <a href="myFocus?type=1">更多</a>
					</div>
					<s:iterator value="#request.focusClubList">
						<div class="portrait">
							<div class="portraitImg">
								<s:if test="logoPath==''">
									<img src="<s:property value="portraitPath" />" width="40px" />
								</s:if>
								<s:else>
									<img src="upload/portrait/auto_photo.png" width="40px" />
								</s:else>
							</div>
							<div class="userName">
								<s:property value="name" />
							</div>
						</div>
					</s:iterator>
					<div class="clearfloat"></div>
				</div>
				<div class="clearfloat"></div>
				<div class="merchant">
					<div>
						关注商家： <a href="myFocus?type=2">更多</a>
					</div>
					<s:iterator value="#request.focusMerchantList">
						<div class="portrait">
							<div class="portraitImg">
								<%-- <s:if test="portrait==''">
									<img src="<s:property value="portraitPath" />" width="40px" />
								</s:if>
								<s:else>
									<img src="upload/portrait/auto_photo.png" width="40px" />
								</s:else> --%>
							</div>
							<div class="userName">
								<s:property value="name" />
							</div>
						</div>
					</s:iterator>
					<div class="clearfloat"></div>
				</div>
				<div class="clearfloat"></div>
			</div>
			<div class="right">
				<!-- 发布说说-->
				<div class="talk" style="background:#EEE;padding:20px;">
					<form action="addTalking" method="post"
						enctype="multipart/form-data">
						说说内容：<br>
						<textarea name="talking.text" cols="70" rows="5"></textarea>
						<br> 媒体链接:<input type="text" name="talking.url" /><br>
						图片:<input type="file" name="uploadImage" /><br> <br> <input
							type="submit" value="发表" />
					</form>
				</div>
				<!--END： 发布说说-->
				<!-- 相册-->
				<div class="photo" style="background:#ffffdd;padding:20px;">
					<s:iterator value="pics">
						<span style="display: inline-block;"> <a
							href="<%=path%><s:property  value="path.replace('st_', '')" />"
							target="_blank"><img src="<%=path%>/${path}" width="190px">
						</a> <br> ${name}&nbsp; From:<a href="#">${user.name}</a> </span>
					</s:iterator>
					<br> <a href="<%=path%>/findAllPicture" target="_self">更多</a>
				</div>
				<!-- END:相册-->
				<!-- 说说 -->
				<div class="talking" style="background:#ddffdd;padding:20px;">
					<s:iterator value="taks" id="tak">
						<div
							style="display: inline-block; border:1px solid;width:80%;margin:20px;"
							id="${id}">
							<s:if test="talking==null">
								<s:property value="text" />
								<br>
								<s:if
									test="url!=null&&!url.trim().equals('')&&urlType.toString()=='PICTURE'">
									<img src="${url}" />
								</s:if>
								<!-- 说说 -->
								<s:elseif
									test="url!=null&&!url.trim().equals('')&&urlType.toString()=='VIDEO'">
								     			${url}
										     </s:elseif>
							</s:if>
							<s:elseif test="talking!=null">
								      	分享：<s:property value="text" />
								<br>
								<div
									style="background:#dddddd; border:1px; width:80%;margin:0 auto;">
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
									<br>来自：${talking.user.name}
								</div>
							</s:elseif>
							<br>${datetime}
							<s:if test="shareDetails!=null">
							     			&nbsp;分享次数：${shareDetails.shareCount}
							     </s:if>
							<s:else>
							     			&nbsp;分享次数：${talking.shareDetails.shareCount}
							     </s:else>
							&nbsp;来自:${user.name} &nbsp;<a
								href="<%=path %>/preShareTalking?talking.id=${id}">分享</a> &nbsp;
							<span id="zan${id}"> <s:if test="shareDetails!=null">
									<a href="javascript:void(0);" onclick="zanTalking(${id});">赞(${shareDetails.praiseCount})</a>
								</s:if> <s:else>
									<a href="javascript:void(0);" onclick="zanTalking(${id});">赞(${talking.shareDetails.praiseCount})</a>
								</s:else> </span>
						</div>
					</s:iterator>
					<br> <a href="<%=path%>/allTalking" target="_self">更多</a>&nbsp;
				</div>
				<!-- END：说说 -->
			</div>
		</div>
		<div class="clearfloat"></div>
		<div class="footer"></div>
	</div>
</body>
</html>
