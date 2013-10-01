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
	<div class="container cf zoom">
		<jsp:include page="head.jsp" />
		
		<div class="main w730 cf mt75">
			<!-- 导航-->
			<div class="userHome_box w700 m5 p10 cf shadow_l_10 radius_6">
				<a href="javascript:void(0)" ><label>相册</label> </a>
				<a href="<%=path%>/talking?user.id=${user.id}"><label>说说</label>
				</a> <a href="#"><label>活动</label> </a>
				<form action="addPicture" method= "post" enctype="multipart/form-data" style="display:inline;">
 					选择照片：<input type = "file" name="uploadImage"/>
 					<input type="submit" value="上传照片"/>
 				</form><s:property value="message" />
			</div>
			<!-- END:相册-->
			<!-- 说说 -->
			<div class="userHome_box w700 m5 mt30 p10 cf shadow_l_10 radius_6">
				<label class="userBox_title w pl10 pr10 h30">相册</label>
				<!-- 删除相片导致相册页数与真实页数不一致 ，将当总页数减一，并跳转至上一页-->
				<s:if test="pics.size()==0&&currentPage!=1">
					<script>　
		     			alert("已经是最后一页"); 
						window.location = "<%=path%>/${actionName}?currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}";
					</script>
				</s:if>
				<s:iterator value="pics">
					<span style="display: inline-block;"> <a
						href="<%=path%><s:property  value="path.replace('st_', '')" />"
						target="_blank"><img src="<%=path%>/${path}" /> </a> <br />
						${name}&nbsp; 
						<s:if test="#request.my.equals('no')">
		     			From:<a href="userHome?user.id=${user.id}">${user.name}</a>
						</s:if> 
						<s:elseif test="#request.my.equals('yes')">
							<a href="<%=path%>/deletePicture?picture.id=${id}">删除</a>
							<a href="<%=path%>/preUpdatePicture?picture.id=${id}">重命名</a>
						</s:elseif> </span>
				</s:iterator>

				<br /> 当当前第${page.currentPage}页&nbsp;共${page.pageNumber}页 <a
					href="<%=path%>/${actionName}?currentPage=${page.currentPage-1}&totalPageNumber=${page.pageNumber}"
					target="_self">上一页</a>&nbsp; <a
					href="<%=path%>/${actionName}?currentPage=${page.currentPage+1}&totalPageNumber=${page.pageNumber}"
					target="_self">下一页</a>

			</div>
		</div>
		
		<div class="clearfloat"></div>
		<div class="footer"></div>
	</div>
</body>
</html>
