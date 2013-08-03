$(function()
{
	//生成下部小按钮
	var length = $('#slideshow_photo a').length;
	for(var i = 0; i < length; i++)
	{
		$('<div class="slideshow-bt" index="'+(length-i)+'"></div>').appendTo('#slideshow_footbar');
    }
    $('#slideshow_footbar .slideshow-bt:last').addClass('bt-on');
    $('#slideshow_footbar .slideshow-bt').mouseenter(function(e)
    {
		slideTo(this);
    });

	
    var indexAllowAutoSlide = true;
    $('#slideshow_wrapper').mouseenter(function()
    {
		indexAllowAutoSlide = false;
    }).mouseleave(function()
    {
		indexAllowAutoSlide = true;
    });

	//滚动
    setInterval(function()
    {
		if (indexAllowAutoSlide) slideDown();
    },3000);

});

function slideDown()
{
	var currentBt = $('#slideshow_footbar .slideshow-bt.bt-on');
    if (currentBt.length <= 0) return;
    var nxt = currentBt.get(0).previousSibling;
    slideTo(nxt?nxt:$('#slideshow_footbar .slideshow-bt:last').get(0));
}

function slideTo(o)
{
	if (!o) return;
	var currentIndex = $('#slideshow_footbar .slideshow-bt.bt-on').attr('index'),
		current = $('#slideshow_photo a[index='+currentIndex+']');
	var nxt = $('#slideshow_photo a[index='+$(o).attr('index')+']');
	if (currentIndex == $(o).attr('index')) return;
	
	if (nxt.find('img[imgsrc]').length > 0)
	{
		var img =nxt.find('img[imgsrc]');
		img.attr('src',img.attr('imgsrc')).removeAttr('imgsrc');
	}
	
	$('#slideshow_footbar .slideshow-bt.bt-on').removeClass('bt-on');
	$(o).addClass('bt-on');
	
	nxt.css('z-index',2);
	
	current.css('z-index',3).fadeOut(500,function()
	{
		$(this).css('z-index','1').show();
		var img = nxt.next('a').find('img[imgsrc]');
		if (img.length > 0)
		{
			img.attr('src',img.attr('imgsrc')).removeAttr('imgsrc');
		}
	});
}
//slideshow end


//--------------------------------------------------------- 
function get_live_status(){ /* 首页直播设置 */
	var d = new Date(); //alert(d.getHours());
	if(d.getHours() <19) return; // 到19点才计时

	get_live_status_do();
	interval = window.setInterval(function(){ get_live_status_do(); }, 60000);
	//window.clearInterval(interval);	
}
function get_live_status_do(){
	$.post("/ajax/home_page.php?action=index_live", { key:'v' }, 
	function(data){	//alert(data);
		if(data !="" ){
			var pos=data.indexOf('@');
			var program_id=data.substring(0,pos);
			var tmp=data.substr(pos+1);

			var ps=tmp.indexOf('@');
			var img_url=tmp.substring(0,ps); 
			var title=tmp.substr(ps+1);

			$('#lmhd_live').show(); //显示直播div
			$('#lmhd_default').hide(); //隐藏在路上首图
			//$('#live_title').text(title);
			$('#lmhd_live_url_1').attr('href','/live/'+program_id);//直播链接
			$('#lmhd_live_url_2').attr('href','/live/'+program_id);
			$('#lmhd_live_url_3').attr('href','/live/'+program_id);
			$('#lmhd_live_src').attr('src','/'+img_url);//图片链接
		}else{
			$('#lmhd_live').hide();
			$('#lmhd_default').show();
		}
	});
}
//-------------------------------------------------------------------- 
