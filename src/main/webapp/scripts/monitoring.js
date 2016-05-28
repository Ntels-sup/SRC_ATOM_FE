var currentNodeId 		= "";
var nodeResourcePeriod 	= 10;		// 단위 : second
var nodeResourceTimeout	= 120;		// 단위 : second
var isDrawed			= false;

function requestNodeResourceInfo( destinationNodeId ) {

	// FIXME  
	destinationNodeId = 33;
	
	currentNodeId = destinationNodeId;
	console.log("[mirinae.maru] requestNodeResourceInfo..." );
	console.log("[mirinae.maru] destinationNodeId : " + destinationNodeId );

	var JSON_data = "";

	JSON_data = JSON_data + "{";
	JSON_data = JSON_data + "'period'	: "+ nodeResourcePeriod+",";		// 단위 : second
	JSON_data = JSON_data + "'timeout'	: "+ nodeResourceTimeout;			// 단위 : second
	JSON_data = JSON_data + "}";

	CommandREQ("0000090002", destinationNodeId, 2147483494, JSON_data);
	CommandREQ("0000090005", destinationNodeId, 2147483494, JSON_data);
	fnNodeResourceInfoInterval("0000090002", destinationNodeId, JSON_data);
	
	//트리갱신
	$.jstree.destroy();
	fnInitializeTree(destinationNodeId);
	
	//알람조회
	$("input[name=nodeId]").val(destinationNodeId);
	fnInitializeAlarm(destinationNodeId);
	
	$("#atom_resources").hide(); //
	$("#atom_top_resources").hide(); //
	$("#atom_batch").hide(); //
	
	//
	$(".tab1, .tab2, .tab3, .tab4, .tab5, .tab6, .tab7, .tab8").removeClass("on");
	$(".sect.type2.page1, .sect.type2.page2, .sect.type2.page3, .sect.type2.page4, .sect.type2.page5, .sect.type2.page6, .sect.type2.page7, .sect.type2.page8").removeClass("on");
	$(".tab1").addClass("on");
}

var intervalResource;
function fnNodeResourceInfoInterval(actionId, destinationNodeId, JSON_data) {
	
	console.log("[mirinae.maru] fnNodeResourceInfoInterval interval START >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" );
	console.log("[mirinae.maru] actionId : " + actionId );
	console.log("[mirinae.maru] destinationNodeId : " + destinationNodeId );
	console.log("[mirinae.maru] JSON_data : " + JSON.stringify(JSON_data) );

	clearInterval(intervalResource);
	
	intervalResource = setInterval(function(){
		CommandREQ(actionId, destinationNodeId, 2147483494, JSON_data);
		fnNodeResourceInfoInterval(actionId, destinationNodeId, JSON_data);
	}, nodeResourceTimeout*1000);
	
	console.log("[mirinae.maru] fnNodeResourceInfoInterval interval END >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" );	
}

function stopNodeResourceInfo() {

	console.log( "[mirinae.maru] stopNodeResourceInfo currentNodeId : " + currentNodeId );
	clearInterval(intervalResource);
	CommandREQ("0000090003", currentNodeId, 2147483494, "{}");
	CommandREQ("0000090006", currentNodeId, 2147483494, "{}");
	
	//트리갱신
	$.jstree.destroy();
	fnInitializeTree("");
	
	//알람조회
	$("input[name=nodeId]").val("");
	fnInitializeAlarm();
	
	$("#atom_resources").show(); //
	$("#atom_top_resources").show(); //
	$("#atom_batch").show(); //
}

function responseNodeResourceInfo( messages ) {

	//console.log( "[mirinae.maru] responseNodeResponseInfo : " + JSON.stringify(messages) );
	console.log( "[mirinae.maru] messages.time : " + messages.time );
	
	$.each(messages, function(key, value){
		//console.log( "[mirinae.maru] key : " + key +"\t"+ JSON.stringify(value.NAME) );
	});
	
	var msgVal = new Object();
	msgVal.msg = messages;

	$("#temperatureResourceInfo").html($(temperatureTmpl).tmpl(msgVal));
	$("#cpuResourceInfo").html( $(cpuTmpl).tmpl(msgVal) );
	$("#diskResourceInfo").html( $(diskTmpl).tmpl(msgVal) );
	$("#memoryResourceInfo").html( $(memoryTmpl).tmpl(msgVal) );
	$("#queueResourceInfo").html( $(queueTmpl).tmpl(msgVal) );
	$("#tablespaceResourceInfo").html( $(tablespaceTmpl).tmpl(msgVal) );
	$("#nicResourceInfo").html( $(nicTmpl).tmpl(msgVal) );
	
	fnDrawChart( messages );

	$.ajax({
        url 	: "dateTime",
        data	: new Object(),
        type 	: 'POST',
        dataType: 'text',
        success : function(datePattern) {
        	var dt = new Date(messages.time).format(datePattern);
        	$(".socketTime").text(dt);
        },
        error: function(e){
        	openAlertModal(e.responseText);
        },
        complete : function() {}
	});
	
}

/*Date.prototype.format = function(f) {
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
	            case "ss": return d.getDate().zf(2);
	            case "hh": return d.getDate().zf(2);
	            default: return $1;
	        }
	    });
    };
    }*/
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};

function fnDrawChart( msg ) {
	
	var tempObj;

	var temperatureArrData 	= new Array();
	var cpuArrData 			= new Array();
	var diskArrData 		= new Array();
	var memoryArrData 		= new Array();
	var queueArrData 		= new Array();
	var tablespaceArrData 	= new Array();
	var nicArrData 			= new Array();
	
	$.each(msg, function(key, value){
		
		if( value.NAME!=undefined && value.NAME=="CPU TEMP" ) {
		
			var i=0;
			var colorArr = ["#28b4cb", "#265299", "#f54725", "#c8cc43", "#7956ba", "#bc7a48", "#df4083", "#1c834e", "#40484f"];
			
			delete value.LIST;
			delete value.NAME;
			
			$.each(value, function(k, v) {
				tempObj = new Object();
				
				tempObj.name 	= k;
				tempObj.avg		= v.avg ;
				tempObj.color 	= colorArr[i++];
				
				//console.log( "[mirinae.maru] cpu temperature data : " + JSON.stringify(tempObj) );
				
				temperatureArrData.push( tempObj );
			});
		}
		
		if( value.NAME!=undefined && value.NAME=="CPU" ) {			
			
			delete value.LIST;
			delete value.NAME;
			var colorArr = ["#28b4cb", "#265299", "#f54725", "#c8cc43", "#7956ba", "#bc7a48", "#df4083", "#1c834e", "#40484f"];
			var i = 0;
			$.each(value, function(k, v) {
				tempObj = new Object();

				tempObj.name 	= k;
				tempObj.usage	= v.usage;
				tempObj.color 	= colorArr[i++];
				
				cpuArrData.push( tempObj );
			});
		}
		
		if( value.NAME!=undefined && value.NAME=="DISK" ) {
			
			delete value.LIST;
			delete value.NAME;
			var colorArr = ["#28b4cb", "#265299", "#f54725", "#c8cc43", "#7956ba", "#bc7a48", "#df4083", "#1c834e", "#40484f"];
			var i = 0;
			$.each(value, function(k, v) {
				tempObj = new Object();

				tempObj.name 	= k;
				tempObj.usage	= v.usage;
				tempObj.color 	= colorArr[i++];
				
				diskArrData.push( tempObj );
			});
		}
		
		if( value.NAME!=undefined && value.NAME=="Memory" ) {
			delete value.LIST;
			delete value.NAME;
			
			$.each(value, function(k, v) {
				tempObj = new Object();
				tempObj.name 	= "Free";
				tempObj.usage	= v.free;
				memoryArrData.push( tempObj );

				tempObj = new Object();
				tempObj.name 	= "Used";
				tempObj.usage	= v.used;
				memoryArrData.push( tempObj );
			});
		}
		
		if( value.NAME!=undefined && value.NAME=="QUEUE" ) {
			
			var colorArr = ["#28b4cb", "#265299", "#f54725", "#c8cc43", "#7956ba", "#bc7a48", "#df4083", "#1c834e", "#40484f"];
			
			delete value.LIST;
			delete value.NAME;
			var i = 0
			$.each(value, function(k, v) {
				
				tempObj = new Object();
				
				tempObj.color 	= colorArr[i++];
				tempObj.name 	= k;
				tempObj.usage	= v.usage ;
				
				queueArrData.push( tempObj );
			});
		}
		
		if( value.NAME!=undefined && value.NAME=="DB Table Space" ) {
			
			var i=0;
			var colorArr = ["#28b4cb", "#265299", "#f54725", "#c8cc43", "#7956ba", "#bc7a48", "#df4083", "#1c834e", "#40484f"];
			
			delete value.LIST;
			delete value.NAME;
			
			//console.log( "[mirinae.maru] DB Table Space : " + JSON.stringify(value) ); 
			
			$.each(value, function(k, v) {
				tablespaceArrData = new Array();
				tempObj = new Object();
				tempObj.name 	= "Free";
				tempObj.usage	= v.free;
				tablespaceArrData.push( tempObj );

				tempObj = new Object();
				tempObj.name 	= "Used";
				tempObj.usage	= v.used;
				tablespaceArrData.push( tempObj );
				
			});
		}
		
		if( value.NAME!=undefined && value.NAME=="NIC" ) {
			delete value.LIST;
			delete value.NAME;
			
			$.each(value, function(k, v) {
				tempObj = new Object();
				
				tempObj.name 	= k;
				tempObj.tx		= v.TX ;
				tempObj.rx		= v.RX ;
				
				nicArrData.push( tempObj );
			});
		}
	});
	
	console.log( "[mirinae.maru] temperatureArrData : " + JSON.stringify(temperatureArrData) );
	console.log( "[mirinae.maru] cpuArrData : " + JSON.stringify(cpuArrData) );
	console.log( "[mirinae.maru] diskArrData : " + JSON.stringify(diskArrData) );
	console.log( "[mirinae.maru] memoryArrData : " + JSON.stringify(memoryArrData) );
	console.log( "[mirinae.maru] queueArrData : " + JSON.stringify(queueArrData) );
	console.log( "[mirinae.maru] tablespaceArrData : " + JSON.stringify(tablespaceArrData) );
	console.log( "[mirinae.maru] nicArrData : " + JSON.stringify(nicArrData) );
	
	if( isDrawed )  {
		reMakeChart(temperatureArrData, cpuArrData, diskArrData, memoryArrData, queueArrData, tablespaceArrData, nicArrData);
	}
	else {
		makeChart(temperatureArrData, cpuArrData, diskArrData, memoryArrData, queueArrData, tablespaceArrData, nicArrData);
		isDrawed = true;
	}
}

var temperatureChart;
var cpuChart;
var diskChart;
var memoryChart;
var queueChart;
var tablespaceChart;
var nicChart;

function makeChart( temperatureArrData, cpuArrData, diskArrData, memoryArrData, queueArrData, tablespaceArrData, nicArrData) {
	
	console.log( "[mirinae.maru] makeChart~~~" );
	console.log( "[mirinae.maru] temperatureArrData : " + JSON.stringify(temperatureArrData) );
	console.log( "[mirinae.maru] temperatureArrData : " + JSON.stringify(temperatureArrData) );
	console.log( "[mirinae.maru] temperatureArrData : " + JSON.stringify(temperatureArrData) );
	console.log( "[mirinae.maru] temperatureArrData : " + JSON.stringify(temperatureArrData) );
	console.log( "[mirinae.maru] temperatureArrData : " + JSON.stringify(temperatureArrData) );
	 
	// CPU Temperature
	temperatureChart = AmCharts.makeChart("chart_bar_01", {
		"type": "serial",
	    "categoryField": "name",
	    "columnWidth": 0.4,
	    "startDuration": 1,
	    "fontFamily": "Segoe UI",
	    "fontSize": 12,
	    "autoMarginOffset": 20,
	    "marginBottom": 70,
	    "marginLeft": 60,
	    "marginRight": 35,
	    "marginTop": 40,
	    "addClassNames": true,
	    "classNamePrefix": "amcharts_bar",
	    "categoryAxis": {
	      "autoRotateAngle": 45,
	      "autoRotateCount": 0,
	      "gridPosition": "start",
	      "tickPosition": "start",
	      "gridAlpha": 0,
	      "color": "#3e3e3e",
	      "axisColor": "#3e3e3e",
	      "labelOffset": 5,
	      "tickLength": 0
	    },
	    "trendLines": [],
	    "graphs": [
	      {
	        "balloonText": "[[name]]:<br><p style='font-size:14px'><b>[[value]]</b></p>",
	        "colorField": "color",
	        "fillAlphas": 1,
	        "id": "AmGraph-1",
	        "lineColorField": "color",
	        "title": "graph 1",
	        "type": "column",
	        "valueField": "avg"
	      }
	    ],
	    "guides": [],
	    "valueAxes": [
	      {
	        "id": "ValueAxis-1",
	        "color": "#3e3e3e",
	        "axisColor": "#3e3e3e",
	        "gridAlpha": 1,
	        "gridColor": "#c2c2c2",
	        "dashLength": 3,
	        "tickLength": 4,
	        "title": ""
	      }
	    ],
	    "allLabels": [],
	    "balloon": {
	      "fillAlpha": 0.9,
	      "fontSize": 12
	    },
	    "titles": [],
	    "dataProvider": temperatureArrData
	});
	
	// CPU
	cpuChart = AmCharts.makeChart("chart_pie_01", {
		"type": "serial",
	    "categoryField": "name",
	    "columnWidth": 0.4,
	    "startDuration": 1,
	    "fontFamily": "Segoe UI",
	    "fontSize": 12,
	    "autoMarginOffset": 20,
	    "marginBottom": 70,
	    "marginLeft": 60,
	    "marginRight": 35,
	    "marginTop": 40,
	    "addClassNames": true,
	    "classNamePrefix": "amcharts_bar",
	    "categoryAxis": {
	      "autoRotateAngle": 45,
	      "autoRotateCount": 0,
	      "gridPosition": "start",
	      "tickPosition": "start",
	      "gridAlpha": 0,
	      "color": "#3e3e3e",
	      "axisColor": "#3e3e3e",
	      "labelOffset": 5,
	      "tickLength": 0
	    },
	    "trendLines": [],
	    "graphs": [
	      {
	        "balloonText": "[[name]]:<br><p style='font-size:14px'><b>[[value]]</b></p>",
	        "colorField": "color",
	        "fillAlphas": 1,
	        "id": "AmGraph-1",
	        "lineColorField": "color",
	        "title": "graph 1",
	        "type": "column",
	        "valueField": "usage"
	      }
	    ],
	    "guides": [],
	    "valueAxes": [
	      {
	        "id": "ValueAxis-1",
	        "color": "#3e3e3e",
	        "axisColor": "#3e3e3e",
	        "gridAlpha": 1,
	        "gridColor": "#c2c2c2",
	        "dashLength": 3,
	        "tickLength": 4,
	        "title": ""
	      }
	    ],
	    "allLabels": [],
	    "balloon": {
	      "fillAlpha": 0.9,
	      "fontSize": 12
	    },
	    "titles": [],
	    "dataProvider": cpuArrData
	});
	
	// DISK
	diskChart = AmCharts.makeChart("chart_bar_02", {
		"type": "serial",
	    "categoryField": "name",
	    "columnWidth": 0.4,
	    "startDuration": 1,
	    "fontFamily": "Segoe UI",
	    "fontSize": 12,
	    "autoMarginOffset": 20,
	    "marginBottom": 70,
	    "marginLeft": 60,
	    "marginRight": 35,
	    "marginTop": 40,
	    "addClassNames": true,
	    "classNamePrefix": "amcharts_bar",
	    "categoryAxis": {
	      "autoRotateAngle": 45,
	      "autoRotateCount": 0,
	      "gridPosition": "start",
	      "tickPosition": "start",
	      "gridAlpha": 0,
	      "color": "#3e3e3e",
	      "axisColor": "#3e3e3e",
	      "labelOffset": 5,
	      "tickLength": 0
	    },
	    "trendLines": [],
	    "graphs": [
	      {
	        "balloonText": "[[name]]:<br><p style='font-size:14px'><b>[[value]]</b></p>",
	        "colorField": "color",
	        "fillAlphas": 1,
	        "id": "AmGraph-1",
	        "lineColorField": "color",
	        "title": "graph 1",
	        "type": "column",
	        "valueField": "usage"
	      }
	    ],
	    "guides": [],
	    "valueAxes": [
	      {
	        "id": "ValueAxis-1",
	        "color": "#3e3e3e",
	        "axisColor": "#3e3e3e",
	        "gridAlpha": 1,
	        "gridColor": "#c2c2c2",
	        "dashLength": 3,
	        "tickLength": 4,
	        "title": ""
	      }
	    ],
	    "allLabels": [],
	    "balloon": {
	      "fillAlpha": 0.9,
	      "fontSize": 12
	    },
	    "titles": [],
	    "dataProvider": diskArrData
	});
	
	// Memory
	memoryChart = AmCharts.makeChart("chart_pie_02", {
		
		"type": "pie",
	    "colors": [
	      "#28b4cb",
	      "#265299",
	      "#f54725",
	      "#c8cc43",
	      "#7956ba",
	      "#bc7a48",
	      "#3271d8",
	      "#df4083",
	      "#1c834e",
	      "#40484f"
	    ],
	    "balloonText": "[[name]]<br><p style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</p>",
	    "startRadius": "100%",
	    "startDuration": 1,
	    "labelText": "[[title]]: [[percents]]%",
	    "pullOutRadius": "12%",
	    "titleField": "name",
	    "valueField": "usage",
	    "fontSize": 11,
	    "color":"#333333",
	    "allLabels": [],
	    "balloon": {
	      "fillAlpha": 0.9,
	      "textAlign": "left",
	      "color": "#222222"
	    },
	    "titles": [],
	    "dataProvider": memoryArrData
	});
	
	queueChart = AmCharts.makeChart("chart_bar_03", {
		
		"type": "serial",
	    "categoryField": "name",
	    "columnWidth": 0.4,
	    "startDuration": 1,
	    "fontFamily": "Segoe UI",
	    "fontSize": 12,
	    "autoMarginOffset": 20,
	    "marginBottom": 70,
	    "marginLeft": 60,
	    "marginRight": 35,
	    "marginTop": 40,
	    "addClassNames": true,
	    "classNamePrefix": "amcharts_bar",
	    "categoryAxis": {
	      "autoRotateAngle": 45,
	      "autoRotateCount": 0,
	      "gridPosition": "start",
	      "tickPosition": "start",
	      "gridAlpha": 0,
	      "color": "#3e3e3e",
	      "axisColor": "#3e3e3e",
	      "labelOffset": 5,
	      "tickLength": 0
	    },
	    "trendLines": [],
	    "graphs": [
	      {
	        "balloonText": "[[name]]:<br><p style='font-size:14px'><b>[[value]]</b></p>",
	        "colorField": "color",
	        "fillAlphas": 1,
	        "id": "AmGraph-1",
	        "lineColorField": "color",
	        "title": "graph 1",
	        "type": "column",
	        "valueField": "usage"
	      }
	    ],
	    "guides": [],
	    "valueAxes": [
	      {
	        "id": "ValueAxis-1",
	        "color": "#3e3e3e",
	        "axisColor": "#3e3e3e",
	        "gridAlpha": 1,
	        "gridColor": "#c2c2c2",
	        "dashLength": 3,
	        "tickLength": 4,
	        "title": ""
	      }
	    ],
	    "allLabels": [],
	    "balloon": {
	      "fillAlpha": 0.9,
	      "fontSize": 12
	    },
	    "titles": [],
	    "dataProvider": queueArrData
	});
	
	// DB Table Space
	tablespaceChart = AmCharts.makeChart("chart_pie_03", {
		"type": "pie",
	    "colors": [
	      "#28b4cb",
	      "#265299",
	      "#f54725",
	      "#c8cc43",
	      "#7956ba",
	      "#bc7a48",
	      "#3271d8",
	      "#df4083",
	      "#1c834e",
	      "#40484f"
	    ],
	    "balloonText": "[[name]]<br><p style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</p>",
	    "startRadius": "100%",
	    "startDuration": 1,
	    "labelText": "[[title]]: [[percents]]%",
	    "pullOutRadius": "12%",
	    "titleField": "name",
	    "valueField": "usage",
	    "fontSize": 11,
	    "color":"#333333",
	    "allLabels": [],
	    "balloon": {
	      "fillAlpha": 0.9,
	      "textAlign": "left",
	      "color": "#222222"
	    },
	    "titles": [],
	    "dataProvider": tablespaceArrData
	});
	
	nicChart = AmCharts.makeChart("chart_cluster_01", {
		"type": "serial",
	    "colors": [
	      "#3271d8",
	      "#40484f"
	    ],
	    "categoryField": "name",
	    "rotate": true,
	    "columnSpacing": 4,
	    "columnWidth": 0.5,
	    "sequencedAnimation": false,
	    "startDuration": 2,
	    "fontFamily": "Segoe UI",
	    "fontSize": 12,
	    "autoMarginOffset": 20,
	    "marginBottom": 100,
	    "marginLeft": 60,
	    "marginRight": 35,
	    "marginTop": 40,
	    "addClassNames": true,
	    "classNamePrefix": "amcharts_cluster",
	    "categoryAxis": {
	      "gridPosition": "start",
	      "gridAlpha": 1,
	      "gridColor": "#c2c2c2",
	      "dashLength": 3,
	      "color": "#3e3e3e",
	      "axisColor": "#3e3e3e",
	      "labelOffset": 0,
	      "tickLength": 0
	    },
	    "trendLines": [],
	    "graphs": [
	      {
	        "balloonText": "[[name]]<br><p style='font-size:14px'>TX: <b>[[value]]</b><p>",
	        "fillAlphas": 1,
	        "id": "AmGraph-1",
	        "title": "graph 1",
	        "type": "column",
	        "valueField": "rx"
	      },
	      {
	        "balloonText": "[[name]]<br><p style='font-size:14px'>RX: <b>[[value]]</b><p>",
	        "fillAlphas": 1,
	        "id": "AmGraph-2",
	        "title": "graph 2",
	        "type": "column",
	        "valueField": "tx"
	      }
	    ],
	    "guides": [],
	    "valueAxes": [
	      {
	        "id": "ValueAxis-1",
	        "color": "#3e3e3e",
	        "axisColor": "#3e3e3e",
	        "gridAlpha": 0,
	        "gridColor": "#c2c2c2",
	        "dashLength": 3,
	        "tickLength": 4,
	        "title": ""
	      }
	    ],
	    "allLabels": [],
	    "balloon": {
	      "fillAlpha": 0.9,
	      "fontSize": 12
	    },
	    "titles": [],
	    "dataProvider": nicArrData
	});
	
	
	
	
	try {
		AmCharts.checkEmptyData(temperatureChart);
	}
	catch ( e ) {
		console.log( "예외 : " + e.message );
	}
}

function reMakeChart( temperatureArrData, cpuArrData, diskArrData, memoryArrData, queueArrData, tablespaceArrData, nicArrData) {
	
	console.log( "[mirinae.maru] reMakeChart~~~" );
	console.log( "[mirinae.maru] cpuArrData : " + JSON.stringify(cpuArrData) );
	
	temperatureChart.dataProvider = temperatureArrData;
	temperatureChart.validateData();
	
	cpuChart.dataProvider = cpuArrData;
	cpuChart.validateData();
	
	diskChart.dataProvider = diskArrData;
	diskChart.validateData();
	
	memoryChart.dataProvider = memoryArrData;
	memoryChart.validateData();
	
	queueChart.dataProvider = queueArrData;
	queueChart.validateData();
	
	tablespaceChart.dataProvider = tablespaceArrData;
	tablespaceChart.validateData();
	
	nicChart.dataProvider = nicArrData;
	nicChart.validateData();
	
	console.log('AmCharts.checkEmptyData(temperatureChart);');
	try {
		AmCharts.checkEmptyData(temperatureChart);
	}
	catch ( e ) {
		console.log( "예외 : " + e.message );
	}
}

AmCharts.checkEmptyData = function (chart) {
	
	console.log( "[mirinae.maru] chart.dataProvider.length : " + chart.dataProvider.length );
	console.log( "[mirinae.maru] chart.dataProvider.length : " + chart.dataProvider.length );
	console.log( "[mirinae.maru] chart.dataProvider.length : " + chart.dataProvider.length );
	console.log( "[mirinae.maru] chart.dataProvider.length : " + chart.dataProvider.length );
	console.log( "[mirinae.maru] chart.dataProvider.length : " + chart.dataProvider.length );
    
	if ( 0 == chart.dataProvider.length ) {
        // set min/max on the value axis
        chart.valueAxes[0].minimum = 0;
        chart.valueAxes[0].maximum = 100;
        
        console.log( "[mirinae.maru] chart.dataProvider... 1" );
        
        // add dummy data point
        var dataPoint = {
            dummyValue: 0
        };
        
        console.log( "[mirinae.maru] chart.dataProvider... 2" );
        
        dataPoint[chart.categoryField] = '';
        chart.dataProvider = [dataPoint];
        
        console.log( "[mirinae.maru] chart.dataProvider... 3" );
        
        // add label
        chart.addLabel(0, '50%', 'The chart contains no data', 'center');
        
        console.log( "[mirinae.maru] chart.dataProvider... 4" );
        
        // set opacity of the chart div
        chart.chartDiv.style.opacity = 0.5;
        
        console.log( "[mirinae.maru] chart.dataProvider... 5" );
        
        
        // redraw it
        chart.validateNow();
        
        console.log( "[mirinae.maru] chart.dataProvider... 6" );
        
    }
}
