<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<script type="text/javascript" charset="utf-8" src="/scripts/jquery.input-ip-address-control-1.0.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/jquery.alphanumeric.js"></script>
<script src="/scripts/locales/bootstrap-datepicker.${language}.min.js" charset="UTF-8"></script>
<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
    	//datepicker
         $(".input-group.date").datepicker({
   	        format: '${fn:toLowerCase(dateformat)}',       
   	        language: "${language}",
	        autoclose: true,
	        todayHighlight: true,
	        startDate : new Date(),
	        endDate : ''
		});
    	
    	$(".clockpicker").clockpicker().find("input").change(function(){});

 		fnInit();
    	
        $("#btn_cancel").click(function() {
        	fnCancel();
        });
        
        $("#btn_save").click(function() {
            fnSave();
        });

 		
 		$("#overwriteFlag").click(function() {
 			if( $("#overwriteFlag").is(":checked")){
 				$("#restore_path").val("");
 				$("#restore_path").attr('disabled',true);
	 		 	// $("#hide").slideToggle(400);
 			}else{
 				$("#restore_path").attr('disabled',false);
 			}
 		});
 		
 		if( ("${searchVal.groupCode}" == "110002") 
 			|| ("${searchVal.groupCode}" == "110003")
 			|| ("${searchVal.groupCode}" == "110013")
 			|| ("${searchVal.groupCode}" == "110014")){
 			$("#overwriteFlag").attr('disabled',true);
 		}  
    });
    
    function fnInit(){
    	   
    	  // $("#currentDate").val("${currentDate}");
    	   //$("#currentHour").val("${currentHour}");
    	   //$("#currentMin").val("${currentMin}");
    	   
    }
    //cancel function
    function fnCancel(){
    	$("#modifyForm").attr("action", "/atom/general/history/backup/list");
        $("#modifyForm").submit();   
    }
    
    //sava function
    function fnSave(){ 
    		if(!$("#overwriteFlag").is(":checked") && $("#restore_path").val() == ""){
    			openAlertModal("<spring:message code="msg.general.history.backup.input.restore_path.text" />");
    			$("#restore_path").focus();
    			return;
    		}
    	
    		if($("#overwriteFlag").is(":checked")){
    			$("#overwrite_flag").val("Y");
    		}else{
    			$("#overwrite_flag").val("N");
    		}   	 
    		
         	var currentTime = $("#currentTime").val().split(":");
    		$("#currentHour").val(currentTime[0]);
    		$("#currentMin").val(currentTime[1]);
    		
    
    		var param=$("#modifyForm").serialize();
    			
			 openConfirmModal("", "<spring:message code="msg.common.save" />", function(){
		        $.ajax({
		            url : '/atom/general/history/restore/saveAction.json',
		            type : 'POST',
		            data : param,
		            dataType : 'json',
		            success : function(data) {
		                if(data.result== "true") {
		                	console.log(data);
		                	openAlertModal("","<spring:message code="msg.common.saved" />", function(){
		                    	$("#modifyForm").attr("action", "/atom/general/history/backup/list");
			            		$("#modifyForm").submit();
		                	});
		                }else{
		                	openAlertModal("",data.result, function(){
		                	});
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
			
			<input type="hidden" id="currentMin" name="currentMin" value="${currentMin}" />
			<input type="hidden" id="currentHour" name="currentHour" value="${currentHour}" />

			<input type="hidden" id="startDate" name="startDate" value="${searchVal.startDate}" />
			<input type="hidden" id="startHour" name="startHour"  value="${searchVal.startHour}" />
			<input type="hidden" id="startMin" name="startMin" value="${searchVal.startMin}" />
			<input type="hidden" id="endDate" name="endDate" value="${searchVal.endDate}" />
			<input type="hidden" id="endHour" name="endHour" value="${searchVal.endHour}" />
			<input type="hidden" id="endMin" name="endMin" value="${searchVal.endMin}" />
			<!-- 검색용 -->
			<input type="hidden" id="node_id" name="node_id" value="${searchVal.node_id}">
			<input type="hidden" id="group_code" name="group_code" value="${searchVal.group_code}">
			<!--  -->
			<input type="hidden" id="nodeId" name="nodeId" value="${searchVal.nodeId}">
			<input type="hidden" id="group_code_nm" name="group_code_nm" value="${searchVal.group_code_nm}">
			<input type="hidden" id="pkg_name" name="pkg_name" value="${searchVal.pkg_name}">
			<input type="hidden" id="node_name" name="node_name" value="${searchVal.node_name}">
			<input type="hidden" id="prc_date" name="prc_date" value="${searchVal.prc_date}">
			<input type="hidden" id="groupCode" name="groupCode" value="${searchVal.groupCode}">
			<input type="hidden" id="backup_name" name="backup_name" value="${searchVal.backup_name}">
			<input type="hidden" id="file_size" name="file_size" value="${searchVal.file_size}">
			<input type="hidden" id="backup_path" name="backup_path" value="${searchVal.backup_path}">
			<input type="hidden" id="node_type" name="node_type" value="${searchVal.node_type}">
			<input type="hidden" id="result_no" name="result_no" value="${searchVal.result_no}">
			<input type="hidden" id="dst_flag" name="dst_flag" value="${searchVal.dst_flag}">
			<input type="hidden" id="overwrite_flag" name="overwrite_flag">
		<header>
			<p><spring:message code="label.general.history.backup.info.explan.text" /></p>
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
					<th><spring:message code="label.general.history.backup.part.text"/></th>
   					<th><spring:message code="label.general.history.backup.date.text"/></th>
   					<th><spring:message code="label.general.history.backup.file_name.text"/></th>
   					<th><spring:message code="label.general.history.backup.backup_path.text"/></th>
   					<th><spring:message code="label.general.history.backup.file_size.text"/></th>
				</tr>
				<tr>
					<td>${searchVal.group_code_nm}</td>
					<td>${searchVal.prc_date}</td>
					<td>${searchVal.backup_name}</td>
					<td>${searchVal.backup_path}</td>
					<td>${searchVal.file_size}</td>
      			</tr>
			</table>
		</div>
		
		<header>
			<p><spring:message code="label.general.history.backup.restore_date.explan.text" /></p>
		</header>
		<div class="detail">
			<table class="tb1_detail">
				<colgroup>
					<col width="16.5%" />
				</colgroup> 
				<tr>
					<th><spring:message code="label.general.history.backup.restore_date.text" /></th>
				</tr>
				<tr>
				  <td class="t_c">
						<div class="input-period">
                           <div class="input-group date" data-date-end-date="0d">
                               <input type="text" readonly="readonly"  id="currentDate" name="currentDate"  class="form-control" value="${currentDate}">
                               <span class="input-group-addon icon"></span> 
                           </div>
	                    </div>
	                    <!-- endTime -->
						<div class="input-period clockpicker" data-placement="bottom" data-align="top" data-autoclose="true">
							<input type="text"readonly="readonly"   class="form-control" id="currentTime" name="currentTime" value="${currentHour}:${currentMin}">
							<span class="input-period-addon"></span>
						</div>
                    </td> 
   				</tr>	
			</table>
		</div>
		<header>
			<p><spring:message code="label.general.history.backup.overwrite.explan.text" /></p>
		</header>
		<div class="detail">
			<table class="tb1_detail">
				<colgroup>
					<col width="16.5%" />
				</colgroup> 
				<tr>
					<th><spring:message code="label.general.history.backup.overwrite.text" /></th>
				</tr>
				<tr>
					<td>
					<span class="switch blue">
						<input id="overwriteFlag" class="toggle toggle-round" type="checkbox" name="overwriteFlag" >
						<label for="overwriteFlag"></label>
					</span>
	      		  </td>
   				</tr>	
			</table>
		</div>
		<header>
			<p><spring:message code="label.general.history.backup.restore_path.explan.text" /></p>
		</header>
		<div class="detail" id="hide">
			<table class="tbl_detail register">
				<colgroup>
					<col width="15%" />
				</colgroup> 
				<tr>
					<th><spring:message code="label.general.history.backup.restore_path.text" /></th>
				</tr>
				<tr>
					<td><input type="text"  id="restore_path" name="restore_path" maxlength="256" style="width:40%"/></td>
   				</tr>	
			</table>
		</div>
	</form>
	</div>
	<div class="cont_footer">
	<div class="btn_area">
			<button id="btn_cancel" type="button"><spring:message code="label.common.cancel.text" /></button>
			<button id="btn_save" type="button"><spring:message code="label.common.save.text" /></button>
	</div>
</div>
 
</div>
