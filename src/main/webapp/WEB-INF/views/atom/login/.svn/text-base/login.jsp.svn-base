<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>

<%@ page import="javax.servlet.http.HttpSession"  %>
<%@ page import="com.ntels.avocado.domain.common.SessionUser"  %>
<%@ page import="com.ntels.avocado.common.Consts"  %>

<%
	String browser = null;
	browser = request.getHeader("User-Agent");
	browser = browser.toUpperCase();
    
	if ((browser != null) && (browser.indexOf("CHROME") != -1)) {
%>

<!--[if lt IE 9]>
	<script src="../scripts/html5.js"></script>
<![endif]-->

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><spring:message code='label.common.title'/></title>

	<link rel="stylesheet" href="/styles/style.css">
		
<!--[if lt IE 9]>
	<script src="../scripts/html5.js"></script>
<![endif]-->
<link rel="stylesheet" href="/styles/style.css">
<script type="text/javascript" charset="utf-8" src="/scripts/jquery.1.11.2.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/multiple-select.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/goMenuPage.js"></script>

<script type="text/javascript" charset="utf-8" src="/scripts/rsa/jsbn.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/rsa/rsa.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/rsa/prng4.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/rsa/rng.js"></script>

<script type="text/javascript">
window.history.forward();

/**
 * 빈페이지로 이동
 */
function fnRedirectBlank( loginResult, dueDay ) {
	
	var frm = makeform("/main/main");
	if( loginResult != "undefined" ) 
		frm.appendChild(AddData("loginResult", loginResult));
	if( dueDay != "undefined" ) 
		frm.appendChild(AddData("dueDay", dueDay));
    
	frm.submit();      	
}

$(document).ready(function() {
	
	$("#userId").focus();
	$("#infoMsg").removeClass("on");
	$("#infoMsg").text("");
	
	var tdObj = $(".drop_box");
	var langOption = "";
	
	langOption = langOption + '<select class="single" id="language">';
	langOption = langOption + '		<option value="en_US"><spring:message code="label.locale.english.label"/></option>';
	langOption = langOption + '		<option value="ko_KR"><spring:message code="label.locale.korea.label"/></option>';
	langOption = langOption + '</select>';
	
	$(tdObj).empty();
 	$(tdObj).append(langOption);
 	
 	$("select[id=language]").multipleSelect({
		single		: true,
        onClick		: function(view){
        	
       		console.log('[mirinae.maru] view.value : ' + view.value );
       		
       		var frm = makeform("/login/login");
       		frm.appendChild(AddData("language", view.value));
            
        	frm.submit();     
        } 
	},"refresh");
 	
 	$("select[id=language]").multipleSelect('setSelects',["${pageContext.response.locale}"]);
 	
 	var param = new Object();
 	param.dummy="dummyVal";
 	$.ajax({
        url		: '/atom/login/makeDummy',
        type	: 'POST',
        data	: param,
        dataType: 'json',
        success	: function(data){
         	$("#rsaPublicKeyModulus").val( data.publicKeyModulus );
        	$("#rsaPublicKeyExponent").val( data.publicKeyExponent );
        },
        error	: function(e){},
        complete: function() {}
    });
});

function showMessage( message ) {
	$("#infoMsg").addClass( "on" );
	$("#infoMsg").text( message );
}

function login() {

	var f = document.formLogin;
	
	if(f.userId.value == "") {
		showMessage( "<spring:message code='msg.login.user.id'/>" );
        f.userId.focus();
        return;
    }
	
	var letterNumber = /^[0-9a-zA-Z]+$/;
	
	if(!f.userId.value.match(letterNumber)){
		showMessage( "<spring:message code='msg.login.user.id.valid'/>" );
		f.userId.focus();
      	return;  
    }
	
	if(f.password.value == "") {
		showMessage("<spring:message code='msg.login.password'/>");
		f.userId.focus();
      	return;  
    }
	
	var rsaPublicKeyModulus = $("#rsaPublicKeyModulus").val();
	var rsaPublicKeyExponent = $("#rsaPublicKeyExponent").val();
	
	var rsa = new RSAKey();
    rsa.setPublic(rsaPublicKeyModulus, rsaPublicKeyExponent);
	
    // 사용자ID와 비밀번호를 RSA로 암호화한다.
    var securedUsername = rsa.encrypt($("#userId").val());
    var securedPassword = rsa.encrypt($("#password").val());
	
	var param = new Object();
	param.userId = securedUsername;
	param.password = securedPassword;
    
    $.ajax({
        url:  '/atom/login/loginAction',
        type: 'POST',
        data: param,
        dataType:'json',
        success: function(data){
        	
        	authMenu = data.authMenu;
        	
        	if (data.result == -1) { //에러
        		showMessage( "<spring:message code='msg.login.error.login'/>" );
        	} 
        	else if (data.result == 0) { //로그인 성공
        		fnRedirectBlank();
        	} 
        	else if (data.result == 1) { //로그인 실패 (패스워드 실패)
        		if( data.failCount == -1 ) { 
        			showMessage('<spring:message code="msg.login.failed.account"/>');
        			setTimeout( function() {
        				makeform("/login/login").submit();
        		      }, 1500 );
        		}
        		else {
        			showMessage('<spring:message code="msg.login.failed.account2" arguments="'+data.failCount+','+data.limitCount+'"/>');
        		}
			} 
        	else if (data.result == 2) { //로그인 실패 (없는 계정) 	
        		showMessage('<spring:message code="msg.login.failed.account"/>');
        		$("#userId").val("");
        		$("#password").val("");
        		
        		setTimeout( function() {
    				makeform("/login/login").submit();
    		      }, 1500 );
			} 
        	else if (data.result == 5) { //config.properties 설정 파일 에러
        		showMessage('<spring:message code="msg.login.error.configuration"/>');
			} 
        	else if (data.result == 100) { //필수파라메터(아아디 / 비번) null 에러 
        		showMessage('<spring:message code="msg.login.failed.input.value"/>');
			} 
        	else if (data.result == 200) { //총 접속 유저수 제한 
        		showMessage('<spring:message code="msg.login.failed.over.count"/>');
			} 
        	else if (data.result == 300) { //사용자 계정 잠김 여부
        		showMessage('<spring:message code="msg.login.failed.lock.account"/>');
			} 
        	else if (data.result == 400) { //중복 접속 유저인지 여부
        		showMessage('<spring:message code="msg.login.failed.duplicated"/>');
			} 
        	else if (data.result == 500) { //접속 IP 확인 여부
        		showMessage('<spring:message code="msg.login.failed.pass.ip.bandwidth"/>');
			} 
        	else if (data.result == 600) { //계정 기한 만료
        		showMessage('<spring:message code="msg.login.failed.expired.account"/>');
			} 
        	else if (data.result == 650) { //장기 미접속으로 lock
        		showMessage('<spring:message code="msg.login.failed.absent.lock.account"/>');
			} 
        	else if (data.result == 700) { //계정기한 만료하기전 알림(노티)
        		showMessage('<spring:message code="msg.login.failed.expired.account.noti" arguments="'+data.dueDay+'"/>');
        		fnRedirectBlank(data.result, data.dueDay);
			} 
        	else if (data.result == 800) { //패스워드 기간 만료하기전 알림(노티)
				
	        		/*if (data.dueDay == 0) {
						showMessage('<spring:message code="msg.login.failed.expired.password"/>');
					} else {
						showMessage('<spring:message code="msg.login.failed.expired.password.noti" arguments="'+data.dueDay+'"/>');
					}*/
					
	        		fnRedirectBlank(data.result);
				} 
	        	else if (data.result == 880) { //관리자가 등록한 패스워드 변경 알림(노티)
	        	
	        		//showMessage('<spring:message code="msg.login.admin.registered.passwd"/>');
	        	
	        		fnRedirectBlank(data.result);
				} 
	        	else if (data.result == 900) { //모름
	        		showMessage('<spring:message code="msg.login.failed.unknown"/>');
				} 
			},
        error: function(e){
            if(typeof e.reponseText == "undefined") {
            	showMessage('<spring:message code="msg.login.error.webserver"/>');
            } 
            else {
            	alert(e.reponseText);  
            }
        },
        complete: function() {
        	//$("#userId").val("");
        	$("#password").val("");
        	f.userId.focus();
        }
    });
}
</script>
</head>

<body class="login">
	<div class="wrap">
		<div class="visual">
			<div class="logo">
				<p><spring:message code="label.browser.google.info1"/></p>
				<span><spring:message code="label.browser.google.info2"/></span>
			</div>
		</div>
		<div class="idpw">
			<form method="post" action="/login/login" name="formLogin">
			<div class="form">
				<input type="hidden" id="loginResult" name="loginResult" value=""/>
				<input type="hidden" id="rsaPublicKeyModulus" 	value="" />
				<input type="hidden" id="rsaPublicKeyExponent" 	value="" />
				<p><spring:message code="label.welcome.label"/></p>
				<span><spring:message code="label.welcome.login.label"/></span>
				<div class="drop_box"></div>
				<div class="insert_box">
					<input type="text" id="userId" name="userId" placeholder="User ID" maxlength="20" onkeydown="javascript:if(event.keyCode == 13){login();}" />
				</div>
				<div class="insert_box">
					<input type="password" id="password" name="password" placeholder="Password" maxlength="20" onkeydown="javascript:if(event.keyCode == 13){login();}" />
				</div>
				<div class="btn">
					<button type="button" onclick="javascript:login()"><spring:message code="msg.login.message.label"/></button>				
				</div>
				<div id="infoMsg" class="info"></div>
				<span id="infoMsg2" class="info"></span>
			</div>
			</form>
		</div>
	</div>

</body>

<!-- bg ani script -->
<script src="/scripts/login.js"></script> 	

<form name="frmMenuHandle"></form> <!-- 폼전송시 필요 -->


<%		
	} else {
%>
	<%--
	<!DOCTYPE html>
	<html>
	<head>
	   <meta charset="utf-8" />
	   <title>Download Google Chrome</title>
	   <style type="text/css">
	      body{background:url(../images/login_bg.gif); padding:200px 0 0 0;}
	      h1, legend{display:none;}      
	      div.downBox{width:530px; height:414px;background:url(/images/download_img.png) no-repeat; margin:0 auto;} 
	      a.chrome{width:238px; height:37px; display:block; position:relative; top:245px;margin:0 auto;background:url(/images/chrome_downpage.png);}
	      a.chrome:hover{background:url(/images/chrome_downpage.png) left -37px;}
		  .logo{width:149px;height:28px;position:relative;top:275px;margin:0 auto;background:url(/images/chrome_downpage_cgw.png) no-repeat;}
		  address{text-align:center; color:#898989; font: 11px Tahoma; position:relative; top:335px;}     
	   </style>
	</head>
	
	<body>
		<h1><span>Download Google Chrome</span></h1>
		<div class="downBox">
	       <a href="/help/download/ChromeStandaloneSetup.exe" class="chrome" title="Download Google Chrome "></a>
	       <p class="logo"></p>
		</div>	
	</body>
	</html>
	--%>
	<!DOCTYPE html>
	<html lang="en">
	<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>ATOM</title>
	<!--[if lt IE 9]>
		<script src="../scripts/html5.js"></script>
	<![endif]-->
	<link rel="stylesheet" href="/styles/style.css">
	</head>
	<body>
		<div class="chrome">
			<div class="info">
				<header>
					<h1><spring:message code='label.common.title'/></h1>
					<span><spring:message code='label.browser.message'/></span>
				</header>
				<h2><spring:message code='label.browser.google.download.install'/></h2>
				<p><spring:message code='label.browser.google.download.install.message'/></p>
				<button href="/help/download/ChromeStandaloneSetup.exe"><spring:message code='label.browser.google.download.chrome'/></button>
			</div>
		</div>
	</body>
<%		
	}
%>