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
	<!-- 商家信息 -->
	<div>
		<span>商家名称：${merchant.name}</span> <a href="focusMerchant?id=${merchant.id}">关注</a>
		<br> 商家logo:<img src="${merchant.logoPath }">
	</div>
	<!-- 商家关注 -->
	<div>
		<label>关注社团<a href="merchantFocus?type=1&pageNum=1">更多</a> </label>
		<div>
			<s:iterator value="#request.focusClubList">
				<div>
					<s:if test="logoPath==''">
						<img src="<s:property value="portraitPath" />" />
					</s:if>
					<s:else>
						<img src="upload/portrait/auto_photo.png" />
					</s:else>
					<label> <s:property value="name" /> </label>
				</div>
			</s:iterator>
		</div>
	</div>
	<div>
		<div>
			关注商家： <a href="merchantFocus?type=2&pageNum=1">更多</a>
		</div>
		<s:iterator value="#request.focusMerchantList">
			<div>
				<div></div>
				<div>
					<s:property value="name" />
				</div>
			</div>
		</s:iterator>
	</div>
	<!-- 商家新闻(预览) -->
	<table>
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
				<td><s:date name="datetime" format="yyyy-MM-dd hh:mm:ss" />
				</td>
				<td><s:a href="deleteMerchantNews?merchantNews.id=%{id}">删除</s:a>
				</td>
			</tr>
		</s:iterator>
	</table>

	<!-- 活动列表,从merchant拿过来的,貌似布局不同,我就把样式去掉了,如果一样那你直接从那粘吧(注意这里比那边的少了最后那个li,就是有javascript调用的那行分享和赞这里不要了) -->
	<div>
		<s:iterator value="acs" id="ac">
			<div>
				<h2>
					<a href="activity?activity.id=${id}"><s:property value="tittle" /> </a>
				</h2>
				<div>
					<img src="${titleImgPath}" />
				</div>
				<ul>
					<li><label>组织单位：</label>${organizer}</li>
					<li><label>主办单位：</label>${club.name}${merchant.name}</li>
					<li><label>发布时间：</label>${datetime}</li>
					<li><label>资金预算：</label>${budget}元</li>
					<li><label>举办地点：</label>${place}</li>
					<li><label>活动状态： </label> <s:property value="status.name" />
					</li>

					<li><label>活动热度：</label>${heat}</li>
					<li><label>分享次数：</label>${talking.shareDetails.shareCount}</li>
				</ul>
			</div>
		</s:iterator>
		<br> <a href="activitys?merchant.id=${merchant.id}">更多活动</a>
	</div>
</body>
</html>
