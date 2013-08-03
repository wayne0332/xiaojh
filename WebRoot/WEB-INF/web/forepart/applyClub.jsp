<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'applyClub.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
<script type="text/javascript">
	var clubName = "";
	$(document)
			.ready(
					function() {
						clubName = $("input[name='club.name']").val();
						$("input[name='club.name']")
								.blur(
										function() {
											if ($(this).val() != clubName
													&& $(this).val() != "") {
												$
														.post(
																"hadRegister?name=<s:property
						value="#session.user.school.id" />_"
																		+ $(
																				this)
																				.val(),
																function(json) {
																	if (json.hadRegister) {
																		$(
																				"label")
																				.html(
																						"社团已存在");
																		$(
																				"label")
																				.css(
																						"display",
																						"inline");
																	} else {
																		$(
																				"label")
																				.css(
																						"display",
																						"none");
																	}
																});
											} else {
												if (clubName != ""
														&& $(this).val() == clubName) {
													$("label").css("display",
															"none");
												} else {
													$("label").html("请输入社团名");
													$("label").css("display",
															"inline");
												}
											}
										});
					});
</script>

</head>

<body>
	<jsp:include page="head.jsp" />
	<form action="applyClub" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>名称:</td>
				<td><input type="text" name="club.name"><label
					style="display:none;color:red;"></label></td>
			</tr>
			<tr>
				<td>学校:</td>
				<td><s:property
						value="#application.schools[#session.user.school.id].name" /> <s:hidden
						name="club.school.id" value="%{#session.user.school.id}" /></td>
			</tr>
			<tr>
				<td>类型:</td>
				<td><s:select name="club.type"
						list="@com.tjxjh.enumeration.ClubType@values()" listKey="name()"
						listValue="name" /></td>
			</tr>
			<tr>
				<td>Logo:</td>
				<td><input type="file" name="logo"></td>
			</tr>
			<tr>
				<td>简介:</td>
				<td><textarea rows="5" cols="20" name="club.briefIntroduction"></textarea>
				</td>
			</tr>
			<tr>
				<td>详细介绍:</td>
				<td><textarea rows="10" cols="20" name="club.introduction"></textarea>
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="提交"></td>
			</tr>
		</table>
	</form>
</body>
</html>
