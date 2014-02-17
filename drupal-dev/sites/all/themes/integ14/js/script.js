(function($){
$(document).ready(function() {

/***************************** Go to top  *********************************/
var $scroll = $('.scrollup');
$(window).scroll(function(){
	if ($(this).scrollTop() > 900) {
		$scroll.fadeIn();
	} else {
		$scroll.fadeOut();
	}
}); 

$scroll.click(function(){
	$("html, body").animate({ scrollTop: 0 }, 600);
	return false;
});

}); //end document ready
})(jQuery);