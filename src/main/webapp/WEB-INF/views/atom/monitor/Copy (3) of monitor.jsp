<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html lang="en_US">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Monitoring</title>
<!--[if lt IE 9]>
	<script src="../scripts/html5.js"></script>
<![endif]-->

<link rel="stylesheet" href="/styles/style.css">
<link rel="stylesheet" href="/scripts/tree/themes/default/style.min.css">
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
        
<script src="/scripts/jwebsocket/1_0_b1/jWebSocket.js"></script>
<script src="/scripts/jwebsocket/pfnmWebSocket.js"></script>

<script type="text/javascript">

<!--
	//websocket setting
	var socketUrl = "${pageContext.servletContext.getAttribute('websocket.connect.url')}";
	
	//initPage(socketUrl, "monitor");
	
	//오디오 변수
	var audio1;
	var audio2;
	var audio3;
	
	var isAlarmSoundReload = true; //알람 사운드 ON & OFF
	
	$(document).ready(function() {
		//로그인 tiles layout 같이 쓰므로 타이틀 변경해야함
		//this.title = 'Monitoring';
		
		$(this).contextmenu(function(e) {
			return false;
		});
		
		
		//최초 한번만 실행
		setTimeout(function() { 
			fnInitializeTree();
			fnInitializeAlarm();
			fnSeverityCount();
			fnInitializeNode();
			//fnIntervalAlarmSound(); //사운드는 반복
			fnKeepAlive();			
		}, 1000);
		
		
		/**
		 * sound 버튼 ON 클릭시
		 */
		$("#btn_soundOn").click(function() {
			//console.log("on");
			isAlarmSoundReload = false;
			//$("#btn_soundOn").hide();
			//$("#btn_soundOff").show();
			//$("#alarm_sound_text").text("Off");	
		});
		
		/**
		 * sound 버튼 OFF 클릭시
		 */
		$("#btn_soundOff").click(function() {
			//console.log("off");
			isAlarmSoundReload = true;
			//$("#btn_soundOn").show();
			//$("#btn_soundOff").hide();	
			//$("#alarm_sound_text").text("On");	
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
		
		$("#jstree").bind("loaded.jstree", function (event, data) {
            $(this).jstree("open_all"); //기본으로 펼친다.
        });
	}
	
	/**
	 * 트리 오른쪽 메뉴 
	 */
	function fnCustomMenu(node) {
		console.log(node.id);
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
		if (node.id == 1)  return items;
	}
	
	/**
	 * 트리 열기
	 */
	function fnExpandAll() {
		$('#jstree').jstree('open_all');
	}
	
	/**
	 * 트리 닫기
	 */
	function fnCollapseAll() {
		$('#jstree').jstree('close_all');
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
			$("#alarmList").html(data);
			
			fnSeverityCount();
		});
		
		result.fail(function(xhr, status) {
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
		var warning_count = $("input[name=warning_count]").attr("value");
		
		$("#critical_count").text(critical_count);
		$("#major_count").text(major_count);
		$("#minor_count").text(minor_count);
		$("#warning_count").text(warning_count);
		
		//알람 총 카운터
		var alarm_totalcount = $("input[name=alarm_totalcount]").attr("value");
		$("#alarm_totalcount").text(alarm_totalcount);
		
		//마지막 페이지
		var lastPage = $("input[name=lastPage]").attr("value");
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
	
	/**
	 * 사운드 실행후 이벤트 발생
	 */
	/* function initEvent() {
		//console.log("file_flag==>"+file_flag);
		try {		
			
			audio1.addEventListener("ended", function() { //사운드 끝나면
				audio2.play();
			}, false);

			audio2.addEventListener("ended", function() { //사운드 끝나면
				audio3.play();	
			}, false);
			
		} catch(e) {
			if (window.console && console.error("Error:" + e));
		} finally {}
	} */
	
	
	//####################################################
	//################### 웹소켓 함수 #####################
	//####################################################
	
	/**
     * 웹소켓 로그인 성공시 호출
     */
	function fnPreparedSocket() {
		console.log("웹소켓 연결 성공...");
		fnLoadingTry(false);
	}
	
	/**
	 * 알람 메세지가 ##트리## 다시 읽어라고 오면 다시 시도
	 */
	function fnMessageInitTree() {
		fnInitializeTree();
	}
	
	/**
	 * 알람 메세지가 ##노드## 다시 읽어라고 오면 다시 시도
	 */
	function fnMessageInitNode() {
		fnInitializeNode();
	}
	
	/**
	 * 알람 메세지가 ##알람## 다시 읽어라고 오면 다시 시도
	 */
	function fnMessageInitAlarm() {
		fnInitializeAlarm();
	}
	
	/**
	 * 트리 상태를 갱신하여 표기한다.
	 */
	function fnMessageTreeStatus() {
		$("#jstree").jstree(true).set_icon(1, "/scripts/tree/themes/skin/pkg_blue.gif");
	}
	
	/**
	 * 웹소켓 접속 종료됨
	 */ 
	function fnDisconnectSocket() {
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
			
		} else { //뱅글뱅글 돌기 화면 업애기
			
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
			return false;
	});	
	
	/* tab */
	$(".tab2").click(function(){ /*.tab 클릭시 sect type2의 page2~8 까지 호출*/
			$(".sect.type2.page2").toggleClass("on");
			return false;
	});	
	$(".tab3").click(function(){ 
			$(".sect.type2.page3").toggleClass("on");
			return false;
	});		
	$(".tab4").click(function(){ 
			$(".sect.type2.page4").toggleClass("on");
			return false;
	});		
	$(".tab5").click(function(){ 
			$(".sect.type2.page5").toggleClass("on");
			return false;
	});	
	$(".tab6").click(function(){ 
			$(".sect.type2.page6").toggleClass("on");
			return false;
	});		
	$(".tab7").click(function(){ 
			$(".sect.type2.page7").toggleClass("on");
			return false;
	});		
	$(".tab8").click(function(){ 
			$(".sect.type2.page8").toggleClass("on");
			return false;
	});		
	
</script>

</head>
<body>
<div class="wrap monitoring">
    <div class="m_header"><div class="m_logo">ATOM Monitoring</div>
    	
    	<!-- ############## 상세 화면 ####################### -->
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
        <!-- ############## 상세 화면 ####################### -->
        
        
        
        <ul class="m_util">
             <li class="util1 dropdown">
                 <a href="#" title="ATOM Info"><span>ATOM Info</span></a>
                       <ul class="dropdown_content">
                             <h6>ATOM System Information</h6>
                             <li>
                                <div class="pie_graph">
                                  <span class="pie devchart1" data-percent="01"><span class="percent"></span></span>
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
                             <li>CPU
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
                             </li>
                       </ul>
             </li>
             <li class="util3"><a href="#" title="Settings"><span>Settings</span></a></li>
             <li class="util4"><a href="#" title="Refresh"><span>Refresh</span></a></li>
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
        <div class="tree_wrap">
               <div class="filter">
                     <div class="common">
                           <p class="search"><input type="text" id="treeSearch" name="Search" placeholder="Search"/><button type="button" title="Search" class="srh">Search</button></p>
                     </div>
               </div>
               <!--// filter -->
              <!--  <a href="#" class="tree_show_hide">Tree</a>
               <a href="javascript:expandAll();">tree expends all</a>
               <a href="javascript:collapseAll();">tree Collapse All</a>  --> 
               <div id="jstree" class="tree jstree jstree-1 jstree-default jstree-closed">

               </div>
               <!--// tree --> 
        </div>  
         <!--// tree_wrap -->   
           
        <div class="sub_content">
        	<div id="network_diagram" class="sub_content"></div>
        </div>
        <!--// sub_content --> 
    </div>
    <!--// sub_body-->
    
    <div class="sub_bottom"> <!--// 창확대 addclass:on -->
    	<form id="checkAlarmForm" name="checkAlarmForm" method="post">
            <div class="alarm_adjustment">
                <div class="select_single common">
                    <select class="single" name="search_type" id="search_type">
                        <option value="all">All</option>
                        <option value="1"><spring:message code="label.monitor.node"/></option>
                        <option value="2"><spring:message code="label.monitor.alarm.code"/></option>
                        <option value="3"><spring:message code="label.snmp.info.severity"/></option>
                    </select>
                </div>
                <div class="common">
                    <p class="search"><input type="text" name="search" placeholder="<spring:message code="label.common.search"/>"/><button type="button" title="<spring:message code="label.common.search"/>" class="srh"><spring:message code="label.common.search"/></button></p>
                </div>
                <div class="table_info_group1">
                    <div class="paging">
                        <ul>
                            <li><a href="javascript:fnPageMove('first')" class="first"><span class="hidden">First</span></a></li>
                            <li><a href="javascript:fnPageMove('before')" class="before"><span class="hidden">Before</span></a></li>
                            <li><input type="text" name="page" value="1" />/ <span id="last_page">1</span></li>
                            <li><a href="javascript:fnPageMove('next')" class="next"><span class="hidden">Next</span></a></li>
                            <li><a href="javascript:fnPageMove('last')" class="last"><span class="hidden">Last</span></a></li>
                        </ul>
                    </div>
                    <div class="count">
                     <span><spring:message code="label.monitor.total.count"/>: <em id="alarm_totalcount">0</em></span><p class="count1" id="critical_count">0</p><p class="count2" id="major_count">0</p><p class="count3" id="minor_count">0</p><p class="count4" id="warning_count">0</p>
                    </div>
                    <div class="button">
                        <button type="button" title="Ack"><spring:message code="label.monitor.ack"/></button>
                        <button type="button" title="unAck"><spring:message code="label.monitor.unack"/></button>
                        <button type="button" title="Clear"><spring:message code="label.monitor.clear"/></button>
                    </div>
                </div>
                <div class="table_info_group2">
                        <button type="button" title="가청 알람" class="icon1">가청 알람</button>
                        <button type="button" title="가시 알람" class="icon2">가시 알람</button>
                        <button type="button" title="소리" class="icon3">소리</button>
                        <button type="button" title="정지" class="icon4">정지</button>
                </div>
                <div class="table_info_group3">
                        <button type="button" title="<spring:message code="label.common.excel.text"/>" class="icon5">Excel</button>
                        <button type="button" title="<spring:message code="label.monitor.more"/>" class="icon6">더 보기</button>
                </div>                
            </div>
            <!--// alarm adjustment -->
            
            <div class="data on">
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
                            <th class="sort up"><spring:message code="label.monitor.node"/></th>
                            <th class="date sort down"><spring:message code="label.monitor.process.date"/></th>
                            <th class="sort"><spring:message code="label.monitor.alarm.code"/></th>
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
    	</form>
    </div>
    <!--// sub_bottom-->
   
</div>
<!--// wrap --> 

<!-- Level 오디오 -->
<c:forEach items="${audioSeveritySound}" var="i" varStatus="status">
	<audio id="level_${i.NAME}" src="/audio/errorlevel_en/${i.NAME}.wav">HTML5 audio not supported</audio>
</c:forEach>	
</body>
</html>




