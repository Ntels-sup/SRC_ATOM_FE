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
     
      		/* Clock */
	 $(".clockpicker").clockpicker().find("input").change(function(){});
	
	$("select.single").multipleSelect({
        single: true,
        selectAll: false,
        multiple: false
    });
      	
      	
  		$("#btn_list").click(function(){
  			goList();
  		});
  		
  		$("#btn_save").click(function(){
  			goSave();
  		});
  		
  		$("input[type=radio][name=status]").change(function() {
  			
  			console.log( "selected value : " + $(this).val() );
  			
  			var statusVal = $(this).val();
  			
  			$("#schedule_cycle_type").val( statusVal );
  			
  			if( statusVal=='01' ) {
  				$("#schedule_cycle_val").hide();
  				$("#schedule_cycle_none").show();
  			}
  			else {
  				$("#schedule_cycle_val").show();
  				$("#schedule_cycle_none").hide();
  				
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
  		
  		$("input[name=status][value='01']").prop("checked",true);
  		$("#schedule_cycle_type").val( '01' );
  		
  		$("#schedule_cycle_val").hide();	
		$("#schedule_cycle_none").show();
  	}
    
    function goList(){
    	
    	$("#pkg_name").val( $("#param_pkg_name").val() );
    	$("#group_name").val( $("#param_group_name").val() );
    	
    	$("#detailForm").attr("action","/atom/general/scheduler/list");
		$("#detailForm").submit();
    }
    
    //user manage goSave
 	function goSave(){
    	
//  		console.log( "pkg_name : " + $("#pkg_name").val() );
//  		console.log( "group_name : " + $("#group_name").val() );
//  		console.log( "schedule_cycle : " + $("#schedule_cycle").val() );
//  		console.log( "schedule_cycle_type : " + $("#schedule_cycle_type").val() );
//  		console.log( "expire_dt : " + $("#expire_dt").val() );
//     	console.log( "expire_tm : " + $("#expire_tm").val() );
    	
    	// package name
    	if($.trim($("#pkg_name").val()) == "" || $("#pkg_name").val() == null){
    		openAlertModal("","<spring:message code='msg.configuration.networkmanager.package.empty' />",function(){$("#pkg_name").focus();});
    		return;
    	}
    	
    	// group name
    	if($.trim($("#group_name").val()) == "" || $("#group_name").val() == null){
    		openAlertModal("","<spring:message code='msg.standardization.group.name.select' />",function(){$("#group_name").focus();});
    		return;
    	}
    	
    	// schedule cycle
    	if($.trim($("#schedule_cycle_type").val()) != "01" && ($("#schedule_cycle").val() == null || $("#schedule_cycle").val() == "")){
    		openAlertModal("","<spring:message code='label.pfnm.batch.schedule_cycle.insert.msg' />",function(){$("#schedule_cycle").focus();});
    		return;
    	}
    	
    	var param = new Object();
    	param = $("#detailForm").serialize();
    	
    	console.log( "param : " + param );

		$.ajax({
            url : "insertSchedulerGroupAction",
            data : param,
            type : 'POST',
            dataType : 'json',
            success : function(data) {
            	
            	//CommandREQ("0000060002", destinationNodeId, 2147483494, JSON_data);
            	refresh();
            	
            	if( data.result == -1 ) {
            		openAlertModal("","<spring:message code="msg.standardization.group.name.exist" />",function(){});	
            	}
            	else {
            		openAlertModal("","<spring:message code="msg.common.saved" />",function(){
                		goList();
                	});
            	}
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
		console.log( "[mirinae.maru] command : " + command );
		console.log( "[mirinae.maru] messages : " + JSON.stringify(messages) );
	}
	
</script>   

    <div class="content">
		<!-- cont_body -->
		<div class="cont_body">
			<div class="detail">
            	<form id="detailForm" name="detailForm">
            		<input type="hidden" id="param_pkg_name" name="param_pkg_name" value="${schedulerGroup.pkg_name}">
	            	<input type="hidden" id="param_group_name" name="param_group_name" value="${schedulerGroup.group_name}">
	            	
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
	                        <td>
								<select id="pkg_name" name="pkg_name" class="single">
			                         	<c:forEach items="${Package}" var="Packagelist" varStatus="status">
				                            <option value="${Packagelist.NAME}">${Packagelist.NAME}</option>
			                            </c:forEach>
			                        </select>
							</td>
	                        <td><input type="text" id="group_name" name="group_name" maxlength="20" placeholder="<spring:message code="label.standardization.group.name" />" /></td>
	                        <td class="t_c">
	                        	<div class="period">
		                        	<div class="input-period">
										<div class="input-group date" data-date-end-date="0d">
											<input type="text" class="form-control" id="start_dt" name="start_dt" value="${schedulerGroup.start_dt}" readonly="readonly">
											<span class="input-group-addon icon"></span>
										</div>
									</div>
									<!-- startTime -->
									<div class="input-period clockpicker" data-placement="bottom" data-align="top" data-autoclose="true">
										<input type="text" class="form-control" id="start_tm" name="start_tm" value="${schedulerGroup.start_tm}" readonly="readonly">
										<span class="input-period-addon"></span>
									</div>
								</div>

							</td>
	                        <td class="t_c">
	                        	<div class="period">
		                        	<div class="input-period">
										<div class="input-group date" data-date-start-date="0d">
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
		                        	<input type="text" class="input_xs" id="schedule_cycle" name="schedule_cycle" value=""/>
			                            <span id="schedule_cycle_label"></span>
	                            </span>
	                            <span id="schedule_cycle_none">
	                            	None
	                            </span>
	                        </td>
	                        <td>
								<select id="use_yn" name="use_yn" class="single">
									<c:forEach items="${listYn}" var="yn" varStatus="status">
										<option value="${yn.ID}">${yn.NAME}</option>
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
            	<button id="btn_list" type="button"><spring:message code="label.common.cancel.text" /></button>
            	<ntels:auth auth="${authType}">
                <button id="btn_save" type="button"><spring:message code="label.common.save.text" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 