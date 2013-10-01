<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<base href="<%=basePath%>" />

<title>校江湖 - 个人主页</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />
<script type="text/javascript" src="<%=path%>/js/ajax.js"></script>
</head>

<body>
	
			<div class="userHome_box w700 m5 mt30 p10 cf shadow_l_10 radius_6">
				<label class="userBox_title w pl10 pr10 h30">江湖动态</label>
				<s:iterator value="taks" id="tak">
					<div id="${t.id}" class="user_dongtai_div cf w700 mt10 pt10 pb15">
						<div class="w60 h fl">
							<img src="${t.user.portraitPath}"
								class="w60 h60 fl shadow_l_10 radius_6" />
						</div>
						<div id="talking_detail_div"
							class="fr w610 mt5 mr15 user_talking_detail_div">
							<a href="userHome?user.id=${t.user.id}" target="_blank"
								class="f16 lh150 user_name_color">${t.user.name}</a> <label
								class="fr w610 f14"><s:property value="t.text"
									escape="false" /> </label>
							<s:if test="t.talking==null">
								<div class="cf w610 mt5 fr of_h">
									<s:if
										test="t.url!=null&&!t.url.trim().equals('')&&t.urlType.toString()=='PICTURE'">
										<img src="${t.url}" class="maw400 mah300" />
									</s:if>
									<s:elseif
										test="t.url!=null&&!t.url.trim().equals('')&&t.urlType.toString()=='VIDEO'">
										<s:property
											value="t.url.replace('400', '300').replace('480', '360')"
											escape="false" />
									</s:elseif>
								</div>
							</s:if>
							<s:elseif test="t.talking!=null">
								<div class="p10 mt5 user_talking_share_div cb">
									<a href="userHome?user.id=${t.talking.user.id}"
										class="f12 user_name_color">${t.talking.user.name}</a> ：
									<s:property value="t.talking.text" escape="false" />
									<br />

									<s:if
										test="t.talking.url!=null&&t.talking.urlType.toString()=='PICTURE'">
										<img src="${t.talking.url}" class="maw400 mah300" />
									</s:if>
									<s:elseif
										test="t.talking.url!=null&&t.talking.urlType.toString()=='VIDEO'">
										<s:property
											value="t.talking.url.replace('400', '300').replace('480', '360')"
											escape="false" />
									</s:elseif>
								</div>
							</s:elseif>
						</div>
						<!-- like -->
						<div class="fr w610 mt5 mr15">
							<s:if test="t.user.id==#session.user.id">
								<a href="javascript:void(0);" onclick="deleteTalking(${t.id});">删除</a>
								<span id="zan${t.id}"> <s:if test="t.shareDetails!=null">
										<!-- like -->
										<a href="javascript:void(0);">赞(${t.shareDetails.praiseCount})</a>
									</s:if> <s:else>
										<a href="javascript:void(0);">赞(${t.talking.shareDetails.praiseCount})</a>
									</s:else> </span>
								<label><s:property
										value="t.datetime.toString().substring(0,16)" /> </label>
								<a href="javascript:void(0);">分享<s:if
										test="t.shareDetails!=null">(${t.shareDetails.shareCount})</s:if>
									<s:else>(${t.talking.shareDetails.shareCount})</s:else> </a>
							</s:if>
							<s:else>
								<span id="zan${t.id}"> <s:if test="t.shareDetails!=null">
										<!-- like -->
										<a href="javascript:void(0);" onclick="zanTalking(${t.id});">赞(${t.shareDetails.praiseCount})</a>
									</s:if> <s:else>
										<a href="javascript:void(0);" onclick="zanTalking(${t.id});">赞(${t.talking.shareDetails.praiseCount})</a>
									</s:else> </span>
								<label><s:property
										value="t.datetime.toString().substring(0,16)" /> </label>

								<s:if test="t.talking==null">
									<a href="<%=path %>/preShareTalking?talking.id=${t.id}">分享<s:if
											test="t.shareDetails!=null">(${t.shareDetails.shareCount})</s:if>
										<s:else>(${t.talking.shareDetails.shareCount})</s:else> </a>
								</s:if>
								<s:else>
									<a
										href="<%=path %>/preShareTalking?talking.id=${t.talking.id}&message=${t.text}">分享<s:if
											test="t.shareDetails!=null">(${t.shareDetails.shareCount})</s:if>
										<s:else>(${t.talking.shareDetails.shareCount})</s:else> </a>
								</s:else>
							</s:else>
							<!-- 分割线 -->
							<!-- 说说回复 -->
							<span id="tcs${t.id}"> <!-- 用于ajax动态更新说说 --> <s:iterator
									value="tcs" id="tc">
									<div id="tc${tc.id}" class="user_pinglun_div w610 cb tc_detail">
										<div class="w40 h40 mt5 mr10 fl ">
											<a href="userHome?user.id=${tc.user.id}" target="_blank">
												<img src="${tc.user.portraitPath}"
												class="w40 h40 shadow_l_10 radius_6" /> </a>
										</div>
										<div class="fl w560">
											<a href="userHome?user.id=${tc.user.id}" target="_blank"
												class="f12 user_name_color">${tc.user.name}</a> :${tc.text}<br />
											<div class="fl color_gray">
												<s:property value="datetime.toString().substring(5,16)" />
												&nbsp;&nbsp;&nbsp;
											</div>
											<a href="javascript:void(0);"
												onclick="huifu(${t.id},'${tc.user.name}',${tc.user.id});"
												class="f12 user_name_color">回复</a>
											<s:if test="user.id==#session.user.id">
												<span class="delete_tc"> &nbsp;&nbsp;<a
													href="javascript:void(0);"
													onclick="deleteTalkingComment(${tc.id});"
													class="f12 user_name_color">删除</a> </span>
											</s:if>
										</div>
										<div class="cb"></div>
									</div>
								</s:iterator> </span> <input type="hidden" id="user_id${t.id}" name="userid"
								value="0" />
							<textarea id="pl_t${t.id}" name="talkingComment.text"
								class="fr mt5 textarea color_gray" style="width:610px;"></textarea>
							<input type="button" class="submit fr"
								onclick="addTalkingComment(${t.id});" value="评论" />
							<!-- End:说说回复 -->
						</div>

						<!-- like end -->
					</div>
				</s:iterator>
				<br> <a href="<%=path%>/allTalking" target="_self">更多</a>

			</div>
			<!-- END：说说 -->
	<script type="text/javascript">
		function huifu(id,name,userid){
			var pl_t='#pl_t'+id;
			var user_id='#user_id'+id;
			$(pl_t).val("@"+name+":");
			$(user_id).val(userid);
			$(pl_t).focus();
		}

	</script>

	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
</body>
</html>
