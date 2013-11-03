<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>
<head>

<title>校江湖</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-club.css" />

</head>

<body>

	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		
		<form action="sendLetter" method="post" enctype="multipart/form-data">
			<table class="applyClubTable shadow_l_5">
				<thead>
					<tr><th colspan="2">发私信</th></tr>
				</thead>
				<tbody>
					<tr>
						<th class=""><label>收件人：</label> </th>
						<td class=""><label><s:property value="targetUser.name" /></label></td>
					</tr>
					<tr>
						<th><label>发件人：</label></th>
						<td><label><s:property value="#session.user.name" /></label></td>
					</tr>
					<tr>
						<th><label>内容：</label></th>
						<td><textarea rows="10" cols="30" name="letter.text"></textarea></td>
					</tr>
					<tr>
						<th></th>
						<td>
							<s:hidden name="letter.userByTargetUserId.id" value="%{targetUser.id}" />
							<s:hidden name="letter.userBySourceUserId.id" value="%{#session.user.id}" />
							<input type="hidden" name="letter.title">
							<input type="submit" class="applyClubTable_submit shadow_l_5 hov" value="发送">
						</td>
					</tr>
					<tr></tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>
