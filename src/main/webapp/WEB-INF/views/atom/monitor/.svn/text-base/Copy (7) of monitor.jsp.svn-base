<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html lang="en_US">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><spring:message code="label.monitor.title"/></title>
<!--[if lt IE 9]>
	<script src="/scripts/html5.js"></script>
<![endif]-->

<link rel="stylesheet" href="/styles/style.css">
<link rel="stylesheet" href="/scripts/tree/themes/default/style.min.css">
<link rel="stylesheet" href="/styles/jquery.contextMenu.css">

<script src="/scripts/jquery.1.11.2.min.js"></script>
<script src="/scripts/custom/local.storage.js"></script>
<script src="/scripts/custom/open.window.js"></script>
<script src="/scripts/tree/jstree.min.js"></script>
<script src="/scripts/ui.monitor.js"></script>
<script src="/scripts/amcharts_3.19.4/amcharts/amcharts.js"></script>
<script src="/scripts/amcharts_3.19.4/amcharts/serial.js"></script>
<script src="/scripts/amcharts_3.19.4/amcharts/pie.js"></script>
<script src="/scripts/amcharts_3.19.4/amcharts/amcharts_custom.js"></script>
<script src="/scripts/clockpicker.min.js"></script> 
<script src="/scripts/datepicker.min.js"></script> 
<script src="/scripts/multiple-select.js"></script> 
<script src="/scripts/easypiechart.js"></script>
<script src="/scripts/gauge/gauge-2.1.4.min.js"></script>
<script src="/scripts/gauge/gauge.js"></script> 
<script src="/scripts/menu/modernizr-custom.js"></script>
<script src="/scripts/menu/classie.js"></script>
<script src="/scripts/menu/main.js"></script>
<script src="/scripts/modal.js"></script>
<script src="/scripts/jquery.simplemodal.js"></script> 
<script src="/scripts/jquery.contextMenu.js"></script>
<script src="/scripts/date.format.js"></script>
<script src="/scripts/jquery-ui.min.js"></script>
        
<script src="/scripts/jwebsocket/pfnmWebSocket.js"></script>
<script src="/scripts/jwebsocket/1_0_b1/jWebSocket.js"></script>

<script type="text/javascript">

<!--
	//websocket setting
	var socketUrl = "${pageContext.servletContext.getAttribute('websocket.connect.url')}";
	
	initPage(socketUrl, "monitor");
	
	//오디오 변수
	var audio1;
	var audio2;
	var audio3;
	
	var isAlarmSoundReload = true; 	//알람 사운드 ON & OFF
	var isAlarmViewReload = true; 	//알람 가시 ON & OFF
	var isAlarmPlayReload = true; 	//알람 플레이 ON & OFF
	
	$(document).ready(function() {
		
		$(this).contextmenu(function(e) {
			//return false;
		});
		
		$("#alarm_popup").hide(); //젤 아래 알람 팝업
		$("#disconnect_popup").hide(); //젤 아래 알람 팝업
		$("#btn_reset").hide(); //reset버튼
		
		//최초 한번만 실행
		setTimeout(function() { 
			fnInitializeTree();
			fnInitializeAlarm();
			// fnInitializeNode();
			fnInitializeResource();
			fnInitializeTopResource();
			fnKeepAlive();			
		}, 1000);
		
		//search 버튼
		$("#btn_search").click(function() {
			$(this).hide();
			$("#btn_reset").show();
			fnInitializeAlarm();
		});
		
		//search 버튼
		$("#btn_reset").click(function() {
			$(this).hide();
			$("#btn_search").show();
		});
		
		//ack
		$("#btn_ack").click(function() {
			console.log("ack");
			fnCheckAlarmConfirm(true);
		});
		
		//unack
		$("#btn_unack").click(function() {
			console.log("btn_unack");
			fnCheckAlarmConfirm(false);
		});
		
		//clear
		$("#btn_clear").click(function() {
			
			if($("#alarmList").children("tr").length == 0) { //리스트가 없다
				openAlertModal("", "<spring:message code="msg.monitor.alarm.select"/>", null, null);
				return;
			} else {
				if($("input:checkbox[name='chk']:checked").length <= 0) { //체크가 없다
					openAlertModal("", "<spring:message code="msg.monitor.alarm.select"/>", null,null);
					return;
				}
			}
			
			openConfirmModal("<spring:message code="msg.monitor.alarm.clear"/>", "", fnMessageAlarmClear, fnCancelAlarmConfirm, "<spring:message code="label.common.ok" />","<spring:message code="label.common.cancel" />");
		});
		
		//sound 버튼 ON 클릭시
		$("#btn_soundOn").click(function() {
			//console.log("btn_soundOn");			
			$("#btn_soundOff").show();
			$("#btn_soundOn").hide();
			
			isAlarmSoundReload = false;
		});
		
		//sound 버튼 OFF 클릭시
		$("#btn_soundOff").click(function() {
			//console.log("btn_soundOff");			
			$("#btn_soundOff").hide();
			$("#btn_soundOn").show();
			
			fnInitializeSound();
			isAlarmSoundReload = true;
				
		});
		
		//알람 팝업 on 클릭시
		$("#btn_viewOn").click(function() {
			console.log("btn_viewOn");	
			$("#btn_viewOff").show();
			$("#btn_viewOn").hide();
		});
		
		//알람 팝업 off 버튼 클릭시
		$("#btn_viewOff").click(function() {
			console.log("btn_viewOff");	
			$("#btn_viewOff").hide();
			$("#btn_viewOn").show();
		});
		
		//restart 버튼 클릭시
		$("#btn_playOn").click(function() {
			console.log("btn_playOn");	
			
			$("#btn_playOff").show();
			$("#btn_playOn").hide();			
			$("#btn_viewOff").hide(); //가시 같이 갱신한다
			$("#btn_viewOn").show();
			
			isAlarmViewReload = false;
			isAlarmPlayReload = false;
			
			fnInitializeAlarm();
			
		});
		
		//pause 버튼 클릭시
		$("#btn_playOff").click(function() {
			console.log("btn_playOff");	
			$("#btn_playOff").hide();
			$("#btn_playOn").show();
			$("#btn_viewOff").show(); //가시 같이 갱신한다
			$("#btn_viewOn").hide();
			
			isAlarmViewReload = true;
			isAlarmPlayReload = true;
		});
		
		//엑셀 다운로드
		$("#btn_export").click(function() {
			console.log("export");			
		});
		
		//더 보기 
		$("#btn_moreDown").click(function() {
			console.log("btn_moreDown");
			$(".sub_bottom").addClass("on");
			$("#btn_moreUp").show();
			$("#btn_moreDown").hide();
		});
		
		//더 보기 
		$("#btn_moreUp").click(function() {
			console.log("btn_moreUp");
			$(".sub_bottom").removeClass("on");
			$("#btn_moreUp").hide();
			$("#btn_moreDown").show();
		});
		
		//전체 체크
		$(document).on("change", "#chk_list", function() {
			var isChecked = $(this).is(":checked");
			console.log("전체 체크 여부 ==>"+isChecked);
			if(isChecked) { //선택되면 Pause 시킨다.
				
			} else {
				
			}
		});
		
		//개별 선택시			
	 	$(document).on("change", "input[name=chk]", function() {
	 		var checkTotalCount = $("input:checkbox[name=chk]:checked").length; 
	 		var list_size = $("input[name=listSize]").attr("value");
	 		
	 		if (checkTotalCount == list_size) { //전체 체크랑 같다면 전체 체크한다.
	 			$("input:checkbox[name=chk_list]").prop("checked", true);
	 		} else {
	 			$("input:checkbox[name=chk_list]").prop("checked", false);
	 		}
	 	});
	 	
		//알람 Detail
		$(document).on("click", "#btn_alarm_detail", function() {
			//console.log($(this).val());
			var param = new Object();
			param.msgId = $(this).val();
			
			var result =
				$.ajax({
					url : "/atom/monitor/alarmDetail",
					data : param,
					type : "post",
					dataType : "html", 
					cache : false
				});
			
			result.done(function(data) {
				$.modal(data, {onShow: function (dialog) {
					dialog.container.draggable({handle: "#pop_alarmDetail", containment: "body"});
					}
				});
				$('#simplemodal-overlay').css('display','none'); /* Overlay Div's display = none */
			});
			
			result.fail(function(xhr, status) {
			});		
		});
		
		//알람 영역에 컨텍스트 메뉴 지정
		$.contextMenu({
		    selector: '#tr_node_name, #tr_code, #tr_severity_name',
		    className: 'light',
		    items: {
		        search: {
		            name: "<spring:message code="label.common.search"/>",
		            callback: function(key, opt){
		            	/* console.log(key);
		            	console.log(opt);
		            	console.log($(this));
		            	console.log($(this).id);
		            	console.log(opt.$trigger.attr('id')); */
		            	
		            	$("input:text[name=search]").val($(this).text()); //text지정
		            	var search_type = 1;
		            	if (opt.$trigger.attr("id") == "tr_node_name") {
		            		search_type = 2;
		            	} else if (opt.$trigger.attr("id") == "tr_code") {
		            		search_type = 3;
		            	} else if (opt.$trigger.attr("id") == "tr_severity_name") {
		            		search_type = 4;
		            	}
		            	$("#search_type").multipleSelect('setSelects',[search_type]);
		            	
		            }
		        }
		    }
		});
		
		var alarm_index = 0;
		//Alarm 팝업 리스트 선택시
		$(document).on("click", "#alarm_list > li", function() {
			//console.log($(this).index());
			alarm_index = $(this).index();
			
			$("#alarm_list > li").removeClass("select");
			$(this).addClass("select");
			
			var node_name = $(this).find(":nth-child(1)").text();
			var alias_code = $(this).find(":nth-child(2)").text();
			var severity_name = $(this).find(":nth-child(3)").text();
			var alarm_group = $(this).find(":nth-child(4)").text();
			var pkg_name = $(this).find(":nth-child(5)").text();
			var probable_cause = $(this).find(":nth-child(6)").text();
			var location = $(this).find(":nth-child(7)").text();
			var target = $(this).find(":nth-child(8)").text();
			var value = $(this).find(":nth-child(9)").text();
			var additional_text = $(this).find(":nth-child(10)").text();
			var node_version = $(this).find(":nth-child(11)").text();
			var node_type = $(this).find(":nth-child(12)").text();
			var prc_date = $(this).find(":nth-child(13)").text();
			var severity_id = $(this).find(":nth-child(14)").text();
			
			if (severity_id == 0) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm ind"); //색상 class
			if (severity_id == 1) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm cr"); //색상 class
			if (severity_id == 2) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm ma"); //색상 class
			if (severity_id == 3) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm mi"); //색상 class
			if (severity_id == 4) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm nor"); //색상 class
			if (severity_id == 6) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm wa"); //색상 class
			if (severity_id == 7) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm cl"); //색상 class
			
			$("#alarm_popup .popup_sys .info .cau").html(severity_name);
			$("#alarm_popup .popup_sys .info .sys_ttl > p").html("["+pkg_name+"]");
			$("#alarm_popup .popup_sys .info .sys_ttl > span").html(node_name);
			
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(1) > td").html(prc_date);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(2) > td").html(alias_code);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(3) > td").html(alarm_group);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(4) > td").html(probable_cause);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(5) > td").html(location);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(6) > td").html(target);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(7) > td").html(value);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(8) > td").html(node_version);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(9) > td").html(node_type);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(10) > td").html(additional_text);
			
		});		
		
		//Alarm 팝업 확인 선택시
		$(document).on("click", "#alarm_confirm", function() {
			
			var obj_select = $("#alarm_list").find(".select");
			if (obj_select.length == "0") { //못찾음
				//openAlertModal("", "<spring:message code="msg.monitor.alarm.select"/>", null, null);
				//alert("<spring:message code="msg.monitor.alarm.select"/>");
				console.log("not found selected");
				return;
			}
			
			obj_select.remove(); //삭제
			
			var alarmListCount = $("#alarm_list li").length;
			
			if (alarmListCount == 0) {
				fnAlarmListAllClose(); //창을 닫는다.
				return;
			} else if(alarmListCount == alarm_index) { //젤 마지막이면
				alarm_index = alarm_index - 1;				
			}
			
			$("#alarm_list > li:eq("+alarm_index+")").addClass("select"); 
			
			$("#alarm_list_count").text(alarmListCount); //알람 개수 갱신
			//console.log(alarmListCount +"/"+alarm_index);
			//선택된 화면 갱신
			var node_name = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(1)").text();
			var alias_code = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(2)").text();
			var severity_name = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(3)").text();
			var alarm_group = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(4)").text();
			var pkg_name = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(5)").text();
			var probable_cause = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(6)").text();
			var location = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(7)").text();
			var target = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(8)").text();
			var value = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(9)").text();
			var additional_text = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(10)").text();
			var node_version = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(11)").text();
			var node_type = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(12)").text();
			var prc_date = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(13)").text();
			var severity_id = $("#alarm_list > li:eq("+alarm_index+")").find(":nth-child(14)").text();
			
			if (severity_id == 0) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm ind"); //색상 class
			if (severity_id == 1) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm cr"); //색상 class
			if (severity_id == 2) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm ma"); //색상 class
			if (severity_id == 3) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm mi"); //색상 class
			if (severity_id == 4) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm nor"); //색상 class
			if (severity_id == 6) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm wa"); //색상 class
			if (severity_id == 7) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm cl"); //색상 class
			
			$("#alarm_popup .popup_sys .info .cau").html(severity_name);
			$("#alarm_popup .popup_sys .info .sys_ttl > p").html("["+pkg_name+"]");
			$("#alarm_popup .popup_sys .info .sys_ttl > span").html(node_name);
			
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(1) > td").html(prc_date);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(2) > td").html(alias_code);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(3) > td").html(alarm_group);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(4) > td").html(probable_cause);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(5) > td").html(location);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(6) > td").html(target);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(7) > td").html(value);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(8) > td").html(node_version);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(9) > td").html(node_type);
			$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(10) > td").html(additional_text);
			
		});
	});
	
	
	
	
	//####################################################
	//################### 트리 함수 #######################
	//####################################################
	
	/**
	 * 온라인 트리 타이틀 & 아이콘 초기화한다
	 */
	function fnInitializeTree() {	
		var to = false;
		$('#treeSearch').keyup(function () {
			if(to) { clearTimeout(to); }
			to = setTimeout(function () {
				var v = $('#treeSearch').val();
				$('#jstree').jstree(true).search(v);
			}, 250);
		});
		
		/**
		 * 클릭시 열고 닫힌다.
		 */
		$('#jstree').on('select_node.jstree', function (e, data) {
			//console.log(e);
			//console.log(data);
			//왼쪽 마우스일때만 
			if (data.event.which == 1) return data.instance.toggle_node(data.node);
		});
		
		$("#jstree").jstree({
			"plugins" : ["search", "contextmenu"],
			"search" : {"show_only_matches" : true},
			"core" : {
				//data: jQuery.parseJSON(aaa)
				data : {
					type : "post",
					url : "/common/listTree.json",
					dataType : "json"
				}
			},
			
			"contextmenu": {
				"items" : fnCustomMenu
			},

		});
		
		$("#jstree").bind("ready.jstree", function (event, data) {
            $(this).jstree("open_all"); //기본으로 펼친다.
            fnNodeStatus(data.instance); //노드 상태 조회한다.
        });
		
		$("#jstree").bind("select_node.jstree", function (event, data) {
           console.log("select.jstre=="+data.node.text);
           console.log(data.node.parents.length);
           //console.log(data.instance);
           if (data.node.parents.length != 1) {
        	   
           }
           
        });
	}
	
	/**
	 * 트리 오른쪽 메뉴 
	 */
	function fnCustomMenu(node) {
		var items = {
			      "1" : {
			          "label" : "Upload File",
			          "action" : function() {
			        	  console.log("Upload File");
			        	  return;
			          }
			      },
			      "2" : {
			         "label" : "dfdfdf",
			         "action" : function() {
			        	 console.log("dfdfdf");
			        	 return;
			         }
			      },
			      "3" : {
			         "label" : "Delete File",
			         "action" : function() {
			        	 console.log("Delete File");
			        	 return;
			         }
			      }
			   };
		//특정 아이템만 적용한다.
		return items;
	}
	
	/**
     * 노드 상태 조회 (최초 디비를 조회한다)
     */
	function fnNodeStatus(node) {
		//console.log(node.get_node("ATOM"));
		var result = 
			$.ajax({
				url : "/atom/monitor/listNodeStatus",
				dataType: "json", 
				data : null,
				type : "POST",
				cache : false
			});
		
		result.done(function(data) {
			//console.log(data);
			if (data != null) {
				
				//노드
				var node_running = "/images/tree_icon/images/node_running.png";
				var node_stopped = "/images/tree_icon/images/node_stopped.png";
				var node_suspend = "/images/tree_icon/images/node_suspend.png";
				var node_scale = "/images/tree_icon/images/node_scale.png";
				var node_abnormal = "/images/tree_icon/images/node_abnormal.png";
				var node_unknown = "/images/tree_icon/images/node_unknown.png";
				var node_up_unknown = "/images/tree_icon/images/node_up_unknown.png"; 
				
				$.each(data, function(index, row) { 
					if (row.NODE_STATUS == "ACTIVE") {
						if (row.PROC_STATUS == "RUNNING") {
							$("#jstree").jstree(true).set_icon(row.PKG_NAME+"-"+row.NODE_NO, node_running);							
						} else if (row.PROC_STATUS == "UNKNOWN") { 
							$("#jstree").jstree(true).set_icon(row.PKG_NAME+"-"+row.NODE_NO, node_unknown);
						} else if (row.PROC_STATUS == "SUSPEND") {
							$("#jstree").jstree(true).set_icon(row.PKG_NAME+"-"+row.NODE_NO, node_suspend);
						} else if (row.PROC_STATUS == "STOPPED") {
							$("#jstree").jstree(true).set_icon(row.PKG_NAME+"-"+row.NODE_NO, node_stopped);
						} else if (row.PROC_STATUS == "HANGUP") {
						} else if (row.PROC_STATUS == "ABNORMAL") {
							$("#jstree").jstree(true).set_icon(row.PKG_NAME+"-"+row.NODE_NO, node_abnormal);
						}
					} else {
						if (row.NODE_STATUS == "UNKNOWN") { 
							$("#jstree").jstree(true).set_icon(row.PKG_NAME+"-"+row.NODE_NO, node_up_unknown);
						} else if ((row.NODE_STATUS == "SCALEIN") || (row.NODE_STATUS == "SCALEOUT")) {
							$("#jstree").jstree(true).set_icon(row.PKG_NAME+"-"+row.NODE_NO, node_scale);
						}
					}
					
					fnNodeStatusParent(node, row.PKG_NAME);
				});				
			}
		});
		
		result.fail(function(xhr, status) {
		});
	}
	
	function fnNodeStatusParent(node, pkg_name) {
		//노드
		var running = "/images/tree_icon/images/node_running.png";
		var unknown = "/images/tree_icon/images/node_unknown.png";
		var suspend = "/images/tree_icon/images/node_suspend.png";
		var stopped = "/images/tree_icon/images/node_stopped.png";
		var abnormal = "/images/tree_icon/images/node_abnormal.png";
		var upUnknown = "/images/tree_icon/images/node_up_unknown.png"; 
		var scale = "/images/tree_icon/images/node_scale.png";
		
		//패키지
		var pkg_running = "/images/tree_icon/images/pkg_running.png";
		var pkg_stopped = "/images/tree_icon/images/pkg_stopped.png";
		var pkg_suspend = "/images/tree_icon/images/pkg_suspend.png";
		var pkg_scale = "/images/tree_icon/images/pkg_scale.png";
		var pkg_abnormal = "/images/tree_icon/images/pkg_abnormal.png";
		var pkg_unknown = "/images/tree_icon/images/pkg_unknown.png";
		
		var node_child = node.get_node(pkg_name).children;
		var icon;
		var decision = null;
		var pkgDecision = null;
		
		$.each(node_child, function (i, v) {
			icon = node.get_node(v).icon;
			if ((icon != null) && (icon != "")) {
				if (scale == icon) {
					decision = scale;
					pkgDecision = pkg_scale;					
				} else if ((decision != scale) && (upUnknown == icon)) {
					decision = upUnknown;
					pkgDecision = pkg_unknown;
				} else if ((decision != scale) && (decision != upUnknown) && (abnormal == icon)) {
					decision = abnormal;
					pkgDecision = pkg_abnormal;
				} else if ((decision != scale) && (decision != upUnknown) && (decision != abnormal) && (stopped == icon)) {
					decision = stopped; 
					pkgDecision = pkg_stopped;
				} else if ((decision != scale) && (decision != upUnknown) && (decision != abnormal) && (decision != stopped) && (suspend == icon)) {
					decision = suspend;	
					pkgDecision = pkg_suspend;
				} else if ((decision != scale) && (decision != upUnknown) && (decision != abnormal) && (decision != stopped) && (decision != suspend) && (unknown == icon)) {
					decision = unknown;
					pkgDecision = pkg_unknown;
				} else if ((decision != scale) && (decision != upUnknown) && (decision != abnormal) && (decision != stopped) && (decision != suspend) && (decision != unknown) && (running == icon)) {
					decision = running;
					pkgDecision = pkg_running;
				}
			}			
		});
		
		$("#jstree").jstree(true).set_icon(pkg_name, pkgDecision);
		
	}
	
	/**
	 * 노드 상세 redraw
	 */
	function fnNodeDetailTree(node_name) {
		//$('#mytree').jstree(true).settings.core.data = fnNodeDetailTree;
		//$('#mytree').jstree(true).refresh();
	}
	//####################################################
	//################### 노드 함수 #######################
	//####################################################
	
	/**
	 * 노드 조회
	 */
	function fnInitializeNode() {
		var param = new Object();
		$.ajax({
			url : "/atom/monitor/networkDiagram.ajax",
			dataType: "html", 
			data : param,
			type : "POST",
			cache : false,
			success: function(data) {
				$("#network_diagram").html(data);
			}
		});
	}
	
	//####################################################
	//################### 알람 함수 #######################
	//####################################################
	
	/**
	 * 알람 조회
	 */
	function fnInitializeAlarm() {
		
		var param = $("#checkAlarmForm").serialize();
		
		var result = 
			$.ajax({
				url : "/atom/monitor/alarmList.ajax",
				dataType: "html", 
				data : param,
				type : "POST",
				cache : false
			});
		
		result.done(function(data) {
			//console.log(data);
			if (data != null) {
				$("#alarmList").html(data);	
				
				$("input:checkbox[name=chk_list]").prop("checked", false); //check all 표시 제거
				$("#btn_playOn").hide();	
				$("#btn_playOff").show();	
				
				$("#btn_viewOff").hide();
				$("#btn_viewOn").show();
				
				fnSeverityCount();
				fnIntervalAlarmSound();
			}
		});
		
		result.fail(function(xhr, status) {
			console.log(status);
		});
		if (result !== null) result = null;
	}
	
	/**
	 * Severity Count 조회 
	 */
	function fnSeverityCount() {
		
		var critical_count = $("input[name=critical_count]").attr("value");
		var major_count = $("input[name=major_count]").attr("value");
		var minor_count = $("input[name=minor_count]").attr("value");
		var fault_count = $("input[name=fault_count]").attr("value");
		var notice_count = $("input[name=notice_count]").attr("value");
		var interminate_count = $("input[name=interminate_count]").attr("value");
		var warning_count = $("input[name=warning_count]").attr("value");
		
		fault_count = Number(fault_count);
		notice_count = Number(notice_count);
		interminate_count = Number(interminate_count);
		warning_count = Number(warning_count);
		
		$("#critical_count").text(critical_count);
		$("#major_count").text(major_count);
		$("#minor_count").text(minor_count);
		$("#warning_count").text(fault_count + notice_count + interminate_count + warning_count);
		
		//알람 총 카운터
		var alarm_totalcount = $("input[name=alarm_totalcount]").attr("value");
		$("#alarm_totalcount").text(alarm_totalcount);
		
		//마지막 페이지
		var lastPage = $("input[name=lastPage]").attr("value");
		if (lastPage == "0") lastPage = 1;
		$("#last_page").text(lastPage);
		
		//현재 페이지
		var realPage = $("input[name=realPage]").attr("value");
		$("input[name=page]").val(realPage);
	}
	
	/**
	 * 페이지 이동
	 */
	function fnPageMove(value) {
		
		var page = $("input[name=realPage]").attr("value");
		var lastPage = $("input[name=lastPage]").attr("value");
		
		page = Number(page);
		lastPage = Number(lastPage);
		//console.log(page +"/"+lastPage);		
		if (value == "first") {
			$("input[name=page]").val(1);
		} else if (value == "before") {
			if (page > 1) $("input[name=page]").val(page-1);
		} else if (value == "next") {
			if (page < lastPage) $("input[name=page]").val(page+1);
		} else if (value == "last") {
			$("input[name=page]").val(lastPage);
		}
		
		fnInitializeAlarm();
	}
	
	/**
	 * ack & unack 호출 함수
	 */
	function fnCheckAlarmConfirm(isBoolean) {
		//console.log("isBoolean==>"+isBoolean);
		//console.log($("#alarmList").children("tr").length);
		if($("#alarmList").children("tr").length == 0) {
			openAlertModal("", "<spring:message code="msg.monitor.alarm.select"/>", null, null);
			return;
		} else {
			if($("input:checkbox[name='chk']:checked").length <= 0) {
				openAlertModal("", "<spring:message code="msg.monitor.alarm.select"/>", null,null);
				return;
			}
		}
		
		if (isBoolean) {
			openConfirmModal("<spring:message code="msg.monitor.alarm.ack"/>", "", fnAckAlarmConfirm, fnCancelAlarmConfirm, "<spring:message code="label.common.ok" />","<spring:message code="label.common.cancel" />");
		} else {
			openConfirmModal("<spring:message code="msg.monitor.alarm.unack"/>", "", fnUnackAlarmConfirm, fnCancelAlarmConfirm, "<spring:message code="label.common.ok" />","<spring:message code="label.common.cancel" />");
		}
	}
	
	/**
	 * Ack 설정 함수
	 */
	function fnAckAlarmConfirm() {
		var param = $("#checkAlarmForm").serialize();		
		var result = 
			$.ajax({
				url : "/atom/monitor/ackAlarmConfirm",
				dataType: "json", 
				data : param,
				type : 'POST',
				cache : false
			});
		
		result.done(function(data) {
			console.log(data);
			if (data == 0) {
				fnInitializeAlarm();
			}
		});
		
		result.fail(function(xhr, status) {
		});
	}
	
	/**
	 * unAck 설정 함수
	 */
	function fnUnackAlarmConfirm() {
		var param = $("#checkAlarmForm").serialize();		
		var result = 
			$.ajax({
				url : "/atom/monitor/unAckAlarmConfirm",
				dataType: "json", 
				data : param,
				type : 'POST',
				cache : false
			});
		
		result.done(function(data) {
			if (data == 0) {
				fnInitializeAlarm();
			}
		});
		
		result.fail(function(xhr, status) {
		});
	}
	
	/**
	 * ack, unack, clear  캔슬했을대 함수
	 */
	function fnCancelAlarmConfirm() {
		$("input:checkbox[name='chk']").prop("checked", false);
		$("input:checkbox[name='chk_list']").prop("checked", false);
	}
	
	//####################################################
	//################### 알람 사운드 함수 #################
	//####################################################
	
	/**
	 * 10초간격으로 사운드 발생
	 */
	var intervalAlarmSound; //알람
	
	function fnIntervalAlarmSound() {
		intervalAlarmSound = setInterval(function() {
			//console.log("isAlarmSoundReload==>"+isAlarmSoundReload);				
			if (isAlarmSoundReload) fnInitializeSound();

			clearInterval(intervalAlarmSound);
			fnIntervalAlarmSound();
			
		}, 10 * 1000);
	} 		
	
	/**
	 * 알람 사운드
	 */
	function fnInitializeSound() {
		var result = 			
			$.ajax({
				url : "/atom/monitor/lastSound",
				dataType: "json", 
				data : "",
				type : "POST",
				cache : false
			});
		
		result.done(function(data) {
			//console.log(data);
			if ((data != "") && (data != null)) {
				//fnPlayAudio(data.SYSTEM_NAME, data.SEVERITY_NAME, data.FILE_FLAG, data.CODE);
				fnPlayAudio(data.SEVERITY_NAME);
			}
			data = null;
		});
		
		result.fail(function(xhr, status) {
		});
		
		if (result !== null) result = null;
	}
	
	/**
	 * 알람 사운드 실행 
	 */
	function fnPlayAudio(severityName) {	
		//console.log(file_flag);
		//console.log(code);
        try {
        	//audio1 = $("#system_" + system_name).get(0);
        	audio2 = $("#level_" + severityName).get(0);
        	//audio3 = $("#alarm_" + code).get(0);
        	
        	if((audio2.error == null) && (audio2 != undefined)) { //에러 아니면
            	//window.addEventListener("DOMContentLoaded", initEvent(), false);
            	audio2.play();
           	} 
        } catch(e) {
            if (window.console && console.error("Error:" + e));
        } finally {
        }
    }
	
	//####################################################
	//################### 웹소켓 함수 #####################
	//####################################################
	
	/**
     * 웹소켓 로그인 성공시 호출
     */
	function fnPreparedSocket() {
		console.log("웹소켓 연결 성공...");
		fnLoadingTry(false);
		
		fnRequestResource(120); //리소스 요청한다.
	}
	
	function fnCommonMessage(command, messages) {
		
		messages = $.parseJSON(messages); //String to Json 변환
		//console.log("받음 command->"+command);
		//console.log(messages);
		if (command == 20021) { //alarm clear 응답
			fnInitializeAlarm(); //화면 재갱신
		} else if (command == 20006) { //알람 발생
			fnMessageInitAlarm(messages);
		} else if (command == 20000) { //알람 발생
			fnMessageInitAlarm(messages);
		} else if ((command == 20002) || (command == 20003)) { //노드 상태
			$.jstree.destroy();
			fnMessageInitTree();
			networkDiagramFrame.reloadNodeStatus(messages);
		} else if (command == 20004 || command == 20018) {
			networkDiagramFrame.reloadConnectionStatus(messages);
		}
		// RSA_MONITORING_REPORT(노드 자원정보 상세 요청)
		else if (command == 90002) { 
			
 			console.log( "[mirinae.maru] RSA_MONITORING_REPORT response..." );
			// RSA_MONITORING_REPORT response...
			responseNodeResourceInfo( messages );
		} 
		// RSA_MONITORING_REPORT_STOP(노드 자원정보 상세 중지요청)
		else if (command == 90003) { 
			
		} 
		//RSA_SUMMARY_REPORT(노드 리소스 정보이면...)
		else if (command == 90005) { 
			fnResponseResource(messages);
		} else if (command == 90006) { //RSA_SUMMARY_REPORT_STOP
		}
	}
	
	/**
	 * 알람 메세지가 ##트리## 다시 읽어라고 오면 다시 시도 
	 */
	function fnMessageInitTree() {
		fnInitializeTree();
	}

	/**
	 * 알람 메세지가 ##노드## 다시 읽어라고 오면 다시 시도(STATUS_CONNECT_EVENT)
	 */
	function fnMessageInitNode() {
		fnInitializeNode();
	}
	
	/**
	 * Ataom 리소스 요청
	 */
	var intervalResource;
	function fnInitializeResource() {
		var timeout = 120; //120초단위로 받기
		intervalResource = setInterval(function() {
			console.log("리소스 요청");
			fnRequestResource(timeout);
			clearInterval(intervalResource);	
			fnInitializeResource();
		}, timeout * 1000);
	}
	
	/** 리소스 요청************/
	function fnRequestResource(timeout) {
		var period = 10; //10초단위로 받기		
		var JSON_data = '{"period":'+period+',"timeout":'+timeout+'}';
		console.log("-->"+JSON_data);
		CommandREQ("0000090005", 46, 2147483494, JSON_data);
	}
	
	/** 아톰 리소스 ****/
	function fnResponseResource(messages) {
		$.each(messages, function(i, row) {
			console.log(row);
		});
	}
	
	/** TOP-5 리소스 **/
	var intervalTopResource;
	function fnInitializeTopResource (){
		intervalTopResource = setInterval(function() {
			
			var result = 
				$.ajax({
					url : "/atom/monitor/listTopResource",
					dataType: "json", 
					data : null,
					type : "POST",
					cache : false
				});
			
			result.done(function(data) {
				//console.log(data);
				if (data != null) {
					var AmChartsColum = ['chart_colum1','chart_colum2','chart_colum3','chart_colum4'];
					var chartConfig;
					var dataArray;
					
					$("#atom_resource").empty();
					var li = null;
					var cololr = null;
					
					$.each(data, function(i, row) {
						li = $("<li>");
						li.append(row.resourceDataName);
						
						dataArray = []; 
						$.each(row.resourceData, function(t, row) {
							li.append("<ol><li>"+row.RSC_ID_NAME+"</li></ol>");
							
							if (t == 0) color = "#01b8aa";
							if (t == 1) color = "#265299";
							if (t == 2) color = "#6f7d94";
							if (t == 3) color = "#adb2ba";
							if (t == 4) color = "#d4d6d9";
							
							dataArray.push({
								"category" : row.RSC_ID_NAME,
						        "column-1" : row.DATA,
						        "color" : color
							});							
						});
						
						li.append("<div id='"+AmChartsColum[i]+"'></div>");
						li.append("</li>");
						//console.log(li);
						$("#atom_resource").append(li);
						
						chartConfig = AmCharts.cloneObject(configTemplate);
						chartConfig.dataProvider = dataArray;
						AmCharts.makeChart(AmChartsColum[i], chartConfig);

					});
					
					
				}
			});
			
			result.fail(function(xhr, status) {
				console.log(status);
			});
			
			clearInterval(intervalTopResource);	
			fnInitializeTopResource();
		}, 10 * 1000); //10초로
	}
	
	/**
	 * 알람 메세지가 ##프로세스 상태## 다시 읽어라고 오면 다시 시도(STATUS_PROC_EVENT)
	 */
	function fnMessageInitProcess() {
	}
	
	/**
	 * 알람 clear (ALM_USER_CHANGE)
	 */
	function fnMessageAlarmClear() {
		console.log("fnMessageAlarmClear");
		
		var param = $("#checkAlarmForm").serialize();
		var result =
			$.ajax({
				url : "/atom/monitor/clearAlarmConfirm",
				dataType: "json", 
				data : param,
				type : 'POST',
				cache : false
			});
		
		result.done(function(data) {
			console.log(data);
			var JSON_data = null;
			var msgId;
		  	var severityId;
			$("input:checkbox[name=chk]:checked").each(function(i, row) {
				msgId = $(this).val();
				severityId = $(this).closest("tr").children("td:eq(11)").text();				
				JSON_data = '{"message":"alarm change by user","msg_id":'+msgId+',"severity_id":'+severityId+',"oper_no":'+data.operNo+',"prc_date":"'+data.NowDate+'","dst_yn":"'+data.DST+'","user_id":"${sessionUser.userId}"}';
				//console.log(JSON_data);
				CommandREQ("0000020007", "", data.AlarmNo, JSON_data);
			}); 
			
		});
		result.fail(function(xhr, status) {
		});
					
	}
	
	/**
	 * 알람 메세지가 ##알람## 다시 읽어라고 오면 다시 시도(ALM_EVENT)
	 */	
	function fnMessageInitAlarm(messages) {
		//messages = '{"message" : "alarm","alarm_group" : "Communications","sequence_id" : 1,"node_no" : 1,"node_name" : "ST0OFCS011", "proc_no" : 1,"severity_id": 2,"severity_name" : "Majer", "pkg_name" : "OFCS","code" : "90300102","alias_code" : "90300102 ","probable_cause" : "ALRM-DISK_OVER","additional_text" : "", "location" : "/OFCS/RSA","target" : "/data","complement": "%",  "value" : "93.7","node_version" : "OFCS1.2","node_type" : "AP",  "prc_date" : "2016-04-12 09:14:53.92", "dst_yn" : "N"}';
		var data = messages;
		//console.log(data);
		var alarmAllData = $.parseJSON('${alarmAll}');
		var isCheck = false;
		if (alarmAllData.length > 0) { //팝업 여부를 체크한다.
			$.each(alarmAllData, function(i, row) {
				if ($.trim(row.CODE) == $.trim(data.alias_code)) {
					isCheck = true;
					return false;  //빠져나간다.
				}
			});	
		}
		
		if (!isCheck) return; //더이상 진행안한다.
		
		var node_name = $.trim(data.node_name);
		var alias_code = $.trim(data.alias_code);
		var severity_name = $.trim(data.severity_name);
		var alarm_group = $.trim(data.alarm_group);
		var pkg_name = $.trim(data.pkg_name);
		var probable_cause = $.trim(data.probable_cause);
		var location = $.trim(data.location);
		var target = $.trim(data.target);
		var value = $.trim(data.value);
		var complement = $.trim(data.complement);
		var additional_text = $.trim(data.additional_text);
		var node_version = $.trim(data.node_version);
		var node_type = $.trim(data.node_type);
		var prc_date = $.trim(data.prc_date);
		var severity_id = $.trim(data.severity_id);
		
		var lowerCase = "${sessionUser.patternDate}".toLowerCase(); //날짜 패턴
		var alarmListCount = $("#alarm_list li").length;  //alarm li count
		
		if (severity_id == 0) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm ind"); //색상 class
		if (severity_id == 1) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm cr"); //색상 class
		if (severity_id == 2) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm ma"); //색상 class
		if (severity_id == 3) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm mi"); //색상 class
		if (severity_id == 4) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm nor"); //색상 class
		if (severity_id == 6) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm wa"); //색상 class
		if (severity_id == 7) $("#alarm_popup .popup_sys .info > div:first").removeClass().addClass("alarm cl"); //색상 class
		
		$("#alarm_popup .popup_sys .info .cau").html(severity_name);
		$("#alarm_popup .popup_sys .info .sys_ttl > p").html("["+pkg_name+"]");
		$("#alarm_popup .popup_sys .info .sys_ttl > span").html(node_name);
		
		$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(1) > td").html(dateFormat(prc_date, lowerCase + " HH:MM:ss"));
		$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(2) > td").html(alias_code);
		$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(3) > td").html(alarm_group);
		$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(4) > td").html(probable_cause);
		$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(5) > td").html(location);
		$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(6) > td").html(target);
		$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(7) > td").html(value+" "+complement);
		$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(8) > td").html(node_version);
		$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(9) > td").html(node_type);
		$("#alarm_popup .popup_sys .info .con > table > tbody > tr:nth-child(10) > td").html(additional_text);
		
		var li = null;
		li = $("<li>");		
		li.append("<p>"+node_name+"</p>");						
		li.append("<span>"+alias_code+"</span>");
		li.append("<span style='display:none;'>"+severity_name+"</span>");
		li.append("<span style='display:none;'>"+alarm_group+"</span>");
		li.append("<span style='display:none;'>"+pkg_name+"</span>");
		li.append("<span style='display:none;'>"+probable_cause+"</span>");
		li.append("<span style='display:none;'>"+location+"</span>");
		li.append("<span style='display:none;'>"+target+"</span>");
		li.append("<span style='display:none;'>"+value+" "+complement+"</span>");
		li.append("<span style='display:none;'>"+additional_text+"</span>");
		li.append("<span style='display:none;'>"+node_version+"</span>");
		li.append("<span style='display:none;'>"+node_type+"</span>");
		
		li.append("<span style='display:none;'>"+dateFormat(prc_date, lowerCase + " HH:MM:ss")+"</span>");
		li.append("<span style='display:none;'>"+severity_id+"</span>");
		
		li.append("</li>");
		
		$("#alarm_list").prepend(li);
				
		$("#alarm_list > li").removeClass("select");
		
		if (data.severity_id == 0) $("#alarm_list li:first-child").addClass("ind select"); //색상 class
		if (data.severity_id == 1) $("#alarm_list li:first-child").addClass("cr select"); //색상 class
		if (data.severity_id == 2) $("#alarm_list li:first-child").addClass("ma select"); //색상 class
		if (data.severity_id == 3) $("#alarm_list li:first-child").addClass("mi select"); //색상 class
		if (data.severity_id == 4) $("#alarm_list li:first-child").addClass("nor select"); //색상 class
		if (data.severity_id == 6) $("#alarm_list li:first-child").addClass("wa select"); //색상 class
		if (data.severity_id == 7) $("#alarm_list li:first-child").addClass("cl select"); //색상 class
		
		if (alarmListCount >= 100) {  //100개 마지막부터 업앤다.
			$("#alarm_list_count").text(alarmListCount); //알람 개수
			$("#alarm_list li:last-child").remove();
		} else {
			$("#alarm_list_count").text(alarmListCount+1); //알람 개수
		}
		
		$("#alarm_popup").modal();
		
		fnInitializeAlarm(); //알람 조회
	}
	
	//alarm 전부 제거
	function fnAlarmListAllClose() {
		console.log("fnAlarmListAllClose");
		$.modal.close();
		$("#alarm_list").empty(); //calarm_modal.close 위로 가면 안지워짐...
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
	
	//####################################################
	//################### 기타 함수 #######################
	//####################################################
	
	var refreshId;
	/**
	 * 부모가 살아있는지 확인한다.
	 */
	function fnKeepAlive() {
		refreshId = setInterval(function() {
	 		try {
	 			var values = fnGetItemValue(storage_key_name);
	 			if ((values != null) && (values != "")) {
	 				var array = values.split(",");
					var length = array.length;
					if (length > 0) {
						var isAlive = false;
						for (var i=0; i < length; i++) {
							if (array[i] == "${titleName}") isAlive = true;	
						}
						if (!isAlive) window.close();
					}
	 			} else {
	 				window.close();
	 			}
	 			
	 			window.opener.name;  //부모창이름이 없으면 Exception 떨어짐
	 			
	 			clearInterval(refreshId);
		 		fnKeepAlive();			 	
		 		
	 		} catch(e) {
	 			console.log("catch(e) :" +e);
	 			fnRemoveItemValue("windows", "${titleName}"); //부모를 못찾아 창이 닫힐때 unload 이벤트 먹지않아 추가함.
	 			clearInterval(refreshId);
	 			window.close();
			} finally {					
			}
	 	}, 1 * 1000); //30초
	}
	
	$(window).unload(function() {
		fnRemoveItemValue("windows", "${titleName}");
	});
	
	//새로고침시 
	$(window).load(function() {
		fnAddItemValue("windows", "${titleName}"); 	
	});
//-->
</script>
<script>
      var g1, g2, g3, g4;

      window.onload = function(){
        var g1 = new JustGage({
          id: "g1",
          value: getRandomInt(0, 100),
          min: 0,
          max: 100,
        });

        var g2 = new JustGage({
          id: "g2",
          value: getRandomInt(0, 100),
          min: 0,
          max: 100,
        });

        var g3 = new JustGage({
          id: "g3",
          value: getRandomInt(0, 100),
          min: 0,
          max: 100,
        });

        var g4 = new JustGage({
          id: "g4",
          value: getRandomInt(0, 100),
          min: 0,
          max: 100,
        });

        setInterval(function() {
          g1.refresh(getRandomInt(50, 100));
          g2.refresh(getRandomInt(50, 100));
          g3.refresh(getRandomInt(0, 50));
          g4.refresh(getRandomInt(0, 50));
        }, 2500);
      };
      
      AmCharts.makeChart("chartdiv_pie",
    		  {
    		  "type": "pie",
    		  "startDuration": 0,
    		   "theme": "none",
    		  "addClassNames": true,
    		  "defs": {
    		    "filter": [{
    		      "id": "shadow",
    		      "width": "200%",
    		      "height": "200%",
    		      "feOffset": {
    		        "result": "offOut",
    		        "in": "SourceAlpha",
    		        "dx": 0,
    		        "dy": 0
    		      },
    		      "feGaussianBlur": {
    		        "result": "blurOut",
    		        "in": "offOut",
    		        "stdDeviation": 5
    		      },
    		      "feBlend": {
    		        "in": "SourceGraphic",
    		        "in2": "blurOut",
    		        "mode": "normal"
    		      }
    		    }]
    		  },
    		  "dataProvider": [{
    		    "country": "Lithuania",
    		    "litres": 501.9
    		  }, {
    		    "country": "Czech Republic",
    		    "litres": 301.9
    		  }, {
    		    "country": "Ireland",
    		    "litres": 201.1
    		  }, {
    		    "country": "Germany",
    		    "litres": 165.8
    		  }, {
    		    "country": "Australia",
    		    "litres": 139.9
    		  }, {
    		    "country": "Austria",
    		    "litres": 128.3
    		  }, {
    		    "country": "UK",
    		    "litres": 99
    		  }, {
    		    "country": "Belgium",
    		    "litres": 60
    		  }, {
    		    "country": "The Netherlands",
    		    "litres": 50
    		  }],
    		  "valueField": "litres",
    		  "titleField": "country",
    		  "export": {
    		    "enabled": true
    		  }
    		});
      
      function loadProcessDiagram(pkg_name, node_type) {
  		$(".m_submenu").toggleClass("on");
  		$(".sub_type").toggleClass("on");
  		$("#processDiagramDiv").html("");
  		$("#processDiagramExpansionDiv").html("");
  		setTimeout(function() {
  			var param = new Object();
  	  		param.pkg_name = pkg_name;
  	  		param.node_type= node_type;
  	  		$.ajax({
  	  			url: "listNodeSvc",
  	  			data: param,
  	  			type: 'POST',
  	  			dataType: 'json',
  	  			success: function(data) {
  	  				var svcList = data.svcList;
  	  				for (var i=0;i<svcList.length;i++) {
  	  					var svc = svcList[i];
  	  					var sHtml = "";
  	  					sHtml += "<div>";
  	  					sHtml += "<h6>Service<em>"+svc.svc_name+"</em></h6>";
  	  					sHtml += "<a href=\"javascript:toggleProcessDiagramExpansion('"+svc.pkg_name+"', '"+svc.node_type+"', '"+svc.svc_no+"', '"+svc.svc_name+"');\" title=\"Zoom\" class=\"zoom\">Zoom</a>";
  	  					sHtml += "<p>";
  	  					sHtml += "	<iframe id=\"processDiagramFrame_"+svc.svc_no+"\" name=\"processDiagramFrame_"+svc.svc_no+"\" src=\"processDiagram.ajax?pkg_name="+svc.pkg_name+"&node_type="+svc.node_type+"&svc_no="+svc.svc_no+"\" style=\"width:100%;height:100%;border:none;\"></iframe>";
  	  					sHtml += "</p>";
  	  					sHtml += "</div>";
  	  					$("#processDiagramDiv").append(sHtml);
  	  					
  	  					sHtml = "";
  	  					sHtml += "<div id=\"expansion_"+svc.svc_no+"\" class=\"sect_zoom obj"+(i+1)+"\"><h6>Service<em>"+svc.svc_name+"</em></h6><a href=\"javascript:toggleProcessDiagramExpansion('"+svc.pkg_name+"', '"+svc.node_type+"', '"+svc.svc_no+"', '"+svc.svc_name+"');\" class=\"back_sml\"><spring:message code="label.configuration.processmanager.allservices.text"/></a>";
  	  					sHtml += "	<p style=\"height:80%;\">";
  	  					// sHtml += "		<iframe id=\"expansionProcessDiagramFrame_"+svc.svc_name+"\" name=\"expansionProcessDiagramFrame_"+svc.svc_name+"\" src=\"processDiagram.ajax?pkg_name="+svc.pkg_name+"&node_type="+svc.node_type+"&svc_no="+svc.svc_no+"\" style=\"width:100%;height:100%;border:none;\"></iframe>";
  	  					sHtml += "</p>";
  	  					sHtml += "	<dl class=\"sect_info\">";
  	  					sHtml += "		<dt><spring:message code="label.configuration.processmanager.total.text"/></dt><dd id=\"totalCount\">-</dd>";
  	  					sHtml += "		<dt><spring:message code="label.configuration.processmanager.run.text"/></dt><dd class=\"run\">-</dd>";
  	  					sHtml += "		<dt><spring:message code="label.configuration.processmanager.stop.text"/></dt><dd class=\"stop\">-</dd>";
  	  					sHtml += "		<dt><spring:message code="label.configuration.processmanager.abnormal.text"/></dt><dd class=\"abnormal\">-</dd>";
  	  					sHtml += "	</dl>";
  	  					sHtml += "</div>";
  	  					$("#processDiagramExpansionDiv").append(sHtml);
  	  				}
  	  			},
  	  			error: function(e) {
  	  				var error = JSON.parse(e.responseText);
  	  				openAlertModal(error.errorMsg.cause.localizedMessage);
  	  			},
  	  			complete: function() {
  	  			}
  	  		});
  		}, 700);
  	}
      
	function toggleProcessDiagramExpansion(pkg_name, node_type, svc_no, svc_name) {
		$("#expansion_"+svc_no).toggleClass("on");
		var sHtml = "<iframe id=\"expansionProcessDiagramFrame_"+svc_no+"\" name=\"expansionProcessDiagramFrame_"+svc_no+"\" src=\"processDiagram.ajax?pkg_name="+pkg_name+"&node_type="+node_type+"&svc_no="+svc_no+"\" style=\"width:100%;height:100%;border:none;\"></iframe>";
		setTimeout(function() {
			$("#expansion_"+svc_no+">p").html(sHtml);
		}, 200);
	}
    </script>
</head>
<body>

<nav id="ml-menu" class="menu"></nav>

<div class="wrap monitoring">
    <div class="m_header"><div class="m_logo">ATOM Monitoring</div>
    	<div class="m_submenu"><!-- 서브 탭메뉴 등장하려면 on 클래스 추가-->
            <div class="default search_area location">
                <button type="button" class="back" title="Back">Back</button>
                <div class="select_single">
                    <select class="single">
                        <option value="Select" selected>OFCS01</option>
                        <option value="01">Code</option>
                        <option value="02">Severity</option>
                    </select>
                </div>
            </div>
            <div class="tab">
                <ul>
                    <li><a href="#" class="tab1 on">Process Flow</a></li><!-- tab1 ~ 8 까지 클릭하면 해당하는 div가 보이도록 구현 / 현재 선택된 탭에는 on 클래스 추가 / 상태별 클래스는 3단계 critical major minor-->
                    <li><a href="#" class="tab2">Temperature</a></li>
                    <li><a href="#" class="tab3 critical">CPU</a></li>
                    <li><a href="#" class="tab4 major">Disk</a></li>
                    <li><a href="#" class="tab5 minor">Memory</a></li>
                    <li><a href="#" class="tab6">Queue</a></li>
                    <li><a href="#" class="tab7">Tablespace</a></li>
                    <li><a href="#" class="tab8 major">NIC</a></li>
                </ul>
            </div>
        </div>
        <!--// m_submenu -->  
          
        <ul class="m_util">
             <li class="util1 dropdown">
                 <a href="#" title="ATOM Info"><span>ATOM Info</span></a>
                       <ul class="dropdown_content">
                             <h6>ATOM System Information</h6>
                             <li>
                                <div class="pie_graph">
                                  <span class="pie devchart1" data-percent="10"><span class="percent"></span></span>
                                  <p>CPU<span>1.22GHz</span></p>
                                </div>
                             </li>
                             <li>
                                <div class="pie_graph">
                                  <span class="pie devchart2" data-percent="100"><span class="percent"></span></span>
                                  <p>Memory<span>4.0 / 7.9GB</span></p>
                                </div>
                             </li>
                             <li>
                                <div class="pie_graph">
                                  <span class="pie devchart3" data-percent="96"><span class="percent"></span></span>
                                  <p>Disk<span>16,134 / 76.537MB</span></p>
                                </div>
                             </li>
                             <li>
                                <div class="pie_graph">
                                  <span class="pie devchart4" data-percent="30"><span class="percent"></span></span>
                                  <p>Tablespace<span>34.04 / 34.80G</span></p>
                                </div>
                             </li>
                             <li>
                                <div class="status_info">
                                  <span class="status_type1 normal">Network</span> <!--class : normal,abnormal--> 
                                  <p>Network<span class="nor">Normal</span></p> <!--class : nor,abnor-->
                                </div>
                             </li>
                             <li>
                                <div class="status_info">
                                  <span class="status_type2 abnormal">Process</span> <!--class : normal,abnormal-->
                                  <p>Process<span class="abnor">Abnormal</span></p> <!--class : nor,abnor-->
                                </div>
                             </li>
                       </ul>
             </li>
             <li class="util2 dropdown">
                 <a href="#" title="Resources"><span>Resources</span></a>
                       <ul class="dropdown_content">
                             <h6>Resources Usage TOP5</h6>
                             <div id="atom_resource">
                             <!-- <li>CPU
                                <ol>
                                  <li>node name 01</li>
                                  <li>node name name name name 02</li>
                                  <li>node03</li>
                                  <li>nodenamename04</li>
                                  <li>node name 05</li>
                                </ol>
                                <div id="chart_colum1"></div>
                             </li>
                             <li>Memory
                                <ol>
                                  <li>node name 01</li>
                                  <li>node name 02</li>
                                  <li>node03</li>
                                  <li>node name 04</li>
                                  <li>node name 05</li>
                                </ol>
                                <div id="chart_colum2"></div>
                             </li>
                             <li>Disk
                                <ol>
                                  <li>node name 01</li>
                                  <li>node name 02</li>
                                  <li>node03</li>
                                  <li>node name 04</li>
                                  <li>node name 05</li>
                                </ol>
                                <div id="chart_colum3"></div>
                             </li>
                             <li>Tablespace
                                <ol>
                                  <li>node name 01</li>
                                  <li>node name 02</li>
                                  <li>node03</li>
                                  <li>node name 04</li>
                                  <li>node name 05</li>
                                </ol>
                                <div id="chart_colum4"></div>
                             </li> -->
                             </div>
                       </ul>
             </li>
             <li class="util3"><a href="#" title="Batch"><span>Batch</span></a></li>
             <!-- <li class="util4"><a href="#" title="Refresh"><span>Refresh</span></a></li> -->
        </ul>
         <div class="legend dropdown"><a href="#"><span>Legend</span></a>
               <ul class="dropdown_content">
                     <li>Running</li>
                     <li>Suspend</li>
                     <li>Scale</li>
                     <li>Stopped</li>
                     <li>Abnormal</li>
                     <li>Unknown</li>
               </ul> 
         </div>
    </div>
    <!--// header --> 
    <div class="sub_body">
        <div class="tree_wrap"><!-- on클래스 추가하면 접혔다 펼쳤다-->
               <div class="filter">
                     <div class="common">
                           <p class="search"><input type="text" id="treeSearch" name="txtbox" placeholder="<spring:message code="label.common.search"/>"/><button type="button" title="<spring:message code="label.common.search"/>" class="srh">Search</button></p>
                     </div>
               </div>
               <!--// filter -->
               <div>
                    <div id="jstree" class="tree" ></div>
                    
                    <button type="button" class="folding" title="Tree">Tree</button><!-- folding 클릭시 tree_wrap 에 on 추가됨-->
               </div>
               <!--// tree --> 
        </div>  
         <!--// tree_wrap -->   
           
        <div class="sub_content change">
        <!-- <div class="main_content" id="network_diagram"> -->
         	<iframe id="networkDiagramFrame" name="networkDiagramFrame" src="networkDiagram.ajax" style="width:100%;height:100%;border:none;"></iframe>
            
            <div class="sub_type" style="width:100%;">
                <div class="total_chart">
                    <div><h5>Average CPU(%)</h5><div id="g1"></div></div>
                    <div><h5>Top CPU Temperature(℃)</h5><div id="g2"></div></div>
                    <div><h5>Top Disk(%)</h5><div id="g3"></div></div>
                    <div><h5>Total Memory(%)</h5><div id="g4"></div></div>
                </div>
             
                <div id="processDiagramDiv" class="sect type1">
                    <!-- <div><h6>Service<em>EPC</em></h6><a href="#" title="Zoom" class="zoom z1">Zoom</a><p><img src="/images/sample1.png" /></p></div>z1 클릭 obj1
                    <div><h6>Service<em>IMS</em></h6><a href="#" title="Zoom" class="zoom z2">Zoom</a><p><img src="/images/sample1.png" /></p></div>z2 클릭 obj2
                    <div><h6>Service<em>SMS</em></h6><a href="#" title="Zoom" class="zoom z3">Zoom</a><p><img src="/images/sample1.png" /></p></div>z3 클릭 obj3
                    <div><h6>Service<em>ORN-SMS</em></h6><a href="#" title="Zoom" class="zoom z4">Zoom</a><p><img src="/images/sample1.png" /></p></div>z4 클릭 obj4 -->           
                </div>
                <div id="processDiagramExpansionDiv">
                	<!-- 확대 보기 obj1/obj2/obj3/obj4 로 구분-->
	                <div class="sect_zoom obj1"><h6>Service<em>EPC</em></h6><a href="#" class="back_sml">All Services</a>
	                    <p><img src="/images/sample2.png" /></p>
	                    <dl class="sect_info">
	                        <dt>Total</dt><dd>190</dd>
	                        <dt>Run</dt><dd class="run">150</dd>
	                        <dt>Stop</dt><dd class="stop">5</dd>
	                        <dt>Abnormal</dt><dd class="abnormal">35</dd>
	                    </dl>
	                </div>
	                <div class="sect_zoom obj2"><h6>Service<em>IMS</em></h6><a href="#" class="back_sml">All Services</a>
	                    <p><img src="/images/sample2.png" /></p>
	                    <dl class="sect_info">
	                        <dt>Total</dt><dd>190</dd>
	                        <dt>Run</dt><dd class="run">150</dd>
	                        <dt>Stop</dt><dd class="stop">5</dd>
	                        <dt>Abnormal</dt><dd class="abnormal">35</dd>
	                    </dl>
	                </div>                
	                <div class="sect_zoom obj3"><h6>Service<em>SMS</em></h6><a href="#" class="back_sml">All Services</a>
	                    <p><img src="/images/sample2.png" /></p>
	                    <dl class="sect_info">
	                        <dt>Total</dt><dd>190</dd>
	                        <dt>Run</dt><dd class="run">150</dd>
	                        <dt>Stop</dt><dd class="stop">5</dd>
	                        <dt>Abnormal</dt><dd class="abnormal">35</dd>
	                    </dl>
	                </div>
	                <div class="sect_zoom obj4"><h6>Service<em>ORN-SMS</em></h6><a href="#" class="back_sml">All Services</a>
	                    <p><img src="/images/sample2.png" /></p>
	                    <dl class="sect_info">
	                        <dt>Total</dt><dd>190</dd>
	                        <dt>Run</dt><dd class="run">150</dd>
	                        <dt>Stop</dt><dd class="stop">5</dd>
	                        <dt>Abnormal</dt><dd class="abnormal">35</dd>
	                    </dl>
	                </div>
                </div>
                             
                <span id="nodeResourceInfo"></span>
                
            </div>
            <!--// sub_type -->
         
        </div>
        <!--// sub_content --> 
    </div>
    <!--// sub_body-->
    
    <!-- ############################# 알람 창 UI ############################################ -->
    
    <form id="checkAlarmForm" name="checkAlarmForm" method="post"> <!-- 폼이 알람 UI 바깥에 있어야 한다. 안그럼  창확대 addclass:on UI가 깨짐 -->
   
	<c:forEach items="${authorizationPackage}" var="i" varStatus="status">
		<c:set var="arrayPackage" value="${arrayPackage}${i.PKG_NAME},"/>
	</c:forEach>
	<input type="hidden" name="packageName" value="${arrayPackage}" /><!-- 패키지 권한 -->
    <div class="sub_bottom"> <!--// 창확대 addclass:on -->
    
            <div class="alarm_adjustment">
                <div class="select_single common">
                    <select class="single" id="search_type" name="search_type">
                        <option value="1">Package</option>
                        <option value="2">Node Name</option>
                        <option value="3">Code</option>
                        <option value="4">Severity</option>
                    </select>
                </div>
                <div class="common">
                    <p class="search"><input type="text" name="search" placeholder="<spring:message code="label.common.search"/>"/>
                    	<button type="button" id="btn_search" title="<spring:message code="label.common.search"/>" class="srh">Search</button>
                    	<button type="button" id="btn_reset" title="Reset" class="reset">Reset</button>
                    </p>
                </div>
                <div class="table_info_group1">
                    <div class="paging">
                        <ul>
                            <!-- <li><a href="javascript:fnPageMove('first');" class="first hidden"><span class="hidden">First</span></a></li> --><!--hidden 처리-->
                            <li><a href="javascript:fnPageMove('first');" class="first"><span class="hidden">First</span></a></li>
                            <li><a href="javascript:fnPageMove('before');" class="before"><span class="hidden">Before</span></a></li>
                            <li><input type="text" name="page" value="1" readonly />/ <span id="last_page">1</span></li>
                            <li><a href="javascript:fnPageMove('next');" class="next"><span class="hidden">Next</span></a></li>
                            <li><a href="javascript:fnPageMove('last');" class="last"><span class="hidden">Last</span></a></li>
                        </ul>
                    </div>
                    <div class="count">
                     <span><spring:message code="label.monitor.total.count"/>: <em id="alarm_totalcount">0</em></span><p class="count1" id="critical_count">0</p><p class="count2" id="major_count">0</p><p class="count3" id="minor_count">0</p><p class="count4" id="warning_count">0</p>
                    </div>
                    <div class="button">
                        <button type="button" id="btn_ack" title="Ack"><spring:message code="label.monitor.ack"/></button>
                        <button type="button" id="btn_unack" title="Ack"><spring:message code="label.monitor.unack"/></button>
                        <button type="button" id="btn_clear" title="Clear"><spring:message code="label.monitor.clear"/></button>
                    </div>
                </div>
                <div class="table_info_group2">
                        <!-- <button type="button" title="가청 알람" class="icon1 act">가청 알람</button> --><!-- 기능 눌렸을 때 "act" class 추가 -->
                        <button type="button" id="btn_viewOff" title="<spring:message code="label.monitor.view.off"/>" class="icon2 act" style="display:none;">가시 알람</button>
                        <button type="button" id="btn_viewOn" title="<spring:message code="label.monitor.view.on"/>" class="icon2">가시 알람</button>
                        <button type="button" id="btn_soundOff" title="<spring:message code="label.monitor.sound.off"/>" class="icon3 act" style="display:none;">소리</button>
                        <button type="button" id="btn_soundOn" title="<spring:message code="label.monitor.sound.on"/>" class="icon3">소리</button>
                        <button type="button" id="btn_playOff" title="<spring:message code="label.monitor.play.off"/>" class="icon4">정지</button>
                        <button type="button" id="btn_playOn" title="<spring:message code="label.monitor.play.on"/>" class="icon4 act" style="display:none;">정지</button>
                </div>
                <div class="table_info_group3">
                        <button type="button" id="btn_export" title="<spring:message code="label.common.excel.text"/>" class="icon5">Excel</button>
                        <button type="button" id="btn_moreDown" title="<spring:message code="label.monitor.more"/>" class="icon6 act">더 보기</button>
                        <button type="button" id="btn_moreUp" title="" class="icon6" style="display:none;">더 보기</button>
                </div>                
            </div>
            <!--// alarm adjustment -->
            
            <div class="data">
                <table class="tbl_list type2">
                    <colgroup>
                        <col />
                        <col />
                        <col width="10%"/>
                        <col />
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="*"/>
                        <col width="10%"/>                    
                        <col width="13%"/>
                        <col />
                        <col width="10px">
                    </colgroup>
                    <thead>
                        <tr>
                            <th class="chk"><input type="checkbox" id="chk_list" name="chk_list" value="" onclick="selectAll()"><label for="chk_list">check</label></th>
                            <th class="ok"><spring:message code="label.monitor.ack"/></th>
                            <th><spring:message code="label.monitor.node"/></th>
                            <th class="date sort"><spring:message code="label.monitor.process.date"/></th>
                            <th><spring:message code="label.monitor.alarm.code"/></th>
                            <th><spring:message code="label.monitor.alarm.type"/></th>
                            <th class="sort"><spring:message code="label.snmp.info.severity"/></th>                            
                            <th><spring:message code="label.monitor.probable.cause"/></th>
                            <th><spring:message code="label.monitor.target"/></th>
                            <th><spring:message code="label.monitor.value"/></th>
                            <th class="ico"><spring:message code="label.monitor.detail"/></th>
                            <th></th>
                        </tr>
                    </thead>
                </table>
                <div class="scroll table hover_event scroll-type3">
                    <table class="tbl_list type2">
                        <colgroup>
                            <col />
                            <col />
                            <col width="10%"/>
                            <col />
                            <col width="10%"/>
                            <col width="10%"/>
                            <col width="10%"/>
                            <col width="*"/>
                            <col width="10%"/>                    
                            <col width="13%"/>
                            <col />
                        </colgroup>
                        <tbody id="alarmList">
                            
                        </tbody>
                    </table>
                </div>
           </div>
    
    </div>
    </form>
    <!--// sub_bottom-->
</div>
<!--// wrap --> 
<script>
    /* process zoom */
	$(".z1").click(function(){
			$(".obj1").toggleClass("on");
			return false;
	});
	$(".z2").click(function(){
			$(".obj2").toggleClass("on");
			return false;
	});	
	$(".z3").click(function(){
			$(".obj3").toggleClass("on");
			return false;
	});	
	$(".z4").click(function(){
			$(".obj4").toggleClass("on");
			return false;
	});			
	$(".back_sml").click(function(){
			$(".obj1").removeClass("on");
			$(".obj2").removeClass("on");
			$(".obj3").removeClass("on");
			$(".obj4").removeClass("on");
			return false;
	});	
	
	/* sub page */
	$(".m_logo, button.back").click(function(){ /*.m_logo를 노드 클릭으로 변경해야 합니다.*/
			$(".m_submenu").toggleClass("on");/* sub menu */
			$(".sub_type").toggleClass("on");
			
// 			console.log( "[mirinae.maru] sub_type : " + $(".sub_type").hasClass("on") );
// 			if( $(".sub_type").hasClass("on") ) {
// 				requestNodeResourceInfo();
// 			}

			// 노드 상세정보 전송 중지요청(monitoring.js)
			stopNodeResourceInfo();
			
			return false;
	});	
	
	
	/* tab */
	$(".tab2").click(function(){ /*.tab 클릭시 sect type2의 page2~8 까지 호출*/
		
		console.log( "[mirinae.maru] Temperature tab clicked..." );
		
		$(".tab1, .tab2, .tab3, .tab4, .tab5, .tab6, .tab7, .tab8").removeClass("on");
		$(".sect.type2.page1, .sect.type2.page2, .sect.type2.page3, .sect.type2.page4, .sect.type2.page5, .sect.type2.page6, .sect.type2.page7, .sect.type2.page8").removeClass("on");
		$(".tab2, .sect.type2.page2").addClass("on");
		
		return false;
	});	
	$(".tab3").click(function(){ 
		
		console.log( "[mirinae.maru] CPU tab clicked..." );
		
		$(".tab1, .tab2, .tab3, .tab4, .tab5, .tab6, .tab7, .tab8").removeClass("on");
		$(".sect.type2.page1, .sect.type2.page2, .sect.type2.page3, .sect.type2.page4, .sect.type2.page5, .sect.type2.page6, .sect.type2.page7, .sect.type2.page8").removeClass("on");
		$(".tab3, .sect.type2.page3").addClass("on");
		
		return false;
	});		
	$(".tab4").click(function(){ 
		
		console.log( "[mirinae.maru] Disk tab clicked..." );
		
		$(".tab1, .tab2, .tab3, .tab4, .tab5, .tab6, .tab7, .tab8").removeClass("on");
		$(".sect.type2.page1, .sect.type2.page2, .sect.type2.page3, .sect.type2.page4, .sect.type2.page5, .sect.type2.page6, .sect.type2.page7, .sect.type2.page8").removeClass("on");
		$(".tab4, .sect.type2.page4").addClass("on");
		
		return false;
	});		
	$(".tab5").click(function(){ 
		
		console.log( "[mirinae.maru] Memory tab clicked..." );
		
		$(".tab1, .tab2, .tab3, .tab4, .tab5, .tab6, .tab7, .tab8").removeClass("on");
		$(".sect.type2.page1, .sect.type2.page2, .sect.type2.page3, .sect.type2.page4, .sect.type2.page5, .sect.type2.page6, .sect.type2.page7, .sect.type2.page8").removeClass("on");
		$(".tab5, .sect.type2.page5").addClass("on");
		
		return false;
	});	
	$(".tab6").click(function(){ 
		
		console.log( "[mirinae.maru] Queue tab clicked..." );
		
		$(".tab1, .tab2, .tab3, .tab4, .tab5, .tab6, .tab7, .tab8").removeClass("on");
		$(".sect.type2.page1, .sect.type2.page2, .sect.type2.page3, .sect.type2.page4, .sect.type2.page5, .sect.type2.page6, .sect.type2.page7, .sect.type2.page8").removeClass("on");
		$(".tab6, .sect.type2.page6").addClass("on");
		
		return false;
	});		
	$(".tab7").click(function(){ 
		
		console.log( "[mirinae.maru] Tablespace tab clicked..." );
		
		$(".tab1, .tab2, .tab3, .tab4, .tab5, .tab6, .tab7, .tab8").removeClass("on");
		$(".sect.type2.page1, .sect.type2.page2, .sect.type2.page3, .sect.type2.page4, .sect.type2.page5, .sect.type2.page6, .sect.type2.page7, .sect.type2.page8").removeClass("on");
		$(".tab7, .sect.type2.page7").addClass("on");
		
		return false;
	});		
	$(".tab8").click(function(){ 
		
		console.log( "[mirinae.maru] NIC tab clicked..." );
		
		$(".tab1, .tab2, .tab3, .tab4, .tab5, .tab6, .tab7, .tab8").removeClass("on");
		$(".sect.type2.page1, .sect.type2.page2, .sect.type2.page3, .sect.type2.page4, .sect.type2.page5, .sect.type2.page6, .sect.type2.page7, .sect.type2.page8").removeClass("on");
		$(".tab8, .sect.type2.page8").addClass("on");
		
		return false;
	});		
	/* tree */

	$(document).ready(function(){
			$(".tree_wrap").addClass("on");
	});
	
	$(".folding").click(function(){ /*.folding 버튼 클릭시 트리메뉴 왼쪽으로 들어가고, ub_content 레이아웃도 같이 움직임*/
		
		$("iframe").each(function() {
			$(this).get(0).contentWindow.g_bResizeProc = false;
		});
		setTimeout(function() {
			$("iframe").each(function() {
				$(this).get(0).contentWindow.g_bResizeProc = true;
				$(this).get(0).contentWindow.onResizeWindow();
			});
		}, 500);
	
		$(".tree_wrap").toggleClass("on");
		
		if($('.tree_wrap').hasClass('on')){
				$('.sub_content').addClass('change');
		  }
		else{
		        $('.sub_content').removeClass('change');
		  }			
	});	

	
</script>

<script src="/scripts/jquery.tmpl.min.js"></script>
<script src="/scripts/monitoring.js"></script>
<jsp:include page="/WEB-INF/views/atom/monitor/tmpl.jsp" flush="false" />

<!-- Level 오디오 -->
<c:forEach items="${audioSeveritySound}" var="i" varStatus="status">
	<audio id="level_${i.NAME}" src="/audio/errorlevel_en/${i.NAME}.wav">HTML5 audio not supported</audio>
</c:forEach>

<!-- 알람 팝업 -->
<div id="alarm_popup">
  <div class="popup_sys">
    <div><a class="close_type2" href="javascript:fnAlarmListAllClose();">&times;</a></div>
    <div class="stats">ALARM : <span id="alarm_list_count">0</span></div>
    <div class="info">
      <h2>Alarm Infomation</h2>
      <div class="alarm nor"> <!--Severity add class : cr, ma, mi, wa, cl, nor, ind -->
        <div class="cau">2</div>
        <div class="sys_ttl">
          <p>1</p>
          <span>1</span> 
        </div>
      </div>
      <div class="con">
        <table>
          <colgroup>
          <col width="33.5%">
          <col width="*">
          </colgroup>
          <tbody>
            <tr>
              <th><spring:message code="label.monitor.process.date"/></th>
              <td></td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.alarm.code"/></th>
              <td>900101</td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.alarm.type"/></th>
              <td>Communications</td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.probable.cause"/></th>
              <td>NOTI-DIM_CONNECTED_FROM_NODE</td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.location"/></th>
              <td>/IMS/IMS_DIM_CO01/CSCF02</td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.target"/></th>
              <td>SMS_INC_DT01</td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.value"/></th>
              <td><span class="per">85.5%</span></td>
            </tr>
            <tr>
              <th>Node Version</th>
              <td>Yes</td>
            </tr>
            <tr>
              <th>Node Type</th>
              <td>Yes</td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.additional.message"/></th>
              <td>Message text Message text Message text</td>
            </tr>
            <tr>
              <th></th>
              <td></td>
            </tr>
          </tbody>
        </table>
      </div>
      <!-- button -->
      <div class="btn_area"> <a href="#">
        <button type="button" id="alarm_confirm">확인</button>
        </a> </div>
    </div>
    
    <!-- alarm list -->
    <div class="alarm_list">
      <ul id="alarm_list">   
      	
      </ul>
    </div>
  </div>
</div>

<!-- disconnect Server -->
<div id="disconnect_popup">
 	<div class="disconnect">
    	<div class="loading_page red"><i></i><i></i></div>  
    	<h4>Disconnect Server</h4>
    	<p>
      		<spring:message code="msg.monitor.disconnect"/>
    	</p>
    </div>
</div>
</body>
</html>




