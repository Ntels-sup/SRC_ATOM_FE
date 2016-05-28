<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script src="/scripts/amcharts_3.19.4/amcharts/amcharts_custom_config.js"></script>
<script src="/scripts/jwebsocket/pfnmWebSocket.js"></script>
<script src="/scripts/jwebsocket/1_0_b1/jWebSocket.js"></script>

<script type="text/javascript">
//websocket setting
var socketUrl = "${pageContext.servletContext.getAttribute('websocket.connect.url')}";
initPage(socketUrl, "dashboard");

$(document).ready(function() {
	
	$("#disconnect_popup").hide();
	
	/** Total Node Start*/
	fnNodeChart();
	/** Total Node End*/
	
	/** Total Alarm Start */
    // Total Alarm 최초 데이터 로딩
	fnTotalAlarmInit();
	var Alarm_chart;
	fnConstrutChart();
	/** Total Alarm End */
	
	/** Top5 chart Start*/
	fnMkTopResourceChart()
	fnTopResourceChartInit();
 	setInterval(function(){
		fnTopResourceChartInit();
	}, 10*1000); // 10초 마다 Usage top5 갱신
	/** Top5 chart End*/
	
	/** Release Log Start*/
	fnReleaseLogInit();
	/** Release Log End*/
	
});
 
   //Total Node
   /* dashboard - node */
   var node_chart;
   function fnNodeChart(){
	   node_chart = AmCharts.makeChart("chart_stacked_100",
			  {
			    "type": "serial",
			    "categoryField": "category",
			    "columnWidth": 1,
			    "autoMargins": false,
			    "marginBottom": 0,
			    "marginLeft": 0,
			    "marginRight": 0,
			    "marginTop": 0,
			    "minMarginBottom": 0,
			    "minMarginLeft": 0,
			    "minMarginRight": 0,
			    "minMarginTop": 0,
			    "startDuration": 0,
			    "startEffect": "easeOutSine",
			    "fontSize": 12,
			    "categoryAxis": {
			      "gridPosition": "start",
			      "axisAlpha": 0,
			      "gridAlpha": 0,
			      "tickLength": 0,
			      "labelsEnabled": false
			    },
			    "graphs": [
			      {
			        "balloonText": "[[title]] : <b>[[value]]</b>",
			        "color": "#c9cdd3",
			        "fillAlphas": 1,
			        "fillColors": "#636f80",
			        "lineThickness": 0,
			        "id": "AmGraph-10",
			        "labelText": "[[title]] : [[value]]",
			        "title": "NODE or PACKAGE NAME 10",
			        "type": "column",
			        "valueField": "column-10"
			      },
			      {
			        "balloonText": "[[title]] : <b>[[value]]</b>",
			        "color": "#c9e4dc",
			        "fillAlphas": 1,
			        "fillColors": "#63b39b",
			        "lineThickness": 0,
			        "id": "AmGraph-9",
			        "labelText": "[[title]] : [[value]]",
			        "title": "NODE or PACKAGE NAME 9",
			        "type": "column",
			        "valueField": "column-9"
			      },
			      {
			        "balloonText": "[[title]] : <b>[[value]]</b>",
			        "color": "#bdc5e2",
			        "fillAlphas": 1,
			        "fillColors": "#4359ac",
			        "lineThickness": 0,
			        "id": "AmGraph-8",
			        "labelText": "[[title]] : [[value]]",
			        "title": "NODE or PACKAGE NAME 8",
			        "type": "column",
			        "valueField": "column-8"
			      },
			      {
			        "balloonText": "[[title]] : <b>[[value]]</b>",
			        "color": "#dbefca",
			        "fillAlphas": 1,
			        "fillColors": "#98d268",
			        "lineThickness": 0,
			        "id": "AmGraph-7",
			        "labelText": "[[title]] : [[value]]",
			        "title": "NODE or PACKAGE NAME 7",
			        "type": "column",
			        "valueField": "column-7"
			      },
			      {
			        "balloonText": "[[title]] : <b>[[value]]</b>",
			        "color": "#d7dbe0",
			        "fillAlphas": 1,
			        "fillColors": "#8d98a6",
			        "lineThickness": 0,
			        "id": "AmGraph-6",
			        "labelText": "[[title]] : [[value]]",
			        "title": "NODE or PACKAGE NAME 6",
			        "type": "column",
			        "valueField": "column-6"
			      },
			      {
			        "balloonText": "[[title]] : <b>[[value]]</b>",
			        "color": "#b4abdd",
			        "fillAlphas": 1,
			        "fillColors": "#6856ba",
			        "lineThickness": 0,
			        "id": "AmGraph-5",
			        "labelText": "[[title]] : [[value]]",
			        "title": "NODE or PACKAGE NAME 5",
			        "type": "column",
			        "valueField": "column-5"
			      },
			      {
			        "balloonText": "[[title]] : <b>[[value]]</b>",
			        "color": "#8ec1a7",
			        "fillAlphas": 1,
			        "fillColors": "#1c834e",
			        "lineThickness": 0,
			        "id": "AmGraph-4",
			        "labelText": "[[title]] : [[value]]",
			        "title": "NODE or PACKAGE NAME 4",
			        "type": "column",
			        "valueField": "column-4"
			      },
			      {
			        "balloonText": "[[title]] : <b>[[value]]</b>",
			        "color": "#9ca7ba",
			        "fillAlphas": 1,
			        "fillColors": "#122d5a",
			        "lineThickness": 0,
			        "id": "AmGraph-3",
			        "labelText": "[[title]] : [[value]]",
			        "title": "NODE or PACKAGE NAME 3",
			        "type": "column",
			        "valueField": "column-3"
			      },
			      {
			        "balloonText": "[[title]] : <b>[[value]]</b>",
			        "color": "#aaebe8",
			        "fillAlphas": 1,
			        "fillColors": "#0bc7be",
			        "lineThickness": 0,
			        "id": "AmGraph-2",
			        "labelText": "[[title]] : [[value]]",
			        "title": "NODE or PACKAGE NAME 2",
			        "type": "column",
			        "valueField": "column-2"
			      },
			      {
			        "balloonText": "[[title]] : <b>[[value]]</b>",
			        "color": "#a7dcf3",
			        "fillAlphas": 1,
			        "fillColors": "#039ade",
			        "lineThickness": 0,
			        "id": "AmGraph-1",
			        "labelText": "[[title]] : [[value]]",
			        "title": "NODE or PACKAGE NAME 1",
			        "type": "column",
			        "valueField": "column-1"
			      }
			    ],
			    "guides": [],
			    "valueAxes": [
			      {
			        "id": "ValueAxis-1",
			        "stackType": "100%",
			        "axisAlpha": 0,
			        "gridAlpha": 0,
			        "labelsEnabled": false
			      }
			    ],
			    "allLabels": [],
			    "balloon": {
			      "fixedPosition": false,
			      "fillAlpha": 0.88,
			      "pointerWidth": 0,
			      "shadowAlpha": 0.2
			    },
			    "dataProvider": [
			      {
			        "category": "category 1",
			        "column-1": 21,
			        "column-2": 10,
			        "column-3": 7,
			        "column-4": 3,
			        "column-5": 3,
			        "column-6": 1,
			        "column-7": 1,
			        "column-8": 1,
			        "column-9": 1,
			        "column-10": 1
			      }
			    ]
			  }
			  );
   }


    // total alarm chart    
    function fnConstrutChart() {
    	Alarm_chart = AmCharts.makeChart("chart_stacked",totlaAlarmConfig);
    }

    /* total alarm 호출 및 갱신 */
    function fnTotalAlarmInit(){
	   var param = $("#myForm").serialize();
	   $.post('totalAlarm.ajax', param, function(data) {
	        $('#totalAlarm').html(data);
	    });   
   }
   
    //Atom Infomation 
	//pie chart
	document.addEventListener('DOMContentLoaded', function() {
	    var pieId = ['#pie01','#pie02','#pie03','#pie04']; /*[ CPU Memory Disk Tablespace ]*/
		
		$.each(pieId, function(index, data) {
			console.log(index+":"+data);
			var pieTextPerId = ['#pie01_per','#pie01_per','#pie01_per','#pie01_per'];
			$(pieId[index]).easyPieChart({
				easing: 'easeInOut',
			    delay: 3000,
	 			barColor: '#fff',
	 			trackColor: '#00ac7d',
	 			scaleColor: false,
	 			lineWidth: 46,
	 			trackWidth: 46,
	 			lineCap: 'butt',
	 			size: 145,
		        onStep: function(from, to, percent) {
		          this.el.children[0].innerHTML = Math.round(percent);
		          var text_persent = "("+Math.round(percent)+"%)";
		          $(pieTextPerId[index]).text(text_persent);
		        }
		    });
		});
	    
	});
   
   //pie차트 value 업데이트 샘플.
   function fnAtonInfomationInit(persent){
	   $('#pie02').data('easyPieChart').update(persent);
   }
   
	//Top 5 Resource Chart 그리기.
	var topResourceCharts =['CpuChart','MemoryChart','DiskChart','TablespaceChart'];
	function fnMkTopResourceChart(){
		var AmChartsColum = ['chart_colum11','chart_colum12','chart_colum13','chart_colum14'];
		$.each(topResourceCharts, function(index, data) {
			//console.log(index+":"+data);
			topResourceCharts[index] = AmCharts.makeChart(AmChartsColum[index],topResourceConfig[index]);
		});
 	}
   
   //Top 5 Resource Chart 데이터 셋팅.
   function fnTopResourceChartInit(){
	   var result = 
			$.ajax({
				url : "listTopResource",
				dataType: "json", 
				data : null,
				type : "POST",
				cache : false
			});
	   result.done(function(data) {
			if (data != null) {
				var dataArray;
				var cololr = null;
				$.each(data, function(i, row) {
					dataArray = []; 
					$.each(row.resourceData, function(t, row) {
					    if (t == 0) color = "#01b8aa";
						if (t == 1) color = "#265299";
						if (t == 2) color = "#738199";
						if (t == 3) color = "#adb2ba";
						if (t == 4) color = "#c8c9cc";
						dataArray.push({
							"RSC_ID_NAME" : row.RSC_ID_NAME,
					        "DATA" : row.DATA,
					        "color" : color
						});							
					});
					topResourceCharts[i].dataProvider = dataArray ;
					topResourceCharts[i].validateData();
				});
			}
		});	   
   }
   
   

   
	/*clock*/
	function Clock_dg(prop) {
		var angle = 360/60,
			date = new Date();
			var h = date.getHours();
			if(h > 12) {
				h = h - 12;
			}
		
			hour = h;
			minute = date.getMinutes(),
			second = date.getSeconds(),
			hourAngle = (360/12) * hour + (360/(12*60)) * minute;
		
			$('#minute')[0].style[prop] = 'rotate('+angle * minute+'deg)';
			$('#second')[0].style[prop] = 'rotate('+angle * second+'deg)';
			$('#hour')[0].style[prop] = 'rotate('+hourAngle+'deg)';
			
			var textTime = hour+":"+minute+":"+second;
			var tTarray = textTime.split(":");
			if(tTarray[1].length < 2){
				tTarray[1] = "0"+tTarray[1]; 
			}
			if(tTarray[2].length < 2){
				tTarray[2] = "0"+tTarray[2]; 
			}
			textTime = tTarray[0]+":"+tTarray[1]+":"+tTarray[2];
			$('#text_time').text(textTime);
			
			var textYMD = new Date().format('${dateformat}');
			$('#text_ymd').text(textYMD);
	}
	
	Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
		    var d = this;
		    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
		        switch ($1) {
		            case "YYYY": return d.getFullYear();
                    case "yyyy": return d.getFullYear();
		            case "YY": return (d.getFullYear() % 1000).zf(2);
		            case "yy": return (d.getFullYear() % 1000).zf(2);
		            case "MM": return (d.getMonth() + 1).zf(2);
					case "mm": return (d.getMonth() + 1).zf(2);
		            case "DD": return d.getDate().zf(2);
		            case "dd": return d.getDate().zf(2);
		            default: return $1;
		        }
		    });
        };
	String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
	String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
	Number.prototype.zf = function(len){return this.toString().zf(len);};
	
	
	$(function(){        
			var props = 'transform WebkitTransform MozTransform OTransform msTransform'.split(' '),
				prop,
				el = document.createElement('div');
			
			for(var i = 0, l = props.length; i < l; i++) {
				if(typeof el.style[props[i]] !== "undefined") {
					prop = props[i];
					break;
				}
			}
			setInterval(function(){
				Clock_dg(prop)
			},100);
	});
   
   
	
   /*Release Log*/
   function fnReleaseLogInit(){
	   var param = $("#myForm").serialize();
	   $.post('releaseLog.ajax', param, function(data) {
	        $('#release_log').html(data);
	    });
   }

   
 //####################################################
 //################### 웹소켓 함수 ####################
 //####################################################
	
	/**
    * 웹소켓 로그인 성공시 호출
    */
	function fnPreparedSocket() {
		console.log("웹소켓 연결 성공...");
		fnLoadingTry(false, "");
		
		//fnRequestResource(120); //리소스 요청한다.
	}
	
	function fnCommonMessage(command, messages) {
		
		messages = $.parseJSON(messages); //String to Json 변환
		console.log("받음 command->"+command);
		console.log(messages);
		if (command == 20006) { //알람 발생
			fnTotalAlarmInit(); // totla alarm 갱신
		} else if (command == 20000) { //알람 발생
			fnTotalAlarmInit(); // totla alarm 갱신
		} 
	}
	
	
		/**
	 * 웹소켓 접속 종료됨
	 */ 
	function fnDisconnectSocket(status) {
		console.log(status);
		if (status == "nm_stop") { //클라이언트 재접속을 하지 않는다.
			//fnLoadingTry(true, "Node Manager");
			return;
		} 
		
		//fnLoadingTry(true, "WSM");
		
		if (lWSC) {
			//lWSC.stopKeepAlive();
			console.log("Disconnecting...");
			var lRes = lWSC.close(3000);
			console.log("reason : "+lWSC.resultToString(lRes));
			
			
			
			//재시도
			setTimeout(function() { 
				//lWSC = null;
				connect();
			}, 10000);
		}
	}
	
	/**
	 * 뱅글뱅글 돌아아야한다.
	 */
	function fnLoadingTry(isBoolean, messages) {
		if (isBoolean) { //뱅글뱅글 돌자 화면
			//console.log("돌자");
			$("#disconnect_popup_message").text(messages);
			
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
</head>
<body>
	<div class="dash_grid">
		<div class="grid item_01">
			<div id="chart_stacked_100"></div>
			<h2>Total Node</h2>
			<div class="total">
				<p>50</p>
				<span>Process: 1,259</span>
			</div>
		</div>
		<div class="grid item_02" >
			<h2>Total Alarm</h2><div class="total" id="alarm_total">0</div>
			<div class="alarm" id="totalAlarm">
				<div class="count1">
					<span>0</span>
					<p>Critical</p>
				</div>
				<div class="count2">
					<span>0</span>
					<p>Major</p>
				</div>
				<div class="count3">
					<span>0</span>
					<p>Minor</p>
				</div>
				<div class="count4">
					<span>0</span>
					<p>Fault</p>
				</div>
			</div>
			<div id="chart_stacked"></div>
		</div>
		
		<div class="grid item_03" >
			<h2>ATOM Infomation</h2>
			<div class="status">
				<p class="nor"><span>Normal</span>Network</p> <!--class : nor,abnor-->
				<p class="abnor"><span>Abnormal</span>Process</p> <!--class : nor,abnor-->
			</div>
				<ul class="piechart">
				<li>
					<div class="pie01" id="pie01" data-percent="01"></div>
					<div class="txt" id="pie01_txt">
						<span>CPU</span>
						<p>1.22GHz</p>
						<p id="pie01_per"></p>
					</div>
				</li>
				<li>
					<div class="pie02" id="pie02" data-percent="100"></div>
					<div class="txt">
						<span>Memory</span>
						<p>4.0 / 7.9GB</p>
						<p id="pie02_per"></p>
					</div>
				</li>
				<li>
					<div class="pie03" id="pie03" data-percent="96"></div>
					<div class="txt">
						<span>Disk</span>
						<p>16,134 / 76.537MB</p>
						<p id="pie03_per"></p>
					</div>
				</li>
				<li>
					<div class="pie04" id="pie04" data-percent="30"></div>
					<div class="txt">
						<span>Tablespace</span>
						<p>34.04 / 34.80G</p>
						<p id="pie04_per"></p>
					</div>
				</li>
			</ul>
		
		</div>
		
		<div id="topFiveChart" hidden="hidden"></div>
				<div class="grid item_04">
			<div class="half">
				<h2>CPU<span>Usage Top5</span></h2>
				<div class="columchart">
					<ol>
					    <li>1</li>
					    <li>2</li>
					    <li>3</li>
					    <li>4</li>
					    <li>5</li>
					</ol>
					<div id="chart_colum11"></div>
				</div>
			</div>
			<div class="half">
				<h2>Memory<span>Usage Top5</span></h2>
				<div class="columchart">
					<ol>
					    <li>1</li>
					    <li>2</li>
					    <li>3</li>
					    <li>4</li>
					    <li>5</li>    
					</ol>
					<div id="chart_colum12"></div>
				</div>
			</div>
		</div>
		
		<div class="grid item_05">
			<div class="half">
					<h2>Disk<span>Usage Top5</span></h2>
					<div class="columchart">
						<ol>
							 <li>1</li>
						     <li>2</li>
						     <li>3</li>
						     <li>4</li>
						     <li>5</li>
						</ol>
						<div id="chart_colum13" style="margin-top: 0"></div>
					</div>
				</div>
				<div class="half">
					<h2>Tablespace<span>Usage Top5</span></h2>
					<div class="columchart">
						<ol>
							<li>1</li>
						    <li>2</li>
						    <li>3</li>
						    <li>4</li>
						    <li>5</li>
						</ol>
						<div id="chart_colum14"></div>
					</div>
				</div>
			</div>
		
		
		
		<div class="grid item_06">
			<div class="log" id="release_log"></div>
			<div class="date_info">
				<p><span>${TimeZome}</span></p>
				<p class="time" id="text_time"></p>
				<p class="date" id="text_ymd"></p>
				<div id="clock">
					<span class="center"></span>
					<div id="hour"><img src="../images/clock_hour.png"></div>
					<div id="minute"><img src="../images/clock_min.png"></div>
					<div id="second"><img src="../images/clock_sec.png"></div>
				</div>
			</div>
	     </div>
	<!-- dashboard -->
	<!-- disconnect Server -->
<div id="disconnect_popup">
 	<div class="disconnect">
    	<div class="loading_page red"><i></i><i></i></div>  
    	<h4>Disconnect Server</h4>
    	<p>
      		<spring:message code="msg.monitor.disconnect"/>
    	</p>
    	<p id="disconnect_popup_message"></p>
    </div>
</div>
	