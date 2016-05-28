 
/*-----------------------------------------------------------------
  * Top menu scroll
-----------------------------------------------------------------*/
	jQuery("document").ready(function($){
	var nav = $('.nav-container');
	$(window).scroll(function () {
		if ($(this).scrollTop() > 0) {
			nav.addClass("f-nav");
		} else {
			nav.removeClass("f-nav");
		}
	});

	var div = $('.trigger-menu');
	$(window).scroll(function () {
		if ($(this).scrollTop() > 0) {
			$('.trigger-menu').addClass("f-trigger");
		} else {
			$('.trigger-menu').removeClass("f-trigger");
		}
	});
	
	var ul = $('.left-menu');
	$(window).scroll(function () {
		if ($(this).scrollTop() > 0) {
			ul.addClass("f-menu");
		} else {
			ul.removeClass("f-menu");
		}
	});
	var h1 = $('.action');
	$(window).scroll(function () {
		if ($(this).scrollTop() > 0) {
			h1.addClass("f-h1");
		} else {
			h1.removeClass("f-h1");
		}
	});
	var div = $('.properties');
	$(window).scroll(function () {
		if ($(this).scrollTop() > 0) {
			$('.properties').css("margin-top", "-70px");
		} else {
			$('.properties').css("margin-top", "0px");
		}
	});	
});
	
/* hamburger menu icon */
$( document ).ready(function() {
  var hamburger = $('#hamburger-icon');
  hamburger.click(function() {
     hamburger.toggleClass('active');
     return false;
  });
});

/*-----------------------------------------------------------------
  * snb
-----------------------------------------------------------------*/
/* snb Sliding Menu animation*/
$(document).ready(function(){
  function fliSmallMenu(){
    var $block = $('.sliding[data-type="menu-slide"]'),
        $menu = $block.find('.left-menu'),
        $icon = $block.find('.trigger-menu'),
        $bars = $icon.find('span');
    $icon.on('click',function(e){
      e.preventDefault();
	  $('.content').addClass('change');/* margin-left를 주어 화면이 밀리게 처리함 */
	  $('.page_title > h2').addClass('change');/* margin-left를 주어 화면이 밀리게 처리함 */
	  $('.nav-container > ul').addClass('change');   /* margin-left를 주어 화면이 밀리게 처리함 */
	  $('.search_area > div').addClass('change');   /* margin-left를 주어 화면이 밀리게 처리함 */

	  
      if($menu.hasClass('active')){
        $menu.removeClass('active');
        $bars.removeClass('close-btn');
		$('.action').removeClass('change');
	    $('.content').removeClass('change');  
	    $('.page_title > h2').removeClass('change');   
	    $('.nav-container > ul').removeClass('change');
		$('.search_area > div').removeClass('change');
      }
      else{
        $menu.addClass('active');
        $bars.addClass('close-btn');
		$('.action').addClass('change');
	    $('.content').addClass('change');
	    $('.page_title > h2').addClass('change');
	    $('.nav-container > ul').addClass('change');  
		$('.search_area > div').addClass('change');
      }
    });
  }
  fliSmallMenu();
});

/* Left Menu 3depth*/
$(document).ready(function(){
        (function() {
            var menuEl = document.getElementById('ml-menu'),
                mlmenu = new MLMenu(menuEl, {
                });
    
        })();

});

