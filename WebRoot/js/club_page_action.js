$(function(){
	$(".club_act_box").on('mouseenter',function() {
		$(this).find(".club_act_info").fadeIn(300);
	});
	$(".club_act_box").on('mouseleave',function() {
		$(this).find(".club_act_info").fadeOut(300);
	});
});