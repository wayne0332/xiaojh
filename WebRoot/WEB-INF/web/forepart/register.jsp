<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="wst" uri="/webSupportTag"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>校江湖 - 注册</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

</head>

<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		<div class="mt100">
			<input type="radio" name="registerType" value="user" class="userRadio"
				checked="checked" />普通用户 <input type="radio" name="registerType"
				value="merchant" class="merchantRadio" />商家用户

		</div>
		<div id="user" class="shadow_l_5 signinPanel">
			<wst:parameter value="msg" />
			<form action="register" method="post" enctype="multipart/form-data">
				<ul>
					<li><span>用户名:</span> <input type="text" name="user.name"
						class="input_text" /><label id="userMsg" class="alertLabel"></label>
					</li>
					<li><span>密码:</span> <input type="password" name="user.password"
						class="input_text" /></li>
					<li><span>学校:</span> <s:select name="user.school.id"
							list="#application.schools" listKey="key" listValue="value.name" />
					</li>
					<li><span>邮箱 (这个要填好 不然注册不了- -):</span> <input type="text"
						name="user.email" class="input_text" /><label id="userEmail"
						class="alertLabel"></label>
					</li>
					<li><span>性别:</span> <s:select name="user.sex"
							list="@com.tjxjh.enumeration.Sex@values()" listKey="name()"
							listValue="name" />
					</li>
					<li><span>入学年份:</span> <select name="user.grade"
						class="input_select"></select>
					</li>
					<li><span>真实姓名:</span> <input type="text" name="user.realName"
						class="input_text" /></li>
					<li><span>学院:</span> <input type="text" name="user.subject"
						class="input_text" /></li>
					<li><span>专业:</span> <input type="text" name="user.profession"
						class="input_text" /></li>
					<li><span>生日:</span> <input type="text" name="user.birthday"
						readonly="readonly" class="Wdate input_text"
						onclick="WdatePicker()" />
					</li>
					<li><span>qq:</span> <input type="text" name="user.qq"
						class="input_text" />
					</li>
					<li><span>头像:</span> <input type="file" name="portrait"
						class="input_file" />
					</li>
					<li><span>电话:</span> <input type="text" name="user.phone"
						class="input_text" />
					</li>
					<li><span>&nbsp;</span>
					</li>
					<li><span>&nbsp;</span> <input type="submit" value="注册"
						class="input_submit hov" />
					</li>
				</ul>
			</form>
		</div>

		<div id="merchant" class="shadow_l_5 signinPanel none">
			<jsp:include page="applyMerchant.jsp" />
		</div>
	</div>

	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="js/userMsg.js"></script>
	<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var currentYear = new Date().getFullYear();
			var select = $("select[name='user.grade']");
			for ( var i = 0; i != 9; ++i) {
				gradeAddOption(select, currentYear - i);
			}
			checkUserName("input[name='user.name']", "#userMsg", "用户");
			checkEmail("input[name='user.email']", "#userEmail");
			$(".merchantRadio").click(function() {
				$("#merchant").delay(300).slideDown(300);
				$("#user").hide(300);
			});
			$(".userRadio").click(function() {
				$("#user").delay(300).slideDown(300);
				$("#merchant").hide(300);
			});
		});

		function gradeAddOption(select, year) {
			select.append("<option value='" + year + "'>" + year + "</option>");
		}
	</script>
</body>
</html>
