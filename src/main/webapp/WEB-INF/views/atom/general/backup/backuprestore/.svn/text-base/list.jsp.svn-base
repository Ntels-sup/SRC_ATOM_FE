<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>

<script type="text/javascript" charset="utf-8" src="/scripts/js/selectBox.js"></script>

<script src="/scripts/jwebsocket/pfnmWebSocket.js"></script>
<script src="/scripts/jwebsocket/1_0_b1/jWebSocket.js"></script>

<script type="text/javascript">

var nodeNo;

console.log( "Init start... : " + "${pageContext.servletContext.getAttribute('websocket.connect.url')}" );

initPage( "${pageContext.servletContext.getAttribute('websocket.connect.url')}", "backuprestore" );

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
	
	//initPage(socket_url, default_node_id, user_id, "backup");
	
	var isWEBSocketConnection = true;
	
	//해상도 체크
	var default_width = 1600;
	var default_height = 900;
	var width = default_width + "px";
	var heigh = default_height + "px";	
	if (screen.availWidth > default_width) width = "100%";
	if (screen.availHeight > default_height) heigh = "100%";

	$(document).ready(function() {

		var tdObj = $("#backupGroup");
		var pkgOption = "";
		
		pkgOption = pkgOption + '<select id="system_id1" name="system_id1" class="group_single" multiple="multiple" value="UncheckAll">';
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
		
//  	 	alert(pkgOption);

	 	$(tdObj).empty();
	 	$(tdObj).append(pkgOption);
		
		$("select[id=system_id1]").multipleSelect({
			filter		: true,
			single		: true,
			selectAll	: false,
	        multiple	: true,
	        multipleWidth: 150,
	        width		: "602px",
	        onClick		: function(view){
	        	getNodeNo(view.value);
	        } 
		},"refresh");

		var tdObj2 = $("#restoreGroup");
		var pkgOption2 = "";
		
		pkgOption2 = pkgOption2 + '<span class="tit">Package / Node</span>';
		pkgOption2 = pkgOption2 + '<select id="system_id2" name="system_id2" class="group" multiple="multiple" value="checkAll">';
		pkgOption2 = pkgOption2 + '    <c:forEach items="${Package}" var="Packagelist" varStatus="status">';
		pkgOption2 = pkgOption2 + '        <optgroup label="${Packagelist.NAME}">';
		pkgOption2 = pkgOption2 + '            <c:forEach items="${System}" var="Systemlist" varStatus="status">';
		pkgOption2 = pkgOption2 + '               <c:if test="${Packagelist.ID eq Systemlist.PACKAGEID}">';
		pkgOption2 = pkgOption2 + '               		<option value="${Systemlist.NAME}">${Systemlist.NAME}</option>';
		pkgOption2 = pkgOption2 + '               </c:if>';
		pkgOption2 = pkgOption2 + '            </c:forEach>';
		pkgOption2 = pkgOption2 + '        </optgroup>';
		pkgOption2 = pkgOption2 + '     </c:forEach>';
		pkgOption2 = pkgOption2 + '</select>';
		
//  	 	alert(pkgOption2);

 	 	$(tdObj2).empty();
 	 	$(tdObj2).append(pkgOption2);
	 	
		$("select[id=system_id2]").multipleSelect({
			filter		: true,
			single		: false,
			selectAll	: true,
	        multiple	: true,
	        multipleWidth: 150,
	        width		: "602px",
	        onClick		: function(view){
	        	fnInit();
	        }  ,
	        onOptgroupClick: function(view) {
	        	fnInit();
	        },
	        onCheckAll: function() {
	        	fnInit();
            }
		},"refresh");
		
		
		$("select[id=system_id2]").multipleSelect("checkAll");	

		$("input:radio[id='gubun_total']").prop("checked", true);
		$("input:checkbox[name='category']").prop("checked", true);
		$("input:checkbox[name='category']").prop("disabled", true);
		
		$("#fnBackUp").click(function() {
			fnBackUp();
		});
		
		$("#ereser").click(function() {
			$("#status_message").text("");
		});
		
		$("#download").click(function() {
			console.log("download : " + $("#status_message").text() );
			
			var status_text = $("#status_message").text();
			console.log("download : " + status_text );
			
	    	if (status_text == "") {
	    		alert("There is nothing");
	    	} else {
	    		status_text = status_text.replace(/=/gi,"-");
	    		//console.log(status_text);
	    		$.download('download', "status_text="+status_text, 'post' );
	    	}
		});
		
		fnInit();
	});
	
	/**
	 * 초기화
	 */
	function fnInit() {
		var param = $("#myForm").serialize();		
		$.post("listAction", param, function(data) {
			$("#dataTable").html(data);
		});	
	}
	
	/**
	 * Back up 함수
	 */
	function fnBackUp() {
		
		console.log("[mirinae.maru] fnBackUp start...");
		console.log("[mirinae.maru] system_id1 : " + $("#system_id1").val() );
		console.log("[mirinae.maru] gubun_total : " + $("input:radio[id='gubun_total']").is(":checked") );
		console.log("[mirinae.maru] gubun_partial : " + $("input:radio[id='gubun_partial']").is(":checked") );
		
		var categoryArr	= new Array();
		
		$("input:checkbox[name='category']").each(function(index, val) {
			console.log("aaa : " + index +"\t"+ $(val).attr("value") +"\t"+ $(val).is(":checked") );
			if( $(val).is(":checked")==true ) {
				categoryArr.push( $(val).attr("value") );
			}
		});
		
		var system_id = $("#system_id1").val();
		if ( system_id=="" || system_id==null ) {
			openAlertModal('<spring:message code="msg.general.backup.dailypolicy.node.empty" />');
			return;
		}
		
		if ( categoryArr.length==0 ) {
			openAlertModal('<spring:message code="msg.general.backup.backuprestore.select.category.text" />');
			return;
		}
		
		var total_partial = "";
		if ( $("input:radio[id='gubun_total']").is(":checked") ) 
			total_partial = "total";
		else total_partial = "partial";
		
		console.log("[mirinae.maru] system_id : " + system_id );
		console.log("[mirinae.maru] total_partial : " + total_partial );
		console.log("[mirinae.maru] categoryArr : " + JSON.stringify(categoryArr) );
		
		
		console.log( 
			"백업시작... " +
			"\nsystem_id : " + system_id +
			"\ntotal_partial : " + total_partial +
			"\ncategory : " + JSON.stringify(categoryArr)
			);
		
		openConfirmModal( "<spring:message code='msg.general.backup.backuprestore.confirm.backup.text'/>" , "" , function() {
			
			var BODY 		= new Object();
			BODY.exec_bin 	= "backup.sh";
			BODY.category	= categoryArr;
			
			console.log("[mirinae.maru] nodeNo : " + nodeNo );
			console.log("[mirinae.maru] BODY : " + JSON.stringify(BODY) );
			
			CommandREQ( "0000100001", nodeNo*1, 90, JSON.stringify(BODY) );
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
	
	function checkTotal() {
		
		$("input:checkbox[name='category']").prop("checked", true);
		$("input:checkbox[name='category']").prop("disabled", true);
	}
	
	function checkPartial() {
		
		$("input:checkbox[name='category']").prop("checked", false);
		$("input:checkbox[name='category']").prop("disabled", false);

// 		$("input:radio[id='gubun_total']").prop("checked", true);
// 		$("input:checkbox[name='category']").prop("checked", true);
// 		$("input:checkbox[name='category']").prop("disabled", true);
	}
	
	/**
	 * restore 함수
	 */
	function fnRestore( restore_path, restore_file ) {
		
		console.log("[mirinae.maru] fnRestore...");
		console.log("[mirinae.maru] restore_file : " + restore_file );
		console.log("[mirinae.maru] restore_path : " + restore_path );
		
		openConfirmModal( "<spring:message code='msg.general.backup.backuprestore.confirm.backup.text'/>" , "" , function() {
			
			var BODY 			= new Object();
			BODY.restore_path	= restore_path;
			BODY.restore_file	= restore_file;
			
			console.log("[mirinae.maru] BODY : " + JSON.stringify(BODY) );
			
			CommandREQ( "0000110001", nodeNo*1, 92, JSON.stringify(BODY) );
      	});	
	}
	
	function fnCommonMessage(command, messages) {
		
		if (command == 110001) { 
			console.log( "[mirinae.maru] RESTORE response..." );
			responseRestore( messages );
		}
		else if (command == 110002) { 
			console.log( "[mirinae.maru] RESTORE response..." );
			responseRestore( messages );
		}
	}

	function responseBackup( messages ) {
		console.log( "[mirinae.maru] response MSG 1: " + JSON.stringify(messages.text) );
		console.log( "[mirinae.maru] response MSG 2 : " + messages.text.replace(/\n/gi,"<br>") );
		$("#status_message").prepend( messages.text.replace(/\n/gi,"<br>") );
	}
	
	function responseRestore( messages ) {
		console.log( "[mirinae.maru] response MSG 1: " + JSON.stringify(messages.text) );
		console.log( "[mirinae.maru] response MSG 2 : " + messages.text.replace(/\n/gi,"<br>") );
		$("#status_message").prepend( messages.text.replace(/\n/gi,"<br>") );
	}
</script>

<!-- content -->
<div class="content">
<!-- //cont_body -->
     <div class="cont_body">

<!-- cont_left -->
<div class="cont_left">
	<header>
		<h3><spring:message code="label.general.backup.backuprestore.backup.text" /></h3>
		<p><spring:message code="msg.general.backup.backuprestore.selectmsg.text" /></p>
	</header>

	<div class="detail type02">
		<table class="tbl_detail register">
			<caption>Backup</caption>
			<tbody>
				<tr>
					<th scope="col" class="imp"><spring:message code="label.general.history.backup.PackageSystem.text" /></th><!-- Package / Node -->				
				</tr>
				<tr>
					<td id="backupGroup">asdfasdf</td>
				</tr>
				<tr>
					<th scope="col" class="imp"><spring:message code="label.filter.option" /></th>	<!-- Option -->					
				</tr>
				<tr>
					<td colspan="2">
						<input type="radio" id="gubun_total" name="gubun" value="total" onClick="javascript:checkTotal()">
						<label for="gubun_total"><spring:message code="label.general.backup.backuprestore.totalbackup.text" /></label><!-- Total Backup -->

						<input type="radio" id="gubun_partial" name="gubun" value="partial" onClick="javascript:checkPartial()">
						<label for="gubun_partial"><spring:message code="label.general.backup.backuprestore.partialbackup.text" /></label><!-- Part Backup -->
					</td>
				</tr>
				<tr>
					<th scope="col" class="imp">Category</th>						
				</tr>
				<tr class="catagory">
					<td colspan="2"><!-- class="chk" -->
						<ul>
							<c:forEach items="${listMntGroup}" var="mntGroup" varStatus="status">
							<c:if test="${mntGroup.group_code!='100000'}"><!-- full 제외 -->
							<li>
								<input type="checkbox" id="category_${mntGroup.group_code}" name="category" value="${mntGroup.state}">
								<label for="category_${mntGroup.group_code}">${mntGroup.state}</label>
							</li>
							</c:if>
							</c:forEach>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>

		<div class="btn_area">
			<button type="button" class="major" id="fnBackUp"><spring:message code="label.general.backup.backuprestore.backup.text" /></button><!-- Backup -->
		</div>
	</div>
</div>
<!-- cont_left -->

<div class="cont_right">
				<header>
					<h3><spring:message code="label.general.backup.backuprestore.restore.text" /><!-- Restore --></h3>
					<p id="restoreableMsg"></p>
				</header>
					
				<form id="myForm" name="myForm" method="post">
				<div class="cont_top_right">
					<div class="select_group type3" id="restoreGroup"></div>
				</div>
				</form>
				
				<div id="dataTable"></div>
			</div>
			<!-- cont_right -->

<div class="command">
	<header>
		<h3><spring:message code="label.security.usermanage.status.text" /></h3><!-- STATUS -->
		<div class="btn_area">
			<button type="button" class="btn_icon eraser" title="<spring:message code='label.general.cli.ereser.text' />" id="ereser" ><spring:message code="label.general.cli.ereser.text" /></button><!-- Ereser -->
			<button type="button" class="btn_icon down" title="<spring:message code='label.common.downlaod' />" id="download"><spring:message code="label.common.downlaod" /></button><!-- Download -->
		</div>
	</header>

	<div class="statusview scroll-type4" id="status_message"></div>
</div>
     </div>
     <!-- //cont_body -->
     
 </div>
 <!--// content --> 
