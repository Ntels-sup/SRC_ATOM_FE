/* dashboard chart config */
var totlaAlarmConfig ={
	    "type": "serial",
	    "categoryField": "alarm_group",
	    "colors": [
	      "#dd1717",
	      "#f2690e",
	      "#f2b230",
	      "#7b6b98"
	    ],
	    "columnWidth": 0.2,
	    "startDuration": 1,
	    "categoryAxis": {
	      "gridPosition": "start",
	      "gridAlpha": 0,
	      "axisColor": "#d2d4d6",
	      "color": "#929aa6",
	      "tickLength": 0
	    },
	    "trendLines": [],
	    "graphs": [
	      {
	        "balloonText": "Critical<p style='font-size:14px'><b>[[value]]</b><p>",
	        "fillAlphas": 1,
	        "id": "AmGraph-1",
	        "title": "graph 1",
	        "type": "column",
	        "valueField": "critical"
	      },
	      {
	        "balloonText": "Major<p style='font-size:14px'><b>[[value]]</b><p>",
	        "fillAlphas": 1,
	        "id": "AmGraph-2",
	        "title": "graph 2",
	        "type": "column",
	        "valueField": "major"
	      },
	      {
	        "balloonText": "Minor<p style='font-size:14px'><b>[[value]]</b><p>",
	        "fillAlphas": 1,
	        "id": "AmGraph-3",
	        "title": "graph 3",
	        "type": "column",
	        "valueField": "minor"
	      },
	      {
	        "balloonText": "Fault<p style='font-size:14px'><b>[[value]]</b><p>",
	        "fillAlphas": 1,
	        "id": "AmGraph-4",
	        "title": "graph 4",
	        "type": "column",
	        "valueField": "fault"
	      }
	    ],
	    "guides": [],
	    "valueAxes": [
	      {
	        "id": "ValueAxis-1",
	        "stackType": "regular",
	        "axisAlpha": 0,
	        "gridAlpha": 0,
	        "labelsEnabled": false
	      }
	    ],
	    "allLabels": [],
	    "balloon": {},
	    "titles": []
	     
	  };




/* dashboard chart  config - Top5 resource */
var topResourceConfig = ['CPU','Memory','Disk','Tablespace'];

 /*CPU*/
 topResourceConfig[0] = {
	    "type": "serial",
	    "categoryField": "RSC_ID_NAME",
	    "rotate": true,
	    "autoMargins": false,
	    "marginBottom": 7,
	    "marginLeft": 1,
	    "marginRight": 15,
	    "marginTop": 0,
	    "startDuration": 1,
	    "precision": 2,
	    "addClassNames": true,
	    "fontSize": 12,
	    "categoryAxis": {
	      "axisAlpha": 0,
	      "color": "#828d99",
	      "gridAlpha": 0,
	      "tickLength": 0,
	      "labelsEnabled": false
	    },
	    "graphs": [
	      {
	        "color":"#787e87",
	        "balloonText": "<b>[[value]]GHz</b>",
	        "colorField": "color",
	        "fillAlphas": 1,
	        "fixedColumnWidth": 6,
	        "fontSize": -16,
	        "gradientOrientation": "horizontal",
	        "id": "AmGraph-1",
	        "labelOffset": -3,
	        "labelPosition": "inside",
 	        "labelText": "[[category]] ([[value]]GHz)",
	        "showAllValueLabels": true,
	        "lineColorField": "color",
	        "title": "graph 1",
	        "type": "column",
	        "valueField": "DATA"
	      }
	    ],
	    "valueAxes": [
	      {
	        "id": "ValueAxis-1",
	        "axisAlpha": 0,
	        "gridAlpha": 0,
	        "labelsEnabled": false
	      }
	    ]
	  };

 /*Memory*/
 topResourceConfig[1] = {
		    "type": "serial",
		    "categoryField": "RSC_ID_NAME",
		    "rotate": true,
		    "autoMargins": false,
		    "marginBottom": 7,
		    "marginLeft": 1,
		    "marginRight": 15,
		    "marginTop": 0,
		    "startDuration": 1,
		    "precision": 1,
		    "addClassNames": true,
		    "fontSize": 12,
		    "categoryAxis": {
		      "axisAlpha": 0,
		      "color": "#828d99",
		      "gridAlpha": 0,
		      "tickLength": 0,
		      "labelsEnabled": false
		    },
		    "graphs": [
		      {
		        "color":"#787e87",
		        "balloonText": "<b>[[value]]GB</b>",
		        "colorField": "color",
		        "fillAlphas": 1,
		        "fixedColumnWidth": 6,
		        "fontSize": -16,
		        "gradientOrientation": "horizontal",
		        "id": "AmGraph-1",
		        "labelOffset": -3,
		        "labelPosition": "inside",
		        "labelText": "[[category]] ([[value]]GB)",
		        "showAllValueLabels": true,
		        "lineColorField": "color",
		        "title": "graph 1",
		        "type": "column",
		        "valueField": "DATA"
		      }
		    ],
		    "valueAxes": [
		      {
		        "id": "ValueAxis-1",
		        "axisAlpha": 0,
		        "gridAlpha": 0,
		        "labelsEnabled": false
		      }
		    ]
		  };
 /*Disk*/
 topResourceConfig[2] = {
		    "type": "serial",
		    "categoryField": "RSC_ID_NAME",
		    "rotate": true,
		    "autoMargins": false,
		    "marginBottom": 7,
		    "marginLeft": 1,
		    "marginRight": 15,
		    "marginTop": 0,
		    "startDuration": 1,
		    "addClassNames": true,
		    "fontSize": 12,
		    "categoryAxis": {
		      "axisAlpha": 0,
		      "color": "#828d99",
		      "gridAlpha": 0,
		      "tickLength": 0,
		      "labelsEnabled": false
		    },
		    "graphs": [
		      {
		        "color":"#787e87",
		        "balloonText": "<b>[[value]]MB</b>",
		        "colorField": "color",
		        "fillAlphas": 1,
		        "fixedColumnWidth": 6,
		        "fontSize": -16,
		        "gradientOrientation": "horizontal",
		        "id": "AmGraph-1",
		        "labelOffset": -3,
		        "labelPosition": "inside",
		        "labelText": "[[category]] ([[value]]MB)",
		        "showAllValueLabels": true,
		        "lineColorField": "color",
		        "title": "graph 1",
		        "type": "column",
		        "valueField": "DATA"
		      }
		    ],
		    "valueAxes": [
		      {
		        "id": "ValueAxis-1",
		        "axisAlpha": 0,
		        "gridAlpha": 0,
		        "labelsEnabled": false
		      }
		    ],
		    "dataProvider": [
		      
		    ]
		  };
 /*Tablespace*/
 topResourceConfig[3] = {
		    "type": "serial",
		    "categoryField": "RSC_ID_NAME",
		    "rotate": true,
		    "autoMargins": false,
		    "marginBottom": 7,
		    "marginLeft": 1,
		    "marginRight": 15,
		    "marginTop": 0,
		    "startDuration": 1,
		    "precision": 1,
		    "addClassNames": true,
		    "fontSize": 12,
		    "categoryAxis": {
		      "axisAlpha": 0,
		      "color": "#828d99",
		      "gridAlpha": 0,
		      "tickLength": 0,
		      "labelsEnabled": false
		    },
		    "graphs": [
		      {
		        "color":"#787e87",
		        "balloonText": "<b>[[value]]GB</b>",
		        "colorField": "color",
		        "fillAlphas": 1,
		        "fixedColumnWidth": 6,
		        "fontSize": -16,
		        "gradientOrientation": "horizontal",
		        "id": "AmGraph-1",
		        "labelOffset": -3,
		        "labelPosition": "inside",
		        "labelText": "[[category]] ([[value]]GB)",
		        "showAllValueLabels": true,
		        "lineColorField": "color",
		        "title": "graph 1",
		        "type": "column",
		        "valueField": "DATA"
		      }
		    ],
		    "valueAxes": [
		      {
		        "id": "ValueAxis-1",
		        "axisAlpha": 0,
		        "gridAlpha": 0,
		        "labelsEnabled": false
		      }
		    ]
		  };