<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>添加活动</title>
	<script type="text/javascript" src="<%=path %>/editor/kindeditor.js"></script>
	<script type="text/javascript" src="<%=path %>/editor/lang/zh_CN.js"></script>
	<script type="text/javascript" src="<%=path %>/js/jquery-1.8.1.min.js"></script>
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
				uploadJson : '<%=path%>/editorUploadJsp',
				afterChange : function() {
					$('#alreadyInput').html(this.count());
					$('#stillInput').html(2000-this.count());
				}
			});
		});
		
	});	
</script>
 <link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css" />
  </head>
  
  <body>
    <div class="div">
     	<!-- 提示信息 -->
     
     		<form action="modifyOnlineActivity?onlineactivity.id=${onlineactivity.id}" method="post" enctype="multipart/form-data">
	 		活动标题:<input type="text" name="onlineactivity.tittle" value="${onlineactivity.tittle}"/><br>
	     	新闻内容：<textarea id="editor" name="onlineactivity.text" id="ncontent" style="width:100%;height:400px;">${onlineactivity.text}</textarea><br>
	     	活动封面图片链接:<input type="text" name="onlineactivity.titleImgPath" value="${onlineactivity.titleImgPath}"/><br>
	     	活动视频连接:<input type="text" name="onlineactivity.videoUrl" value="${onlineactivity.videoUrl}"/><br>
	     	上传活动封面图片:<input type = "file" name="uploadImage"/><br>
	     	上传活动视频:<input type = "file" name="uploadVideo"/><br>
		         活动状态:<s:select name="onlineactivity.status" list="@com.tjxjh.enumeration.OnlineActivityStatus@values()"
				listKey="name()" listValue="name" />
			<br>
	     	<input type="submit" value="提交"/>
     	</form>
     </div>
</html>
