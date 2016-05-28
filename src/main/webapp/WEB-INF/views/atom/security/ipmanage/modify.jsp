<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>

<script type="text/javascript" charset="utf-8" src="/scripts/stringUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/jquery.alphanumeric.js"></script>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
    	// multiple select start // 
		$("select.single").multipleSelect({
	        single: true,
	        selectAll: false,
            multiple: false
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
    	$("#max_simult").numeric();
    	$("#allow_yn").multipleSelect('setSelects',["${ipManage.allow_yn}"]);
    }
    
    //ip Manage cancel
    function fnCancel(){
		$("#modifyForm").attr("action","/atom/security/ipmanage/detail");
		$("#modifyForm").submit();
    }
    
    //ip Manage update
 	function fnModify(){
 		//dupl Ip check value
    	var duplIp = fnDuplChkIp();
    	
    	if($("#ip").val() == "" || $("#ip").val() == null){
    		openAlertModal("","<spring:message code="msg.security.ipmanage.need.ip" />",function(){$("#ip").focus();});
    		return;
    	} else if(!isValidIpBandWidth($("#ip").val())){
    		openAlertModal("","<spring:message code="msg.security.ipmanage.chcek.ip" />",function(){$("#ip").focus();});
    		return;
    	} else if(duplIp != ""){
    		openAlertModal("","<spring:message code="msg.security.ipmanage.check.duplicate_ip" />"+" ("+duplIp+")" ,function(){$("#ip").focus();});
    		return;
    	}
    	if($("#max_simult").val() == "" || $("#max_simult").val() == null){
    		openAlertModal("","<spring:message code="msg.security.ipmanage.need.sessions" />",function(){$("#max_simult").focus();});
    		return;
    	} else if(!$.isNumeric($("#max_simult").val())){
    		openAlertModal("","<spring:message code="msg.security.ipmanage.chcek.sessions" />",function(){$("#max_simult").focus();});
    		return;
    	}else if($("#max_simult").val() == "0"){
    		openAlertModal("","<spring:message code="msg.security.ipmanage.check.number" />",function(){$("#max_simult").focus();});
    		return;
    	}
    	if($("#description").val() == "" || $("#description").val() == null){
    		openAlertModal("","<spring:message code="msg.security.ipmanage.need.description" />",function(){$("#description").focus();});
    		return;
    	}
    	
    	var param = new Object();
    	param = $("#modifyForm").serialize();
		
 		$.ajax({
            url : "modifyAction",
            data : param,
            type : 'POST',
            dataType : 'json',
            success : function(data) {
            	openAlertModal("","<spring:message code="msg.common.saved" />",function(){
            		$("#modifyForm").attr("action","/atom/security/ipmanage/list");
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

 	//ip Manage update fnDuplChkIp
    function fnDuplChkIp(){
       	var returnVal = "";
       	
 		if($("#ip").val() != "${ipManage.ip}"){
	       	
	       	var param = new Object();
	       	param.ipBandWidth = $("#ip").val();
	       	
	 		$.ajax({
	            url : "duplChkIpBandWidth",
	            data : param,
	            type : 'POST',
	            dataType : 'json',
	            async: false,
	            success : function(data) {
	            	if(data.checkIpResult != ""){
	            		returnVal = data.checkIpResult;
	            	}
	            }
			});
 		}
 		
 		return returnVal;
    }

</script>   

    <div class="content">
		<!-- cont_body -->
		<div class="cont_body">
			<div class="detail">
				<form id="modifyForm" name="modifyForm">
					<!-- 수정시, detail 화면이동시 필요 -->
					<input type="hidden" id="ip_manager_no" name="ip_manager_no" value="${ipManage.ip_manager_no}">
	            	<!-- list 화면이동시 필요 -->
	            	<input type="hidden" id="searchAllowYn" name="" value="${searchVal.searchAllowYn}">
	            	<input type="hidden" id="searchIp" name="searchIp" value="${searchVal.searchIp}">
	
	                <table class="tbl_detail register">
						<caption><spring:message code="label.security.ipmanage.title.text" /></caption>
	                    <colgroup>
		                    <col width="25%"/>
		                    <col width="25%"/>
		                    <col width="25%"/>
	                    </colgroup>
	                    <tr>
	                        <th scope="col" class="imp"><spring:message code="label.security.ipmanage.ip_address.text" /></th>
	                        <th scope="col" class="imp"><spring:message code="label.security.ipmanage.login_allowance.text" /></th>
	                        <th scope="col" class="imp"><spring:message code="label.security.ipmanage.sessions.text" /></th>
	                    </tr>
	                    <tr>
	                        <td><input type="text" id="ip" name="ip" value="${ipManage.ip}" /></td>
	                        <td>
	                        	<select class="single" id="allow_yn" name="allow_yn">
									<option value="Y">Allow</option>
									<option value="N">Deny</option>
	                        	</select>
	                        </td>
	                        <td><input type="text" id="max_simult" name="max_simult" value="${ipManage.max_simult}" maxLength="3"/></td>
	                    </tr>
	                    <tr>
	                         <th scope="col" colspan="3" class="imp"><spring:message code="label.security.ipmanage.description.text" /></th>
	                    </tr>
	                    <tr>
	                        <td colspan="3"><textarea id="description" name="description" rows="3" maxlength="256">${ipManage.description}</textarea></td>
	                    </tr>
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