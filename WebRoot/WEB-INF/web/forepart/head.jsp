<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ads" uri="fineTu/ads"%>

<div class="header shadow_d_3">
	<div class="logo">
		<img src="images/icon/logo.png" id="logo_img" class="w135" />
	</div>

	<s:if test="#session.user == null && #session.merchant == nll">
		<div class="nav_bar bc">
			<ul class="fr">
				<!-- 暂时加的 以后要删 -->
				<li><a href="manageIndex" class="a_bt">管理</a>
				<li><a href="managerLoginInput" class="a_bt">管理登陆</a> <!-- 暂时加的 以后要删 -->
				<li><a href="index" class="a_bt">主页</a>
				<li><a href="registerInput" class="a_bt">注册</a></li>
			</ul>
		</div>
	</s:if>

	<s:elseif test="#session.user != null">
		<div class="nav_bar bc">
			<ul class="fr">
				<li><a href="logout" class="a_bt">注销</a></li>
				<li><a href="registerInput" class="a_bt">注册</a></li>
				<li><a href="myAnnouncements" class="a_bt">通知(<s:property
							value="#session.user.announcementCount" />)</a></li>
			</ul>
			<ul class="fl">
				<li><a href="index" class="a_bt">主页</a></li>
				<li><a href="userCenter" class="a_bt">个人中心</a></li>
				<li><a href="myClubs" class="a_bt">我的社团</a></li>
				<li><a href="#" class="a_bt">店铺</a></li>
				<li><a href="relativeActivity" class="a_bt">线下活动</a></li>
				<li><a href="relativeOnlineActivity" class="a_bt">线上活动</a></li>
				<li><a href="relativeTalking" class="a_bt">说说</a></li>
				<li><a href="relativePicture" class="a_bt">相册</a></li>
				<li><a href="photos" class="a_bt">我的相册</a></li>


				<li><a href="myFocus?type=0" class="a_bt">好友</a></li>
				<li><a href="userHome" class="a_bt">个人主页</a></li>
				<li><a href="receivedLetters" class="a_bt">飞鸽传书 (<s:property
							value="#session.user.receiveLetterCount" />)</a></li>
			</ul>
		</div>
	</s:elseif>
	<s:elseif test="#session.merchant != null">
		<div class="nav_bar bc">
			<ul class="fr">
				<li><a href="#" class="a_bt">弄一个商家的专门的头部啊</a>
				</li>
				<li><a href="logout" class="a_bt">注销</a></li>
			</ul>
			<ul class="fl">
				<li><a href="index" class="a_bt">主页</a>
				</li>
				<li><a href="merchantMain" class="a_bt">商家主页</a>
				</li>
				<li><a href="updateMerchantInput" class="a_bt">详细信息</a>
				</li>
				<li><a href="merchantNews" class="a_bt">更多新闻</a>
				</li>
			</ul>
		</div>
	</s:elseif>
</div>
