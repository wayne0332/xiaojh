var mapPanel = $("#mapPanel");
var advPanel = $("#advPanel");
var mapBar = $("#mapBar");
var mapToAdv = $("#mapToAdv");
var advToMap = $("#advToMap");

$(function() {
	// 首页广告和地图的切换
	mapToAdv.click(function() {
		mapPanel.fadeOut(300);
		mapBar.hide(300);
		advPanel.delay(350).fadeIn(500);
		mapToAdv.fadeOut(300);
		advToMap.delay(350).show(300);
	});
	advToMap.click(function() {
		mapPanel.delay(350).fadeIn(300);
		mapBar.delay(350).fadeIn(300);
		advPanel.hide(300);
		advToMap.fadeOut(300);
		mapToAdv.delay(350).show(300);
	});
});

$(function() {
	$(".cityMap_nankai").click(function() {
		$(".campusList").hide(300);
		$(".ulNankai").delay(350).show(500);
	});
	$(".cityMap_xiqing").click(function() {
		$(".campusList").hide(300);
		$(".ulXiqing").delay(350).show(500);
	});
	$(".cityMap_hexi").click(function() {
		$(".campusList").hide(300);
		$(".ulHexi").delay(350).show(500);
	});
	$(".cityMap_hebei").click(function() {
		$(".campusList").hide(300);
		$(".ulHebei").delay(350).show(500);
	});
	$(".cityMap_beicheng").click(function() {
		$(".campusList").hide(300);
		$(".ulBeicheng").delay(350).show(500);
	});
	$(".cityMap_wuqing").click(function() {
		$(".campusList").hide(300);
		$(".ulWuqing").delay(350).show(500);
	});
	$(".cityMap_dongli").click(function() {
		$(".campusList").hide(300);
		$(".ulDongli").delay(350).show(500);
	});
});