<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<link rel="stylesheet" href="css/grid.css" type="text/css">
<link rel="stylesheet" href="css/master.css" type="text/css" />


<script type='text/javascript' src='js/fancyzoom.js'></script>
<script type='text/javascript' src='js/demo.js'></script>

<div id="content" class="photoBox ml10">

	<div class="span-17 column rounded">
		<s:iterator value="pics" status="index">
			<div class="span-6 column rotated">
			<a id="image1" class="cms-editable polaroid" href="#pic-<s:property value="#index.index"/>"
				rel="lightbox" title="first image"> <img src="${path}" alt="image" /> </a>
		</div>
		</s:iterator>
		
		
		<s:iterator value="pics" status="index">
			<div id="pic-<s:property value="#index.index"/>">
				<img src="<s:property  value="path.replace('st_', '')"/>" alt="image" />
			</div>
		</s:iterator>
	
	</div>

</div>

