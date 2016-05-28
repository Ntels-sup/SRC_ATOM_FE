<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title><spring:message code="label.title"/></title>

<link rel="stylesheet" href="<c:url value="/styles/basic.css" />" type="text/css" />
<link rel="stylesheet" href="<c:url value="/styles/jquery-ui-1.8.11.custom.css" />" type="text/css" />
<link rel="stylesheet" href="<c:url value="/styles/jsplumb.css" />" type="text/css" />
<link rel="stylesheet" href="<c:url value="/styles/contextmenu.css" />" type="text/css" />

<!-- Batch position -->
<style>
<c:forEach items="${listBatch}" var="batch" varStatus="status">
#batch${batch.batch_job_id} {top:${batch.image_y}px;left:${batch.image_x}px;}
</c:forEach>
</style>

<script type="text/javascript" src="<c:url value="/scripts/jquery/jquery-1.6.2.js" />"></script>
<script type="text/javascript" src="<c:url value="/scripts/jquery/jquery-ui-1.8.11.custom.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/scripts/jquery/jquery.simplemodal.1.4.1.min.js" />"></script>
<script type="text/javascript" charset="utf-8" src="<c:url value="/scripts/selectBox/selectBox.js" /> "></script>
<script type="text/javascript" charset="utf-8" src="<c:url value="/scripts/jquery/calendar/jquery.ui.datepicker-ko.js" />"></script>
		
<!-- support lib for bezier stuff -->
<script type="text/javascript" charset="utf-8" src="<c:url value="/scripts/jsplumb/jsBezier-0.2-min.js" /> "></script>
<!-- main jsplumb engine -->
<script type="text/javascript" charset="utf-8" src="<c:url value="/scripts/jsplumb/jsPlumb-1.3.0-RC1.js" /> "></script>
<!-- connectors, endpoint and overlays  -->
<script type="text/javascript" charset="utf-8" src="<c:url value="/scripts/jsplumb/jsPlumb-defaults-1.3.0-RC1.js" /> "></script>
<!-- canvas renderer -->
<script type="text/javascript" charset="utf-8" src="<c:url value="/scripts/jsplumb/jsPlumb-renderers-canvas-1.3.0-RC1.js" /> "></script>
<!-- jquery jsPlumb adapter -->
<script type="text/javascript" charset="utf-8" src="<c:url value="/scripts/jsplumb/jquery.jsPlumb-1.3.0-RC1.js" /> "></script>
<!-- jquery context menu -->
<script type="text/javascript" charset="utf-8" src="<c:url value="/scripts/jsplumb/jquery.contextMenu.js" /> "></script>


<script type="text/javascript">
<!--

	var temp_conn = false;
	var id = ""; 
	var end_date = "9999-12-31";

	$(document).ready( function() {
		
		if("${viewType}" == "flow") {
			
			$("#content_flow").show();
			$("#content_info").hide();
			//$("#iframeBatch").contents().find(".p_body").show();
		}
		else {
			
			$("#content_flow").hide();
			$("#content_info").show();
			//$("#iframeBatch").contents().find(".p_body").hide();				
		}
		
		// 배치 그룹 데이터 설정 시작 ==============================================================	
		
		// 배치 그룹 이름 
		$("#batch_group_name").val("${batchGroup.batch_group_name}");	

		// 공휴일 수행 여부
		if("Y" == "${batchGroup.holiday_exception_yn}") {
			
			$("#holiday_exception_yn").attr("checked", true);
		}		
		
		// 비고
		$("#remark").val("${batchGroup.remark}");
		
		// 수행 주기
		var schedule_cycle_type = "${batchGroup.schedule_cycle_type}";
		var schedule_cycle = "${batchGroup.schedule_cycle}";

		$("#schedule_cycle_type").val(schedule_cycle_type);
		$("#schedule_cycle").val(schedule_cycle);
		
		var schedule_cycle_type_ = schedule_cycle_type;
		if(schedule_cycle_type == '05') {
			
			schedule_cycle_type_ = "04"; 
		}
		
		$("#r" + schedule_cycle_type_).attr("checked",true);
		$("#t" + schedule_cycle_type_).show();
		
		switch(schedule_cycle_type) {

			case '00':
				$("#t00 input[name=cycle").val(schedule_cycle);
    			break;		
		
			case '01':
				$("#t01 #button_01").attr("checked",true);
				$("#t01 #cycle_01").val(schedule_cycle);
	    		break;
			
			case '02':
				$("#t02 #button_02").attr("checked",true);
				$("#t02 #cycle_02").val(schedule_cycle);
	    		break;
			
			case '03':
				$("#t03 #button_03").attr("checked",true);
				$("#t03 #cycle_03").val(schedule_cycle);				
	    		break;
	    		
			case '04':
				$("#t04 #button_05").attr("checked",true);
				$("#t04 #cycle_05").val(schedule_cycle);
	    		break;
	    		
			case '05':
				$("#t04 #button_06").attr("checked",true);
				$("#t04 #cycle_06").val(schedule_cycle);
	    		break;	    		
		}
		
		// 수행 기간 - Calendar 초기화 [ 적용날짜, 만료날짜 ]
		$.datepicker.setDefaults($.datepicker.regional['en']);
		$( ".date" ).datepicker();
		
		var apply_date = "${batchGroup.apply_date}";
		var expire_date = "${batchGroup.expire_date}";
		var applyOption;
		var i = 0;

		for(i = 0; i < 24; i++) {
			applyOption =  $('<option value="' + ((i < 10) ? '0' + i : i) + '">' + ((i < 10) ? '0' + i : i) + '</option>');
			$("#applyHour").append(applyOption);
		}
		
		for(i = 0; i < 60; i++) {
			applyOption =  $('<option value="' + ((i < 10) ? '0' + i : i) + '">' + ((i < 10) ? '0' + i : i) + '</option>');
			$("#applyMin").append(applyOption);
		}

		// 적용 날짜
		if(apply_date != "") {
			
			$("#applyDate").val(apply_date.substring(0,4) + "_" + apply_date.substring(4,6) + "_" + apply_date.substring(6,8));
			$("#applyHour option[value = " + apply_date.substring(8,10) + "]").attr("selected", true);
			$("#applyMin option[value = " + apply_date.substring(10,12) + "]").attr("selected", true);
		}
		
		// 만료 날짜
		if(expire_date != "") {
			
			if(expire_date == end_date.replace(/-/g,"")) {
				
				$("#expire_n").attr("checked", true);
			}
			else {

				$("#expire_y").attr("checked", true);
			}
			
			$("#expireDate").val(expire_date.substring(0,4) + "_" + expire_date.substring(4,6) + "_" + expire_date.substring(6,8));
		}
		
		// 배치 그룹 데이터 설정 끝 ==============================================================	
			
		// 수행 주기 유형 클릭시
		id = schedule_cycle_type_;
		
		$("#cycle_type input[name=cycle_type]").click(function() {
			
			id = $(this).val();
			
			initialize(id);
			
			$("#cycle_type #t" + id).show();
		});
		
		// 수행 기간 [없음] 선택시
		$("#expire_n").click(function() {
			
			$("#expireDate").val(end_date);
		});
		
		// 수행 기간 [만료 날짜] 선택시
		$("#expire_y").click(function() {
			
			$("#expireDate").val(expire_date.substring(0,4) + "_" + expire_date.substring(4,6) + "_" + expire_date.substring(6,8));
		});
		
        // context menu 설정 (시스템 아이콘 영역 내 클릭)
	    $(".batch").contextMenu({
    	    menu: "myMenu"
    	},
        function(action, el, pos) {
    		
    		var url = "";
    		var system_id = $("#system_id").val();
    		var package_id = $("#package_id").val();
    		var batch_group_id = $("#batch_group_id").val();    		
    		var batch_job_id = $(el).attr("id").substring(5);
    		var image_x = window.event.clientX;
    		var image_y = window.event.clientY;    		
    		
    		var dataString = "system_id=" + system_id + "&package_id=" + package_id + "&batch_group_id=" + batch_group_id + "&batch_job_id=" + batch_job_id + "&image_x=" + image_x + "&image_y=" + image_y;;    		
    		
    		switch(action) {

	    		case 'view':
    				url = "/pfnm/designer/batch/get.ajax"; 
		    		break;
    
	    		case 'copy':
    				url = "/pfnm/designer/batch/insertByCopy.ajax";
		    		break;
    			
	    		case 'rename':
    				url = "/pfnm/designer/batch/updateByRename.ajax";
		    		break;
    			
	    		case 'delete':
    				url = "/pfnm/designer/batch/delete.json";
		    		break;
    		}

    		if(action != 'info') {
    			openModal(action, url, dataString);
    		}
    	});
        
	 	// context menu 설정 (시스템 아이콘 영역 바깥 클릭)
	    $("body:not(.batch)").contextMenu({
    	    menu: "myMenu2"
    	},
        function(action, el, pos) {

    		var url = "";    		
    		var system_id = $("#system_id").val();
    		var package_id = $("#package_id").val();
    		var batch_group_id = $("#batch_group_id").val();    		
    		var image_x = window.event.clientX;
    		var image_y = window.event.clientY;
    		
    		var dataString = "system_id=" + system_id + "&package_id=" + package_id + "&batch_group_id=" + batch_group_id + "&image_x=" + image_x + "&image_y=" + image_y;    		
    		
    		switch(action) {
    		
				case 'insert':
					url = "/pfnm/designer/batch/insert.ajax";
	    			break;
    		}
    		
    		openModal(action, url, dataString);
    	});
        
		// 시스템 아이콘 위치 이동 끝
		$(".batch").mouseup(function(e) {
			
			/*
			  1 = Left   Mousebutton
			  2 = Centre Mousebutton
			  3 = Right  Mousebutton
			*/
		    if (e.which == 1) {

	    		var system_id = $("#system_id").val();
	    		var package_id = $("#package_id").val();
	    		var batch_group_id = $("#batch_group_id").val();
				var batch_job_id = $(this).attr("id").substring(5);
				var image_x = getObjectLeft($(this));
				var image_y = getObjectTop($(this));
				
				var dataString = "system_id=" + system_id + "&package_id=" + package_id + "&batch_group_id=" + batch_group_id + "&batch_job_id=" + batch_job_id + "&image_x=" + image_x + "&image_y=" + image_y;
				
				$.post("/pfnm/designer/batch/updateByPosition.json", dataString);
				
		    }
		});		
	});
	
	var g_interval = null;
	var g_connection = null;

	// 시스템 그리기 설정
	jsPlumb.bind('ready', function() {

		// chrome fix.
		document.onselectstart = function () { return false; };								

		// default drag options
		jsPlumb.Defaults.DragOptions = { cursor: 'pointer', zIndex:2000 };
		// default to blue at one end and green at the other
		jsPlumb.Defaults.EndpointStyles = [{ fillStyle:'#696969' }, { fillStyle:'#558822' }];
		// blue endpoints 7 px; green endpoints 11.
		jsPlumb.Defaults.Endpoints = [ [ "Dot", {radius:3} ], [ "Dot", { radius:3 } ]];
		// enable mouse events
		jsPlumb.setMouseEventsEnabled(true);	

		// this is the paint style and hover style for the connecting lines
		var connectorPaintStyle = {lineWidth:2,strokeStyle:"#909ea9"};
		var connectorHoverStyle = {lineWidth:2,strokeStyle:"#909ea9"};

		// the overlays to decorate each connection with.  note that the label overlay uses a function to generate the label text; in this
		// case it returns the 'labelText' member that we set on each connection in the 'init' method below.
		var overlays = [
			[ "Arrow", {  width:5, length:15, location:1 } ]
		];
		
		//var anchors = [[0.2, 0, 0, -1], [1, 0.2, 1, 0], [0.8, 1, 0, 1], [0, 0.8, -1, 0] ];
		//var anchors = ["TopLeft", "TopCenter", "TopRight", "RightMiddle", "BottomRight", "BottomCenter", "BottomLeft", "LeftMiddle"];
		//var anchors = ["TopCenter", "RightMiddle", "BottomCenter", "LeftMiddle"];
		//var anchors = ["RightMiddle", "LeftMiddle"];
		var anchors = ["TopCenter"];
		
		// the definition of source/target endpoints (the small blue ones)
		var connectEndpoint = {
			//endpoint:"Dot",
			endpoint:["Image", {url:'<c:url value="/images/map/point.gif"/>'}],
			paintStyle:{fillStyle:"#696969",radius:3},
			dynamicAnchors:anchors,
			isSource:true,
			isTarget:true,
			connector:"Straight",
			maxConnections:10,
			connectorStyle:connectorPaintStyle,
			hoverPaintStyle:connectorHoverStyle,
			connectorHoverStyle:connectorHoverStyle,			
			connectorOverlays: overlays,
			dropOptions:{hoverClass:"hover"}
		};

		// add endpoints to the various elements
		<c:forEach items="${listBatch}" var="batch" varStatus="status">
		var e_${batch.batch_job_id} = jsPlumb.addEndpoint("batch${batch.batch_job_id}", {anchor:"AutoDefault"}, connectEndpoint);
		</c:forEach>
		
		// connect two elements.  calls the init function to register mouse handlers etc.
		var connect = function(s,t) {

			var c = jsPlumb.connect({source:s,target:t, overlays:overlays});
		};

		// connect, by Endpoint.
		<c:forEach items="${listBatchFlow}" var="batchFlow" varStatus="status">
		//console.log(e_${batchFlow.batch_job_id});
		<c:if test="${batchFlow.next_job_id != '999999'}">
		connect(e_${batchFlow.batch_job_id}, e_${batchFlow.next_job_id});
		</c:if>
		</c:forEach>

		// connection element 간 연결 시
		jsPlumb.bind("jsPlumbConnection", function(connInfo) { 

			var se = connInfo.sourceEndpoint;
			var te = connInfo.targetEndpoint;
			var conn = connInfo.connection;
			temp_conn = conn;
			
			conn.labelText = conn.sourceId.substring(6) + " - " + conn.targetId.substring(6);
			
			if (g_connection != null) {
				// jsPlumb.detach(g_connection.sourceId, g_connection.targetId);
				var canvasId = g_connection.canvas.id;
				$("#"+canvasId).remove();
			}
			if (g_interval != null) {
				clearInterval(g_interval);
			}
			
			frm.batch_job_id.value = conn.sourceId.substring(5);
			frm.next_job_id.value = conn.targetId.substring(5);
			
			var url = "/pfnm/designer/batch/insertFlow.ajax";			
			var width = "0";
			var height = "0";
			
			var w = openWindow(url, width, height);
			
			g_connection = conn;
			g_interval = setInterval(function() {
				if (w.closed) {
					clearInterval(g_interval);
					g_interval = null;
					// jsPlumb.detach(g_connection.sourceId, g_connection.targetId);
					var canvasId = g_connection.canvas.id;
					$("#"+canvasId).remove();
					g_connection = null;
				}
			}, 100);
		});			
		
		jsPlumb.draggable($(".batch"));
		
		// click event
		jsPlumb.bind("click", function(connection, originalEvent) { 
			
			//alert("click on connection from " + connection.sourceId + " to " + connection.targetId); 
			
			//if (confirm("Delete connection from " + connection.sourceId + " to " + connection.targetId + "?")) {
				//jsPlumb.detach(connection); 				
			//}
		});				
		
		// double click event
		jsPlumb.bind("dblclick", function(connection, originalEvent) { 
			
			//alert("double click on connection from " + connection.sourceId + " to " + connection.targetId); 
		
			//if (confirm("Delete connection from " + connection.sourceId + " to " + connection.targetId + "?")) {
				
				//jsPlumb.detach(connection);
				
			temp_conn = connection;
			
			frm.batch_job_id.value = connection.sourceId.substring(5);
			frm.next_job_id.value = connection.targetId.substring(5);

			var url = "/pfnm/designer/batch/getFlow.ajax";			
			var width = "0";
			var height = "0";
			
			openWindow(url, width, height);
			
			//}
		});
		
		// endpoint click event
		jsPlumb.bind("endpointClick", function(endpoint, originalEvent) { 
			
			alert("click on endpoint on element " + endpoint.elementId); 
		});
	});
	
	// object의 top position return
	function getObjectTop(jObj) {
		
		var obj = jObj.get(0);
		
		if (obj.offsetParent == document.body) {
			return obj.offsetTop;
		}
	  	else {
	  		return obj.offsetTop + getObjectTop(obj.offsetParent);
	  	}	  	
	} 

	// object의 left position return
	function getObjectLeft(jObj) {
		
		var obj = jObj.get(0);
		
	 	if (obj.offsetParent == document.body) {
	 		return obj.offsetLeft;		
	 	}	  
	 	else {
	 		return obj.offsetLeft + getObjectLeft(obj.offsetParent);		
	 	}	  
	}
	
	// 팝업창 modal로 열기
	function openModal(action, url, dataString) {
		
		$.ajax({
			type : "post",
			url : url,
			data : dataString,
			success : function(data) {
			
				if(action == "delete") {
					reloadPage();
				}
				else {
					viewLayer(data);				
				}
			}
		});
	}
	
	// 모달 submit
	function goBatch(type) {

		if("insert" == type || "get" == type) {
			
			if($("#batch_job_name").val() == "") {
				alert('<spring:message code="msg.pfnm.batch.batch_job_name.text"/>');
				$("#batch_job_name").focus();
				return;
			}
		}
		else if("copy" == type) {

			if($("#batch_job_name").val() == "") {
				alert('<spring:message code="msg.pfnm.batch.batch_job_name.text"/>');
				$("#batch_job_name").focus();
				return;
			}
		}
		else if("rename" == type) {
			
			if($("#batch_job_name").val() == "") {
				alert('<spring:message code="msg.pfnm.batch.batch_job_name.text"/>');
				$("#batch_job_name").focus();
				return;
			}
		}
		
		$.post($("#pop").attr("action"), $("#pop").serialize(), function(data) {
			
			reloadPage();		
		});
	}
	
	// 창 닫기
	function closeWindow() {

		$.modal.close();
		
		if(temp_conn) {
			
			reloadPage();
		}		
	}	
	
	// 화면 리로드
	function reloadPage() {
		
		frm.action="/pfnm/designer/batch/iframeBatch.ajax";
		frm.target = "_self";
		frm.submit();
	}
	
	// pop_layer 보이기
	function viewLayer(data) {
		// 남아있는 elements 제거
		$("#pop_layer").children().remove();
		// 생성된 elements 추가
		$("#pop_layer").append(data);
		// 모달로 열기
		$("#pop_layer").modal();					
	}
	
	// 화면 로드시 초기화
	function initialize(id) {
		
		for(var i=0; i<5; i++) {
			
			$("#cycle_type #t0" + i).hide();
		}
		
		if(id) {
			
			$("#cycle_type #t" + id).show();
		}	
	}
	
	// 수정 버튼 클릭시
	
	function save() {

		// 수행 주기
		var cycle = "";
		
		if(id == "00") {
			
			cycle = $("#t" + id + " input[name=cycle]").val();
		}
		else {

			$("#t" + id + " input[name=cycle_button_" + id +"]").each(function() {

				if($(this).is(":checked")) {
					
					cycle = $("#t" + id + " #cycle_" + $(this).val()).val();
					
					if($(this).val() == "06") {
						
						id = "05"; 
					}
				}
			});
		}

		$("#schedule_cycle_type").val(id);
		$("#schedule_cycle").val(cycle);			
		
		// 수행 기간
		var apply_date = $("#applyDate").val();
		var apply_hour = $("#applyHour").val();
		var apply_min = $("#applyMin").val();
		var expire_date = $("#expireDate").val(); 
		
		//$("#apply_date").val(apply_date.replace(/-/g,"") + apply_hour + apply_min);
		//$("#expire_date").val(expire_date.replace(/-/g,""));
		$("#apply_date").val(apply_date.replace(/_/gi,"") + apply_hour + apply_min);
		$("#expire_date").val(expire_date.replace(/_/gi,""));
		
		frm.action = "/pfnm/designer/batch/updateBatchGroupAction";
		frm.target = "_parent";
		frm.submit();
	}
	
	// 팝업창 열기
	function openWindow(url,width,height) {
		
		var w = window.open("","popup","width=" + width + ",height=" + height + ",fullscreen=0,toolbar=0,scrollbars=0,location=0,status=0,menubar=0");
		
		frm.action = url;
		frm.target = "popup";
		frm.submit();
		
		return w;
	}	

//-->	
</script>

</head>

<body onunload="jsPlumb.unload();" style="min-width:800px;">
	<div id="iframeDiv" style="min-height:550px;">
		<form id="frm" name="frm" method="post" action="/pfnm/designer/batch/iframeBatch.ajax">
		<input type="hidden" id="system_id" name="system_id" value="${system_id}"/>
		<input type="hidden" id="package_id" name="package_id" value="${package_id}"/>
		<input type="hidden" id="batch_group_id" name="batch_group_id" value="${batch_group_id}"/>
		<input type="hidden" name="batch_job_id" value=""/>
		<input type="hidden" name="next_job_id" value=""/>
		<input type="hidden" name="exit_value" value=""/>
		<input type="hidden" id="schedule_cycle_type" name="schedule_cycle_type" value=""/>	
		<input type="hidden" id="schedule_cycle" name="schedule_cycle" value=""/>
				<!--e : tab-->								
				<div id="content_flow">
					<c:forEach items="${listBatch}" var="batch" varStatus="status">
					<div class="batch" id="batch${batch.batch_job_id}" title="${batch.batch_job_name}"><strong class="connector">${batch.batch_job_name}</strong></div>
					</c:forEach>
					<ul id="myMenu" class="contextMenu">
						<li class="view"><a href="#view"><spring:message code="label.pfnm.batch.view.text"/></a></li>
						<%-- <li class="info"><a href="#info"><spring:message code="label.pfnm.batch.info.text"/></a></li> --%>
						<li class="copy separator"><a href="#copy"><spring:message code="label.pfnm.batch.copy.text"/></a></li>
						<li class="delete"><a href="#delete"><spring:message code="label.pfnm.batch.delete.text"/></a></li>
						<li class="rename"><a href="#rename"><spring:message code="label.pfnm.batch.rename.text"/></a></li>
					</ul>
					<ul id="myMenu2" class="contextMenu">
						<li class="insert"><a href="#insert"><spring:message code="label.pfnm.batch.insert.text"/></a></li>
					</ul>
					<ul id="myMenu3" class="contextMenu">
						<li class="line"><a href="#line"><spring:message code="label.pfnm.batch.line.text"/></a></li>
					</ul>	
				</div>			
				<div id="content_info" style="display:none;">
					<br>
					<input type="hidden" name="user_id" value="test"/>
					<table class="modif">
						<colgroup>
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
			            <tr>
			               <th class="capt" colspan="4"><spring:message code="label.pfnm.batch.batch_info.text"/></th>
			            </tr>					
						<tr>
							<th><label for="001"><strong>*</strong><spring:message code="label.pfnm.batch.batch_group.text"/></label>
							</th>
							<td><input type="text" id="batch_group_name" name="batch_group_name" value="">
							</td>
							<th><label for="002"><spring:message code="label.pfnm.batch.holiday_exception_yn.text"/></label>
							</th>
							<td><input type="checkbox" id="holiday_exception_yn" name="holiday_exception_yn" value="Y">
							</td>
						</tr>
						<tr>
							<th><label for="003"><spring:message code="label.pfnm.batch.remark.text"/></label>
							</th>
							<td colspan="3"><input type="text" id="remark" name="remark" class="pc100" value="">
							</td>
						</tr>
					</table>	
					<br>
					<table class="modif">
			             <tr>
			               <th class="capt" colspan="4"><spring:message code="label.pfnm.batch.schedule_cycle_type.text"/></th>
			            </tr>
						<tr id="cycle_type">
							<th width="320"><spring:message code="label.pfnm.batch.select.text"/>: 
								<input type="radio" id="r00" name="cycle_type" value="00" checked><label for="r00"><spring:message code="label.pfnm.batch.not.text"/></label>
								<input type="radio" id="r01" name="cycle_type" value="01"><label for="r01"><spring:message code="label.pfnm.batch.min.text"/></label>
								<input type="radio" id="r02" name="cycle_type" value="02"><label for="r02"><spring:message code="label.pfnm.batch.hour.text"/></label>
								<input type="radio" id="r03" name="cycle_type" value="03"><label for="r03"><spring:message code="label.pfnm.batch.day.text"/></label>
								<input type="radio" id="r04" name="cycle_type" value="04"><label for="r04"><spring:message code="label.pfnm.batch.month.text"/></label>
							</th>
							<td id="t00" style="display:none;">
								<input type="hidden" id="t00_cycle" name="cycle" value="0">
							</td>
							<td id="t01" style="display:none;">
								<input type="radio" id="button_01" name="cycle_button_01" value="01" checked><label for="t011"><spring:message code="label.pfnm.batch.per.text"/></label>
								<input type="text" id="cycle_01" name="cycle" class="px50" value="5"> 
								<label for="t012"><spring:message code="label.pfnm.batch.per_min.text"/></label>
							</td>
							<td id="t02" style="display:none;">							
								<input type="radio" id="button_02" name="cycle_button_02" value="02" checked><label for="t021"><spring:message code="label.pfnm.batch.per.text"/></label>
								<input type="text" id="cycle_02" name="cycle" class="px50" value="1">
								<label for="t022"><spring:message code="label.pfnm.batch.per_hour.text"/></label>
							</td>
							<td id="t03" style="display:none;">
								<input type="radio" id="button_03" name="cycle_button_03" value="03" checked><label for="t032"><spring:message code="label.pfnm.batch.per.text"/></label>
								<input type="text" id="cycle_03" name="cycle" class="px50" value="1"> 
								<label for="t033"><spring:message code="label.pfnm.batch.per_day.text"/></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" id="button_04" name="cycle_button_03" value="04"><label for="t034"><spring:message code="label.pfnm.batch.per_week.text"/> : </label> 
								<select id="cycle_04" name="cycle">
	                        		<option value="7"><spring:message code="label.pfnm.batch.mon.text"/></option>
	                        		<option value="7"><spring:message code="label.pfnm.batch.tue.text"/></option>
	                        		<option value="7"><spring:message code="label.pfnm.batch.wed.text"/></option>
	                        		<option value="7"><spring:message code="label.pfnm.batch.thu.text"/></option>
	                        		<option value="7"><spring:message code="label.pfnm.batch.fri.text"/></option>
	                        		<option value="7"><spring:message code="label.pfnm.batch.sat.text"/></option>
	                        		<option value="7"><spring:message code="label.pfnm.batch.sun.text"/></option>
	                     		</select>
							</td>
							<td id="t04" style="display:none;">
								<input type="radio" id="button_05" name="cycle_button_04" value="05" checked>
								<label for="button_04"><spring:message code="label.pfnm.batch.per.text"/></label> 
								<input type="text" id="cycle_05" name="cycle" class="px50" value="1"> 
								<label for="cycle_04"><spring:message code="label.pfnm.batch.per_mon.text"/></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" id="button_06" name="cycle_button_04" value="06">
								<label for="button_05"><spring:message code="label.pfnm.batch.per_mon2.text"/></label> 
								<input type="hidden" id="cycle_06" name="cycle" class="px50" value="1"> 
								<label for="cycle_05"><spring:message code="label.pfnm.batch.last_day.text"/></label>
							</td>							
						</tr>
					</table>	
					<br>
					<table class="modif">
			            <tr>
			               <th class="capt"><spring:message code="label.pfnm.batch.schedule_date.text"/></th>
			            </tr>
						<tr>
							<th><spring:message code="label.pfnm.batch.apply_date.text"/></th>
						</tr>
						<tr>
							<td>
								<input type="hidden" id="apply_date" name="apply_date">
								<input id="applyDate" name="applyDate" class="px100 date" readonly="readonly"> 
								<a href="javascript:$('#applyDate').datepicker('show');" id="btn_apply_date" class="ico_cal">
								<img src="/images/ico_cal.gif"></a>&nbsp;<select id="applyHour" name="applyHour"></select> : <select id="applyMin" name="applyMin"></select>							
							</td>
						</tr>
						<tr>
							<th><spring:message code="label.pfnm.batch.select.text"/>: <input type="radio" id="expire_n" name="expire_yn" checked>
								<label for="a01"><spring:message code="label.pfnm.batch.not.text"/></label> 
								<input type="radio" id="expire_y" name="expire_yn">
								<label for="a03"><spring:message code="label.pfnm.batch.expire_date.text"/></label>
							</th>
						</tr>
						<tr>
							<td>
								<input type="hidden" id="expire_date" name="expire_date">
								<input id="expireDate" class="px100 date" name="expireDate" value="9999-12-31">
								<a href="javascript:$('#expireDate').datepicker('show');" id="btn_expire_date" class="ico_cal">
								<img src="/images/ico_cal.gif"></a>
							</td>
						</tr>					
					</table>	
				</div>
				<!-- modal content -->
				<div id="pop_layer" style="display:none;"></div>				
		</form>
	</div>
</body>
</html>