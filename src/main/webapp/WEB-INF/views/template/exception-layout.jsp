<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<html lang="${sessionUser.language}">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><spring:message code="label.common.err.title"/></title>
</head>
<link rel="stylesheet" href="/styles/style.css">
<script src="/scripts/jquery.1.11.2.min.js"></script>
<script src="/scripts/jquery-ui.min.js"></script>
<script src="/scripts/ui.js"></script>
<script src="/scripts/datepicker.min.js"></script>
<script src="/scripts/clockpicker.min.js"></script>
<script src="/scripts/multiple-select.js"></script>
<script src="/scripts/jquery.simplemodal.js"></script> 
<script type="text/javascript" src="/scripts/jwebsocket/1_0_b1/jWebSocket.js"></script>
<script src="/scripts/jwebsocket/pfnmWebSocket.js"></script>
<script src="/scripts/amcharts_3.19.4/amcharts/amcharts.js"></script>
<script src="/scripts/amcharts_3.19.4/amcharts/serial.js"></script>
<script src="/scripts/amcharts_3.19.4/amcharts/plugins/export/export.js"></script>
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
		//console.log("fnKeepAlive()...");
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
	
	function fnCloseConfirm() {
		try {			
			var prevUrl = document.referrer;
			if (prevUrl == "") prevUrl = "/";
			var frm = document.frmReturn;
			frm.action = prevUrl;
			frm.method = "post";
			frm.target = "";
			frm.submit(); 
		} catch(e) {
			
		}	  
	}
//-->
</script>	

<body>
<form name="frmReturn"></form>
<tiles:insertAttribute name="body" />
</body>
</html>