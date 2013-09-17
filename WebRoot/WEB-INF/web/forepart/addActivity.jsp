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
	<div class="container">
		<jsp:include page="head.jsp" />
		<!-- 提示信息 -->
		<s:property value="message" />
		<br />

		<form action="addActivity" method="post" enctype="multipart/form-data">
			活动标题:<input type="text" name="activity.tittle" /><br> 新闻内容：
			<textarea id="editor" name="activity.text" id="ncontent"
				style="width:100%;height:400px;"></textarea>
			<br> 活动封面图片链接:<input type="text" name="activity.titleImgPath" /><br>
			活动视频连接:<input type="text" name="activity.videoUrl" /><br>
			活动预算资金：<input type="text" name="activity.budget" />元<br> 活动组织：<input
				type="text" name="activity.organizer" /><br> 活动举办地点：<input
				type="text" name="activity.place" /><br> 上传活动封面图片:<input
				type="file" name="uploadImage" /><br> 上传活动视频:<input
				type="file" name="uploadVideo" /><br> <br> <input
				type="submit" value="提交" />
		</form>
	</div>


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

</body>
</html>
