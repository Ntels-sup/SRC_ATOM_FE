var $gnb,$dep_01,$dep_01_li,$dep_01_a,$dep_02,$dep_02_li,$dep_02_a,$dep_02_bg,$step_bg;
$(function(){
  // gnb 
  $gnb = $('.gnb');
  $dep_01 = $gnb.find('.dep_01');
  $dep_01_li = $dep_01.children('ul').children('li');
  $dep_01_a = $dep_01_li.children('a');
  $dep_02 = $gnb.find('.dep_02');
  $dep_02_li = $dep_02.children('ul').children('li');
  $dep_02_a = $dep_02_li.find('a');
  $dep_02_bg = $dep_02.find('.bg');

  // load gnb
  for (var i = 0; i < $dep_02_li.length; i++) {
    $dep_02_li.eq(i).css('top',$dep_01_li.eq(i).position().top);
  }
  setActiveMenu();
  for (var i = 0; i < $dep_01_a.length; i++) {
    var t = 150;
    //hover
    $dep_01_a.eq(i).hover(function(){
      // $dep_02_li show animation
      var $index = $(this).parents('li').index();
        dep_02_setActive($dep_02_li.eq($index));
      // $dep_02 slide animation
      //if($dep_02_li.eq($index).find('a').length){
      if($dep_02_li.eq($index).find('li').length){
        dep_02Show();
      }else{
        dep_02Hide();
      }
      // $dep_01 icon hover animation
      gnbHover($(this));
    },function(){
      if(!$(this).parents('li').hasClass('on')){
        gnbHoverOut($(this));
      }
    });
    // click
    $dep_01_a.eq(i).on('click', function(){
      $dep_02.find('li').removeClass('on');
      $(this).parent('li').addClass('on').siblings('li').removeClass('on');

      gnbHover($(this));
      gnbBgActive($(this));
      var $this_sibling = $(this).parent('li').siblings('li').children('a'); 
      gnbHoverOut($this_sibling);
      gnbBgActiveRemove($this_sibling);
    });
  }
  // gnb hover animation
  $gnb.hover(function(){
  },function(){
    setActiveMenu();
    
    if(!$dep_02.find('li.on').length){
      dep_02Hide();
    }
    
    /*if($(".menu_01").hasClass('on')) dep_02Hide();*/
  })
  for (var i = 0; i < $dep_02_a.length; i++) {
    // load
/*    if($dep_02_a.eq(i).parent('li').hasClass('on')){
      $dep_02_a.eq(i).animate({
        backgroundColor:"#14a79f"
      },{duration:500},"fast","swing")
    }*/
    // hover
    $dep_02_a.eq(i).hover(function(){
      $(this).animate({
        //backgroundColor:"#14a79f"
      },{duration:150},"fast","swing").parent('li').siblings().find('a').animate({
        backgroundColor:"transparent"
      },{duration:50},"fast","swing");
      var index = $(this).parent('li').parents('li').index();
      gnbHover($dep_01_li.eq(index).find('a'));
      $dep_01_li.eq(index).filter(function(index ) {
        return (!$(this).hasClass("on"));
      }).css("backgroundColor", "#efefef"); /* solgit */

    },function(){
      if(!$(this).parent().hasClass('on')){
        $(this).animate({
          backgroundColor:"transparent"
        },{duration:50},"fast","swing")
      }
      var index = $(this).parent('li').parents('li').index();
      $dep_01_li.eq(index).filter(function(index ) {
        return (!$(this).hasClass("on"));
      }).css("backgroundColor", ""); /* solgit */
    })
    // click
    $dep_02_a.eq(i).on('click',function(){
      $dep_01_a.parent('li').removeClass('on');
      $dep_02_a.parent('li').removeClass('on');
      $(this).parent('li').addClass('on');
    }); 
  }
  // gnb end
  
  inputFocus();//input focus class common
  tableEvent();//table hover&check in dashboard
  btnHover();//btn hover class common
  fileInputHover();
  checkboxHover();
});
// $function end
function dep_02Show(){
  var $dep_02 = $('.gnb').find('.dep_02');
  $dep_02.animate({
    top:'0px',
    opacity:1
  },{duration:150},"fast","swing")
}
function dep_02Hide(){
  var $dep_02 = $('.gnb').find('.dep_02');
  $dep_02.animate({
    top:'-50px',
    opacity:0
  },{duration:150},"fast","swing")
}
function dep_02_setActive(e){
  e.animate({
    display:'block',
    opacity:'1'
  },{duration:150},"fast","swing").siblings().animate({
    display:'none',
    opacity:'0'
  },{duration:150},"fast","swing");
}
function gnbBgActive(e){
  e.find('.bg').animate({
    right:'0'
  },{duration:150},"fast","swing");
}
function gnbBgActiveRemove(e){
  e.find('.bg').animate({
    right:'10px'
  },{duration:150},"fast","swing");
}
function gnbHover(e){
  var t = 0;
  e.animate({
    //color:'#00b9af'
  },{duration:t},"fast","swing").find('.icon').animate({
    opacity:1
  },{duration:t},"fast","swing").siblings('.icon_hover').animate({
    opacity:1
  },{duration:t},"fast","swing")
}
function gnbHoverOut(e){
  var t = 0;
  e.animate({
    //color:'#7b828c'
  },{duration:t},"fast","swing").find('.icon').animate({
    opacity:1
  },{duration:t},"fast","swing").siblings('.icon_hover').animate({
    opacity:0
  },{duration:t},"fast","swing")
}
//load, mouseleave 시점 실행
function setActiveMenu(){
  var $active = $gnb.find('.on');
  if($active.parents().hasClass('dep_02')){
    var index = $active.parents('li').index(); 
    $dep_01_li.eq(index).addClass('on');
    gnbHover($dep_01_li.eq(index).find('a'));
    gnbHoverOut($dep_01_li.eq(index).siblings('li').find('a'));
    gnbBgActive($dep_01_li.eq(index).find('a'));
    gnbBgActiveRemove($dep_01_li.eq(index).siblings().find('a'));
    dep_02_setActive($active.parents('li'));
    dep_02Hide();
/*    $dep_02_a.parent('li').filter('.on').find('a').animate({
      backgroundColor:"#14a79f"
    },{duration:500},"fast","swing");*/
  }else{
    gnbHover($active.find('a'));
    gnbHoverOut($active.siblings().find('a'));
    gnbBgActive($active.find('a'));
    gnbBgActiveRemove($active.siblings().find('a'));
  }
}

//input focus class common
function inputFocus(){
    var $input = $('input,textarea');
    for (var i = 0; i < $input.length; i++) {
        $input.eq(i).focusin(function(){
            $(this).parent().addClass('focus');
        });
        $input.eq(i).focusout(function(){
            $(this).parent().removeClass('focus');
        });
    }
}
//table hover&check in dashboard
function tableEvent(){
    var $tbl_event = $('table.event');
    var $toe = $tbl_event.find('.toe');
    for (var i = 0; i < $tbl_event.length; i++) {
        $tbl_td = $tbl_event.eq(i).find('td');
        $tbl_td.hover(function(){
            $(this).parent('tr').addClass('hover');
        },function(){
            $(this).parent('tr').removeClass('hover');
        });
        if($tbl_event.eq(i).find('input:checkbox').length>0){//itm제어
            $tbl_td.on('click',function(e){
                var $target = e.target;
                if ($target.nodeName!=="BUTTON"){//임의제어 설정 버튼 액션 제외
                    var $checkbox = $(this).parent('tr').find('.checkbox').find('input');
                    $(this).parent('tr').toggleClass('check');
                    if($checkbox.is(':checked')){
                        $checkbox.prop('checked',false).parents('tr').removeClass('check');
                    }else{
                        $checkbox.prop('checked',true).parents('tr').addClass('check');
                    }
                }
            });
        }else{//dashboard
            $tbl_td.on('click',function(){
                $(this).parent('tr').addClass('check').siblings('tr').removeClass('check');
            });
        }
    }
    if($toe.length){
        for (var i = 0; i < $toe.length; i++) {
            $toe.eq(i).attr('title',$toe.eq(i).text());
        }
    }

}
//btn hover class common
function btnHover(){
  var $btn = $('button');
  for (var i = 0; i < $btn.length; i++) {
    $btn.eq(i).hover(function(){
        $(this).addClass('hover');
    },function(){
        $(this).removeClass('hover');
    });
  }
}
function checkboxHover(){
  var $checkbox = $('.checkbox');
  for (var i = 0; i < $checkbox.length; i++) {
    $checkbox.eq(i).hover(function(){
        $(this).addClass('hover');
    },function(){
        $(this).removeClass('hover');
    });
  }
}
function fileInputHover(){
  var $file_input = $('.file_input').find('.fi_hid');
  for (var i = 0; i < $file_input.length; i++) {
    $file_input.eq(i).hover(function(){
        $(this).parents('.file_input').addClass('hover');
    },function(){
        $(this).parents('.file_input').removeClass('hover');
    });
  }
}

//pie chart
document.addEventListener('DOMContentLoaded', function() {
  var chart = window.chart = new EasyPieChart(document.querySelector('.devchart1'), {
    easing: 'easeOutElastic',
    delay: 3000,
    barColor: '#61c2f2',
    trackColor: '#eeeeee',
    scaleColor: false,
    lineWidth: 12,
    trackWidth: 11,
    lineCap: 'butt',
    onStep: function(from, to, percent) {
      this.el.children[0].innerHTML = Math.round(percent);
    }
  });
});
document.addEventListener('DOMContentLoaded', function() {
  var chart = window.chart = new EasyPieChart(document.querySelector('.devchart2'), {
    easing: 'easeOutElastic',
    delay: 3000,
    barColor: '#61c2f2',
    trackColor: '#eeeeee',
    scaleColor: false,
    lineWidth: 12,
    trackWidth: 11,
    lineCap: 'butt',
    onStep: function(froiㅕm, to, percent) {
      this.el.children[0].innerHTML = Math.round(percent);
    }
  });
});
document.addEventListener('DOMContentLoaded', function() {
  var chart = window.chart = new EasyPieChart(document.querySelector('.devchart3'), {
    easing: 'easeOutElastic',
    delay: 3000,
    barColor: '#61c2f2',
    trackColor: '#eeeeee',
    scaleColor: false,
    lineWidth: 12,
    trackWidth: 11,
    lineCap: 'butt',
    onStep: function(from, to, percent) {
      this.el.children[0].innerHTML = Math.round(percent);
    }
  });
});