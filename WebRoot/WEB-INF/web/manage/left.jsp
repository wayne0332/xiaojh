<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
<title>My JSP 'left.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<script src="js/prototype.lite.js" type="text/javascript"></script>
<script src="js/moo.fx.js" type="text/javascript"></script>
<script src="js/moo.fx.pack.js" type="text/javascript"></script>
<style>
body {
	font: 12px Arial, Helvetica, sans-serif;
	color: #000;
	background-color: #EEF2FB;
	margin: 0px;
}

#container {
	width: 182px;
}

H1 {
	font-size: 12px;
	margin: 0px;
	width: 182px;
	cursor: pointer;
	height: 30px;
	line-height: 20px;
}

H1 a {
	display: block;
	width: 182px;
	color: #000;
	height: 30px;
	text-decoration: none;
	moz-outline-style: none;
	background-image: url(images/menu_bgS.gif);
	background-repeat: no-repeat;
	line-height: 30px;
	text-align: center;
	margin: 0px;
	padding: 0px;
}

.content {
	width: 182px;
	height: 26px;
}

.MM ul {
	list-style-type: none;
	margin: 0px;
	padding: 0px;
	display: block;
}

.MM li {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 26px;
	color: #333333;
	list-style-type: none;
	display: block;
	text-decoration: none;
	height: 26px;
	width: 182px;
	padding-left: 0px;
}

.MM {
	width: 182px;
	margin: 0px;
	padding: 0px;
	left: 0px;
	top: 0px;
	right: 0px;
	bottom: 0px;
	clip: rect(0px, 0px, 0px, 0px);
}

.MM a:link {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 26px;
	color: #333333;
	background-image: url(images/menu_bg1.gif);
	background-repeat: no-repeat;
	height: 26px;
	width: 182px;
	display: block;
	text-align: center;
	margin: 0px;
	padding: 0px;
	overflow: hidden;
	text-decoration: none;
}

.MM a:visited {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 26px;
	color: #333333;
	background-image: url(images/menu_bg1.gif);
	background-repeat: no-repeat;
	display: block;
	text-align: center;
	margin: 0px;
	padding: 0px;
	height: 26px;
	width: 182px;
	text-decoration: none;
}

.MM a:active {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 26px;
	color: #333333;
	background-image: url(images/menu_bg1.gif);
	background-repeat: no-repeat;
	height: 26px;
	width: 182px;
	display: block;
	text-align: center;
	margin: 0px;
	padding: 0px;
	overflow: hidden;
	text-decoration: none;
}

.MM a:hover {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 26px;
	font-weight: bold;
	color: #006600;
	background-image: url(images/menu_bg2.gif);
	background-repeat: no-repeat;
	text-align: center;
	display: block;
	margin: 0px;
	padding: 0px;
	height: 26px;
	width: 182px;
	text-decoration: none;
}
</style>
</head>
<body>
	<table width="100%" height="280" border="0" cellpadding="0"
		cellspacing="0" bgcolor="#EEF2FB">
		<tr>
			<td width="182" valign="top"><div id="container">
					<h1 class="type">
						<a href="javascript:void(0)">网站常规管理</a>
					</h1>
					<div class="content">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><img src="images/menu_topline.gif" width="182"
									height="5" />
								</td>
							</tr>
						</table>
						<ul class="MM">
							<li><a href="allUser?pageNum=1" target="main">用户账号管理</a>
							</li>
							<li><a href="allClub?pageNum=1" target="main">社团账号管理</a>
							</li>
							<li><a href="allMerchant?pageNum=1" target="main">商家账号管理</a>
							</li>
							<li><a href="allKeyword" target="main">关键字管理</a>
							</li>
							<li><a href="publicAnnouncements" target="main">系统通告</a>
							</li>
						</ul>
					</div>
					<h1 class="type">
						<a href="javascript:void(0)">社团管理</a>
					</h1>
					<div class="content">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><img src="images/menu_topline.gif" width="182"
									height="5" />
								</td>
							</tr>
						</table>
						<ul class="MM">
							<li><a href="allClubPost?pageNum=1" target="main">社团帖子总览</a>
							</li>
							<li><a href="allClubNews?pageNum=1" target="main">社团新闻总览</a>
							</li>
						</ul>

					</div>
					<h1 class="type">
						<a href="javascript:void(0)">活动管理</a>
					</h1>
					<div class="content">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><img src="images/menu_topline.gif" width="182"
									height="5" />
								</td>
							</tr>
						</table>
						<ul class="MM">
							<li><a href="allActivityPost?pageNum=1" target="main">线上活动帖子总览</a>
							</li>
							<li><a href="adminActivitys?pageNum=1&flage=0" target="main">活动总览</a>
							</li>
							<li><a href="adminActivitys?pageNum=1&flage=1" target="main">正在申请的活动</a>
							</li>
							<li><a href="adminActivitys?pageNum=1&flage=2" target="main">通过审核的活动</a>
							</li>
							<li><a href="adminActivitys?pageNum=1&flage=3" target="main">已经拒绝的活动</a>
							</li>
						</ul>
					</div>
				</div> <script type="text/javascript">
					var contents = document.getElementsByClassName('content');
					var toggles = document.getElementsByClassName('type');

					var myAccordion = new fx.Accordion(toggles, contents, {
						opacity : true,
						duration : 400
					});
					myAccordion.showThisHideOpen(contents[0]);
				</script></td>
		</tr>
	</table>
</body>
</html>
