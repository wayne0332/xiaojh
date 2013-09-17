<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>校江湖 - 活动</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

</head>

<body>

	<div class="container cf zoom">
		<jsp:include page="head.jsp" />

		<!-- 提示信息 -->
		<s:property value="message" />

		<form action="addOnlineActivity" method="post"
			enctype="multipart/form-data" class="w600 shadow_l_5 mt100 bc bg_box">
			<ul class="input_list">
				<li>发布线上活动</li>
				<li><label>活动标题:</label></li>
				<li><input type="text" name="onlineactivity.tittle" class="input_list_text" />
				</li>
				<li></li>
				<li></li>
			</ul>

			新闻内容：
			<textarea id="editor" name="onlineactivity.text" id="ncontent"
				style="width:100%;height:400px;"></textarea>
			<br> 活动封面图片链接:<input type="text"
				name="onlineactivity.titleImgPath" /><br> 活动视频连接:<input
					type="text" name="onlineactivity.videoUrl" /><br> 上传活动封面图片:<input
						type="file" name="uploadImage" /><br> 上传活动视频:<input
							type="file" name="uploadVideo" /><br> <input type="hidden"
								name="club.id" value="${club.id}"> <br> <input
										type="submit" value="提交" />
		</form>

	</div>

	<script type="text/javascript" src="<%=path%>/editor/kindeditor.js"></script>
	<script type="text/javascript" src="<%=path%>/editor/lang/zh_CN.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery-1.8.1.min.js"></script>

	<!--文本编辑器-->
	<script>
	var editor;
	$(document).ready(function (){
		//渲染编辑器
		KindEditor.ready(function(K) {
			editor = K.create('#editor',{
				items:[
					'source','preview','fontname','fontsize','forecolor','hilitecolor','bold','italic','underline','strikethrough','justifyleft','justifycenter','justifyright','hr','image','emoticons','fullscreen','insertfile'
				],
				uploadJson : '<%=path%>
		/editorUploadJsp',
							afterChange : function() {
								$('#alreadyInput').html(this.count());
								$('#stillInput').html(2000 - this.count());
							}
						});
					});

				});
	</script>

</body>
</html>
