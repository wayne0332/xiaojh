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
		<div class="span-6 column rotated">
			<a id="image1" class="cms-editable polaroid" href="#pic-1"
				rel="lightbox" title="first image"> <img src="gallery/1_s.jpg"
				alt="image" /> </a>
		</div>
		<div class="span-6 column rotated">
			<a id="image2" class="cms-editable polaroid" href="#pic-2"
				rel="lightbox" title="second image"> <img src="gallery/2_s.jpg"
				alt="image" /> </a>
		</div>
		<div class="span-6 column rotated last">
			<a id="image3" class="cms-editable polaroid" href="#pic-3"
				rel="lightbox" title="third image"> <img src="gallery/3_s.jpg"
				alt="image" /> </a>
		</div>
		<div class="span-6 column rotated">
			<a id="image4" class="cms-editable polaroid" href="#pic-4"
				rel="lightbox" title="first image"> <img src="gallery/4_s.jpg"
				alt="image" /> </a>
		</div>
		<div class="span-6 column rotated">
			<a id="image5" class="cms-editable polaroid" href="#pic-5"
				rel="lightbox" title="first image"> <img src="gallery/5_s.jpg"
				alt="image" /> </a>
		</div>
		<div class="span-6 column rotated last">
			<a id="image6" class="cms-editable polaroid" href="#pic-6"
				rel="lightbox" title="first image"> <img src="gallery/6_s.jpg"
				alt="image" /> </a>
		</div>

		<div id="pic-1">
			<img src="gallery/1.jpg" alt="image" />
		</div>
		<div id="pic-2">
			<img src="gallery/2.jpg" alt="image" />
		</div>
		<div id="pic-3">
			<img src="gallery/3.jpg" alt="image" />
		</div>
		<div id="pic-4">
			<img src="gallery/4.jpg" alt="image" />
		</div>
		<div id="pic-5">
			<img src="gallery/5.jpg" alt="image" />
		</div>
		<div id="pic-6">
			<img src="gallery/6.jpg" alt="image" />
		</div>
	</div>

</div>

