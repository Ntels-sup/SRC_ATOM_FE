<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>

<script type="text/javascript" charset="utf-8" src="/scripts/stringUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/jquery.alphanumeric.js"></script>
<script src="/scripts/locales/bootstrap-datepicker.${language}.min.js" charset="UTF-8"></script>

<script type="text/javascript" charset="utf-8" src="/scripts/rsa/jsbn.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/rsa/rsa.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/rsa/prng4.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/rsa/rng.js"></script>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
    	// datepicker start //
        $(".input-group.date").datepicker({
   	        format: '${fn:toLowerCase(dateformat)}',       
   	        language: "${language}",
	        autoclose: true,
	        todayHighlight: true
		});
      	
    	// multiple select start // 
		$("select.single").multipleSelect({
	        single: true,
	        selectAll: false,
            multiple: false
		});
    	
		//radio(login type) change 이벤트
		$("input[type=radio][name=loginType]").change(function(){
			if($(this).attr("id") == "single"){
				$("#login_type").val(1);
				$("#login_type_count").hide();
			} else {
				$("#login_type").val("${userManage.login_type}");
				$("#login_type_count").show();
			}
		});

		$("#btn_cancel").click(function(){
			fnCancel();
		});
		
		$("#btn_save").click(function(){
			fnModify();
		});
		
    	fnInit();
    });
    
    //value setting
    function fnInit(){
    	//login type, emp_no 숫자만 입력가능 
    	$("#login_type").numeric();
    	$("#emp_no").numeric();
    	
  		//login type 셋팅
  		if(parseInt("${userManage.login_type}") == 1){
  			$("input[name=loginType][id=single]").prop("checked",true);
	  		$("input[name=loginType][id=multi]").prop("checked",false);
	  		$("#login_type_count").hide();
	  		
  		} else {
  			$("input[name=loginType][id=single]").prop("checked",false);
  			$("input[name=loginType][id=multi]").prop("checked",true);
  			$("#login_type_count").show();
  		}
  		
  		//radio 버튼 체크 (status) 
  		$("input[name=status][value=${userManage.status}]").prop("checked",true);
    }
    
    //ip Manage cancel
    function fnCancel(){
		$("#modifyForm").attr("action","/atom/security/usermanage/detail");
		$("#modifyForm").submit();
    }
    
    //ip Manage update
 	function fnModify(){
    	//user name check
    	if($.trim($("#user_name").val()) == "" || $("#user_name").val() == null){
    		openAlertModal("","<spring:message code="msg.security.usermanage.check.user_name" />",function(){$("#user_name").focus();});
    		return;
    	} else if(!getBytes($("#user_name").val(), parseInt($("#user_name").attr("maxlength")))){
    		openAlertModal("","<spring:message code="msg.security.usermanage.check_length.user_name" />",function(){$("#user_name").focus();});
    		return;
    	}
    	//employee no check
    	if(!$.isNumeric($("#emp_no").val())){
    		openAlertModal("","<spring:message code="msg.security.usermanage.check_number.employee_no" />",function(){$("#emp_no").focus();});
    		return;
    	}
    	//phone number check
    	if(!isValidNumOrHyphen($("#user_phone").val())){
    		openAlertModal("","<spring:message code="msg.security.usermanage.check_number.phone_number" />",function(){$("#user_phone").focus();});
    		return;
    	}
    	//email check
    	if(!isValidEmail($("#user_email").val())){
    		openAlertModal("","<spring:message code="msg.security.usermanage.check_character.email" />",function(){$("#user_email").focus();});
    		return;
    	}
    	
    	//userLevel = 1 인경우만 check
    	if("${userLevelId}" == 1){
    		//password check
    		if($.trim($("#passwd").val()) == "" || $("#passwd").val() == null){
        		openAlertModal("","<spring:message code="msg.security.usermanage.check.password" />",function(){$("#passwd").focus();});
        		return;
    		} else if(($("#passwd").val().length < 0) || ($("#passwd").val().length > 12)){
        		openAlertModal("","<spring:message code="msg.security.usermanage.check_length.password" />",function(){$("#passwd").focus();});
        		return;
    		} else if(!isValidAlphaOrNum($("#passwd").val())){
        		openAlertModal("","<spring:message code="msg.security.usermanage.check_character.password" />",function(){$("#passwd").focus();});
        		return;
    		}
    		//confirm password check
    		if($.trim($("#confirm_passwd").val()) == "" || $("#confirm_passwd").val() == null){
        		openAlertModal("","<spring:message code="msg.security.usermanage.check.confirm_password" />",function(){$("#confirm_passwd").focus();});
        		return;
    		} else if($("#passwd").val() != $("#confirm_passwd").val()){
        		openAlertModal("","<spring:message code="msg.security.usermanage.check_same.password" />",function(){$("#confirm_passwd").focus();});
        		return;
    		}
    		//Number of sessions allowed check
    		if($.trim($("#login_type").val()) == "" || $("#login_type").val() == null){
        		openAlertModal("","<spring:message code="msg.security.usermanage.check.number_of_session_allowed" />",function(){$("#login_type").focus();});
        		return;
    		} else if(!$.isNumeric($("#login_type").val())){
        		openAlertModal("","<spring:message code="msg.security.usermanage.check_number.number_of_session_allowed" />",function(){$("#login_type").focus();});
        		return;
    		} else if( parseInt($("#login_type").val()) == 0 ){
    			openAlertModal("","<spring:message code="msg.security.usermanage.check_zero.number_of_session_allowed" />",function(){$("#login_type").focus();});
    			return;
    		}
    		//retry count setting
    		if($("input[name=status]:checked").val() == "Y" && "${userManage.status}" == "L"){
    			$("#retry_count").val("0");
    		}
    	}
    	
    	//password 암호화
        fnEncrypt();
    	
    	var param = new Object();
    	param = $("#modifyForm").serialize();
    	
 		$.ajax({
            url : "modifyAction",
            data : param,
            type : 'POST',
            dataType : 'json',
            success : function(data) {
            	openAlertModal("","<spring:message code="msg.common.saved" />",function(){
            		$("#modifyForm").attr("action","/atom/security/usermanage/list");
            		$("#modifyForm").submit();
            	});
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {

            }
		});
 	}

    //password 암호화
    function fnEncrypt(){
		var rsa = new RSAKey();
	    rsa.setPublic("${publicKeyModulus}", "${publicKeyExponent}");
		
	    // 비밀번호를 RSA로 암호화한다.
	    var securedPassword = rsa.encrypt($("#passwd").val());
	    $("#passwd").val(securedPassword);
    }
    
	//byte check
	function getBytes(text, maxByte) {
		var str = text;
		var strLength = text.length;
		
		var rbyte = 0;
		var one_char = "";
		
		for (var i=0; i<strLength; i++) {
			one_char = str.charAt(i);
			if (escape(one_char).length > 4) {
				rbyte += 2;
			} else {
				rbyte += 1;
			}
		}
		if(rbyte > maxByte){
			return false;
		}
		
		return true;
	}
	
</script>   

    <div class="content">
		<!-- cont_body -->
		<div class="cont_body">
			<div class="detail">
            	<form id="modifyForm" name="modifyForm">
            		<!-- 수정시, detail 화면이동시 필요 -->
	            	<input type="hidden" id="user_id" name="user_id" value="${userManage.user_id}">
	            	<input type="hidden" id="retry_count" name="retry_count" value="${userManage.retry_count}">
	            	<!-- list 화면이동시 필요 -->
	            	<input type="hidden" id="groupNo" name="groupNo" value="${searchVal.groupNo}">

	                <table class="tbl_detail register">
	                	<caption><spring:message code="label.security.usermanage.title.text" /></caption>
	                    <colgroup>
		                    <col width="25%"/>
		                    <col width="25%"/>
		                    <col width="25%"/>
		                    <col width="25%"/>
	                    </colgroup>
	                    <tr>
	                        <th scope="col" class="imp"><spring:message code="label.security.usermanage.user_id.text" /></th>
	                        <th scope="col" class="imp"><spring:message code="label.security.usermanage.user_group.text" /></th>
	                        <th scope="col" class="imp"><spring:message code="label.security.usermanage.user_level.text" /></th>
	                        <th></th>
	                    </tr>
	                    <tr>
	                        <td><input type="text" id="user_id" name="user_id" value="${userManage.user_id}" disabled /></td>
	                        <td>
	                        	<select class="single" id="group_no" name="group_no">
			                    	<c:forEach items="${listUserGroup}" var="userGroup" varStatus="status">
			                    		<option value="${userGroup.ID}">${userGroup.NAME}</option>
			                    	</c:forEach>
		                    	</select>
	                        </td>
	                        <td>
	                        	<c:choose>
	                        		<c:when test="${userManage.level_id eq 1}">
	                        		<input type="hidden" id="level_id" name="level_id" value="${userManage.level_id}" />
	                        		${userManage.level_name}
	                        		</c:when>
	                        		<c:otherwise>
			                        	<select class="single" id="level_id" name="level_id">
					                    	<c:forEach items="${listUserLevel}" var="userLevel" varStatus="status">
					                    		<c:if test="${userLevel.ID ne 1}">
					                    			<option value="${userLevel.ID}" <c:if test="${userLevel.ID eq userManage.level_id}">selected="selected"</c:if>>${userLevel.NAME}</option>
					                    		</c:if>
					                    	</c:forEach>
					                    </select>
	                        		</c:otherwise>
	                       		</c:choose>
	                        </td>
	                        <td></td>
	                    </tr>
	                    <tr>
	                    	<th scope="col" class="imp"><spring:message code="label.security.usermanage.user_name.text" /></th>
	                        <th scope="col"><spring:message code="label.security.usermanage.employee_no.text" /></th>
	                        <th scope="col"><spring:message code="label.security.usermanage.phone_number.text" /></th>
	                        <th scope="col"><spring:message code="label.security.usermanage.email.text" /></th>
	                    </tr>
	                    <tr>
	                    	<td><input type="text" id="user_name" name="user_name" maxlength="30" placeholder="<spring:message code="label.security.usermanage.user_name.text" />" value="${userManage.user_name}" /></td>
	                        <td><input type="text" id="emp_no" name="emp_no" maxlength="18" placeholder="<spring:message code="label.security.usermanage.employee_no.text" />" value="${userManage.emp_no}" /></td>
	                        <td><input type="text" id="user_phone" name="user_phone" maxlength="20" placeholder="<spring:message code="label.security.usermanage.phone_number.text" />" value="${userManage.user_phone}" /></td>
	                        <td><input type="text" id="user_email" name="user_email" placeholder="<spring:message code="label.security.usermanage.email.text" />" value="${userManage.user_email}" maxlength="40" /></td>
	                    </tr>
	                    
	                    <!-- userLevel = 1 인 유저만 view  -->
	                    <c:if test="${userLevelId eq 1}">
		                    <tr>
		                        <th scope="col" class="imp"><spring:message code="label.security.usermanage.password.text" /></th>
		                        <th scope="col" class="imp"><spring:message code="label.security.usermanage.confirm_password.text" /></th>
		                        <th colspan="2"></th>
		                    </tr>
		                    <tr>
		                        <td><input type="password" id="passwd" name="passwd" maxlength="12" placeholder="<spring:message code="label.security.usermanage.password.text" />" /></td>
		                        <td><input type="password" id="confirm_passwd" name="confirm_passwd" maxlength="12" placeholder="<spring:message code="label.security.usermanage.confirm_password.text" />" /></td>
		                        <td colspan="2"></td>
		                    </tr>
		                    <tr>
		                        <th colspan="2" scope="col" class="imp"><spring:message code="label.security.usermanage.login_type.text" /></th>
		                        <th scope="col" class="imp"><spring:message code="label.security.usermanage.user_account_expiration.text" /></th>
		                        <th scope="col"><spring:message code="label.security.usermanage.password_expiration.text" /></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2">
		                            <input type="radio" id="single" name="loginType" />
		                            <label for="single"><spring:message code="label.security.usermanage.single.text" /></label>
		                            <input type="radio" id="multi" name="loginType" />
		                            <label for="multi"><spring:message code="label.security.usermanage.multiple.text" /></label>
		                            <span id="login_type_count"><spring:message code="label.security.usermanage.count.text" />  
		                                <input type="text" class="input_xs" id="login_type" name="login_type" value="${userManage.login_type}" maxlength="3" />
		                            </span>
		                        </td>
		                        <td class="t_c">
									<div class="input-period">
										<div class="input-group date" data-date-start-date="${userManage.account_exfire}">
											<input type="text" class="form-control" id="account_exfire" name="account_exfire" value="${userManage.account_exfire}" readonly="readonly">
											<span class="input-group-addon icon"></span>
										</div>
									</div>
	                            </td>
	                            <td><input type="hidden" id="passwd_exfire" name="passwd_exfire" value="${userManage.passwd_exfire}" />${userManage.passwd_exfire}</td>
		                    </tr>
		                    <tr>
		                        <th colspan="2" scope="col"><spring:message code="label.security.usermanage.login_status.text" /></th>
		                        <th colspan="2" scope="col"><spring:message code="label.security.usermanage.status_reason.text" /></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2">
		                            <input type="radio" id="enalbe" name="status" value="Y" />
		                            <label for="enalbe"><spring:message code="label.security.usermanage.enable.text" /></label>
		                            <input type="radio" id="disable" name="status" value="N" />
		                            <label for="disable"><spring:message code="label.security.usermanage.disable.text" /></label>
		                            <input type="radio" id="locked" name="status" value="L" />
		                            <label for="locked"><spring:message code="label.security.usermanage.locked.text" /></label>
		                        </td>
		                        <td colspan="2"><input type="text" id="status_reason" name="status_reason" value="${userManage.status_reason}" maxlength="256"/></td>
		                    </tr>
						</c:if>
						<!-- //userLevel = 1 인 유저만 view -->
	                </table>
				</form>
            </div>
        </div>
		<!-- //cont_body -->
		
        <div class="cont_footer">
            <div class="btn_area">
                <button id="btn_cancel" type="button"><spring:message code="label.common.cancel.text" /></button>
                <ntels:auth auth="${authType}">
                <button id="btn_save" type="button" class="major"><spring:message code="label.common.save.text" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 