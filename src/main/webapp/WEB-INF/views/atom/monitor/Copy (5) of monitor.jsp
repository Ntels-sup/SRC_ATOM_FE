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
<script src="/scripts/jquery.contextMenu.js"></script>
        
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
	
	var isAlarmSoundReload = true; 	//알람 사운드 ON & OFF
	var isAlarmViewReload = true; 	//알람 가시 ON & OFF
	var isAlarmPlayReload = true; 	//알람 플레이 ON & OFF
	
	$(document).ready(function() {
		//로그인 tiles layout 같이 쓰므로 타이틀 변경해야함
		//this.title = 'Monitoring';
		
		$(this).contextmenu(function(e) {
			//return false;
		});
		
		
		//최초 한번만 실행
		setTimeout(function() { 
			fnInitializeTree();
			fnInitializeAlarm();
			fnInitializeNode();
			//fnIntervalAlarmSound(); //사운드는 반복
			fnKeepAlive();			
		}, 1000);
		
		//search 버튼
		$("#btn_search").click(function() {
			console.log("search");
			fnInitializeAlarm();
		});
		
		/**
		 * sound 버튼 ON 클릭시
		 */
		$("#btn_soundOn").click(function() {
			console.log("btn_soundOn");			
			$("#btn_soundOff").show();
			$("#btn_soundOn").hide();
			
			isAlarmSoundReload = false;
		});
		
		/**
		 * sound 버튼 OFF 클릭시
		 */
		$("#btn_soundOff").click(function() {
			console.log("btn_soundOff");			
			$("#btn_soundOff").hide();
			$("#btn_soundOn").show();
			
			isAlarmSoundReload = true;
				
		});
		
		/**
		 * 알람 팝업 on 클릭시
		 */
		$("#btn_viewOn").click(function() {
			console.log("btn_viewOn");	
			$("#btn_viewOff").show();
			$("#btn_viewOn").hide();
		});
		
		/**
		 * 알람 팝업 off 버튼 클릭시
		 */
		$("#btn_viewOff").click(function() {
			console.log("btn_viewOff");	
			$("#btn_viewOff").hide();
			$("#btn_viewOn").show();
		});
		
		/**
		 * restart 버튼 클릭시
		 */
		$("#btn_playOn").click(function() {
			console.log("btn_playOn");	
			$("#btn_playOff").show();
			$("#btn_playOn").hide();
		});
		
		/**
		 * pause 버튼 클릭시
		 */
		$("#btn_playOff").click(function() {
			console.log("btn_playOff");	
			$("#btn_playOff").hide();
			$("#btn_playOn").show();
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
		
		$(document).on("click", "#btn_alarm_detail", function() {
			console.log("Aaaa");
		});
		
		//알람 context menu
		$(document).on("click", "#tr_node_name", function(e) {
			console.log("aaaa");
			//console.log($(this).children("td").eq(2).text());
			///console.log($(this).children("td").eq(4).text());
			//console.log($(this).children("td").eq(6).text());
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
				fnSeverityCount();
			}
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
		var fault_count = $("input[name=fault_count]").attr("value");
		var notice_count = $("input[name=notice_count]").attr("value");
		var interminate_count = $("input[name=interminate_count]").attr("value");
		var warning_count = $("input[name=warning_count]").attr("value");
		var cleared_count = $("input[name=cleared_count]").attr("value");
		
		fault_count = Number(fault_count);
		notice_count = Number(notice_count);
		interminate_count = Number(interminate_count);
		warning_count = Number(warning_count);
		cleared_count = Number(cleared_count);
		
		$("#critical_count").text(critical_count);
		$("#major_count").text(major_count);
		$("#minor_count").text(minor_count);
		$("#warning_count").text(fault_count + notice_count + interminate_count + warning_count + cleared_count);
		
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
      
    </script>
</head>
<body>

<nav id="ml-menu" class="menu"></nav>
<ul id="the-node">
    <li><span class="context-menu-one btn btn-neutral">right click me 1</span></li>
    <li><span class="context-menu-one btn btn-neutral">right click me 2</span></li>
    <li>right click me 3</li>
    <li>right click me 4</li>
</ul>
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
           
        <div class="sub_content">
         <div class="main_content"><img src="/images/sample2.png"/></div><!-- 메인 모니터링-->
            
            <div class="sub_type">
                <div class="total_chart">
                    <div><h5>Average CPU(%)</h5><div id="g1"></div></div>
                    <div><h5>Top CPU Temperature(℃)</h5><div id="g2"></div></div>
                    <div><h5>Top Disk(%)</h5><div id="g3"></div></div>
                    <div><h5>Total Memory(%)</h5><div id="g4"></div></div>
                </div>
             
                <div class="sect type1">
                    <div><h6>Service<em>EPC</em></h6><a href="#" title="Zoom" class="zoom z1">Zoom</a><p><img src="/images/sample1.png" /></p></div><!--z1 클릭 obj1-->
                    <div><h6>Service<em>IMS</em></h6><a href="#" title="Zoom" class="zoom z2">Zoom</a><p><img src="/images/sample1.png" /></p></div><!--z2 클릭 obj2-->
                    <div><h6>Service<em>SMS</em></h6><a href="#" title="Zoom" class="zoom z3">Zoom</a><p><img src="/images/sample1.png" /></p></div><!--z3 클릭 obj3-->
                    <div><h6>Service<em>ORN-SMS</em></h6><a href="#" title="Zoom" class="zoom z4">Zoom</a><p><img src="/images/sample1.png" /></p></div><!--z4 클릭 obj4-->           
                </div>
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
                             
                <div class="sect type2 page2">
                    <div><span>Date:2016-02-01 10:30:30</span><h4>Temperature Usage TOP10</h4><div id="chartdiv_pie"></div></div>
                    <div class="data">
                        <table class="tbl_list">
                            <colgroup>
                            <col width="8%"/>
                            <col width="15%"/>
                            <col width="*"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="10px"/>                            
                            </colgroup>
                            <thead>
                                <tr>
                                    <th class="t_c">No</th>
                                    <th>Mount Name</th>
                                    <th>File System Name</th>
                                    <th class="t_r">Disk Usage<br/>(%)</th>
                                    <th class="t_r">Total Space<br/>(MB)</th>
                                    <th class="t_r">Used Space<br/>(MB)</th>
                                    <th class="t_r">Free Space<br/>(MB)</th>
                                    <th></th>
                                </tr>
                            </thead>
                        </table>
                        <div class="scroll">
                            <table class="tbl_list">
                                <colgroup>
                                <col width="8%"/>
                                <col width="15%"/>
                                <col width="*"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r suspend">76,534</td>
                                        <td class="t_r suspend">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r running">86.43</td>
                                        <td class="t_r stopped">76,537</td>
                                        <td class="t_r unknown">76,534</td>
                                        <td class="t_r abnormal">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>                                    
                                </tbody>
                            </table>
                        </div>                    

                    </div>
                    <!--// data -->
                </div>
                <!--// sect type2 -->
                
                <div class="sect type2 page3">
                    <div><span>Date:2016-02-01 10:30:30</span><h4>CPU Usage TOP10</h4><div id="chartdiv_pie3"></div></div>
                    <div class="data">
                        <table class="tbl_list">
                            <colgroup>
                            <col width="8%"/>
                            <col width="15%"/>
                            <col width="*"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="10px"/>                            
                            </colgroup>
                            <thead>
                                <tr>
                                    <th class="t_c">No</th>
                                    <th>Mount Name</th>
                                    <th>File System Name</th>
                                    <th class="t_r">Disk Usage<br/>(%)</th>
                                    <th class="t_r">Total Space<br/>(MB)</th>
                                    <th class="t_r">Used Space<br/>(MB)</th>
                                    <th class="t_r">Free Space<br/>(MB)</th>
                                    <th></th>
                                </tr>
                            </thead>
                        </table>
                        <div class="scroll">
                            <table class="tbl_list">
                                <colgroup>
                                <col width="8%"/>
                                <col width="15%"/>
                                <col width="*"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r suspend">76,534</td>
                                        <td class="t_r suspend">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r running">86.43</td>
                                        <td class="t_r stopped">76,537</td>
                                        <td class="t_r unknown">76,534</td>
                                        <td class="t_r abnormal">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>                                    
                                </tbody>
                            </table>
                        </div>                    

                    </div>
                    <!--// data -->
                </div>
                <!--// sect type3 -->

                <div class="sect type2 page4">
                    <div><span>Date:2016-02-01 10:30:30</span><h4>Disk Usage TOP10</h4><div id="chartdiv_pie4"></div></div>
                    <div class="data">
                        <table class="tbl_list">
                            <colgroup>
                            <col width="8%"/>
                            <col width="15%"/>
                            <col width="*"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="10px"/>                            
                            </colgroup>
                            <thead>
                                <tr>
                                    <th class="t_c">No</th>
                                    <th>Mount Name</th>
                                    <th>File System Name</th>
                                    <th class="t_r">Disk Usage<br/>(%)</th>
                                    <th class="t_r">Total Space<br/>(MB)</th>
                                    <th class="t_r">Used Space<br/>(MB)</th>
                                    <th class="t_r">Free Space<br/>(MB)</th>
                                    <th></th>
                                </tr>
                            </thead>
                        </table>
                        <div class="scroll">
                            <table class="tbl_list">
                                <colgroup>
                                <col width="8%"/>
                                <col width="15%"/>
                                <col width="*"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r suspend">76,534</td>
                                        <td class="t_r suspend">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r running">86.43</td>
                                        <td class="t_r stopped">76,537</td>
                                        <td class="t_r unknown">76,534</td>
                                        <td class="t_r abnormal">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>                                    
                                </tbody>
                            </table>
                        </div>                    

                    </div>
                    <!--// data -->
                </div>
                <!--// sect type4 -->

                <div class="sect type2 page5">
                    <div><span>Date:2016-02-01 10:30:30</span><h4>Memory Usage TOP10</h4><div id="chartdiv_pie5"></div></div>
                    <div class="data">
                        <table class="tbl_list">
                            <colgroup>
                            <col width="8%"/>
                            <col width="15%"/>
                            <col width="*"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="10px"/>                            
                            </colgroup>
                            <thead>
                                <tr>
                                    <th class="t_c">No</th>
                                    <th>Mount Name</th>
                                    <th>File System Name</th>
                                    <th class="t_r">Disk Usage<br/>(%)</th>
                                    <th class="t_r">Total Space<br/>(MB)</th>
                                    <th class="t_r">Used Space<br/>(MB)</th>
                                    <th class="t_r">Free Space<br/>(MB)</th>
                                    <th></th>
                                </tr>
                            </thead>
                        </table>
                        <div class="scroll">
                            <table class="tbl_list">
                                <colgroup>
                                <col width="8%"/>
                                <col width="15%"/>
                                <col width="*"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r suspend">76,534</td>
                                        <td class="t_r suspend">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r running">86.43</td>
                                        <td class="t_r stopped">76,537</td>
                                        <td class="t_r unknown">76,534</td>
                                        <td class="t_r abnormal">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>                                    
                                </tbody>
                            </table>
                        </div>                    

                    </div>
                    <!--// data -->
                </div>
                <!--// sect type5 -->

                <div class="sect type2 page6">
                    <div><span>Date:2016-02-01 10:30:30</span><h4>Queue Usage TOP10</h4><div id="chartdiv_pie6"></div></div>
                    <div class="data">
                        <table class="tbl_list">
                            <colgroup>
                            <col width="8%"/>
                            <col width="15%"/>
                            <col width="*"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="10px"/>                            
                            </colgroup>
                            <thead>
                                <tr>
                                    <th class="t_c">No</th>
                                    <th>Mount Name</th>
                                    <th>File System Name</th>
                                    <th class="t_r">Disk Usage<br/>(%)</th>
                                    <th class="t_r">Total Space<br/>(MB)</th>
                                    <th class="t_r">Used Space<br/>(MB)</th>
                                    <th class="t_r">Free Space<br/>(MB)</th>
                                    <th></th>
                                </tr>
                            </thead>
                        </table>
                        <div class="scroll">
                            <table class="tbl_list">
                                <colgroup>
                                <col width="8%"/>
                                <col width="15%"/>
                                <col width="*"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r suspend">76,534</td>
                                        <td class="t_r suspend">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r running">86.43</td>
                                        <td class="t_r stopped">76,537</td>
                                        <td class="t_r unknown">76,534</td>
                                        <td class="t_r abnormal">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>                                    
                                </tbody>
                            </table>
                        </div>                    

                    </div>
                    <!--// data -->
                </div>
                <!--// sect type6 -->

                <div class="sect type2 page7">
                    <div><span>Date:2016-02-01 10:30:30</span><h4>Tablespace Usage TOP10</h4><div id="chartdiv_pie7"></div></div>
                    <div class="data">
                        <table class="tbl_list">
                            <colgroup>
                            <col width="8%"/>
                            <col width="15%"/>
                            <col width="*"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="10px"/>                            
                            </colgroup>
                            <thead>
                                <tr>
                                    <th class="t_c">No</th>
                                    <th>Mount Name</th>
                                    <th>File System Name</th>
                                    <th class="t_r">Disk Usage<br/>(%)</th>
                                    <th class="t_r">Total Space<br/>(MB)</th>
                                    <th class="t_r">Used Space<br/>(MB)</th>
                                    <th class="t_r">Free Space<br/>(MB)</th>
                                    <th></th>
                                </tr>
                            </thead>
                        </table>
                        <div class="scroll">
                            <table class="tbl_list">
                                <colgroup>
                                <col width="8%"/>
                                <col width="15%"/>
                                <col width="*"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r suspend">76,534</td>
                                        <td class="t_r suspend">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r running">86.43</td>
                                        <td class="t_r stopped">76,537</td>
                                        <td class="t_r unknown">76,534</td>
                                        <td class="t_r abnormal">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>                                    
                                </tbody>
                            </table>
                        </div>                    

                    </div>
                    <!--// data -->
                </div>
                <!--// sect type7 -->
                
                <div class="sect type2 page8">
                    <div><span>Date:2016-02-01 10:30:30</span><h4>NIC Usage TOP10</h4><div id="chartdiv_pie8"></div></div>
                    <div class="data">
                        <table class="tbl_list">
                            <colgroup>
                            <col width="8%"/>
                            <col width="15%"/>
                            <col width="*"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="13%"/>
                            <col width="10px"/>                            
                            </colgroup>
                            <thead>
                                <tr>
                                    <th class="t_c">No</th>
                                    <th>Mount Name</th>
                                    <th>File System Name</th>
                                    <th class="t_r">Disk Usage<br/>(%)</th>
                                    <th class="t_r">Total Space<br/>(MB)</th>
                                    <th class="t_r">Used Space<br/>(MB)</th>
                                    <th class="t_r">Free Space<br/>(MB)</th>
                                    <th></th>
                                </tr>
                            </thead>
                        </table>
                        <div class="scroll">
                            <table class="tbl_list">
                                <colgroup>
                                <col width="8%"/>
                                <col width="15%"/>
                                <col width="*"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                <col width="13%"/>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r suspend">76,534</td>
                                        <td class="t_r suspend">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r running">86.43</td>
                                        <td class="t_r stopped">76,537</td>
                                        <td class="t_r unknown">76,534</td>
                                        <td class="t_r abnormal">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>
                                    <tr>
                                        <td class="t_c">1</td>
                                        <td>/MYSQL_DATA</td>
                                        <td>/dev/cciss/c0d0p2</td>
                                        <td class="t_r">86.43</td>
                                        <td class="t_r">76,537</td>
                                        <td class="t_r">76,534</td>
                                        <td class="t_r">76,534</td>
                                    </tr>                                    
                                </tbody>
                            </table>
                        </div>                    

                    </div>
                    <!--// data -->
                </div>
                <!--// sect type8 -->
                
            </div>
            <!--// sub_type -->
         
        </div>
        <!--// sub_content --> 
    </div>
    <!--// sub_body-->
    
    <!-- ############################# 알람 창 UI ############################################ -->
    
    <form id="checkAlarmForm" name="checkAlarmForm" method="post"> <!-- 폼이 알람 UI 바깥에 있어야 한다. 안그럼  창확대 addclass:on UI가 깨짐 -->
    <div class="sub_bottom"> <!--// 창확대 addclass:on -->
            <div class="alarm_adjustment">
                <div class="select_single common">
                    <select class="single" name="search_type">
                        <option value="1">Package</option>
                        <option value="2">Node Name</option>
                        <option value="3">Code</option>
                        <option value="4">Severity</option>
                    </select>
                </div>
                <div class="common">
                    <p class="search"><input type="text" name="search" placeholder="<spring:message code="label.common.search"/>"/><button type="button" id="btn_search" title="<spring:message code="label.common.search"/>" class="srh">Search</button></p>
                </div>
                <div class="table_info_group1">
                    <div class="paging">
                        <ul>
                            <!-- <li><a href="javascript:fnPageMove('first');" class="first hidden"><span class="hidden">First</span></a></li> --><!--hidden 처리-->
                            <li><a href="javascript:fnPageMove('first');" class="first"><span class="hidden">First</span></a></li>
                            <li><a href="javascript:fnPageMove('before');" class="before"><span class="hidden">Before</span></a></li>
                            <li><input type="text" name="page" value="1" />/ <span id="last_page">1</span></li>
                            <li><a href="javascript:fnPageMove('next');" class="next"><span class="hidden">Next</span></a></li>
                            <li><a href="javascript:fnPageMove('last');" class="last"><span class="hidden">Last</span></a></li>
                        </ul>
                    </div>
                    <div class="count">
                     <span><spring:message code="label.monitor.total.count"/>: <em id="alarm_totalcount">0</em></span><p class="count1" id="critical_count">0</p><p class="count2" id="major_count">0</p><p class="count3" id="minor_count">0</p><p class="count4" id="warning_count">0</p>
                    </div>
                    <div class="button">
                        <button type="button" title="Ack"><spring:message code="label.monitor.ack"/></button>
                        <button type="button" title="Ack"><spring:message code="label.monitor.unack"/></button>
                        <button type="button" title="Clear"><spring:message code="label.monitor.clear"/></button>
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
	/* tree */

	$(document).ready(function(){
			$(".tree_wrap").addClass("on");
	});
	$(".folding").click(function(){ /*.folding 버튼 클릭시 트리메뉴 왼쪽으로 들어가고, ub_content 레이아웃도 같이 움직임*/
			$(".tree_wrap").toggleClass("on");
			
			if($('.tree_wrap').hasClass('on')){
					$('.sub_content').addClass('change');
			  }
			else{
			        $('.sub_content').removeClass('change');
			  }			
	});	

</script>

<!-- Level 오디오 -->
<c:forEach items="${audioSeveritySound}" var="i" varStatus="status">
	<audio id="level_${i.NAME}" src="/audio/errorlevel_en/${i.NAME}.wav">HTML5 audio not supported</audio>
</c:forEach>	
</body>
</html>




