<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>
<head>
<title>校江湖</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-club.css" />

</head>
<body>
	<div class="container">
		<jsp:include page="head.jsp" />
		<br>

		<!-- 提示信息 -->
		<s:property value="message" />
		
		<form action="shareTalking" method="post"><!-- 尚未被分享过的原始说说 -->
		
			<!-- 尚未被分享过的原始说说 -->
			<s:if test="origntalking.talking==null">
				<input type="hidden" name="talkingid" value="${origntalking.id}" />
				<table class="applyClubTable shadow_l_5">
					<thead>
						<tr>
							<th colspan="2">分享</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th class="pt10"><label>说说内容：</label></th>
							<td class="pt20">
								<textarea name="talking.text" cols="20" rows="5">@${origntalking.user.name}:${message}</textarea>
							</td>
						</tr>
						<tr>
							<th><label>原始说说：</label></th>
							<td><label>${origntalking.text}</label></td>
						</tr>
						<tr>
							<th><label></label>
							</th>
							<td>
								<s:if test="origntalking.url!=null&&origntalking.urlType.toString()=='PICTURE'">
									<img src="${origntalking.url}" />
								</s:if>
								<!-- 说说 -->
								<s:elseif test="origntalking.url!=null&&origntalking.urlType.toString()=='VIDEO'">
		     						${origntalking.url}
				    			</s:elseif>
							</td>
						</tr>
						<tr>
							<th></th>
							<td>
								<input type="submit" class="applyClubTable_submit shadow_l_5 hov" value="分享"></td>
						</tr>
						<tr></tr>
					</tbody>
				</table>
			</s:if>
			<!-- 该说说引用别的说说 -->
			<s:else>
				<input type="hidden" name="talkingid" value="${origntalking.id}" />
				<table class="applyClubTable shadow_l_5">
					<thead>
						<tr>
							<th colspan="2">分享</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th class=""><label>说说内容：</label></th>
							<td class="">
								<textarea name="talking.text" cols="20" rows="5">#@${origntalking.user.name}:${origntalking.text}#</textarea>
							</td>
						</tr>
						<tr>
							<th><label>原始说说：</label></th>
							<td><label>${origntalking.text}</label></td>
						</tr>
						<tr>
							<th><label></label>
							</th>
							<td>
								<s:if test="origntalking.url!=null&&origntalking.urlType.toString()=='PICTURE'">
									<img src="${origntalking.takling.url}" />
								</s:if>
								<!-- 说说 -->
								<s:elseif test="origntalking.url!=null&&origntalking.urlType.toString()=='VIDEO'">
		     						${origntalking.url}
				    			</s:elseif>
							</td>
						</tr>
						<tr>
							<th></th>
							<td>
								<input type="submit" class="applyClubTable_submit shadow_l_5 hov" value="分享"></td>
						</tr>
						<tr></tr>
					</tbody>
				</table>
			</s:else>
		</form>
	</div>
</body>
</html>
