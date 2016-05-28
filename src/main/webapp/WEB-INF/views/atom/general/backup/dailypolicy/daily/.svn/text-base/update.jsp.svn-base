<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>

<script type="text/javascript" charset="utf-8" src="/scripts/jquery.input-ip-address-control-1.0.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/jquery.alphanumeric.js"></script>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
     	$("#backup_input_data").numeric(); 
		$("#backup_hist_data").numeric(); 
		$("#backup_output_data").numeric(); 
		$("#backup_stat_data").numeric(); 
		$("#backup_log_data").numeric(); 
		$("#backup_pm_data").numeric(); 
		
		$("#delete_input_data").numeric(); 
		$("#delete_hist_data").numeric(); 
		$("#delete_output_data").numeric(); 
		$("#delete_stat_data").numeric(); 
		$("#delete_log_data").numeric(); 
		$("#delete_pm_data").numeric(); 
		
		$("#comp_input_data").numeric(); 
		$("#comp_hist_data").numeric(); 
		$("#comp_output_data").numeric(); 
		$("#comp_stat_data").numeric(); 
		$("#comp_log_data").numeric(); 
		$("#comp_pm_data").numeric();
		
		 
        $("#btn_cancel").click(function() {
        	fnCancel();
        });
        
        $("#btn_save").click(function() {
            fnSave();
        });
        
         $("#btn_default").click(function() {
            fnDefault();
        }); 
    });
    
    //cancel function
    function fnCancel(){
    	$("#modifyForm").attr("action", "/atom/general/backup/dailypolicy/daily/list");
        $("#modifyForm").submit();   
    }
    
     function fnDefault(){
    	<c:forEach items="${defaultInformation}" var="defaultInformation" varStatus="status">
    		$("#"+("${defaultInformation.ID}"+"_DATA").toLowerCase()).val("${defaultInformation.NAME}")
	    </c:forEach>
    } 
    //sava function
    function fnSave(){
    	
    	if (!$.isNumeric($("#backup_input_data").val())) {
        	openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.backup_input_data.invalid" />", function(){
    			$("#backup_input_data").focus();
        	});
			return;
		}			
    	
    	if (!$.isNumeric($("#backup_hist_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.backup_hist_data.invalid" />", function(){
    			$("#backup_hist_data").focus();
        	});
			return;
		}
		if (!$.isNumeric($("#backup_output_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.backup_output_data.invalid" />", function(){
    			$("#backup_output_data").focus();
        	});
			return;
		}
		if (!$.isNumeric($("#backup_stat_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.backup_stat_data.invalid" />", function(){
    			$("#backup_stat_data").focus();
        	});
			return;
		}
		if (!$.isNumeric($("#backup_log_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.backup_log_data.invalid" />", function(){
    			$("#backup_log_data").focus();
        	});
			return;
		}
		if (!$.isNumeric($("#backup_pm_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.backup_pm_data.invalid" />", function(){
    			$("#backup_pm_data").focus();
        	});
			return;
		}
		if (!$.isNumeric($("#delete_input_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.delete_input_data.invalid" />", function(){
    			$("#delete_input_data").focus();
        	});
			return;
		}			
		if (!$.isNumeric($("#delete_hist_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.delete_hist_data.invalid" />", function(){
    			$("#delete_hist_data").focus();
        	});
			return;
		}			
		if (!$.isNumeric($("#delete_output_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.delete_output_data.invalid" />", function(){
    			$("#delete_output_data").focus();
        	});
			return;
		}			
		if (!$.isNumeric($("#delete_stat_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.delete_stat_data.invalid" />", function(){
    			$("#delete_stat_data").focus();
        	});
			return;
		}			
		if (!$.isNumeric($("#delete_log_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.delete_log_data.invalid" />", function(){
    			$("#delete_log_data").focus();
        	});
			return;
		}			
		if (!$.isNumeric($("#delete_pm_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.delete_pm_data.invalid" />", function(){
    			$("#delete_pm_data").focus();
        	});
			return;
		}			
		if (!$.isNumeric($("#comp_input_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.comp_input_data.invalid" />", function(){
    			$("#comp_input_data").focus();
        	});
			return;
		}			
		if (!$.isNumeric($("#comp_hist_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.comp_hist_data.invalid" />", function(){
    			$("#comp_hist_data").focus();
        	});
			return;
		}
		if (!$.isNumeric($("#comp_output_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.comp_output_data.invalid" />", function(){
    			$("#comp_output_data").focus();
        	});
			return;
		}
		if (!$.isNumeric($("#comp_stat_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.comp_stat_data.invalid" />", function(){
    			$("#comp_stat_data").focus();
        	});
			return;
		}   
		if (!$.isNumeric($("#comp_log_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.comp_log_data.invalid" />", function(){
    			$("#comp_log_data").focus();
        	});
			return;
		}
		if (!$.isNumeric($("#comp_pm_data").val())) {
    		openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.comp_pm_data.invalid" />", function(){
    			$("#comp_pm_data").focus();
        	});
			return;
		}
		
		// delete keep day가 backup keep day보다 더 커야한다.
		if (parseInt($("#backup_input_data").val()) >= parseInt($("#delete_input_data").val())) {
			openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.input_data_compare" />", function(){
    			$("#delete_input_data").focus();
        	});
			return;	
		}
		if (parseInt($("#backup_hist_data").val()) >= parseInt($("#delete_hist_data").val())) {
			openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.hist_data_compare" />", function(){
    			$("#delete_hist_data").focus();
        	});
			return;	
		}
		if (parseInt($("#backup_output_data").val()) >= parseInt($("#delete_output_data").val())) {
			openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.output_data_compare" />", function(){
    			$("#delete_output_data").focus();
        	});
			return;	
		}
		
		if (parseInt($("#backup_stat_data").val()) >= parseInt($("#delete_stat_data").val())) {
			openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.stat_data_compare" />", function(){
    			$("#delete_stat_data").focus();
        	});
			return;	
		}
		if (parseInt($("#backup_log_data").val()) >= parseInt($("#delete_log_data").val())) {
			openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.log_data_compare" />", function(){
    			$("#delete_log_data").focus();
        	});
			return;	
		}
		if (parseInt($("#backup_pm_data").val()) >= parseInt($("#delete_pm_data").val())) {
			openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.pm_data_compare" />", function(){
    			$("#delete_pm_data").focus();
        	});
			return;	
		}
		
		if ((parseInt($("#backup_input_data").val()) > 30000)
				|| (parseInt($("#backup_output_data").val()) > 30000)
				|| (parseInt($("#backup_hist_data").val()) > 30000)
				|| (parseInt($("#backup_stat_data").val()) > 30000)
				|| (parseInt($("#backup_log_data").val()) > 30000)
				|| (parseInt($("#backup_pm_data").val()) > 30000)
				|| (parseInt($("#delete_input_data").val()) > 30000) 
				|| (parseInt($("#delete_hist_data").val()) > 30000)
				|| (parseInt($("#delete_output_data").val()) > 30000)
				|| (parseInt($("#delete_stat_data").val()) > 30000)
				|| (parseInt($("#delete_log_data").val()) > 30000)
				|| (parseInt($("#delete_pm_data").val()) > 30000)
				|| (parseInt($("#comp_input_data").val()) > 30000)
				|| (parseInt($("#comp_output_data").val()) > 30000)
				|| (parseInt($("#comp_hist_data").val()) > 30000)
				|| (parseInt($("#comp_stat_data").val()) > 30000)
				|| (parseInt($("#comp_log_data").val()) > 30000)
				|| (parseInt($("#comp_pm_data").val()) > 30000)
				|| (parseInt($("#comp_package_data").val()) > 30000)) {
			openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.all_data_compare_maximum" />", function(){
        	});
			return;
		}
		
		
		if ((parseInt($("#backup_input_data").val()) == 0)
				|| (parseInt($("#backup_output_data").val()) == 0)
				|| (parseInt($("#backup_hist_data").val()) == 0)
				|| (parseInt($("#backup_stat_data").val()) == 0)
				|| (parseInt($("#backup_log_data").val()) == 0)
				|| (parseInt($("#backup_pm_data").val()) == 0)
				) {
			openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.all_data_compare_zero" />", function(){
        	});
			return;
		}
		
		    	
        var param = new Object();
        
        var node_id = "${node_id}";
		
		param.node_id=node_id;
		
		param.backup_input_data = $("#backup_input_data").val();	
		param.backup_output_data = $("#backup_output_data").val();	
		param.backup_hist_data = $("#backup_hist_data").val();	
		param.backup_stat_data = $("#backup_stat_data").val();	
		param.backup_log_data = $("#backup_log_data").val();	
		param.backup_pm_data = $("#backup_pm_data").val();
		param.delete_input_data = $("#delete_input_data").val();
		param.delete_hist_data = $("#delete_hist_data").val();
		param.delete_output_data = $("#delete_output_data").val();
		param.delete_stat_data = $("#delete_stat_data").val();
		param.delete_log_data = $("#delete_log_data").val();
		param.delete_pm_data = $("#delete_pm_data").val();
		param.comp_input_data = $("#comp_input_data").val();	
		param.comp_output_data = $("#comp_output_data").val();	
		param.comp_hist_data = $("#comp_hist_data").val();	
		param.comp_stat_data = $("#comp_stat_data").val();	
		param.comp_log_data = $("#comp_log_data").val();	
		param.comp_pm_data = $("#comp_pm_data").val();
		
		openConfirmModal("", "<spring:message code="msg.common.save" />", function(){
	        $.ajax({
	            url : 'saveAction',
	            type : 'POST',
	            data : param,
	            dataType : 'json',
	            success : function(data) {
	                if(data.result == "true") {
	                	openAlertModal("","<spring:message code="msg.common.saved" />", function(){
		            		$("#modifyForm").attr("action","/atom/general/backup/dailypolicy/daily/list");
		            		$("#modifyForm").submit();
	                	});
	                } else {                
	                    result = false;
	                }
	
	            },
	            error: function(e){
	            	openAlertModal("",e.responseText);
	            },
	            complete : function() {
	            }
	        }); 
   		});
     }

 
	
</script>   
<div class="content" >
	<div class="cont_body">
	<form id="modifyForm" name="modifyForm" method ="post">
	<input id="node_id" name="node_id" value="${node_id}" type="hidden">
		<header>
			<h3><spring:message code="label.general.backup.dailypolicy.backup_title.text" /></h3>
			<p><spring:message code="label.general.backup.dailypolicy.backup_explan.text" /></p>
		</header>
		<div class="detail">
			<table class="tb1_detail">
				<colgroup>
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="17.5%" />
				</colgroup> 
				<tr>
					<th><spring:message code="label.general.backup.dailypolicy.input_data.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.history.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.output_data.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.statistics.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.log.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.pm.text" /></th>
				</tr>
				<tr>
					<td><input type="text" class="input_xs" id="backup_input_data" name="backup_input_data" maxlength="5" value="${backupInformation.BACKUP_INPUT_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="backup_hist_data" name="backup_hist_data" maxlength="5" value="${backupInformation.BACKUP_HIST_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="backup_output_data" name="backup_output_data" maxlength="5" value="${backupInformation.BACKUP_OUTPUT_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="backup_stat_data" name="backup_stat_data" maxlength="5" value="${backupInformation.BACKUP_STAT_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="backup_log_data" name="backup_log_data" maxlength="5" value="${backupInformation.BACKUP_LOG_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="backup_pm_data" name="backup_pm_data" maxlength="5" value="${backupInformation.BACKUP_PM_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
      			</tr>
			</table>
		</div>
				
		<header>
			<h3><spring:message code="label.general.backup.dailypolicy.delete_title.text" /></h3>
			<p><spring:message code="label.general.backup.dailypolicy.delete_explan.text" /></p>
		</header>
		<div class="detail">
			<table class="tb1_detail">
				<colgroup>
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="17.5%" />
				</colgroup>
				<tr>
					<th><spring:message code="label.general.backup.dailypolicy.input_data.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.history.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.output_data.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.statistics.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.log.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.pm.text" /></th>
				</tr>
				<tr>
					<td><input type="text" class="input_xs" id="delete_input_data" name="delete_input_data" maxlength="5" value="${deleteInformation.DELETE_INPUT_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="delete_hist_data" name="delete_hist_data" maxlength="5" value="${deleteInformation.DELETE_HIST_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="delete_output_data" name="delete_output_data" maxlength="5" value="${deleteInformation.DELETE_OUTPUT_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="delete_stat_data" name="delete_stat_data" maxlength="5" value="${deleteInformation.DELETE_STAT_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="delete_log_data" name="delete_log_data" maxlength="5" value="${deleteInformation.DELETE_LOG_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="delete_pm_data" name="delete_pm_data" maxlength="5" value="${deleteInformation.DELETE_PM_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   				</tr>		
			</table>
		</div>
		
		
		<header>
			<h3><spring:message code="label.general.backup.dailypolicy.comp_title.text" /></h3>
			<p><spring:message code="label.general.backup.dailypolicy.comp_explan.text" /></p>
		</header>
		<div class="detail">
			<table class="tb1_detail">
				<colgroup>
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="17.5%" />
				</colgroup> 
				<tr>
					<th><spring:message code="label.general.backup.dailypolicy.input_data.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.history.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.output_data.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.statistics.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.log.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.pm.text" /></th>
				</tr>
				<tr>
					<td><input type="text" class="input_xs" id="comp_input_data" name="comp_input_data" maxlength="5" value="${deleteInformation.COMP_INPUT_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="comp_hist_data" name="comp_hist_data" maxlength="5" value="${deleteInformation.COMP_HIST_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="comp_output_data" name="comp_output_data" maxlength="5" value="${deleteInformation.COMP_OUTPUT_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="comp_stat_data" name="comp_stat_data" maxlength="5" value="${deleteInformation.COMP_STAT_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="comp_log_data" name="comp_log_data" maxlength="5" value="${deleteInformation.COMP_LOG_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td><input type="text" class="input_xs" id="comp_pm_data" name="comp_pm_data" maxlength="5" value="${deleteInformation.COMP_PM_DATA}" /> <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   				</tr>	
			</table>
		</div>
	</form>
	</div>
	<div class="cont_footer">
	<div class="btn_area">
			<button id="btn_default" type="button"><spring:message code="label.general.backup.dailypolicy.default.text" /></button>
			<button id="btn_cancel" type="button"><spring:message code="label.common.cancel.text" /></button>
			<button id="btn_save" type="button"><spring:message code="label.common.save.text" /></button>
	</div>
</div>
 
</div>
