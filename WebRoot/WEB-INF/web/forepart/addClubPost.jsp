<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>校江湖 - 社团</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-club.css" />
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
	<div class="container clearfix">
		<jsp:include page="head.jsp" />
		</div>
		<div class="clearfix">1</div>
	<div class="div w700 mt30 bc clearfix">
		<!-- 提示信息 -->
		<s:property value="message" />
		<br />
		<h2 class="h2_title">发布帖子</h2><br><br><br>
		<form action="addClubPost?club.id=<s:property value="club.id" />"
			method="post" enctype="multipart/form-data">
			标题:<input type="text" name="post.tittle" /><br> 帖子内容：
			<textarea id="editor" name="post.text" id="ncontent"
				style="width:100%;height:400px;"></textarea>
			<br> <input type="submit" value="提交" class="applyClubTable_submit shadow_l_5 hov" />
		</form>
	</div>
</body>
</html>
