<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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

		<form action="applyClub" method="post" enctype="multipart/form-data">
			<table class="applyClubTable shadow_l_5">
				<thead>
					<tr>
						<th colspan="2">申请社团</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th class="pt30"><label>名称：</label></th>
						<td class="pt30"><input type="text" name="club.name"
							class="applyClubTable_text" /><label class="alertLabel none"></label>
						</td>
					</tr>
					<tr>
						<th><label>学校：</label></th>
						<td><s:property
								value="#application.schools[#session.user.school.id].name" /> <s:hidden
								name="club.school.id" value="%{#session.user.school.id}" />
						</td>
					</tr>
					<tr>
						<th><label>类型：</label></th>
						<td><s:select name="club.type"
								list="@com.tjxjh.enumeration.ClubType@values()" listKey="name()"
								listValue="name" />
						</td>
					</tr>
					<tr>
						<th><label>Logo：</label></th>
						<td><input type="file" name="logo">
						</td>
					</tr>
					<tr>
						<th><label>简介：</label></th>
						<td><textarea rows="5" cols="20"
								name="club.briefIntroduction"></textarea>
						</td>
					</tr>
					<tr>
						<th><label>详细介绍：</label></th>
						<td><textarea rows="10" cols="20" name="club.introduction"></textarea>
						</td>
					</tr>
					<tr>
						<th></th>
						<td><button type="submit"
								class="applyClubTable_submit shadow_l_5 hov">提交</button>
						</td>
					</tr>
					<tr></tr>
				</tbody>
			</table>
		</form>
	</div>

	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
		var clubName = "
							";
		$(document).ready(
				function() {
					clubName=$(
							"input[name='club.name'
							]").val();
					$("input[name='club.name'
							]").blur(
							function() {
								if ($(this).val() !=clubName
							&& $(this).val() !=""
							) {
									$.post(
											"hadRegister?name=<s:property
						value="#session.user.school.id" />
							_"
													+ $(this).val(), function(
													json) {
												if (json.hadRegister) {
													$("label").html("社团已存在");
													$("label").css("display",
															"inline");
												} else {
													$("label").css("display",
															"none");
												}
											});
								} else {
									if (clubName !=""
							&& $(this).val() ==clubName){$("label").css("display", "none");
									} else {
										$("label").html("请输入社团名");
										$("label").css("display", "inline");
									}
								}
							});
				});
	</script>
</body>
</html>
