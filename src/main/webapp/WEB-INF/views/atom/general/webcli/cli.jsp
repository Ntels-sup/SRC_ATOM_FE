<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script src="/scripts/jwebsocket/pfnmWebSocket.js"></script>
<script src="/scripts/jwebsocket/1_0_b1/jWebSocket.js"></script>
  
<script type="text/javascript">

console.log( "Init start... : " + "${pageContext.servletContext.getAttribute('websocket.connect.url')}" );

initPage("${pageContext.servletContext.getAttribute('websocket.connect.url')}", "commandLineInterface");

var paramArray;
var pkgName 	= "";
var processNo 	= "";
var nodeNo		= "";

$(document).ready(function() {	
	
	var tdObj = $("#packageNodeList");
	var pkgOption = "";
	
	pkgOption = pkgOption + '<select id="system_id" name="system_id" class="group_single" multiple="multiple" value="UncheckAll">';
	pkgOption = pkgOption + '    <c:forEach items="${Package}" var="Packagelist" varStatus="status">';
	pkgOption = pkgOption + '        <optgroup label="${Packagelist.NAME}">';
	pkgOption = pkgOption + '            <c:forEach items="${System}" var="Systemlist" varStatus="status">';
	pkgOption = pkgOption + '               <c:if test="${Packagelist.ID eq Systemlist.PACKAGEID}">';
	pkgOption = pkgOption + '               		<option value="${Systemlist.NAME}">${Systemlist.NAME}</option>';
	pkgOption = pkgOption + '               </c:if>';
	pkgOption = pkgOption + '            </c:forEach>';
	pkgOption = pkgOption + '        </optgroup>';
	pkgOption = pkgOption + '     </c:forEach>';
	pkgOption = pkgOption + '</select>';
	
//	 	alert(pkgOption);

 	$(tdObj).empty();
 	$(tdObj).append(pkgOption);
	
	$("select[id=system_id]").multipleSelect({
		filter		: true,
		single		: true,  
        multiple	: true,
        multipleWidth: 150,
        width		: "602px",
        onClick		: function(view){
       		console.log('[mirinae.maru] Package / Node... :  ' + JSON.stringify(view.value));
       		listCMD( view.value );
       		getPkgName( view.value );
			getNodeNo( view.value );
			
       		conditionInitialize();// 조건 초기화
        } 
	},"refresh");
	
	$("select[id=cmd_name]").multipleSelect({
    	single	: true,
    	selectAll	: false,
    	multiple	: false,
        onClick		: function(view){
       		console.log('[mirinae.maru] CMD change :  ' + JSON.stringify(view.value));
       		conditionInitialize();	// 조건 초기화
       		listCMDArg( view.value );
        } 
	},"refresh");
	
	$("select[id=svc_no]").multipleSelect({
    	single		: true,
    	selectAll	: false,
    	multiple	: false,
        onClick		: function(view){
       		console.log('[mirinae.maru] service change :  ' + JSON.stringify(view.value));
       		listProcess( view.value );// svc_no
        } 
	},"refresh");
	
	$("select[id=proc_no]").multipleSelect({
    	single: true,
    	selectAll: false,
    	multiple: false
	});
	
	// 메세지 삭제
	$("#status_message_ereser").click(function() {
		$("#status_message").empty();
	});
	
	// 메세지 다운로드
	$("#status_message_download").click(function() {
		
		console.log("download : " + $("#status_message").text() );
		
		var status_text = $("#status_message").html();
		console.log("download : " + status_text );
		
    	if (status_text == "") {
    		alert("There is nothing");
    	} else {    		
    		// $("#status_message").prepend( messages.text.replace(/\n/gi,"<br>") );
    		status_text = status_text.replace(/=/gi,"-");
    		status_text = status_text.replace(/<br>/gi,"\n");
    		console.log(status_text);
    		$.download('download', "txt="+status_text, 'post' );
    	}
    	
	});

	$("#execute").click(function() {
		
		console.log('[mirinae.maru] session_id : ' + 18 );
		console.log('[mirinae.maru] node : ' + $("select[id=system_id] option:selected").text());
		console.log('[mirinae.maru] command : ' + $("select[id=cmd_name] option:selected").text());
		console.log('[mirinae.maru] command_code : ' + $("select[id=cmd_name]").val() );
		console.log('[mirinae.maru] svc_no : ' + $("select[id=svc_no]").val() );
		console.log('[mirinae.maru] proc_no : ' + $("select[id=proc_no]").val() );
		console.log('[mirinae.maru] queue_name : ' + $("#queue_name").val() );
		console.log('[mirinae.maru] queue_count : ' + $("#queue_count").val() );
		
		
		var argument;
		var parameter;
		var parameter_array;
		
		var argument_array 	= new Array();
		var JSON_data 		= new Object();
		
		var node_name 	= $("select[id=system_id] option:selected").text();
		var command_code= $("select[id=cmd_name]").val();
		
		// package / node
		if( node_name==null || node_name=="" ) {
			openAlertModal('<spring:message code="msg.common.empty.node" />',"",function(){
				$("#system_id").focus();
			});
    		return;
		}
		
		// command
		if( command_code==null || command_code=="" ) {
			openAlertModal('<spring:message code="msg.common.empty.command.select" />',"",function(){
				$("#cmd_name").focus();
			});
    		return;
		}
		
		JSON_data.session_id 	= "01025231692";	// 항목은 필요하고 값은 필요하지 않아 dummy value를 입력
		JSON_data.command_code 	= $("select[id=cmd_name]").val();
		JSON_data.command 		= $("select[id=cmd_name] option:selected").text();
		
		console.log('[mirinae.maru] JSON_data : ' + JSON.stringify(JSON_data) );
		
		var chk = true;
		$.each(paramArray, function(i,command_arg_name) {
			
			if( command_arg_name=="SERVICE_NAME" ) {
				
				if( $("select[id=svc_no] option:selected").val()==undefined || $("select[id=svc_no] option:selected").val()==null || $("select[id=svc_no] option:selected").val()=="" ) {
// 					openAlertModal('<spring:message code="msg.common.empty.service" />',"",function(){
// 						 $("select[id=svc_no]").focus();
// 					});
// 					chk = false;
// 					return false;
				}
				else {
					argument 	= new Object();
					parameter 	= new Object();
					
					
					argument.name = command_arg_name;
					
					parameter_array = new Array();
					parameter.parameter = $("select[id=svc_no] option:selected").text();
					parameter_array.push( parameter );

					argument.parameter_array = parameter_array;
					console.log('[mirinae.maru] service argument : ' + JSON.stringify(argument) );
					argument_array.push( argument );
				}
			}
			else if( command_arg_name=="PROCESS_NAME" ) {
    			
    			if( $("select[id=proc_no] option:selected").val()==undefined || $("select[id=proc_no] option:selected").val()==null || $("select[id=proc_no] option:selected").val()=="" ) {
// 					openAlertModal('<spring:message code="msg.common.empty.process" />',"",function() {
// 						 $("select[id=proc_no]").focus();
// 					});		
// 					chk = false;	
// 					return false;
				}
				else {
					argument 	= new Object();
					parameter 	= new Object();
					
					
					argument.name = command_arg_name;
					
					parameter_array = new Array();
					parameter.parameter = $("select[id=proc_no] option:selected").text();
					parameter_array.push( parameter );

					argument.parameter_array = parameter_array;
					console.log('[mirinae.maru] process argument : ' + JSON.stringify(argument) );
					argument_array.push( argument );
					
					processNo = $("select[id=proc_no] option:selected").val();
				}
			}
			else if( command_arg_name=="QUEUE_NAME" ) {
    			
    			if( $("#queue_name").val()==null || $("#queue_name").val()=="" ) {
					openAlertModal('<spring:message code="msg.common.empty.queue.count" />',"",function(){$("#queue_name").focus();});
					chk = false;
					return false;
				}
				else {
					argument 	= new Object();
					parameter 	= new Object();
					
					
					argument.name = command_arg_name;
					
					parameter_array = new Array();
					parameter.parameter = $("#queue_name").val();
					parameter_array.push( parameter );

					argument.parameter_array = parameter_array;
					console.log('[mirinae.maru] queue name argument : ' + JSON.stringify(argument) );
					argument_array.push( argument );
				}
    		}
			else if( command_arg_name=="QUEUE_COUNT" ) {
    			
				if( $("#queue_count").val()==null || $("#queue_count").val()=="" ) {
					openAlertModal('<spring:message code="msg.common.empty.queue.count" />',"",function(){$("#queue_count").focus();});
					chk = false;
					return false;
				}
				else {
					argument 	= new Object();
					parameter 	= new Object();
					
					
					argument.name = command_arg_name;
					
					parameter_array = new Array();
					parameter.parameter = $("#queue_count").val();
					parameter_array.push( parameter );

					argument.parameter_array = parameter_array;
					console.log('[mirinae.maru] queue count argument : ' + JSON.stringify(argument) );
					argument_array.push( argument );
				}
    		}
    		
			JSON_data.argument_array = argument_array;
		});
		
		console.log('[mirinae.maru] final JSON_data : ' + JSON.stringify(JSON_data) );
     	
		if( chk ) {
			var param = new Object();
			param.pkg_name = pkgName;
			param.cmd_code = $("select[id=cmd_name]").val();
			
			$.ajax({
		        url 	: "getCmdEmsDestination",
		        data	: param,
		        type 	: 'POST',
		        dataType: 'text',
		        success : function(data) {
		        	console.log('[mirinae.maru] data.CMD_EMS_DESTINATION : ' + data );
		        	console.log('[mirinae.maru] data.CMD_EMS_DESTINATION : ' + data );
		        	console.log('[mirinae.maru] data.CMD_EMS_DESTINATION : ' + data );
		        	console.log('[mirinae.maru] data.CMD_EMS_DESTINATION : ' + data );
		        	
		        	console.log('[mirinae.maru] data.CMD_EMS_DESTINATION (typeof data) : ' + (typeof data) );
		        	data = data * 1
		        	console.log('[mirinae.maru] data.CMD_EMS_DESTINATION (typeof data) : ' + (typeof data) );
		        	console.log('[mirinae.maru] data.CMD_EMS_DESTINATION : ' + data );
		        	console.log('[mirinae.maru] data.CMD_EMS_DESTINATION : ' + data );
		        	
		        	console.log('[mirinae.maru] node_no : ' + nodeNo );
		        	console.log('[mirinae.maru] node_no : ' + nodeNo );
		        	console.log('[mirinae.maru] node_no : ' + nodeNo );
		        	console.log('[mirinae.maru] node_no : ' + nodeNo );
		        	console.log('[mirinae.maru] node_no : ' + nodeNo*1 );
		        	
		        	//CommandREQ("0000080001", $("select[id=system_id]").val(), data, JSON.stringify(JSON_data));
		        	CommandREQ("0000080001", nodeNo*1, data, JSON.stringify(JSON_data));
		        },
		        error: function(e){
		        	openAlertModal(e.responseText);
		        },
		        complete : function() {}
			});
		}
	});
});

function conditionInitialize() {
	
	// service selectbox 초기화
	$("select[id=svc_no]").empty().multipleSelect("refresh");
	$(".service_view").css("display","none");
	
	// process selectbox 초기화
	$("select[id=proc_no]").empty().multipleSelect("refresh");
	$(".process_view").css("display","none");
	
	// queue name 초기화
	$("#queue_name").val("");
	$(".queue_name_view").css("display","none");
	
	// queue count 초기화
	$("#queue_count").val("");
	$(".queue_count_view").css("display","none");	
}

function getPkgName( node_name ) {
	
	var param = new Object();
	param.node_name = node_name;
	
	$.ajax({
        url 	: "getPkgName",
        data	: param,
        type 	: 'POST',
        dataType: 'text',
        success : function(data) {
        	pkgName = data;
        },
        error: function(e){
        	openAlertModal(e.responseText);
        },
        complete : function() {}
	});
}

function getNodeNo( node_name ) {
	
	var param = new Object();
	param.node_name = node_name;
	
	$.ajax({
        url 	: "getNodeNo",
        data	: param,
        type 	: 'POST',
        dataType: 'text',
        success : function(data) {
        	nodeNo = data;
        },
        error: function(e){
        	openAlertModal(e.responseText);
        },
        complete : function() {}
	});
}

function listCMD( node_name ) {
	
	var optionTag = "";
	$("select[name='cmd_name'] option").remove();
 	$("#cmd_name").html('<option value="">Select</option>');
 	
 	$("#cmd_name").append(optionTag).multipleSelect('refresh');
 	
	var param = new Object();
	param.node_name = node_name;

	$.ajax({
        url 	: "listCMD",
        data	: param,
        type 	: 'POST',
        dataType: 'json',
        success : function(data) {
        	console.log( "[mirinae.maru] listCMD data : " + JSON.stringify(data) );
        	$.each(data,function(index,obj) {
     			optionTag = $('<option value="'+obj.CMD_CODE+'">'+obj.CMD_NAME+'</option>');
    			$("#cmd_name").append(optionTag).multipleSelect('refresh');
     		});
        },
        error: function(e){
        	openAlertModal(e.responseText);
        },
        complete : function() {}
	});
}

function listCMDArg( cmd_code ) {
	
	console.log('[mirinae.maru] listCMDArg change : ' + cmd_code );

	var param = new Object();
	param.cmd_code = cmd_code;

	$.ajax({
        url 	: "listCMDArg",
        data	: param,
        type 	: 'POST',
        dataType: 'json',
        success : function(data) {
        	
        	paramArray = new Array();
        	
        	console.log( "[mirinae.maru] listCMDArg data : " + JSON.stringify(data) );
        	$.each(data,function(index,obj) {
        		
        		console.log( "[mirinae.maru] listCMDArg ARG_NAME : " + obj.ARG_NAME );
        		
        		if( obj.ARG_NAME=="SERVICE_NAME" ) {
        			console.log( "[mirinae.maru] service list request..." );
        			listService( pkgName );	// service 리스트 요청
        			$(".service_view").css("display","table-row");
        		}
        		
        		// command parameter - PROCESS_NAME
        		if( obj.ARG_NAME=="PROCESS_NAME" ) {
        			$(".process_view").css("display","table-row");
        		}
        		
        		if( obj.ARG_NAME=="QUEUE_NAME" ) {
        			$(".queue_name_view").css("display","table-row");
        		}
        		
        		if( obj.ARG_NAME=="QUEUE_COUNT" ) {
        			$(".queue_count_view").css("display","table-row");
        		}
        		
    			paramArray.push(obj.ARG_NAME);
     		});
        },
        error: function(e){
        	openAlertModal(e.responseText);
        },
        complete : function() {}
	});
}

function listService( pkg_name ) {
	
	var optionTag = "";
	$("select[name='svc_no'] option").remove();
 	$("#svc_no").html('<option value="">Select</option>');
 	
 	$("#svc_no").append(optionTag).multipleSelect('refresh');
 	
	var param = new Object();
	param.pkg_name = pkg_name;

	$.ajax({
        url 	: "listService",
        data	: param,
        type 	: 'POST',
        dataType: 'json',
        success : function(data) {
        	console.log( "[mirinae.maru] svc_no data : " + JSON.stringify(data) );
        	$.each(data,function(index,obj) {
     			optionTag = $('<option value="'+obj.SVC_NO+'">'+obj.SVC_NAME+'</option>');
    			$("#svc_no").append(optionTag).multipleSelect('refresh');
     		});
        },
        error: function(e){
        	openAlertModal(e.responseText);
        },
        complete : function() {}
	});
}

function listProcess( svc_no ) {
	
	console.log( "[mirinae.maru] listProcess node_name : " + $("#system_id").val() );
	console.log( "[mirinae.maru] listProcess svc_no : " + svc_no );
	
	var obj = $("#system_id").val()+"";
	console.log( "[mirinae.maru] obj type : " + (typeof obj) );
	
	
	var optionTag = "";
	$("select[name='proc_no'] option").remove();
 	$("#proc_no").html('<option value="">Select</option>');
 	
 	$("#proc_no").append(optionTag).multipleSelect('refresh');
 	
	var param 		= new Object();
	param.node_name = $("#system_id").val()+"";
	param.svc_no 	= svc_no;	

	console.log( "[mirinae.maru] listProcess param : " + JSON.stringify(param) );
	
	$.ajax({
        url 	: "listProcess",
        data	: param,
        type 	: 'POST',
        dataType: 'json',
        success : function(data) {
        	console.log( "[mirinae.maru] proc data : " + JSON.stringify(data) );
        	$.each(data,function(index,obj) {
     			optionTag = $('<option value="'+obj.PROC_NO+'">'+obj.PROC_NAME+'</option>');
    			$("#proc_no").append(optionTag).multipleSelect('refresh');
     		});
        },
        error: function(e){
        	openAlertModal(e.responseText);
        },
        complete : function() {}
	});
}

function fnCommonMessage(command, messages) {
	
	if (command == 80001) { 
		console.log( "[mirinae.maru] CLI_COMMAND response..." );
		responseCliCommand( messages );
	}
}

function responseCliCommand( messages ) {
	console.log( "[mirinae.maru] response MSG 1: " + JSON.stringify(messages.text) );
	console.log( "[mirinae.maru] response MSG 2 : " + messages.text.replace(/\n/gi,"<br>") );
	$("#status_message").prepend( messages.text.replace(/\n/gi,"<br>") );
}
</script>

	<!-- content -->
    <div class="content">
        <div class="cont_body">
			<div class="cont_left">
				<div class="detail type2">
					<table class="tbl_detail register">
						<caption>Configuration</caption>
						<tbody>
							<tr>
								<th scope="col" class="imp"><spring:message code="label.security.operationhist.package_system.text" /></th><!-- Package / Node -->
							</tr>
							<tr>
								<td>
									<div class="select_group_type02" id="packageNodeList"></div>	
								</td>
							</tr>
							<tr>
								<th scope="col" class="imp"><spring:message code="label.security.operationhist.command.text" /></th><!-- Command -->
							</tr>
							<tr>
								<td>
									<select id="cmd_name" name="cmd_name" class="single"></select>
								</td>
							</tr>
							<tr class="service_view" style="display:none;">
								<th scope="col"><spring:message code="label.common.service" /></th><!-- Service -->
							</tr>
							<tr class="service_view" style="display:none;">
								<td>
									<select id="svc_no" name="svc_no" class="single"></select>
								</td>
							</tr>
							<tr class="process_view" style="display:none;">
								<th scope="col"><spring:message code="label.configuration.processmanager.process.text" /></th><!-- Process -->
							</tr>
							<tr class="process_view" style="display:none;">
								<td>
									<select id="proc_no" name="proc_no" class="single"></select>
								</td>
							</tr>
							<tr class="queue_name_view" style="display:none;">
								<th scope="col" class="imp"><spring:message code="label.general.cli.queuename.text" /></th><!-- Queue Name -->
							</tr>
							<tr class="queue_name_view" style="display:none;">
								<td>
									<input type="text" name="queue_name" id="queue_name" placeholder="keyword">
								</td>
							</tr>
							<tr class="queue_count_view" style="display:none;">
								<th scope="col" class="imp"><spring:message code="label.general.cli.queuecount.text" /></th><!-- Queue Count -->
							</tr>
							<tr class="queue_count_view" style="display:none;">
								<td>
									<input type="text" name="queue_count" id="queue_count" placeholder="keyword">
								</td>
							</tr>
							</span>
						</tbody>
					</table>

					<div class="btn_area">
						<button type="button" class="major" id="execute"><spring:message code="label.configuration.processmanager.execute.text" /></button><!-- Execute -->
					</div>
				</div>
			</div>
			<div class="command type2">
				<header>
					<h3>STATUS</h3>
					<div class="btn_area">
						<button type="button" id="status_message_ereser" class="btn_icon eraser" title="Ereser"><spring:message code="label.general.cli.ereser.text" /></button><!-- Ereser -->
						<button type="button" id="status_message_download" class="btn_icon down" title="Download"><spring:message code="label.common.downlaod" /></button><!-- Download -->
					</div>
				</header>
				<div id="status_message" class="statusview scroll-type4"></div>
			</div>
        </div>
        <!-- //cont_body -->     
    </div>
    <!--// content --> 