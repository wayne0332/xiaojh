var talkingspanid;
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
			alert("删除成功！");
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

