var talkingspanid;
function addTalking(id)
{ 
	if(!confirm("确定删除说说?")){
		return;
	}
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null)
	{
		alert ("您的浏览器不支持AJAX！");
		return;
	} 
	talkingspanid=id;
	var url="addTalking?talking.id="+id;
	xmlHttp.open("POST",url);
	xmlHttp.onreadystatechange=huifuStateChanged;
	xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xmlHttp.send("talkingComment.talking.id="+talkingid+"&userid="+userid+"&talkingComment.text="+encodeURIComponent(pl_t));
}

function addTalkingChanged()
{ 
	if (xmlHttp.readyState==4)
	{ 
		var res=xmlHttp.responseText;
		if(res=="true"){
			document.getElementById(talkingspanid).style.display = "none";
		}else{
			alert("删除失败！");
		}

	}
}
function deleteTalking(id)
{ 
	if(!confirm("确定删除说说?")){
		return;
	}
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null)
	{
		alert ("您的浏览器不支持AJAX！");
		return;
	} 
	talkingspanid=id;
	var url="deleteTalking?talking.id="+id;
	xmlHttp.onreadystatechange=deleteTalkingChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function deleteTalkingChanged()
{ 
	if (xmlHttp.readyState==4)
	{ 
		var res=xmlHttp.responseText;
		if(res=="true"){
			document.getElementById(talkingspanid).style.display = "none";
		}else{
			alert("删除失败！");
		}

	}
}
var zanspanid;
var talkingid;
function zanTalking(id)
{ 
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null)
	{
		alert ("您的浏览器不支持AJAX！");
		return;
	} 
	
	zanspanid="zan"+id;
	talkingid=id;
	var url="zanTalking?talking.id="+id;
	xmlHttp.onreadystatechange=zanTalkingChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function zanTalkingChanged()
{ 
	if (xmlHttp.readyState==4)
	{ 
		var res=xmlHttp.responseText;
		if(res=="-1"){
			alert ("你已赞过！");
		}
		else if(res!="-2"){
			document.getElementById(zanspanid).innerHTML="<a href='javascript:void(0);' onclick='deleteZan("+
			talkingid+");' style='text-decoration:none;'>取消赞("+res+")</a>";
		}else{
			alert("网络忙，请稍后再试！");
		}

	}
}
function deleteZan(id)
{ 
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null)
	{
		alert ("您的浏览器不支持AJAX！");
		return;
	} 
	
	zanspanid="zan"+id;
	talkingid=id;
	var url="deletezan?talking.id="+id;
	xmlHttp.onreadystatechange=deleteZanChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function deleteZanChanged()
{ 
	if (xmlHttp.readyState==4)
	{ 
		var res=xmlHttp.responseText;
		if(res!="-2"){
			document.getElementById(zanspanid).innerHTML="<a href='javascript:void(0);' onclick='zanTalking("+
			talkingid+");' style='text-decoration:none;'>赞("+res+")</a>";
		}else{
			alert("网络忙，请稍后再试！");
		}

	}
}


var talking_span;
var pl_t_div;
function addTalkingComment(talkingid)
{ 
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null)
	{
		alert ("您的浏览器不支持AJAX！");
		return;
	} 
	talking_span='tcs'+talkingid;
	var userid_div="user_id"+talkingid;
    pl_t_div="pl_t"+talkingid;
    
	var pl_t=document.getElementById(pl_t_div).value;
	var userid=document.getElementById(userid_div).value;
	
	var url="addTalkingComment?";
	xmlHttp.open("POST",url);
	xmlHttp.onreadystatechange=huifuStateChanged;
	xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xmlHttp.send("talkingComment.talking.id="+talkingid+"&userid="+userid+"&talkingComment.text="+encodeURIComponent(pl_t));
}
function huifuStateChanged()
{ 
	if (xmlHttp.readyState==4)
	{ 
		var res=xmlHttp.responseText;
		if(res!="0"){
			document.getElementById(talking_span).innerHTML=document.getElementById(talking_span).innerHTML+res;
			document.getElementById(pl_t_div).value="";
			document.getElementById(pl_t_div).focus();
		}else{
			alert("网络忙，请稍后再试！");
		}

	}
}
var tc_div;
function deleteTalkingComment(id)
{ 
	if(!confirm("确定删除说说?")){
		return;
	}
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null)
	{
		alert ("您的浏览器不支持AJAX！");
		return;
	} 
	tc_div="tc"+id;
	var url="deleteTalkingcomment?talkingComment.id="+id;
	xmlHttp.onreadystatechange=deleteTalkingCommentChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function deleteTalkingCommentChanged()
{ 
	if (xmlHttp.readyState==4)
	{ 
		var res=xmlHttp.responseText;
		if(res=="1"){
			document.getElementById(tc_div).style.display="none";
		}else{
			alert("网络忙，请稍后再试！");
		}

	}
}
function GetXmlHttpObject()
{
var xmlHttp=null;
try
  {
  xmlHttp=new XMLHttpRequest();
  }
catch (e)
  {
  try
    {
    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }
  catch (e)
    {
    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
  }
return xmlHttp;
}
//ajax

