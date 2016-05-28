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
<script src="/scripts/jquery.contextMenu.js"></script>

<script src="/scripts/jwebsocket/1_0_b1/jWebSocket.js"></script>
<script src="/scripts/jwebsocket/pfnmWebSocket.js"></script>

<script type="text/javascript">

<!--
	//websocket setting
	var socketUrl = "${pageContext.servletContext.getAttribute('websocket.connect.url')}";
	
	initPage(socketUrl, "monitor");
	
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
			fnInitializeNode();
			fnIntervalAlarmSound(); //사운드는 반복
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
		
		$('#the-node').contextMenu({
	        selector: 'li', 
	        callback: function(key, options) {
	            var m = "clicked: " + key + " on " + $(this).text();
	            window.console && console.log(m) || alert(m); 
	        },
	        items: {
	            "edit": {name: "Edit", icon: "edit"},
	            "cut": {name: "Cut", icon: "cut"},
	            "copy": {name: "Copy", icon: "copy"},
	            "paste": {name: "Paste", icon: "paste"},
	            "delete": {name: "Delete", icon: "delete"},
	            "sep1": "---------",
	            "quit": {name: "Quit", icon: function($element, key, item){ return 'context-menu-icon context-menu-icon-quit'; }}
	        }
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
				console.log(v);
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
			
		});
		
		result.fail(function(xhr, status) {
		});
		if (result !== null) result = null;
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
</head>
<body>
${titleName}
<input type="text" id="treeSearch" value="" class="input" style="margin:0em auto 1em auto; display:block; padding:4px; border-radius:4px; border:1px solid silver;" />

<div id="jstree"></div>

<a href="javascript:fnExpandAll();">tree expends all</a><br>
<a href="javascript:fnCollapseAll();">tree Collapse All</a>
<!-- <a href="javascript:fnOpenNewTab('/atom/monitor/individualMonitor', 'individualMonitor', '');">monitor</a> -->


<div id="alarmList"></div>


	<!-- Level 오디오 -->
	<c:forEach items="${audioSeveritySound}" var="i" varStatus="status">
		<audio id="level_${i.NAME}" src="/audio/errorlevel_en/${i.NAME}.wav">HTML5 audio not supported</audio>
	</c:forEach>



<ul id="the-node">
    <li><span class="context-menu-one btn btn-neutral">right click me 1</span></li>
    <li><span class="context-menu-one btn btn-neutral">right click me 2</span></li>
    <li>right click me 3</li>
    <li>right click me 4</li>
</ul>
	
</body>
</html>




