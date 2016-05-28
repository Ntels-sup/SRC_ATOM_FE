<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html lang="en_US">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><spring:message code="label.common.title"/></title>
<!--[if lt IE 9]>
	<script src="../scripts/html5.js"></script>
<![endif]-->
<link rel="stylesheet" href="/styles/style.css">
<link rel="stylesheet" href="/styles/custom.css">
<script src="/scripts/jquery.1.11.2.min.js"></script>
<script src="/scripts/jquery-ui.min.js"></script>
<script src="/scripts/menu-ui.js"></script>
<script src="/scripts/datepicker.min.js"></script>
<script src="/scripts/clockpicker.min.js"></script>
<script src="/scripts/multiple-select.js"></script>
<script src="/scripts/jquery.simplemodal.js"></script> 
<script src="/scripts/modal.js"></script>
<script src="/scripts/jwebsocket/1_0_b1/jWebSocket.js"></script>
<script src="/scripts/jwebsocket/pfnmWebSocket.js"></script>
<script src="/scripts/amcharts_3.19.4/amcharts/amcharts.js"></script>
<script src="/scripts/amcharts_3.19.4/amcharts/serial.js"></script>
<script src="/scripts/amcharts_3.19.4/amcharts/pie.js"></script>
<script src="/scripts/amcharts_3.19.4/amcharts/plugins/export/export.js"></script>
<script src="/scripts/menu/modernizr-custom.js"></script>
<script src="/scripts/menu/classie.js"></script>
<script src="/scripts/menu/main.js"></script>
<script src="/scripts/jquery.easypiechart.js"></script>
<script src="/scripts/custom/local.storage.js"></script>
<script src="/scripts/custom/open.window.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/goMenuPage.js"></script>

<script type="text/javascript">
<!--
	window.history.forward();

	$(document).ready(function() {
		$(this).contextmenu(function(e) { 
			return false; 
		});
		
		fnKeepAlive();
	});
	
	var refreshId = null;

	function fnKeepAlive(){
		console.log("fnKeepAlive()...");
	 	refreshId = setInterval(function() {
	 		var result = 
		 		$.ajax({
		 			url : "/common/keepAlive",
		 			type : "POST",
		 			async : false,
		 			cache : false
		 		});
	 		
	 		result.done(function(data) {
	 			console.log(data);
	 			if (data == 1) { //서버 세션 잃어버림
	 				fnKeepAliveEnd();
	 			} else if (data == 2) { //유저 강제 종료 
	 				fnKeepAliveEnd();
	 			}
	 		});
	 			 		
		 	result.fail(function(xhr, status) {
				fnKeepAliveEnd();
	 		});
			
	 		if (result !== null) result = null;
			
	 		clearInterval(refreshId);
	 		fnKeepAlive();		
	 		
		}, 30 * 1000);
	}
	
	function fnKeepAliveEnd() {
		clearInterval(refreshId);
		//fnCloseWindowAll(); //모든 팝업 닫기
		location.replace("/"); //root 이동
	}
	
	
	// 엑셀 다운로드 추가
	jQuery.download = function(url, data, method){
	    // url과 data를 입력받음
	    if( url && data ){ 
	        // data 는  string 또는 array/object 를 파라미터로 받는다.
	        data = typeof data == 'string' ? data : jQuery.param(data);
	        // 파라미터를 form의  input으로 만든다.
	        var inputs = '';
	        jQuery.each(data.split('&'), function(){ 
	            var pair = this.split('=');
	            inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
	        });
	        // request를 보낸다.
	        jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>').appendTo('body').submit().remove();
	    };
	};
	
	
	
//-->
</script>
</head>
<body>
	<div class="wrap">
	<tiles:insertAttribute name="header" ignore="true" />
	<div id="aaaa"><tiles:insertAttribute name="body" /></div>
	<tiles:insertAttribute name="footer" />
	</div>
<form name="frmMenuHandle"></form>
</body>
</html>