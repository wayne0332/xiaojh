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
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

<script type="text/javascript" src="<%=path%>/editor/kindeditor.js"></script>
<script type="text/javascript" src="<%=path%>/editor/lang/zh_CN.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery-1.9.1.min.js"></script>
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

</head>

<body>
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		<div class="mt75">
			<!-- 提示信息 -->
			<s:property value="message" />
			<br />

			<form action="addClubNews" method="post"
				enctype="multipart/form-data">
				新闻标题:<input type="text" name="clubnews.tittle" /><br> 新闻内容：
				<textarea id="editor" name="clubnews.text" id="ncontent"
					style="width:100%;height:400px;"></textarea>
				<br> 封面图片链接:<input type="text" name="clubnews.titleImgPath" /><br>
				视频连接:<input type="text" name="clubnews.videoUrl" /><br>
				上传封面图片:<input type="file" name="uploadImage" /><br> 视频:<input
					type="file" name="uploadVideo" /><br> <br> <input
					type="submit" value="提交" />
			</form>
		</div>
	</div>
</html>
