<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

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
    	$("#severity_ccd").multipleSelect('setSelects',["${alarmConfig.severity_ccd}"]);
    	$("#alm_group").multipleSelect('setSelects',["${alarmConfig.group_ccd}"]);
    	$("#snmp_yn").multipleSelect('setSelects',["${alarmConfig.snmp_yn}"]);
    	$("#sms_yn").multipleSelect('setSelects',["${alarmConfig.sms_yn}"]);
    	$("#email_yn").multipleSelect('setSelects',["${alarmConfig.email_yn}"]);
    	
    }
    
    //atom Config cancel
    function fnCancel(){
		$("#modifyForm").attr("action","/atom/fault/alarmconfig/detail");
		$("#modifyForm").submit();
    }
    
    //atom Config modify
 	function fnModify(){
    	if($("#code").val() == "" || $("#code").val() == null){
    		openAlertModal("","<spring:message code="msg.fault.alarmconfig.need.alarm_code" />",function(){$("#code").focus();});
    		return;
    	}
    	if($("#probable_cause").val() == "" || $("#probable_cause").val() == null){
    		openAlertModal("","<spring:message code="msg.fault.alarmconfig.need.probable_cause" />",function(){$("#probable_cause").focus();});
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
            		$("#modifyForm").attr("action","/atom/fault/alarmconfig/list");
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
 	

</script>   

    <div class="content">
		<!-- cont_body -->
		<div class="cont_body">
			<div class="detail">
				<form id="modifyForm" name="modifyForm">
					<!-- 수정시, detail 화면이동시 필요 -->
	            	<input type="hidden" id="code" name="code" value="${alarmConfig.code}">
	            	<input type="hidden" id="pkg_name" name="pkg_name" value="${alarmConfig.pkg_name}">
	            	<!-- list 화면이동시 필요 -->
	            	<input type="hidden" id="alarmType" name="alarmType" value="${searchVal.alarmType}">
	            	<input type="hidden" id="alarmGroup" name="alarmGroup" value="${searchVal.alarmGroup}">
	            	<input type="hidden" id="pkgName" name="pkgName" value="${searchVal.pkgName}">
	            	<input type="hidden" id="searchType" name="searchType" value="${searchVal.searchType}">
	            	<input type="hidden" id="searchText" name="searchText" value="${searchVal.searchText}">
	            	
	                <table class="tbl_detail register">
						<caption><spring:message code="label.fault.alarmconfig.title.text" /></caption>
	                    <colgroup>
		                    <col width="20%"/>
		                    <col width="20%"/>
		                    <col width="20%"/>
		                    <col width="20%"/>
		                    <col width="20%"/>
	                    </colgroup>
	                    <tr>
	                        <th scope="col" class="imp"><spring:message code="label.fault.alarmconfig.alarm_code.text" /></th>
	                        <th scope="col" class="imp"><spring:message code="label.fault.alarmconfig.probable_cause.text" /></th>
	                        <th scope="col" class="imp"><spring:message code="label.fault.alarmconfig.alarm_group.text" /></th>
	                        <th scope="col" class="imp"><spring:message code="label.fault.alarmconfig.defalut_severity.text" /></th>
	                    </tr>
	                    <tr>
	                        <td><input type="text" id="alias_code" name="alias_code" value="${alarmConfig.alias_code}" /></td>
	                        <td><input type="text" id="probable_cause" name="probable_cause" value="${alarmConfig.probable_cause}" /></td>
	                        <td>
								<select class="single" id="group_ccd" name="group_ccd">
									<c:forEach items="${listAlarmGroup}" var="alaramGroup" varStatus="status">
										<option value="${alaramGroup.ID}">${alaramGroup.NAME}</option>
									</c:forEach>
								</select>
	                        </td>
	                        <td>
								<select class="single" id="severity_ccd" name="severity_ccd">
									<c:forEach items="${listAlaramServrity}" var="alaramServrity" varStatus="status">
										<option value="${alaramServrity.ID}">${alaramServrity.NAME}</option>
									</c:forEach>
								</select>
							</td>
	                    </tr>
	                    <tr>
	                        <th scope="col"><spring:message code="label.fault.alarmconfig.alarm_type.text" /></th>
	                        <th scope="col"><spring:message code="label.fault.alarmconfig.snmp.text" /></th>
	                        <th scope="col"><spring:message code="label.fault.alarmconfig.sms.text" /></th>
	                        <th scope="col"><spring:message code="label.fault.alarmconfig.email.text" /></th>
	                    </tr>
	                    <tr>
							<td>${alarmConfig.type_ccd_name}</td>
	                        <td>
								<select class="single" id="snmp_yn" name="snmp_yn">
									<c:forEach items="${listYn}" var="yn" varStatus="status">
										<option value="${yn.ID}">${yn.NAME}</option>
									</c:forEach>
								</select>
	                        </td>
	                        <td>
								<select class="single" id="sms_yn" name="sms_yn">
									<c:forEach items="${listYn}" var="yn" varStatus="status">
										<option value="${yn.ID}">${yn.NAME}</option>
									</c:forEach>
								</select>
	                        </td>
	                        <td>
								<select class="single" id="email_yn" name="email_yn">
									<c:forEach items="${listYn}" var="yn" varStatus="status">
										<option value="${yn.ID}">${yn.NAME}</option>
									</c:forEach>
								</select>
							</td>
	                    </tr>
	                    <tr>
	                         <th scope="col" colspan="4"><spring:message code="label.fault.alarmconfig.description.text" /></th>
	                    </tr>
	                    <tr>
	                        <td colspan="4"><textarea id="description" name="description" rows="3">${alarmConfig.description}</textarea></td>
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
                <button id="btn_save" type="button" class="major"><spring:message code="label.common.update.text" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 