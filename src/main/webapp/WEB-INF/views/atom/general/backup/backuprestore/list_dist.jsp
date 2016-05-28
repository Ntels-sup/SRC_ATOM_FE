<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>

<script type="text/javascript" charset="utf-8" src="/scripts/js/selectBox.js"></script>

<!-- jwebsocket -->
<script type="text/javascript" src="/scripts/jwebsocket/1_0_b1/jWebSocket.js"></script>
<script type="text/javascript" src="/scripts/jwebsocket/pfnmWebSocket.js"></script>

<script type="text/javascript">

	var default_node_id = "9999";
	var socket_url = "${uasGatewayAddress}";
	var user_id = "${session_user.user_id}";
	
	//임시시작
	//var socket_url = "ws://localhost:8787/";
	//var user_id = "UAS";
	//임시끝
	
	//packet send parameter
	//var node_id;
	var package_id = "01";
	var reqseq = "0000";
	var service_id;
	var componentType;
	var process_id;
	var processSeq = "0";
	var commandType;
	var commandPriority = "0";
	var temp_user_seq;
	
	initPage(socket_url, default_node_id, user_id, "backup");
	
	var isWEBSocketConnection = true;
	
	//해상도 체크
	var default_width = 1600;
	var default_height = 900;
	var width = default_width + "px";
	var heigh = default_height + "px";	
	if (screen.availWidth > default_width) width = "100%";
	if (screen.availHeight > default_height) heigh = "100%";

	$(document).ready(function() {
		getOptionItemWithDefault("/common/listSystemId", search_node_id, "S", "node_id="+$("#node_id").val());
		fnInit();
		
		//조회 버튼 클릭시
		$("#btn_search").click(function() {
			var node_id = $("#search_node_id").val();
			
			if (node_id == "") {
				alert('<spring:message code="msg.common.empty.node"/>');
				$("#search_node_id").focus();
				return;
			}
			var param = $("#form").serialize();
			
			$.post('listAction.ajax', param, function(data) {
				$('#dataTable').html(data);
			});			
		});
		
		
	});
	
	/**
	 * 초기화
	 */
	function fnInit() {
		var param = $("#form").serialize();		
		$.post("listAction.ajax", param, function(data) {
			$("#dataTable").html(data);
		});	
	}
	
	/**
	 * Back up 함수
	 */
	function fnBackUp() {
		//console.log("fnBackUp");
		var node_id = $("#node_id").val();		
		if ((node_id == "") || (node_id != $("#search_node_id").val())) {
			alert('<spring:message code="msg.common.search"/>');
			return;
		}
		
		if(!confirm("Do you want to run the backup?")) return;
		
		//console.log($("input:checkbox[name='chkFileList']:checked").length);
		var count = $("input:checkbox[name='chkFileList']:checked").length;
		if (count > 0) { //선택할수 없음
			alert("Backup can not check file list");			
			$("input:checkbox[name='chkFileList']:checked").each(function(i, index) {
				$("input:checkbox[id='chkFileList']").attr("checked", false);
				$("input:checkbox[id='chkFileList']").attr("disabled", false);
			});
			return;
		}
		
		service_id = "000000";
    	componentType = "BT";
    	process_id = "000010";
    	commandType = "9231";
    	
    	temp_user_seq = USER_SEQ; //pfnmWebSocket
    		
    	var option = $(":radio[name=option]:checked").val();
    	var argument = node_id + "," + temp_user_seq + ",UAS," + user_id + ",";
    	
    	if (option == "total") {
    		argument += "100000";
    	} else {
    		
    		var category_bin = $("#category_bin").attr("checked");
    		var category_client = $("#category_client").attr("checked");
    		var category_util = $("#category_util").attr("checked");
    		var category_script = $("#category_script").attr("checked");
    		var category_database = $("#category_database").attr("checked");
    		var category_cgw_config = $("#category_cgw_config").attr("checked");
    		var category_system_config = $("#category_system_config").attr("checked");
    		//console.log(category_bin+"/"+category_client+"/"+category_util+"/"+category_script+"/"+category_database+"/"+category_cgw_config+"/"+category_system_config);
    		if (!category_bin && !category_client && !category_util && !category_script && !category_database && !category_cgw_config && !category_system_config) { //1개라도 체크해야 함
    			alert("Please select Category.");
    			return;
    		}
    			
    		if (category_bin) argument += "100002,";
    		if (category_client) argument += "100003,";
    		if (category_util) argument += "100004,";
    		if (category_script) argument += "100005,";
    		if (category_database) argument += "100006,";
    		if (category_cgw_config) argument += "100007,";
    		if (category_system_config) argument += "100008,";
    		
    		var last = argument.length - 1;
			if ((argument.charAt(last) == ",")) argument = argument.substr(0, last); //쉼표 마지막 문자열 자르기
    	}
    	//console.log(argument);
    	sendAppCmdREQ(node_id, node_id, package_id, reqseq, service_id, componentType, process_id, processSeq, commandType, argument, commandPriority);

	}
	
	/**
	 * compare 함수
	 */
	function fnCompare() {
		//console.log("fnCompare");
		var node_id = $("#node_id").val();
		if ((node_id == "") || (node_id != $("#search_node_id").val())) {
			alert('<spring:message code="msg.common.search"/>');
			return;
		}
		
		var count = $("input:checkbox[name='chkFileList']:checked").length;
		if (count == 0) { 
			alert("Please select File");
			return;	
		}
		
		if (count != 2) { //2개만 선택
			alert("Please select only two");
			return;
		}
		
		service_id = "000000";
    	componentType = "BT";
    	process_id = "000010";
    	commandType = "9035";
    	
    	temp_user_seq = USER_SEQ; //pfnmWebSocket
    	
    	var argument = node_id + "," + temp_user_seq + ",UAS," + user_id + ",";
    	var array;
    	var group_code = "";
    	var file_name = "";
    	var isBoolean = false;
    	
    	$("input:checkbox[name='chkFileList']:checked").each(function(i, index) {
    		array = index.value.split("|");
    		if (i == 0) {
    			group_code = array[0];
    		} else {
    			if (group_code != array[0]) isBoolean = true;
    		}
    		file_name += array[1] + ",";
    	});
  		
    	if (isBoolean) {
    		alert("Category is different");
    		return;
    	}
    	
    	if(!confirm("Do you want to run the compare?")) return;
    	
    	argument += file_name;
    	var last = argument.length - 1;
		if ((argument.charAt(last) == ",")) argument = argument.substr(0, last); //쉼표 마지막 문자열 자르기
		
    	//console.log(argument);
    	sendAppCmdREQ(node_id, node_id, package_id, reqseq, service_id, componentType, process_id, processSeq, commandType, argument, commandPriority);
	}
	
	/**
	 * restore 함수
	 */
	function fnRestore() {
		//console.log("fnRestore");
		var node_id = $("#node_id").val();		
		if ((node_id == "") || (node_id != $("#search_node_id").val())) {
			alert('<spring:message code="msg.common.search"/>');
			return;
		}
		
		var count = $("input:checkbox[name='chkFileList']:checked").length;
		if (count == 0) { 
			alert("Please select File");
			return;	
		}
		
		if (count != 1) { //1개만 선택할수 있음
			alert("Please select only one");
			return;
		}
		
		if(!confirm("Do you want to run the restore?")) return;
		
		service_id = "000000";
    	componentType = "BT";
    	process_id = "000010";
    	commandType = "9233";
    	
    	temp_user_seq = USER_SEQ; //pfnmWebSocket
    	
    	var argument = node_id + "," + temp_user_seq + ",UAS," + user_id + ",";
    	var array;
    	var group_code = "";
    	var file_name = "";
    	
    	$("input:checkbox[name='chkFileList']:checked").each(function(i, index) {
    		array = index.value.split("|");
    		group_code = array[0];
    		file_name = array[1];
    	});
    	
    	//console.log(group_code);
    	if (group_code == "100000") {
    		var option = $(":radio[name=option]:checked").val();
    		if (option == "part") {
        		var category_bin = $("#category_bin").attr("checked");
        		var category_client = $("#category_client").attr("checked");
        		var category_util = $("#category_util").attr("checked");
        		var category_script = $("#category_script").attr("checked");
        		var category_database = $("#category_database").attr("checked");
        		var category_cgw_config = $("#category_cgw_config").attr("checked");
        		var category_system_config = $("#category_system_config").attr("checked");
        		
        		if (category_bin) argument += "100002,";
        		if (category_client) argument += "100003,";
        		if (category_util) argument += "100004,";
        		if (category_script) argument += "100005,";
        		if (category_database) argument += "100006,";
        		if (category_cgw_config) argument += "100007,";
        		if (category_system_config) argument += "100008,";
        		
        	} else {
        		argument += group_code + ",";
        	}
    	} else {
    		argument += group_code + ",";
    	}    	
    	
    	argument += file_name;
    	//console.log(argument);
    	sendAppCmdREQ(node_id, node_id, package_id, reqseq, service_id, componentType, process_id, processSeq, commandType, argument, commandPriority);
	}
	
	
	/**
	 * backup, compare, restore 패킷을 보내면 바로 응답메세지(command)가 온다.
	 */
	function responseBackUpResult(commandType, responseType, messages) {
		/* console.log("commandType=>"+commandType);
		console.log("responseType=>"+responseType);
		console.log("messages=>"+messages);
		console.log("======================"); */ 		
		if ((commandType == "9231") || (commandType == "9035") || (commandType == "9233")) {
			if (responseType == "01") {
				//console.log(width);
				//console.log(heigh);
				$("#modal_progress_pannel > div").css("width", width);
				$("#modal_progress_pannel > div").css("height", heigh);				
				$("#modal_progress_pannel").show();
				
			} else {
				$("#status").append(messages + "\r\n");
				$("#status").append("\r\n");		
				$("#status").scrollTop($("#status")[0].scrollHeight);
			}
		}		
	}
	
	var text = "";
	
	/**
	 * noti 메세지
	 */
	function notificationBackUp(messageType, pos, messages) {
		
		if ((messageType != "P004") //compare
				&& (messageType != "P003") //restore
				&& (messageType != "P002") //backup
				) return;

		var user_seq = messages.substr(0,4);
		
		/* console.log("temp_user_seq=>"+temp_user_seq);
		console.log("user_seq=>"+user_seq);
		console.log("messageType=>"+messageType);
		console.log("pos=>"+pos);
		console.log("messages=>"+messages);
		console.log("======================"); */ 
		
		if (temp_user_seq == user_seq) messages = messages.substr(5, messages.length);
				
		if (pos == "F") { //start 메세지 
			if ((messageType == "P004") || (messageType == "P003") || (messageType == "P002")) {
				if (temp_user_seq == user_seq) {
					text += messages + "\r\n";					
					$("#status").val(text);
					$("#status").scrollTop($("#status")[0].scrollHeight);
				}
			}
		} else if (pos == "M") { //message
			if ((messageType == "P004") || (messageType == "P003") || (messageType == "P002")) {
				if (temp_user_seq == user_seq) {
					text += messages + "\r\n";		
					$("#status").val(text);
					$("#status").scrollTop($("#status")[0].scrollHeight);
				}
			}
		} else if (pos == "L") { //end(종료) 
			if ((messageType == "P004") || (messageType == "P003") || (messageType == "P002")) {
				if (temp_user_seq == user_seq) {
					text += messages + "\r\n\r\n" ;						
					$("#status").val(text);
					$("#status").scrollTop($("#status")[0].scrollHeight);
					$("#modal_progress_pannel").hide();
				}
			}
		}
	}
	
	
	function clear() {
		$("#status").val("");
		text = "";
	}
	
	function fileExport() {
		var status_text = $('#status').val();
    	if (status_text == "") {
    		alert("There is nothing");
    	} else {
    		status_text = status_text.replace(/=/gi,"-");
    		//console.log(status_text);
    		$.download('download', "status_text="+status_text, 'post' );
    	}
	}
	
	/**
	 * 웹소켓 로그인 성공
	 */
	function preparedSocket() {	
		console.log("UAS Login Success!!!!");
		$("#modal_disconnect_pannel").hide();
	}
	
	/**
	 * 계정 락 걸렸을때
	 */
	function accountLock() {}
	
	/**
     * 웹소켓 로그인 실패시 호출
     */
	function loginFail(){
		if (isWEBSocketConnection) {
			isWEBSocketConnection = false;
			$("#disConnectTime").html("USC Login Fail!!!");
			$("#modal_disconnect").css("width", width);
			$("#modal_disconnect").css("height", heigh);
			$("#modal_disconnect_pannel").show();
			
			intervalFinish();
		}
	}
	
	/**
	 * websocket 종료되면 호출된다.
	 */
	function disconnectSocket(){
		console.log("disconnectSocket==>"+isWEBSocketConnection);
		if (isWEBSocketConnection) {
			isWEBSocketConnection = false;
			$("#disConnectTime").html("Disconnect WebSocket.");
			$("#modal_disconnect").css("width", width);
			$("#modal_disconnect").css("height", heigh);
			$("#modal_disconnect_pannel").show();
			intervalFinish(); 
		}
	}
	
	/**
	 * 주기적으로 호출하여 재접속 시도한다
	 */
	function intervalFinish() {
		setTimeout(function() { 
			connectWEBSocket(); 
		}, 5000);
	}
	
	/**
	 * 재접속 한다.
	 */
	function connectWEBSocket() {
		console.log("connectWEBSocket==>"+isWEBSocketConnection);
		if (isWEBSocketConnection) return;		
		initPage(socket_url, default_node_id, user_id, "backup");		
		isWEBSocketConnection = true;
	}
	
	var isUASReload = false;
	
	/**
	 * UAS 기동 및 종료
	 */
	function event_UAS_Up_And_Down(isBoolean) {
		//isBoolean :true 면 기동 false :종료
		if(isBoolean) { 
			console.log("UAS Running!!!!");
			$("#modal_disconnect_pannel").hide();
			isUASReload = false;
			
		} else {
			console.log("UAS Stop!!!!");
			$("#disConnectTime").html("Gateway server is disconnected from the server...");
			$("#modal_disconnect").css("width", width);
			$("#modal_disconnect").css("height", heigh);
			$("#modal_disconnect_pannel").show();
			isUASReload = true;
		}
	}
	
	
	//윈도우가 닫힐 때
	$(window).unload(function() {
		//exitPage();		
	});
	
	/**
	 * reload 체크
	 */
	window.onbeforeunload = function() {
		//exitPage(); //파일저장할때 호출됨 막아야함
	};
	
</script>

<!-- modal UAS Disconnect Pannel -->
<div id="modal_disconnect_pannel" class="layer_delay" style="display:none; z-index:9999;">
   	<div id="caution" style="width:350px; height:80px; background:#fff; padding:25px; border:1px solid #ccc; margin:20% 0 0 40%; color:#000; border-radius: 15px; position: absolute; z-index: 102;">
  	<img src="/images/mtr/discon.gif" alt="" style="float:left;">
     	<span id="disConnectTime"></span>
  	</div>
   	<div id="modal_disconnect" style="margin:-80px 0 0 0; width:1600px; height:900px; position:absolute; z-index:101; background:black; opacity:.5"></div>
</div>

<!-- modal progress Pannel -->
<div id="modal_progress_pannel" class="layer_delay" style="display:none; z-index:9999;">
   	<div style="margin:-80px 0 0 0; width:1600px; height:900px; position:absolute; z-index:101; background:black; opacity:.1"></div>
</div>
	
	
<div id="container" style="width:98%">	
	<section id="listSection">
		<article>
			<br>
			<header>
				<h1>Backup and Restore</h1>
				<div class="icons">
					<a href="#" class="ico_search" id="btn_search" title="Search">Search</a>
				</div>	
			</header>
			<form id="form" name="form" method="post">
			<div class="search_wrap">
				<ul class="search">
					<li>
	                	<label for="s01"><spring:message code="label.conifg.nodemanagement.node.text"/>
	          				<select id="search_node_id" name="search_node_id" class="px100"></select>
	        			</label>
					</li>			
				</ul>
			</div>
			</form>
			
			
			<div id="dataTable"></div>
					
			
		</article>
	</section>
</div>
