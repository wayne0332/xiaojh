<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<form action="applyMerchant" method="post" enctype="multipart/form-data">
	<ul>
		<li><span>用户名:</span> <input type="text" name="merchant.name"
			class="input_text" /><label id="nameMsg" class="alertLabel"></label>
		</li>
		<li><span>商家名:</span> <input type="text"
			name="merchant.merchantName" class="input_text" /></li>
		<li><span>密码:</span> <input type="password"
			name="merchant.password" class="input_text" />
		</li>
		<li><span>类型:</span> <s:select name="merchant.type"
				list="@com.tjxjh.enumeration.MerchantType@values()" listKey="name()"
				listValue="name" />
		</li>
		<li><span>行业:</span> <s:select name="merchant.business"
				list="@com.tjxjh.enumeration.MerchantBusiness@values()"
				listKey="name()" listValue="name" />
		</li>
		<li><span>合作意向:</span> <s:checkboxlist name="purpose"
				list="@com.tjxjh.util.MerchantPurposeUtil@purposesMap" /></li>
		<li><span>地址:</span> <input type="text" name="merchant.address"
			class="input_text" />
		</li>
		<li><span>电话:</span> <input type="text" name="merchant.phone"
			class="input_text" />
		</li>
		<li><span>联系人姓名:</span> <input type="text"
			name="merchant.connectorName" class="input_text" />
		</li>
		<li><span>联系人电话:</span> <input type="text"
			name="merchant.connectorPhone" class="input_text" />
		</li>
		<li><span>联系人QQ:</span> <input type="text"
			name="merchant.connectorQq" class="input_text" />
		</li>
		<li><span>联系人邮箱:</span> <input type="text"
			name="merchant.connectorEmail" class="input_text" /><label
			id="merchantEmail" class="alertLabel"></label>
		</li>
		<li><span>Logo:</span> <input type="file" name="logo"
			class="input_file" /></li>
		<li><span>&nbsp;</span>
		</li>
		<li><span>&nbsp;</span> <input type="submit" value="注册"
			class="input_submit hov" /></li>
	</ul>
</form>

<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/userMsg.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		checkUserName("input[name='merchant.name']", "#nameMsg", "商家");
		checkEmail("input[name='merchant.connectorEmail']", "#merchantEmail");
	});
</script>
