<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'success.jsp' starting page</title>
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
     	<s:property value="message"/><br/>
     	
	 	<form action="modifyClubNews" method="post" enctype="multipart/form-data">
	 		<input type="hidden" name="clubnews.id" value="${clubnews.id}"/>
	 		新闻标题:<input type="text" name="clubnews.tittle" value="${clubnews.tittle}"/><br>
	     	新闻内容：<textarea id="editor" name="clubnews.text" id="ncontent" style="width:100%;height:400px;">${clubnews.text}</textarea><br>
	     	封面图片:<input type="text" name="clubnews.titleImgPath" size="60" value="${clubnews.titleImgPath}"/><br>
	     	视频连接:<input type="text" name="clubnews.videoUrl" size="60" value="${clubnews.videoUrl}"/><br>
	     	封面图片:<input type = "file" name="uploadImage"/><br>
	     	视频:<input type = "file" name="uploadVideo"/><br>
			<br>
	     	<input type="submit" value="修改"/>
     	</form>
     </div>
</html>
