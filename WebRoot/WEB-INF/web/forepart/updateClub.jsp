<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>
<head>
<title>校江湖 - 社团</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-club.css" />

</head>

<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />

		<form action="updateClub" method="post" enctype="multipart/form-data">
			<table class="applyClubTable shadow_l_5">
				<thead>
					<tr>
						<th colspan="2">修改社团信息</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th class="pt30"><label>名称：</label>
						</th>
						<td class="pt30"><label><s:property
									value="#session.clubMember.club.name" /> </label>
						</td>
					</tr>
					<tr>
						<th><label>学校：</label>
						</th>
						<td><s:property
								value="#application.schools[#session.user.school.id].name" /></td>
					</tr>
					<tr>
						<th><label>类型：</label>
						</th>
						<td><s:select name="club.type"
								list="@com.tjxjh.enumeration.ClubType@values()" listKey="name()"
								listValue="name" value="#session.clubMember.club.type" /></td>
					</tr>
					<tr>
						<th><label>原Logo：</label>
						</th>
						<td><img src="${session.clubMember.club.logoPath}"></td>
					</tr>
					<tr>
						<th><label>新Logo：</label>
						</th>
						<td><input type="file" name="logo"></td>
					</tr>
					<tr>
						<th><label>简介：</label>
						</th>
						<td><textarea rows="5" cols="20"
								name="club.briefIntroduction">${session.clubMember.club.briefIntroduction }</textarea>
						</td>
					</tr>
					<tr>
						<th><label>详细介绍：</label>
						</th>
						<td><textarea rows="10" cols="20" name="club.introduction">${session.clubMember.club.introduction }</textarea>
						</td>
					</tr>
					<tr>
						<th></th>
						<td><input type="hidden" name="club.id"
							value="${session.clubMember.club.id }" /><input type="submit"
							class="applyClubTable_submit shadow_l_5 hov" value="提交" /></td>
					</tr>
					<tr></tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>
