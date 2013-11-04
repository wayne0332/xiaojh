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
		
		<form action="updateUser" method="post" enctype="multipart/form-data">
			<table class="applyClubTable shadow_l_5">
				<thead>
					<tr>
						<th colspan="2">修改个人信息</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th class=""><label>昵称：</label>
						</th>
						<td class=""><label><s:property value="#session.user.name" /></label>
						</td>
					</tr>
					<tr>
						<th><label></label></th>
						<td><a href="changeUserPasswordInput">修改密码</a></td>
					</tr>
					<tr>
						<th><label>学校：</label></th>
						<td><label><s:property value="#application.schools[#session.user.school.id].name" /></label></td>
					</tr>
					<tr>
						<th><label>邮箱：</label></th>
						<td><label><s:property value="#session.user.email" /></label></td>
					</tr>
					<tr>
						<th><label>性别：</label></th>
						<td><label><s:property value="#session.user.sex.name" /></label></td>
					</tr>
					<tr style="border-bottom:1px solid #ddd;">
						<th><label>年级：</label></th>
						<td><label><s:property value="#session.user.grade" /></label></td>
					</tr>
					<tr>
						<th><label>真实姓名：</label></th>
						<td><label><s:textfield type="text" name="user.realName" value="%{#session.user.realName}" /></label></td>
					</tr>
					<tr>
						<th><label>学院：</label></th>
						<td><label><s:textfield type="text" name="user.profession" value="%{#session.user.profession}" /></label></td>
					</tr>
					<tr>
						<th><label>专业：</label></th>
						<td><label><s:textfield type="text" name="user.subject" value="%{#session.user.subject}" /></label></td>
					</tr>
					<tr>
						<th><label>生日：</label></th>
						<td><label><input type="text" name="user.birthday" onFocus="WdatePicker({isShowClear:false,readOnly:true})" class="Wdate" onClick="WdatePicker()" value="<s:date name="#session.user.birthday" format="yyyy-MM-dd"/>" /></td>
					</tr>
					<tr>
						<th><label>手机：</label></th>
						<td><label><s:textfield type="text" name="user.phone" value="%{#session.user.phone}" /></td>
					</tr>
					<tr>
						<th><label>QQ：</label></th>
						<td><label><s:textfield type="text" name="user.qq" value="%{#session.user.qq}" /></td>
					</tr>
					<tr>
						<th><label>头像：</label>
						</th>
						<td><img src="<s:property value="#session.user.portraitPath"/>"></td>
					</tr>
					<tr>
						<th><label>新头像：</label>
						</th>
						<td><input type="file" name="portrait"></td>
					</tr>
					<tr>
						<th></th>
						<td>
							<s:hidden name="user.id" value="%{#session.user.id}" />
							<input type="submit" class="applyClubTable_submit shadow_l_5 hov" value="提交">
						</td>
					</tr>
					<tr></tr>
				</tbody>
			</table>
		</form>
	</div>

	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>
