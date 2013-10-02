<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'updateMerchant.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<jsp:include page="head.jsp" />
	<h1>详细信息</h1>
	<ul>
		<li><span>用户名:</span> <s:property value="#session.merchant.name" />
		</li>
		<li><span>商家名:</span><s:property value="#session.merchant.merchantName" />
		</li>
		<li><span>类型:</span> <s:select name="merchant.type"
				list="@com.tjxjh.enumeration.MerchantType@values()" listKey="name()"
				listValue="name"   value="#session.merchant.club.type" /></li>
		<li><span>行业:</span> <s:select name="merchant.business"
				list="@com.tjxjh.enumeration.MerchantBusiness@values()"
				listKey="name()" listValue="name" /></li>
		<li><span>合作意向:</span> <s:checkboxlist name="purpose"
				list="@com.tjxjh.util.MerchantPurposeUtil@purposesMap" />
		</li>
		<li><span>地址:</span> <input type="text" name="merchant.address"
			class="input_text" /></li>
		<li><span>电话:</span> <input type="text" name="merchant.phone"
			class="input_text" /></li>
		<li><span>联系人姓名:</span> <input type="text"
			name="merchant.connectorName" class="input_text" /></li>
		<li><span>联系人电话:</span> <input type="text"
			name="merchant.connectorPhone" class="input_text" /></li>
		<li><span>联系人QQ:</span> <input type="text"
			name="merchant.connectorQq" class="input_text" /></li>
		<li><span>联系人邮箱:</span> <input type="text"
			name="merchant.connectorEmail" class="input_text" /><label
			id="merchantEmail" class="alertLabel"></label></li>
		<li><span>Logo:</span> <input type="file" name="logo"
			class="input_file" />
		</li>
		<li><span>&nbsp;</span></li>
		<li><span>&nbsp;</span> <input type="submit" value="注册"
			class="input_submit hov" />
		</li>
	</ul>
</body>
</html>
