<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'applyMerchant.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="js/userMsg.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		checkUserName("input[name='merchant.name']", "#nameMsg", "商家");
		checkEmail("input[name='merchant.connectorEmail']", "#merchantEmail");
	});
</script>

</head>

<body>
	<form action="applyMerchant" method="post"
		enctype="multipart/form-data">
		<table>
			<tr>
				<td>用户名:</td>
				<td><input type="text" name="merchant.name"><label
					id="nameMsg" style="display:none;color:red;"></label></td>
			</tr>
			<tr>
				<td>商家名:</td>
				<td><input type="text" name="merchant.merchantName"></td>
			</tr>
			<tr>
				<td>密码:</td>
				<td><input type="password" name="merchant.password"></td>
			</tr>
			<tr>
				<td>类型:</td>
				<td><s:select name="merchant.type"
						list="@com.tjxjh.enumeration.MerchantType@values()"
						listKey="name()" listValue="name" /></td>
			</tr>
			<tr>
				<td>行业:</td>
				<td><s:select name="merchant.business"
						list="@com.tjxjh.enumeration.MerchantBusiness@values()"
						listKey="name()" listValue="name" /></td>
			</tr>
			<tr>
				<td>合作意向:</td>
				<td><s:checkboxlist name="purpose"
						list="@com.tjxjh.util.MerchantPurposeUtil@purposesMap" />
				</td>
			</tr>
			<tr>
				<td>地址:</td>
				<td><input type="text" name="merchant.address"></td>
			</tr>
			<tr>
				<td>电话:</td>
				<td><input type="text" name="merchant.phone"></td>
			</tr>
			<tr>
				<td>联系人姓名:</td>
				<td><input type="text" name="merchant.connectorName"></td>
			</tr>
			<tr>
				<td>联系人电话:</td>
				<td><input type="text" name="merchant.connectorPhone">
				</td>
			</tr>
			<tr>
				<td>联系人QQ:</td>
				<td><input type="text" name="merchant.connectorQq"></td>
			</tr>
			<tr>
				<td>联系人邮箱:</td>
				<td><input type="text" name="merchant.connectorEmail"><label
					id="merchantEmail" style="display:none;color:red;"></label></td>
			</tr>
			<tr>
				<td>Logo:</td>
				<td><input type="file" name="logo">
				</td>
			</tr>
		</table>
		<input type="submit" value="提交">
	</form>
</body>
</html>
