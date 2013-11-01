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
	<table class="商家新闻">
		<tr>
			<td>标题</td>
			<td>时间</td>
			<td>操作</td>
		</tr>
		<s:iterator value="#request.merchantNews" status="status">
			<tr>
				<td><s:a href="merchantNewsDetails?merchantNews.id=%{id}">
						<s:property value="tittle" />
					</s:a>
				</td>
				<td><s:date name="datetime" format="yyyy-MM-dd hh:mm:ss" /></td>
				<td>
				</td>
			</tr>
		</s:iterator>
	</table>
	商家活动<br>
	<s:iterator value="acs" id="ac">
				<div
					class="myActivity_box w700 mt15 ml5 p10 cf fl shadow_l_3 bg_fff">
					<h2 class="w335 fr">
						<a href="activity?activity.id=${id}" class="f16 a_no"><s:property
								value="tittle" /> </a>
					</h2>
					<div class="myActivity_img w335 fl">
						<img src="${titleImgPath}" class="w335 fl" />
					</div>
					<ul class="w335 fr mt10">
						<li><label>组织单位：</label>${organizer}</li>
						<li><label>主办单位：</label>${club.name}${merchant.name}</li>
						<li><label>发布时间：</label>${datetime}</li>
						<li><label>资金预算：</label>${budget}元</li>
						<li><label>举办地点：</label>${place}</li>
						<li><label>活动状态： </label>
						<s:property value="status.name" />
						</li>
						<li><label>参与人数：</label>${participantCount}</li>
						<li><label>活动热度：</label>${heat}</li>
						<li><label>分享次数：</label>${talking.shareDetails.shareCount}</li>
						<li class="fr"><a
							href="/preShareTalking?talking.id=${talking.id}">分享</a>
							<span id="zan${talking.id}"> <a href="javascript:void(0);"
								onclick="zanTalking(${talking.id});">赞(${talking.shareDetails.praiseCount})</a>
						</span><a href="#">我要参与</a></li>
					</ul>
				</div>
			</s:iterator>
			<ul class="w300 fl mt20">
				<li class="w60 fr">共${page.pageNumber}页</li>
				<li class="w60 fr">当前第${page.currentPage}页</li>
				<li class="w60 fl"><a
					href="/${actionName}?condition=${condition}&currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}&club.id=${club.id}&merchant.id=${merchant.id}"
					target="_self">上一页</a>
				</li>
				<li class="w60 fl"><a
					href="/${actionName}?condition=${condition}&currentPage=${page.currentPage+1}&totalPageNumber=${page.pageNumber}&club.id=${club.id}&merchant.id=${merchant.id}"
					target="_self">下一页</a></li>
			</ul>
</body>
</html>
