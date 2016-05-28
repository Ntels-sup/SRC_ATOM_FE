<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 


<script src="/scripts/locales/bootstrap-datepicker.${sessionUser.language}.min.js" charset="UTF-8"></script>
<script src="/scripts/jwebsocket/pfnmWebSocket.js"></script>
<script src="/scripts/jwebsocket/1_0_b1/jWebSocket.js"></script>

<script type="text/javascript">
	
	initPage("${pageContext.servletContext.getAttribute('websocket.connect.url')}", "batchGroup");

	//Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
    	
    	//datepicker
        $(".input-group.date").datepicker({
   	        format: '${fn:toLowerCase(sessionUser.patternDate)}',       
   	        language: "${sessionUser.language}",
	        autoclose: true,
	        todayHighlight: true
		});
      	//datepicker
      	
  		$("#btn_view").click(function(){
  			goView();
  		});
  		
  		$("select.single").multipleSelect({
  	        single: true,
  	        selectAll: false,
  	        multiple: false
  	    });
  		
  		$("#btn_del").click(function(){
  			openConfirmModal("<spring:message code='label.confirm.delete'/>", "", function() {
  				fnRemove();
			});
  		});
  		
  		$("#btn_save").click(function(){
  			goModify();
  		});
  		
  		var beforeVal = $("#schedule_cycle").val();
  		$("input[type=radio][name=status]").change(function() {
  			
  			console.log( "before value : " + beforeVal );
  			console.log( "selected value : " + $(this).val() );
  			
  			var statusVal = $(this).val();
  			
  			$("#schedule_cycle_type").val( statusVal );
  			
  			if( statusVal=='01' ) {
  				beforeVal = $("#schedule_cycle").val();
  				$("#schedule_cycle_val").hide();
  				$("#schedule_cycle_none").show();
  			}
  			else {
  				$("#schedule_cycle_val").show();
  				$("#schedule_cycle_none").hide();
  				$("#schedule_cycle").val( beforeVal );
  				
  				if( statusVal=='02' ) 
  					$("#schedule_cycle_label").text( "Minute" );
  				else if( statusVal=='03' ) 
  					$("#schedule_cycle_label").text( "Day" );
  				else if( statusVal=='04' ) 
  					$("#schedule_cycle_label").text( "Week" );
  				else if( statusVal=='05' ) 
  					$("#schedule_cycle_label").text( "Month" );
  				else if( statusVal=='06' ) 
  					$("#schedule_cycle_label").text( "Month Last" );
  				
  			}
  		});

  		fnInit();
    });
    
  	//value setting
  	function fnInit(){
  		
  		//radio 버튼 체크 (status) 
  		$("input[name=status][value=${schedulerGroup.schedule_cycle_type}]").prop("checked",true);
  		
  		if( $("#schedule_cycle").val()=='01' ) {
			$("#schedule_cycle_val").hide();	
		}
		else {
			$("#schedule_cycle_none").hide();	
		}
  	}
    
    function goView(){
    	$("#detailForm").attr("action","/atom/general/scheduler/viewSchedulerGroup");
		$("#detailForm").submit();
    }
    
    function goList(){
    	$("#detailForm").attr("action","/atom/general/scheduler/list");
		$("#detailForm").submit();
    }
    
    function fnRemove(){
    	
    	var param = new Object();
    	param = $("#detailForm").serialize();

		$.ajax({
            url 	: "deleteSchedulerGroupAction",
            data	: param,
            type 	: 'POST',
            dataType: 'json',
            success : function(data) {
            	refresh();
            	goList();
            },
            error: function(e){
            	openAlertModal(e.responseText);
            },
            complete : function() {

            }
		});
    }
    
    function goModify(){
    	console.log( "expire_dt : " + $("#expire_dt").val() );
    	console.log( "expire_tm : " + $("#expire_tm").val() );
    	
    	var param = new Object();
    	param = $("#detailForm").serialize();

		$.ajax({
            url : "updateSchedulerGroupAction",
            data : param,
            type : 'POST',
            dataType : 'json',
            success : function(data) {
            	
            	refresh();
            	console.log( "[mirinae.maru] update result : " + data.result );
            	
//             	setTimeout(function() {
//             		goList();
//             	}, 5000);
            },
            error: function(e){
            	openAlertModal(e.responseText);
            },
            complete : function() {

            }
		});
 	}
	
	function refresh() {
    	
    	$.ajax({
            url : "socketInfo",
            data : new Object(),
            type : 'POST',
            dataType : 'json',
            success : function(data) {
            	
            	console.log( "[mirinae.maru] node_no : " + data.nodeInfo.node_no );
            	console.log( "[mirinae.maru] node_type : " + data.nodeInfo.node_type );
            	console.log( "[mirinae.maru] proc_no : " + data.processInfo.proc_no );
            	console.log( "[mirinae.maru] proc_name : " + data.processInfo.proc_name );
            	console.log( "[mirinae.maru] pkg_name : " + data.processInfo.pkg_name );
            	
            	var JSON_data = new Object();
            	JSON_data.pkg_name 	= data.processInfo.pkg_name;
            	JSON_data.node_type	= data.nodeInfo.node_type;
                JSON_data.proc_name	= data.processInfo.proc_name;
                JSON_data.proc_no	= data.processInfo.proc_no;
            	
                console.log( "[mirinae.maru] JSON_data : " + JSON.stringify(JSON_data) );
            	
            	CommandREQ("0000060002", data.nodeInfo.node_no*1, data.processInfo.proc_no*1, JSON.stringify(JSON_data));
            }
		});
    }
	
	function fnCommonMessage(command, messages) {

		if (command == 60002) { 
			console.log( "[mirinae.maru] Batch Group update response..." );
			console.log( "[mirinae.maru] command : " + command );
			
			responseUpdateBatchGroup( messages );
		}
	}
	
	function responseUpdateBatchGroup( messages ) {
		console.log( "[mirinae.maru] response MSG : " + JSON.stringify(messages) );
	}
</script>   

    <div class="content">
		<!-- cont_body -->
		<div class="cont_body">
			<div class="detail">
            	<form id="detailForm" name="detailForm">
            		<!-- modify 화면이동시 필요 -->
	            	<input type="hidden" id="pkg_name" name="pkg_name" value="${schedulerGroup.pkg_name}">
	            	<!-- list 화면이동시 필요 -->
	            	<input type="hidden" id="group_name" name="group_name" value="${schedulerGroup.group_name}">
	            	<input type="hidden" id="schedule_cycle_type" name="schedule_cycle_type" value="${schedulerGroup.schedule_cycle_type}">

	                <table class="tbl_detail">
	                	<caption>Batch Group</caption>
	                    <colgroup>
		                    <col width="20%"/>
		                    <col width="20%"/>
		                    <col width="20%"/>
		                    <col width="20%"/>
	                    </colgroup>
	                    <tr>
	                        <th scope="col"><spring:message code="label.general.systeminformation.package.text" /></th>
	                        <th scope="col"><spring:message code="label.pfnm.batch.batch_group.text" /></th>
	                        <th scope="col"><spring:message code="label.pfnm.batch.apply_date.text" /></th>
	                        <th scope="col"><spring:message code="label.pfnm.batch.expire_date.text" /></th>
	                    </tr>
	                    <tr>
	                        <td>${schedulerGroup.pkg_name}</td>
	                        <td>${schedulerGroup.group_name}</td>
	                        <td>${schedulerGroup.start_date}</td>
	                        <td class="t_c">
	                        	<div class="period">
		                        	<%-- ${schedulerGroup.expire_date} --%>
	                        		<div class="input-period">
										<div class="input-group date" data-date-end-date="0d">
											<input type="text" class="form-control" id="expire_dt" name="expire_dt" value="${schedulerGroup.expire_dt}" readonly="readonly">
											<span class="input-group-addon icon"></span>
										</div>
									</div>
									<!-- startTime -->
									<div class="input-period clockpicker" data-placement="bottom" data-align="top" data-autoclose="true">
										<input type="text" class="form-control" id="expire_tm" name="expire_tm" value="${schedulerGroup.expire_tm}" readonly="readonly">
										<span class="input-period-addon"></span>
									</div>
								</div>
	                        </td>
	                    </tr>
	                    <tr>
	                    	<th scope="col" colspan="2">
	                        	<spring:message code="label.resource.statistics.cycle.text" />
	                        	<spring:message code="label.configuration.networkmanager.type.text" /> 
	                        </th>
	                        <th scope="col"><spring:message code="label.resource.statistics.cycle.text" /></th>
	                        <th scope="col"><spring:message code="label.configuration.networkmanager.use.text" /></th>
	                    </tr>
	                    <tr>
	                    	<td colspan="2">
								<c:forEach items="${cycleType}" var="cycleModel" varStatus="status">
		                            <input type="radio" id="${cycleModel.NAME}" name="status" value="${cycleModel.ID}" />
		                            <label for="${cycleModel.NAME}">${cycleModel.NAME}</label>
	                            </c:forEach>
							</td>
	                        <td>
	                        	<span id="schedule_cycle_val">
		                        	<input type="text" class="input_xs" id="schedule_cycle" name="schedule_cycle" value="${schedulerGroup.schedule_cycle}"/>
		                        	<c:forEach items="${cycleType}" var="cycleModel" varStatus="status">
			                            <c:if test="${cycleModel.ID eq schedulerGroup.schedule_cycle_type}">
			                            	<span id="schedule_cycle_label">${cycleModel.NAME}</span>
			                            </c:if>
		                            </c:forEach>
	                            </span>
	                            <span id="schedule_cycle_none">
	                            	None
	                            </span>
	                        </td>
	                        <td>
								<select id="use_yn" name="use_yn" class="single">
									<c:forEach items="${listYn}" var="yn" varStatus="status">
										<option value="${yn.ID}" <c:if test="${yn.ID eq schedulerGroup.use_yn}">selected</c:if> >${yn.NAME}</option>
									</c:forEach>
		                        </select>
							</td>
	                    </tr>
	                    <tr>
	                    	<th scope="col" colspan="4">Description</th>
	                    </tr>
	                    <tr>
	                    	<td colspan="4"><textarea id="description" name="description" placeholder="Description" rows="3"/>${schedulerGroup.description}</textarea></td>
	                    </tr>
	                </table>
				</form>
            </div>
        </div>
		<!-- //cont_body -->
		
        <div class="cont_footer">
            <div class="btn_area">
            	<button id="btn_view" type="button"><spring:message code="label.common.cancel.text" /></button>
            	<ntels:auth auth="${authType}">
                <button id="btn_del" type="button"><spring:message code="label.common.delete.text" /></button>
                <button id="btn_save" type="button"><spring:message code="label.common.save.text" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 