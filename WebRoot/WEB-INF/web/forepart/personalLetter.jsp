<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>
<head>
<title>校江湖</title>

<link rel="stylesheet" type="text/css" href="css/base-min.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/page-user.css" />

</head>
<body>
	<div class="container">
	
		<jsp:include page="head.jsp" />
		
		<div class="main mt75">
			<div class="letter_box cf">
			
				<div class="lette_box_left">
					<img alt="头像" title="头像" src="images/head/head1.jpg"
						class="logoImg shadow_l_3" />
						<br>
					<s:property value="letter.userBySourceUserId.name" />
				</div>
				
				<div class="lette_box_right shadow_l_3">
					<div>
						<s:a href="personalLetter?letter.id=%{id}" class="showLetter">
							<p class="letter_content">
								<s:property value="letter.text" />
							</p>
						</s:a>
					</div>
					<div>
						<span class="letter_name">
							<span>
								<s:date name="letter.datetime" format="MM/dd HH:mm" />
								<s:a href="personalLetterInput?targetUser.id=%{userBySourceUserId.id}&targetUser.name=%{userBySourceUserId.name}">回复</s:a>
								<s:a href="deleteLetter?letter.id=%{letter.id}">删除</s:a>
							</span>
						</span> 
					</div>
				</div>
				
			</div>
		</div>
		
	</div>
</body>
</html>
