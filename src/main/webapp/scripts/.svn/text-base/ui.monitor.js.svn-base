/*-----------------------------------------------------------------
  * Multi Select
-----------------------------------------------------------------*/
$(document).ready(function(){
 $("select.group").multipleSelect({
			filter: true,
            multiple: true,
            multipleWidth: 150,
            width: "602px"
        });

 $("select.group_single").multipleSelect({
			filter: true,
			single: true,  
            multiple: true,
            multipleWidth: 150,
            width: "602px"
        });
 $("select.multi").multipleSelect({
		   	filter: true,
            multiple: true,
			multipleWidth: 150,
            width: "162px"
        });
 $("select.single").multipleSelect({
	        single: true,
	        selectAll: false,
            multiple: false,
        });	
 $("select.bottom").multipleSelect({
	        single: true,
	        selectAll: false,
            multiple: false,
            position: "top",
        });
 $("select.multi,select.group").multipleSelect("checkAll");
 
/* Clock */
 $(".clockpicker").clockpicker()
		  .find("input").change(function(){
			console.log(this.value);
		  });
});
   
/* Calendar */
 $(document).ready(function () {
        $('.input-group.date').datepicker({
            language: "kr",
            autoclose: true,
            todayHighlight: true
        });
});

/*-----------------------------------------------------------------
  * TABLE Row 추가/삭제 
-----------------------------------------------------------------*/
 
 $(document).ready(function(){
  // 키값 rowTag로 테이블의 기본 row 값의 Html태그 저장
  var rowTag = $(".list table tbody").html();
  $(".tbl_update").data("rowTag", rowTag);  //키값 rowTag로 테이블의 기본 row 값의 Html태그 저장
 }); 
    
 // 행추가 기능
 function rowAdd(){
  $(".list table tbody").append($(".tbl_update").data("rowTag")); //rowTag의 키값으로 저장된 Html값 호출하여 테이블에 추가
 }
 
 // 현재행 삭제 기능
 function rowDelete(obj){
  $(obj).parent().parent().remove();
 }

 // 체크박스 선택행 삭제 기능 
 function rowCheDel(){
  var $obj = $("input[name='chk']");
  var checkCount = $obj.size();
  for (var i=0; i<checkCount; i++){
   if($obj.eq(i).is(":checked")){
   $obj.eq(i).parent().parent().remove();
   }
  }
 }

 // 체크박스 전체선택/해제 기능
 function selectAll(){
  if($("#chk_list").is(":checked")){

  //  $("input[name=chk]").attr("checked",true);
  $("input[name=chk]").prop("checked",true);
  }
  else{
   $("input[name=chk]").prop("checked",false);
  }
 }
 
 
/*-----------------------------------------------------------------
  * table hover event
-----------------------------------------------------------------*/
/*jQuery("document").ready(function($){  var $tbl = $('.table.hover_event');
  var $tbl_tr = $tbl.find('tbody tr');
  for (var i = 0; i < $tbl_tr.length; i++) {
    $tbl_tr.eq(i).hover(function(){
      $(this).addClass('hover');
      if($(this).filter('.sev')){
        $get_lv_class = $(this).find('.sev').attr('class');
        $(this).addClass($get_lv_class).removeClass('sev')
      }
    },function(){
      $(this).removeClass();
    })
  }
 });*/
 
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
                	breadcrumbsCtrl : false,
                });
    
        })();

});

//pie chart
document.addEventListener('DOMContentLoaded', function() {
  var tarDiv = ['.devchart1','.devchart2','.devchart3','.devchart4'];
  for(idx =0 ; idx<tarDiv.length ; idx++){
	  $(tarDiv[idx]).easyPieChart({
	        easing: 'easeInOut',
	        delay: 3000,
	        barColor: '#00a8eb',
	        trackColor: '#e3e4e6',
	        scaleColor: false,
	        lineWidth: 16,
	        trackWidth: 16,
	        lineCap: 'butt',
	        onStep: function(from, to, percent) {
	          this.el.children[0].innerHTML = Math.round(percent);
	        }
	    });
	  
   
  }
});