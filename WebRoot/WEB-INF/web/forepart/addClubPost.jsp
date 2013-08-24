<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'addClubPost.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
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
		
		//获取文本域内容
		$("#getVal").click(function (){
			alert(editor.html());
		});
	});	
	</script>
	<style type="text/css">
		body{margin:0 auto;padding:0 0;}
		.header span{float:right;}
		.clearfloat{clear:both}
		.container{margin:0 auto;padding:0 0;width:920px;}
		.main{}
		.header{}
		.left{float:left; width:620px;}
		.list{float:left; width:610px;}
		.right{float:right; width:270px;}
		.portrait_big{width:60px;float:left;}
		.userItem{width:540px;}
		.infoItem{margin-top:5px;width:200px;}
	</style>


  </head>
  
	<body>
    	<div class="div">
	     	<!-- 提示信息 -->
	     	<s:property value="message"/><br/>
		 	<form action="addClubPost?club.id=<s:property value="club.id" />" method="post" enctype="multipart/form-data">
		 		标题:<input type="text" name="post.tittle"/><br>
		     	帖子内容：<textarea id="editor" name="post.text" id="ncontent" style="width:100%;height:400px;"></textarea><br>
		     	<input type="submit" value="提交"/>
	     	</form>
	     </div>
	</body>
</html>
