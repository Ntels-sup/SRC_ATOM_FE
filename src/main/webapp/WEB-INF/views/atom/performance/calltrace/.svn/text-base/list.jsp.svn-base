<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="/scripts/jwebsocket/1_0_b1/jWebSocket.js"></script>
<script src="/scripts/jwebsocket/pfnmWebSocket.js"></script>
<script src="/scripts/stringUtil.js"></script>
<style>
.statusviewWrap{position:relative;height:596px;background:#0a1e40;color:#fff;overflow:hidden;clear:both;border-radius:7px}
.statusviewWrap .statusviewLeft,.statusviewWrap .statusviewRight{float:left;height:100%;padding:15px 23px;overflow:auto}
.statusviewWrap .statusviewLeft{width:280px;}
.statusviewWrap .statusviewRight{width:calc(100% - 280px);border-left:1px solid #020711;}
.cont_right.type02{padding:0px;border-left:0px;}
.detail.type03 {width: 330px;height: 640px;border-radius: 7px;}
.command{height:639px;}
</style>
<script>
var g_trcHist = null;
$(document).ready(function() {
	var socketUrl = "${pageContext.servletContext.getAttribute('websocket.connect.url')}";
	initPage(socketUrl, "callTrace");
	
	$("#node_id, #search_mode, #trace_mode").multipleSelect({
        single: true,
        selectAll: false,
        multiple: false
	});
	$("#startButton").click(function() {
		insertHist();
	});
	$("#stopButton").click(function() {
		traceStop(g_trcHist);
	});
	$("#eraseButton").click(function() {
		eraseDivContents();
	});
	$("#downloadButton").click(function() {
		downloadDivContents();
	});
});

function downloadDivContents() {
	$("#downloadContents").attr("download", "export.html");
	$("#downloadContents").attr("href", "data:text/html," + $("#statusviewRight").html());
	$("#downloadContents")[0].click();
}

function eraseDivContents() {
	$(".statusviewLeft").html("");
	$(".statusviewRight").html("");
}

function traceStart(trcHist) {
	/* "{
	  ""BODY"": {
	    ""oper_no"" : 10,
	    ""pkg_name"" : ""POFCS"",
	    ""node_no"" : 1,
	    ""node_type"" : ""EMS"",
	    ""trace"" : ""on"",
	    ""protocol"" : 0,
	    ""search_mode"" : 1/2/3/4"",
	    ""keyword"" : ""821012231123/45005821012234123/192.168.100.101/192.168.100.102"",
	    ""run_mode"" : ""1/2"",
	    ""user_id"" : ""abc123"",
	    ""start_date"" : ""20160430160045""
	  }
	}" */
	var command = "0000100001";
	var destinationNodeId = 1;
	var destinationProcessId = 11;
	JSON_data = new Object();
	JSON_data.oper_no = parseInt(trcHist.oper_no);
	JSON_data.pkg_name = $("#node_id option:selected").parent("optGroup").attr("label");
	JSON_data.node_no = parseInt($("#node_id").val());
	JSON_data.node_type = $("#node_id option:selected").data("node_type");
	JSON_data.trace = "on";
	JSON_data.protocol = parseInt(trcHist.protocol);
	JSON_data.search_mode = parseInt($("#search_mode").val());
	JSON_data.keyword = $("#keyword").val();
	JSON_data.run_mode = parseInt($("#trace_mode").val());
	JSON_data.user_id = "${sessionUser.userId}";
	JSON_data.start_date = trcHist.start_date;
	JSON_data.end_date = "";
	CommandREQ(command, destinationNodeId, destinationProcessId, JSON.stringify(JSON_data));
}

function traceStop(trcHist) {
	/* "{
	  ""BODY"": {
	    ""oper_no"" : 10,
	    ""pkg_name"" : ""POFCS"",
	    ""node_no"" : 1,
	    ""node_type"" : ""EMS"",
	    ""trace"" : ""off"",
	    ""protocol"" : 0,
	    ""search_mode"" : 1/2/3/4"",
	    ""keyword"" : ""821012231123/45005821012234123/192.168.100.101/192.168.100.102"",
	    ""run_mode"" : ""1/2"",
	    ""user_id"" : ""abc123"",
	    ""start_date"" : ""2016-04-30 16:00:45"",
	    ""end_date"" : ""2016-04-30 16:00:45""
	  }
	}" */
	var command = "0000100002";
	var destinationNodeId = 1;
	var destinationProcessId = 11;
	var JSON_data = new Object();
	JSON_data = new Object();
	JSON_data.oper_no = parseInt(trcHist.oper_no);
	JSON_data.pkg_name = $("#node_id option:selected").parent("optGroup").attr("label");
	JSON_data.node_no = parseInt($("#node_id").val());
	JSON_data.node_type = $("#node_id option:selected").data("node_type");
	JSON_data.trace = "off";
	JSON_data.protocol = parseInt(trcHist.protocol);
	JSON_data.search_mode = parseInt($("#search_mode").val());
	JSON_data.keyword = $("#keyword").val();
	JSON_data.run_mode = parseInt($("#trace_mode").val());
	JSON_data.user_id = "${sessionUser.userId}";
	JSON_data.start_date = trcHist.start_date;
	JSON_data.end_date = trcHist.end_date;
	CommandREQ(command, destinationNodeId, destinationProcessId, JSON.stringify(JSON_data));
	
	addTextToLeftDiv("<spring:message code="msg.performance.calltrace.requeststop.text"/>");
	
	g_nTimeout = setTimeout(function() {
		checkStopResponseArrived();
	}, 10000);
}

function disableButton(selector) {
	$(selector).prop("disabled", true);
	$(selector).css("background-color", "#aaaaaa");
}

function enableButton(selector) {
	$(selector).prop("disabled", false);
	$(selector).css("background-color", "");
}

function updateHist() {
	var param = g_trcHist;
	
	$.ajax({
		url: "updateHist",
		data: param,
		type: 'POST',
		dataType: 'json',
		success: function(data) {
			var result = data.result;
			if (result == "succ") {
				var trcHist = data.trcHist;
				
				setElementsDisabled(true, true);
				
			} else {
				openAlertModal(result);
			}
		},
		error: function(e) {
			var error = JSON.parse(e.responseText);
			openAlertModal(error.errorMsg.cause.localizedMessage);
			hideLoading();
		},
		complete: function() {
		}
	});
}


var g_nTimeout = null;
// websocket 요청 보내기 전에 TAT_OPERATION_HIST, TAT_TRC_HIST 테이블에 이력을 INSERT 한다.
function insertHist() {
	if (isEmpty($("#keyword").val())) {
		openAlertModal("<spring:message code="msg.performance.calltrace.keyword.empty"/>", "", function() {
			$("#keyword").focus();
		});
		return;
	}
	if (($("#search_mode").val() == "1" || $("#search_mode").val() == "2") && !isValidNumber($("#keyword").val())) {
		openAlertModal("<spring:message code="msg.performance.calltrace.keyword.number.invalid"/>", "", function() {
			$("#keyword").focus();
		});
		return;
	}
	if (($("#search_mode").val() == "3" || $("#search_mode").val() == "4") && !isValidIpAddress($("#keyword").val())) {
		openAlertModal("<spring:message code="msg.performance.calltrace.keyword.ip.invalid"/>", "", function() {
			$("#keyword").focus();
		});
		return;
	}
	var param = new Object();
	param.package_name = $("#node_id option:selected").parent("optGroup").attr("label");
	param.node_name = $("#node_id option:selected").text();
	param.user_id = "${sessionUser.userId}";
	param.protocol = 0;
	param.run_mode = $("#trace_mode").val();
	param.search_mode = $("#search_mode").val();
	param.cmd = "";
	param.file_name = "";
	param.status = 0;

	$.ajax({
		url: "insertHist",
		data: param,
		type: 'POST',
		dataType: 'json',
		success: function(data) {
			var result = data.result;
			if (result == "succ") {
				var trcHist = data.trcHist;
				traceStart(trcHist);
				
				setElementsDisabled(true, true);
				
				g_trcHist = trcHist;
				
				addTextToLeftDiv("<spring:message code="msg.performance.calltrace.requeststart.text"/>");
				
				g_nTimeout = setTimeout(function() {
					checkStartResponseArrived();
				}, 10000);
			} else {
				openAlertModal(result);
			}
		},
		error: function(e) {
			var error = JSON.parse(e.responseText);
			openAlertModal(error.errorMsg.cause.localizedMessage);
			hideLoading();
		},
		complete: function() {
		}
	});
}

// disabled 속성을 변경한다.
function setElementsDisabled(bStart, bStop) {
	if (bStart) {
		$("#node_id, #search_mode, #trace_mode").multipleSelect("disable");
		$("#keyword").prop("disabled", true);
		disableButton("#startButton");
	} else {
		$("#node_id, #search_mode, #trace_mode").multipleSelect("enable");
		$("#keyword").prop("disabled", false);
		enableButton("#startButton");
	}
	if (bStop) {
		disableButton("#stopButton");
	} else {
		enableButton("#stopButton");
	}
}

// 웹소켓 요청이 정상적으로 송신되었는지 체크
function checkStartResponseArrived() {
	if (g_nTimeout == null) {
		return;
	}
	addTextToLeftDiv("<spring:message code="msg.performance.calltrace.requeststart.fail.text"/>");
	setElementsDisabled(false, true);
	// updateHist();
}

//웹소켓 요청이 정상적으로 송신되었는지 체크
function checkStopResponseArrived() {
	if (g_nTimeout == null) {
		return;
	}
	addTextToLeftDiv("<spring:message code="msg.performance.calltrace.requeststop.fail.text"/>");
	setElementsDisabled(true, false);
}

function addTextToLeftDiv(sText) {
	if (!isEmpty($(".statusviewLeft").html())) {
		$(".statusviewLeft").append("<br/>");
	}
	$(".statusviewLeft").append(sText);
}

function addTextToRightDiv(sText) {
	if (!isEmpty($(".statusviewRight").html())) {
		$(".statusviewRight").append("<br/>");
	}
	$(".statusviewRight").append(sText);
}

// 웹소켓 메시지 수신
function fnCommonMessage(command, message) {
	console.log(command);
	console.log(message);
	var msgObj = JSON.parse(message);
	if (command == 100001) {
		// TRACE_ON Response
		/* "{
		  ""BODY"": {
		    ""oper_no"" : 10,
		    ""trace"" : ""on"",
		    ""status"" : ""start/process/finish"",
		    ""start_date"" : ""20160430160045"",
		    ""end_date"" : """",
		    ""success"" : true/false,
		    ""msg"" : """"
		   }
		}" */
		if (msgObj.oper_no == g_trcHist.oper_no) {
			if (msgObj.trace == "on" && msgObj.success) {
				addTextToLeftDiv("<spring:message code="msg.performance.calltrace.tracestart.text"/>");
				clearTimeout(g_nTimeout);
				g_nTimeout = null;
				setElementsDisabled(true, false);
			}
			if (msgObj.trace == "off" && msgObj.success) {
				if (msgObj.oper_no == g_trcHist.oper_no) {
					if (msgObj.success) {
						addTextToLeftDiv("<spring:message code="msg.performance.calltrace.tracestop.text"/>");
						clearTimeout(g_nTimeout);
						g_nTimeout = null;
						setElementsDisabled(false, true);
						g_trcHist = null;
					}
				}
			}
		}
	} else if (command == 100002) {
		// TRACE_OFF Response
		/* "{
		  ""BODY"": {
		    ""oper_no"" : 10,
		    ""trace"" : ""off"",
		    ""status"" : ""start/process/finish"",
		    ""start_date"" : ""2016-04-30 16:00:45"",
		    ""end_date"" : ""2016-04-30 16:00:45"",
		    ""success"" : true/false,
		    ""msg"" : """"
		   }
		}" */
	} else if (command == 100003) {
		// TRACE_DATA
		/* "{
		  ""BODY"": {
		    ""oper_no"" : 10,
		    ""trace"" : ""on"",
		    ""status"" : ""process"",
		    ""start_date"" : ""20160430160045"",
		    ""end_date"" : ""20160430160045"",
		    ""success"" : true/false,
		    ""msg"" : ""fdsfasdfdsfdsaffsafdfaffasfdas~~~~~~~~~~~~~~~~~~~~""
		   }
		}" */
		addTextToLeftDiv("<spring:message code="msg.performance.calltrace.received.text"/>");
		
		var msg = msgObj.msg;
		addTextToRightDiv(msg);
	}
}

/**
 * 웹소켓 접속 종료됨
 */ 
function fnDisconnectSocket(status) {
	console.log(status);
	if (lWSC) {
		//lWSC.stopKeepAlive();
		console.log("Disconnecting...");
		var lRes = lWSC.close();
		console.log("reason : "+lWSC.resultToString(lRes));
		
		fnLoadingTry(true);
		
		//재시도
		setTimeout(function() { 
			initPage(socketUrl, "monitor"); 
		}, 5000);
	}
}

/**
 * 뱅글뱅글 돌아아야한다.
 */
function fnLoadingTry(isBoolean) {
	if (isBoolean) { //뱅글뱅글 돌자 화면
		//console.log("돌자");
		$("#disconnect_popup").modal({
			opacity:92,
		    overlayCss: {backgroundColor:"#fff"}
		});
	} else { //뱅글뱅글 돌기 화면 업애기
		//console.log("돌기 업애기");
		$.modal.close();
	}
}
</script>
<div style="display:none;">
	<a id="downloadContents"></a>
</div>
<div class="content">
	<div class="cont_body">
		<div class="cont_left">
			<div class="detail type03">
				<table class="tbl_detail">
					<caption><spring:message code="label.performance.calltrace.configuration.text"/></caption>
					<tbody>
						<tr>
							<th scope="col" class="imp"><spring:message code="label.performance.calltrace.packagenode.text"/></th>						
						</tr>
						<tr>
							<td>
								<div class="select_group_type02">
									<select id="node_id" class="single">
										<c:forEach items="${Package}" var="Packagelist" varStatus="status">
											<optgroup label="${Packagelist.NAME}">
												<c:forEach items="${System}" var="Systemlist" varStatus="status">
													<c:if test="${Packagelist.ID eq Systemlist.PACKAGEID}">
														<option value="${Systemlist.ID}" data-node_type="${Systemlist.NODETYPE}">${Systemlist.NAME}</option>
													</c:if>
												</c:forEach>
											</optgroup>
										</c:forEach>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="col" class="imp"><spring:message code="label.performance.calltrace.tracemode.text"/></th>						
						</tr>
						<tr>
							<td colspan="2">
								<select id="trace_mode" class="single">
									<c:forEach items="${traceModes}" var="traceMode" varStatus="status">
										<option value="${traceMode.ID}">${traceMode.NAME}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="col" class="imp"><spring:message code="label.performance.calltrace.keyword.text"/></th>
						</tr>
						<tr>
							<td colspan="2" class="last">
								<select id="search_mode" name="search_mode" class="single">
									<c:forEach items="${keywords}" var="keyword" varStatus="status">
										<option value="${keyword.ID}">${keyword.NAME}</option>
									</c:forEach>
								</select>
								<input type="text" id="keyword" name="keyword" placeholder="keyword">
							</td>
						</tr>
					</tbody>
				</table>
				
				<div class="btn_area">
					<button id="startButton" type="button" class="major"><spring:message code="label.performance.calltrace.start.text"/></button>
					<button id="stopButton" type="button" class="major" style="background-color:#aaaaaa;" disabled><spring:message code="label.performance.calltrace.stop.text"/></button>
				</div>
			</div>
		</div>
		<!-- cont_left -->
		<!-- cont_right -->
		<div class="cont_right type02">
			<div class="command">
				<header>
					<h3><spring:message code="label.performance.calltrace.status.text"/></h3>
					<span class="btn_area">
						<button id="eraseButton" type="button" class="btn_icon eraser" title="Ereser">
							<span><spring:message code="label.performance.calltrace.eraser.text"/></span>
						</button>
						<button id="downloadButton" type="button" class="btn_icon down" title="Download">
							<span><spring:message code="label.performance.calltrace.download.text"/></span>
						</button>
					</span>
				</header>
				
				<div class="statusviewWrap">
					<div id="statusviewLeft" class="statusviewLeft scroll-type4"></div>
					<div id="statusviewRight" class="statusviewRight scroll-type4"></div>
				</div>
			</div>
		</div>
		<!-- cont_right -->
	</div>
<!-- //cont_body -->     
</div>
<!-- disconnect Server -->
<div id="disconnect_popup" style="display:none;">
	<div class="disconnect">
		<div class="loading_page red"><i></i><i></i></div>  
		<h4>Disconnect Server</h4>
		<p>
			<spring:message code="msg.monitor.disconnect"/>
		</p>
		<p id="disconnect_popup_message"></p>
	</div>
</div>