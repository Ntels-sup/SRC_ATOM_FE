<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<script src="/scripts/stringUtil.js"></script>

<script type="text/javascript" charset="utf-8" src="/scripts/rsa/jsbn.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/rsa/rsa.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/rsa/prng4.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/rsa/rng.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/pdf/help.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/openFullWindow/openFullWindow.js"></script>

<script type="text/javascript">
<!--

	var duplicatedTabMsg = "<spring:message code='msg.common.duplicated.newtab' />";
	
	$(document).ready(function() {
		/* $("#modalConfirm").hide();
		
		$("#logOutConfirm").click(function() {
			$("#modalConfirm").modal();
		}); */
		
	});
	
	/**
	 * 로그아웃 모달 닫기
	 */
	function closeModal() {
	    $.modal.close();
	}

	/**
	 * 화면 이동 함수
	 */
	function fnRedirect(url) {
		//console.log("-->"+url);
		document.frmRecent.action = url;
		document.frmRecent.target = "_parent";
		document.frmRecent.method = "post";
		document.frmRecent.submit();
	}
	
	/**
	 * 최근 목록 삭제 함수
	 */
	function fnRecentDelete(menuId) {
		var param = new Object();
		param.menuId = menuId;
		
		var res =
			$.ajax({
				url : "/common/removeRecent",
				dataType: "json", 
				data : param,
				type : "POST",
				cache: false
			});
			
		res.done(function(data) {
			//console.log("data->"+data);
			$("#recent_content > li").remove();
			if (data.length > 0) {
				$.each(data, function(index, values) {
					//console.log(values);
					$("#recent_content").append("<li><a href=\"javascript:fnRedirect('"+values.VIEW_PATH+"');\">"+values.MENU_NAME+"</a><a href=\"javascript:fnRecentDelete('"+values.MENU_ID+"');\" class=\"x\"><span>close</span></a></li>");
				});
			}
		});	
		res.fail(function(xhr, status) {
			console.log("fail :"+status);
		});
	}
	
	/**
	 * 로그 아웃 함수
	 */
	function fnLogOutOk() {
		
		fnCloseWindowAll(); //먼저 창을 닫아야 한다.
		
		document.frmRecent.action="<%=request.getContextPath()%>/atom/login/logoutAction";
		document.frmRecent.method="post";
		document.frmRecent.target="";
		document.frmRecent.submit();
	}
	
	function goUserInfo(){
		var frm = makeform("/atom/security/usermanage/detail");
		frm.appendChild(AddData("user_id", "${sessionUser.userId}"));
    	frm.submit(); 
	}
	
	$(document).ready(function() {
		
//	 	alert( "loginResult1 : ${loginResult}" );
		
		if( "${loginResult}" != "undefined" && "${loginResult}" != "" ) {
			// 패스워드 기간 만료하기전 알림(노티)
			if( ("${loginResult}"=='800') || ("${loginResult}"=='880') ) {
				
				//alert( "loginResult2 : ${loginResult}" );
				$('#passwdPopup').hide();
				$('#passwdPopup').modal();
				
				var param = new Object();
			 	param.dummy="dummyVal";
			 	$.ajax({
			        url		: '/atom/login/makeDummy',
			        type	: 'POST',
			        data	: param,
			        dataType: 'json',
			        success	: function(data){
			        	console.log("[mirinae.maru] makeDummy publicKeyModulus : " + data.publicKeyModulus);
			         	console.log("[mirinae.maru] makeDummy publicKeyExponent : " + data.publicKeyExponent);
			         	$("#rsaPublicKeyModulus").val( data.publicKeyModulus );
			        	$("#rsaPublicKeyExponent").val( data.publicKeyExponent );
			        },
			        error	: function(e){},
			        complete: function() {}
			    });
			}
			else if( "${loginResult}"=='700'  ) {
				openAlertModal("",'<spring:message code="msg.login.failed.expired.account.noti" arguments="${dueDay}"/>',function(){
	        	}); 
			}
		}
	});

	function changePassword() {
		
		if( $.trim($("#current_password").val())=="" ) {
			// 현재 비밀번호를 입력해 주세요.
			showMessage('<spring:message code="msg.change.password.current_password.msg" />');		
			$("#current_password").focus();
			return;
		}
		else if( $.trim($("#new_password1").val())=="" ) {
			// 새 비밀번호를 입력해 주세요.
			showMessage('<spring:message code="msg.change.password.new_password1.msg" />');
			$("#new_password1").focus();
			return;
		}
		else if( $.trim($("#new_password2").val())=="" ) {
			// 새 비밀번호 확인을 입력해 주세요.
			showMessage('<spring:message code="msg.change.password.new_password2.msg" />');
			$("#new_password2").focus();
			return;
		}
		else if( $.trim($("#new_password1").val())!=$.trim($("#new_password2").val()) ) {
			// 새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.
			showMessage('<spring:message code="msg.change.password.new_password.not_equal.msg" />');
			$("#new_password1").focus();
			$("#new_password1").val("");
			$("#new_password2").val("");
			return;
		}
		else if( $.trim($("#new_password1").val())==$.trim($("#current_password").val()) ) {
			// 현재 비밀번호와 다른 비밀번호를 입력해 주세요.
			showMessage('<spring:message code="msg.change.password.other_passwd.msg" />');
			$("#new_password1").focus();
			$("#new_password1").val("");
			$("#new_password2").val("");
			return;
		}
		else if(!isValidAlphaOrNum($("#new_password1").val())){
			// Please enter Password (alphabet+numbers).
			showMessage('<spring:message code="msg.security.usermanage.check_character.password" />');
			$("#new_password1").focus();
			$("#new_password1").val("");
			$("#new_password2").val("");
			return;
		}
		else {
			
			var rsaPublicKeyModulus 	= $("#rsaPublicKeyModulus").val();
			var rsaPublicKeyExponent 	= $("#rsaPublicKeyExponent").val();

			console.log( "[mirinae.maru] rsaPublicKeyModulus : " + rsaPublicKeyModulus );
			console.log( "[mirinae.maru] rsaPublicKeyExponent : " + rsaPublicKeyExponent );
			
			var rsa = new RSAKey();
		    rsa.setPublic(rsaPublicKeyModulus, rsaPublicKeyExponent);
		    
		        
			var param = new Object();
			param.current_password 	= rsa.encrypt($("#current_password").val());
			param.new_password 		= rsa.encrypt($("#new_password1").val());
			
			$.ajax({
	            url		:  '/atom/login/changePasswordAction',
	            type	: 'POST',
	            data	: param,
	            dataType:'json',
	            success	: function(data){
	            	
	            	//alert( "data.result : " + data.result);
	            	
	            	if( data.result=="-1" ) {
	            		showMessage('<spring:message code="msg.change.password.wrong_passwd.msg" />');
	            	}
	            	else if( data.result=="1" ) {
		            	closeModal();
		            	openAlertModal("",'<spring:message code="msg.change.password.change_complete.msg" />',function(){
		            	}); 
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
	            	$("#current_password").val("");
	            	$("#new_password1").val("");
	            	$("#new_password2").val("");
	            }
	        });
		}
	}

	function showMessage( message ) {
		$("#infoMsg").removeClass( "hide" );
		$("#infoMsg").addClass( "show" );
		$("#infoMsg").text( message );
	}
	
	function goChangePassword() {
		
		$('#passwdPopup').hide();
		$('#passwdPopup').modal();
		$('#passwdMsg').hide();
		
		var param = new Object();
	 	param.dummy="dummyVal";
	 	$.ajax({
	        url		: '/atom/login/makeDummy',
	        type	: 'POST',
	        data	: param,
	        dataType: 'json',
	        success	: function(data){
	        	console.log("[mirinae.maru] makeDummy publicKeyModulus : " + data.publicKeyModulus);
	         	console.log("[mirinae.maru] makeDummy publicKeyExponent : " + data.publicKeyExponent);
	         	$("#rsaPublicKeyModulus").val( data.publicKeyModulus );
	        	$("#rsaPublicKeyExponent").val( data.publicKeyExponent );
	        },
	        error	: function(e){},
	        complete: function() {}
	    });
	}
//-->
</script>

<form name="frmRecent"></form>

<div id="snb" class="sliding" data-type="menu-slide">
        <div class="trigger-menu" title="Package Menu"><span class="three-bars-icon"></span></div>
        <h1 class="action"><a href="#" class="logo">ATOM</a></h1>
        <div class="left-menu al-left">
        
        
		<nav id="ml-menu" class="menu">
			<div class="menu__wrap">
				
				${listPackageMenu}
				        
                
			</div>            
		</nav>
        </div> 
    </div>

    <div class="header">
        <div class="nav-container">
            <ul class="nav">
            	
            	<c:set var="index" value="0" /> <!-- 1뎁스 자식변수와 비교하기 위한 변수 -->
        		<c:set var="childCount" value="0" /> <!-- 1뎁스 자식 개수 변수 -->
        		
        		<c:set var="indexSub" value="0" /> <!-- 2뎁스 자식변수와 비교하기 위한 변수 -->
        		<c:set var="childSubCount" value="0" /> <!-- 2뎁스 자식 개수 변수 -->
        		
            	<c:forEach items="${listAuthorizationMenu}" var="i" varStatus="status">
            		<!-- 1depth -->
            		<c:if test="${i.IS_FOLDER eq 'N' and i.DEPTH eq 1 and i.CHILD_CNT eq 0}">
            			<li><a href="<c:if test="${i.POPUP_YN eq 'Y'}">javascript:fnOpenNewTab('${i.MENU_PATH}', '${i.MENU_NAME}', '');</c:if><c:if test="${i.POPUP_YN eq 'N'}">${i.MENU_PATH}</c:if>" class="dropbtn active">${i.MENU_NAME}</a></li>
            		</c:if>
            		<c:if test="${i.IS_FOLDER eq 'Y' and i.DEPTH eq 1 and i.CHILD_CNT > 0}">
            			<c:set var="childCount" value="${i.CHILD_CNT}" />
            			<li class="dropdown"><a href="#" class="dropbtn" >${i.MENU_NAME}</a>
            				<ul class="dropdown_content">
            		</c:if>
            		
            		<!-- 2depth -->
            		<c:if test="${i.IS_FOLDER eq 'N' and i.DEPTH eq 2 and i.CHILD_CNT eq 0}"> <!-- 2뎁스 자식이 없는 경우 -->
            			<li><a href="${i.MENU_PATH}">${i.MENU_NAME}</a></li>
            			<c:set var="index" value="${index+1}"/>
            			<c:if test="${childCount eq index}"> <!-- 1뎁스 마지막 자식이면 -->
	        				</ul></li>
	        				<c:set var="index" value="0"/><!-- 초기화 -->
	        			</c:if>
            		</c:if>            		
            		<c:if test="${i.IS_FOLDER eq 'Y' and i.DEPTH eq 2 and i.CHILD_CNT > 0}"> <!-- 2뎁스 자식이 있는 경우 -->
            			<c:set var="childSubCount" value="${i.CHILD_CNT}" />
            			<li class="dropdown_sub"><a href="${i.MENU_PATH}" class="dropbtn">${i.MENU_NAME}</a>
            				<ul class="dropdown_content_3dpt">
            			<c:set var="index" value="${index+1}"/>
            		</c:if>
            		
            		<!-- 3depth -->
            		<c:if test="${i.IS_FOLDER eq 'N' and i.DEPTH eq 3 and i.CHILD_CNT eq 0}"> <!-- 3뎁스 자식이 없는 경우 -->
            			<li><a href="${i.MENU_PATH}">${i.MENU_NAME}</a></li>
            			<c:set var="indexSub" value="${indexSub+1}"/>
            			<c:if test="${childSubCount eq indexSub}"> <!-- 2뎁스 마지막 자식이면 -->
        					</ul></li>
        					<c:set var="indexSub" value="0"/><!-- 초기화 -->
        				</c:if>
        			</c:if>
            		
            		
        			
            	</c:forEach>
            	
                
            </ul> <!-- 마지막 ul 필요함 --> 
            </ul>
            
            <div class="nav_info">
                <div class="dropdown">
                    <p class="id "><strong>${sessionUser.userId}</strong><a href="#" class="dropbtn"><span>ID</span></a>
                        <ul class="dropdown_content">
                        	<fmt:parseDate var="loginDate" value="${fn:replace(sessionUser.userLoginDate,' ', '')}" pattern="yyyyMMddHHmmss" />
                            <li>${sessionUser.userLevel} <br/><span> <fmt:formatDate value="${loginDate}" pattern="${sessionUser.patternDate} HH:mm:ss" /></span></li>
                            <li><a href="javascript:goUserInfo();"><spring:message code="label.common.myinfo" /></a></li>
                            <li><a href="javascript:goChangePassword();"><spring:message code="label.common.change.password" /></a></li>
                            <li><a href="javascript:openConfirmModal('<spring:message code="msg.common.logout" />', '',fnLogOutOk, null,'<spring:message code="label.common.ok" />','<spring:message code="label.common.cancel" />');"><span><spring:message code="label.common.logout" /></a></li>
                        </ul>
                    </p>  
                </div>
                <p class="help"><a href="javascript:help();" title="Help"><span><spring:message code="label.common.help" /></span></a></p>
                <p class="menu"><a href="#" title="About&License"><span><spring:message code="label.common.license" /></span></a></p>
            </div>
        </div>
        <div class="page_title">
            <h2>${titleName} (authType : ${authType})</h2>
            <ul>
                <p><spring:message code="label.common.recent.page" /> : </p>
                <c:forEach items="${listRecent}" var="i" varStatus="status">
                	<li><a href="javascript:fnRedirect('${i.MENU_PATH}');">${i.MENU_NAME}</a><a href="javascript:fnRecentDelete('${i.MENU_ID}');" class="x"><span>close</span></a></li>
                </c:forEach>
            </ul>
        </div>
        <!-- //page_title --> 
    </div>
    <!-- //header --> 
    
    <!-- 관리자가 등록한 비밀번호 -->
	<div id="passwdPopup" style="display:none">
		<div class="popup pw">
			<h2><spring:message code="label.common.change.password"/></h2>
			<a class="close" href="javascript:closeModal();">&times;</a>
			<div class="pop_cont">
	        	<p id="passwdMsg">
	        		<c:if test="${loginResult=='800'}">
	              		<i>!</i><spring:message code="msg.change.password.expire.text"/><!-- 비밀번호 만료일입니다. 비밀번호를 재설정 해주십시오. -->
	              	</c:if>
	              	<c:if test="${loginResult=='880'}">
	              		<i>!</i><spring:message code="msg.change.password.byadmin.text"/><!-- 관리자가 등록한 비밀번호입니다. 비밀번호를 재설정 해주십시오. -->
	              	</c:if>
	            </p>
	            <form method="post" action="/login/changePassword" name="formPasswd">
				<input type="hidden" id="rsaPublicKeyModulus" value="" />
				<input type="hidden" id="rsaPublicKeyExponent" value="" />
	            <div class="insert">
	                <label><spring:message code="msg.change.password.current.text"/> <em>*</em></label>
					<input type="password" id="current_password" name="current_password" maxlength="12" placeholder="<spring:message code="msg.change.password.current.text"/>">
	                <label><spring:message code="msg.change.password.new.text"/> <em>*</em></label>
					<input type="password" id="new_password1" name="new_password1" maxlength="12" placeholder="<spring:message code="msg.change.password.new.text"/>">
	                <label><spring:message code="msg.change.password.new_cofirm.text"/> <em>*</em></label>
					<input type="password" id="new_password2" name="new_password2" maxlength="12" placeholder="<spring:message code="msg.change.password.new_cofirm.text"/>">
	            </div>
	            </form>
	            <span id="infoMsg" class="hide"></span><!-- class는 show , hide로 개발하시면 됩니다. -->
	         </div>
	        <div class="btn_area">
				<a href="javascript:changePassword()"><button type="button" class="major"><spring:message code="label.common.ok"/></button></a>
		        <a href="javascript:closeModal();"><button type="button" ><spring:message code="label.common.cancel"/></button></a>
			</div>
	    </div>
	</div>
