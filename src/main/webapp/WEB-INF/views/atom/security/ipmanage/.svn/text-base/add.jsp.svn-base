<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

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

		$("#btn_save").click(function(){
			fnSave();
		});
		
		$("#btn_cancel").click(function(){
			fnCancel();
		});
		
		fnInit();
    });
    
    //value setting
    function fnInit(){
    	$("#max_simult").numeric();
    }
    
    //ip Manage cancel
    function fnCancel(){
		$("#addForm").attr("action","/atom/security/ipmanage/list");
		$("#addForm").submit();
    }
    
    //ip Manage insert
 	function fnSave(){
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
    	param.ipBandWidth = $("#ip").val()
    	param = $("#addForm").serialize();

    	$.ajax({
            url : "addAction",
            data : param,
            type : 'POST',
            dataType : 'json',
            success : function(data) {
            	openAlertModal("","<spring:message code="msg.common.saved" />",function(){
            		$("#addForm").attr("action","/atom/security/ipmanage/list");
            		$("#addForm").submit();
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
 		
 		return returnVal;
    }

</script>   

    <div class="content">
		<!-- cont_body -->
		<div class="cont_body">
			<div class="detail">
			<form id="addForm" name="addForm">
            	<!-- list 화면이동시 필요 -->
            	<input type="hidden" id="searchAllowYn" name="searchAllowYn" value="${searchVal.searchAllowYn}">
            	<input type="hidden" id="searchIp" name="searchIp" value="${searchVal.searchIp}">
            	
                <table class="tbl_detail register">
                    <caption><spring:message code="label.security.ipmanage.title.text" /></caption>
                    <colgroup>
	                    <col width="25%"/>
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
                        <td><input type="text" id="ip" name="ip" value="" placeholder="<spring:message code="label.security.ipmanage.ip_address.text" />"/></td>
                        <td>
                        	<select class="single" id="allow_yn" name="allow_yn">
								<option value="Y">Allow</option>
								<option value="N">Deny</option>
                        	</select>
                        </td>
                        <td><input type="text" id="max_simult" name="max_simult"  maxLength="3" value="" placeholder="<spring:message code="label.security.ipmanage.sessions.text" />"/></td>
                    </tr>
                    <tr>
                         <th scope="col" colspan="3" class="imp"><spring:message code="label.security.ipmanage.description.text" /></th>
                    </tr>
                    <tr>
                        <td colspan="3"><textarea id="description" name="description" placeholder="<spring:message code="label.security.ipmanage.description.text" />" rows="3" maxlength="256"></textarea></td>
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