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
     	<s:property value="message"/><br/>
     	<s:if test="actionName.equals('admin')">
     		<form action="adminModifyActivity?activity.id=${activity.id}" method="post" enctype="multipart/form-data">
     	</s:if>
     	<s:else>
     		<form action="modifyActivity?activity.id=${activity.id}" method="post" enctype="multipart/form-data">
     	</s:else>
	 		活动标题:<input type="text" name="activity.tittle" value="${activity.tittle}"/><br>
	     	新闻内容：<textarea id="editor" name="activity.text" id="ncontent" style="width:100%;height:400px;">${activity.text}</textarea><br>
	     	活动封面图片链接:<input type="text" name="activity.titleImgPath" value="${activity.titleImgPath}"/><br>
	     	活动视频连接:<input type="text" name="activity.videoUrl" value="<s:property value="activity.videoUrl"/>"/><br>
	     	活动预算资金：<input type="text" name="activity.budget" value="${activity.budget}"/>元<br>
	     	活动组织：<input type="text" name="activity.organizer" value="${activity.organizer}"/><br>
	     	活动举办地点：<input type="text" name="activity.place" value="${activity.place}"/><br>
	     	上传活动封面图片:<input type = "file" name="uploadImage"/><br>
	     	上传活动视频:<input type = "file" name="uploadVideo"/><br>
	     	<s:if test="actionName.equals('admin')">
		     	活动状态:<s:select name="activity.status" list="@com.tjxjh.enumeration.ActivityStatus@values()"
				listKey="name()" listValue="name" />
			</s:if>
			<br>
	     	<input type="submit" value="提交"/>
     	</form>
     </div>
</html>
