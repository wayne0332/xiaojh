<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>校江湖 - 社团</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

</head>

<body>

	<div class="container cf zoom">
		<jsp:include page="head.jsp" />

		<div class="left_bar mt75">
			<div class="my_info w240 h90 p5 m5 shadow_l_3 bg_box">
				<img src="<s:property value="#session.user.portraitPath"/>"
					class="fl mt5 ml10 circle_80 shadow_l_5" />
				<ul class="fl w135 p5 pl10 text_r">
					<li class="w135 text_l f14"><a href="updateUserInput"><s:property
								value="#session.user.name" /> </a></li>
					<li><s:property value="#session.user.grade" />
					</li>
					<li><s:property
							value="#application.schools[#session.user.school.id].name" />
					</li>
				</ul>
			</div>
			<div class="w240 h300 p5 m5 shadow_l_3 bg_box cf">
				<div class="mt30 ml5">
					按热度排序：<a href="myClubs">查看</a>
				</div>
				<div class="club_category cf ml5">
					<span>按类型查看：</span><br />
					<s:iterator value="@com.tjxjh.enumeration.ClubType@values()"
						id="ac">
						<a class="shadow_l_5"
							href="myClubs?clubType=<s:property value="name()"/>">${name}</a>
					</s:iterator>
				</div>
			</div>
		</div>

		<div class="main mt75">
			<div class="cf">
				<a href="applyClubInput"
					class="single_bt1 w100 mt5 ml5 mb5 fl shadow_l_3">申请社团</a>
				<s:if
					test="#request.clubInviteCount != null && #request.clubInviteCount != 0">
					<a href="myInvited" class=""> 我的邀请(<s:property
							value="#request.clubInviteCount" />) </a>
				</s:if>
			</div>
			<div class="bg_fff shadow_l_5 ml5 mr10 mt30">
				<table class="w">
					<thead class="clubList_thead">
						<tr>
							<th>Logo</th>
							<th>社团名字</th>
							<th>身份</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody class="clubList_tbody">
						<s:iterator value="#request.myClubs">
							<tr>
								<td class="tl"><img src="${club.logoPath}" class="" />
								</td>
								<td><s:property value="club.name" />
								</td>
								<td><s:property value="role.name" /> <s:if
										test="status.name() == 'NO_CHECK'">(<s:property
											value="status.name" />)</s:if>
								</td>
								<td><s:a href="clubMain?club.id=%{club.id}">进入社团</s:a>
								</td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</div>
			<wst:page url="myClubs" />
			<s:if test="#request.myNoCheckClubs.size != 0">
			<div>
				<label>未审核社团(可以做我的社团和未审核社团的切换按钮和效果)</label>
				<table class="w">
					<thead class="clubList_thead">
						<tr>
							<th>Logo</th>
							<th>社团名字</th>
						</tr>
					</thead>
					<tbody class="clubList_tbody">
						<s:iterator value="#request.myNoCheckClubs">
							<tr>
								<td class="tl"><img src="${logoPath}" class="" />
								</td>
								<td><s:property value="name" />
								</td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</div>
		</s:if>
		</div>
	</div>
</body>
</html>
