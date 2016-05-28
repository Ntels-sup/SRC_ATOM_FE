<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

 <head>
 	<meta charset="UTF-8">
 	<meta http-equiv="X-UA-Compatible" content="IE=edge">
 	<title>ATOM</title>

<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/selectBox.js"></script>

 
<script src="/scripts/locales/bootstrap-datepicker.${language}.min.js" charset="UTF-8"></script>


    
<script type="text/javascript">
var language = '${language}';

$(document).ready(function() {

	fnInit();
	
	/* Clock */
	 $(".clockpicker").clockpicker().find("input").change(function(){});
	
	 $("select.group").multipleSelect({
			filter		: true,
         multiple	: true,
         multipleWidth: 150,
         width		: "602px"
     });
	
	$("select.single").multipleSelect({
        single: true,
        selectAll: false,
        multiple: false
    });
	
	$("select.multi,select.group").multipleSelect("checkAll");	
	
	/* Calendar */
     $('.input-group.date').datepicker({
    	        format: '${fn:toLowerCase(dateformat)}',       
    	        language: language,
	            autoclose: true,
	            todayHighlight: true
	       
     });
	
	//버튼 클릭시
    $("#btn_search").click(function() {
    	$("#page").val("1");
        goSearch();
    });
	
    $("#keyTextBox").blur( function(){
    	$("#keyTextBox").val($.trim($("#keyTextBox").val()));
    });
	
    fnConstrutChart();
	goSearch();
	


});

function fnInit(){
	
	var endTime = "${endHour}"+":"+"${endMin}";
    $("#endTime").val(endTime);
} 

function goSearch(){

	var pscheck = $("#system_id").val();
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="msg.alarm.statistics.systemNoncheck" />');
	    return;
	}
	
	//$("#keyTextBox").val($.trim($("#keyTextBox").val()));
	
	var startTimeArray = $("#startTime").val().split(':');
	$("#startHour").val(startTimeArray[0]); 
	$("#startMin").val(startTimeArray[1]); 
	
	var endTimeArray = $("#endTime").val().split(':');
	$("#endHour").val(endTimeArray[0]); 
	$("#endMin").val(endTimeArray[1]); 
	
	var returnMsg = fnCheckPeriod(startDate, startHour, startMin, endDate, endHour, endMin, typeId);
   	
   	if(returnMsg != "") {
       	if(returnMsg == 'wrong_period') {
       		openAlertModal('<spring:message code="msg.alarm.statistics.wrong_period" />');
       	} else if(returnMsg == 'is5minutePerDay') {
       		openAlertModal('<spring:message code="msg.alarm.statistics.is5minutePerDay" />'+'${holyCheck_dat}'+'<spring:message code="msg.alarm.statistics.End" />');
       	} else if(returnMsg == 'is10minutePerDay') {
       		openAlertModal('<spring:message code="msg.alarm.statistics.is10minutePerDay" />'+'${holyCheck_dat}'+'<spring:message code="msg.alarm.statistics.End" />');
       	} else if(returnMsg == 'is30minutePerDay') {
       		openAlertModal('<spring:message code="msg.alarm.statistics.is30minutePerDay" />'+'${holyCheck_dat}'+'<spring:message code="msg.alarm.statistics.End" />');
       	} else if(returnMsg == 'ishourPerYear') {
       		openAlertModal('<spring:message code="msg.alarm.statistics.ishourPerYear" />'+'${dailyCheck_dat}'+'<spring:message code="msg.alarm.statistics.End" />');
       	}

   		return;
   	}		
   	
	fnShowLoading();
	
	var param = $("#myForm").serialize();
        $.post('listAction.ajax', param, function(data) {
            $('#dataTable').html(data);
        });
    }
    

	
    
    /**
     * Loading image
     */
    function fnShowLoading() {
        var loadImage =  '<div class="scroll" id="loading"><div class="loading"><span class="loading-inner"></span></div></div>';;
        $('.data').children().remove();
        $('.data').append(loadImage);   
    }

    /** 
    엑셀 함수
    **/
    function fnExcel(){
        if($("tbody > tr > td").html() == '<spring:message code="label.empty.list" />') {
        	openAlertModal('<spring:message code="msg.common.excel.download.alarm" />');
            return;
        }
        
    	var pscheck = $("#system_id").val();
    	if(pscheck == null || pscheck == ''){
    		openAlertModal('<spring:message code="msg.alarm.statistics.systemNoncheck" />');
    	    return;
    	}
    	
    	//$("#keyTextBox").val($.trim($("#keyTextBox").val()));
    	
    	var startTimeArray = $("#startTime").val().split(':');
    	$("#startHour").val(startTimeArray[0]); 
    	$("#startMin").val(startTimeArray[1]); 
    	
    	var endTimeArray = $("#endTime").val().split(':');
    	$("#endHour").val(endTimeArray[0]); 
    	$("#endMin").val(endTimeArray[1]); 
    	
    	var returnMsg = fnCheckPeriod(startDate, startHour, startMin, endDate, endHour, endMin, typeId);
       	
       	if(returnMsg != "") {
           	if(returnMsg == 'wrong_period') {
           		openAlertModal('<spring:message code="msg.alarm.statistics.wrong_period" />');
           	} else if(returnMsg == 'is5minutePerDay') {
           		openAlertModal('<spring:message code="msg.alarm.statistics.is5minutePerDay" />'+'${holyCheck_dat}'+'<spring:message code="msg.alarm.statistics.End" />');
           	} else if(returnMsg == 'is10minutePerDay') {
           		openAlertModal('<spring:message code="msg.alarm.statistics.is10minutePerDay" />'+'${holyCheck_dat}'+'<spring:message code="msg.alarm.statistics.End" />');
           	} else if(returnMsg == 'is30minutePerDay') {
           		openAlertModal('<spring:message code="msg.alarm.statistics.is30minutePerDay" />'+'${holyCheck_dat}'+'<spring:message code="msg.alarm.statistics.End" />');
           	} else if(returnMsg == 'ishourPerYear') {
           		openAlertModal('<spring:message code="msg.alarm.statistics.ishourPerYear" />'+'${dailyCheck_dat}'+'<spring:message code="msg.alarm.statistics.End" />');
           	}

       		return
       	}
		
       	var param = $("#myForm").serialize();
        $.download('exportAction.xls',param,'post' );
    }
    
    var chart;    
    function fnConstrutChart() {
    	chart = AmCharts.makeChart("chartdiv",
     			{
     	    "type": "serial",
     	    "categoryField": "PRC_DATE",
     	    "colors": [
     	              "#29b4cc",
     	              "#fd625e",
     	              "#404f52",
     	              "#f2c318",
     	              "#c252cc",
     	              "#bd7b4b",
     	              "#3272d9",
     	              "#f21835",
     	              "#32c253",
     	              "#ef8ede",
     	              "#3e7f82"
     	            ],
     	            "plotAreaFillAlphas": 1,
     	            "plotAreaFillColors": "#f8fafa",
     	            "autoMarginOffset": 35,
     	            "marginRight": 354,
     	            "marginTop": 35,
     	            "fontFamily": "Segoe UI",
     	            "fontSize": 12,
     	            "categoryAxis": {
     	              "equalSpacing": true,
     	              "minPeriod": "mm",
     	              "parseDates": true,
     	              "startOnAxis": true,
     	              "gridAlpha": 0,
     	              "labelOffset": -3,
     	              "color": "#3e3e3e",
     	              "axisColor": "#3e3e3e",
     	              "boldPeriodBeginning": false,
     	              "centerLabelOnFullPeriod": false,
     	              "tickLength": 5
     	            },
     	        		"chartCursor": {
     	        			"enabled": true,
     	        			"categoryBalloonDateFormat": "JJ:NN",
     	              "cursorPosition": "middle",
     	              "cursorColor": "#2a3139",
     	              "graphBulletSize": 9,
     	              "selectionAlpha": 0.15
     	        		},
     	        		"chartScrollbar": {
     	        			"enabled": true,
     	              "backgroundColor": "#e1e1e1",
     	              "dragIcon": "dragIconRectBig",
     	              "dragIconHeight": 32,
     	              "scrollbarHeight": 10
     	        		},
     	        		"trendLines": [],
     	        		"allLabels": [],
     	            "balloon": {
     	              /*"adjustBorderColor": false,*/
     	              /*"borderAlpha": 0,*/
     	              /*"color": "#FFFFFF",*/
     	              "borderThickness": 1,
     	              "fontSize": 10,
     	              "cornerRadius": 2,
     	              "fillAlpha": 1,
     	              "pointerWidth": 10,
     	              "shadowAlpha": 0,
     	              "horizontalPadding": 6,
     	              "verticalPadding": 3,
     	              "textAlign": "left"
     	            },
     	            "legend": {
     	              "enabled": true,
     	              "autoMargins": false,
     	              "backgroundAlpha": 1,
     	              "backgroundColor": "#FFF",
     	              "color": "#808080",
     	              "fontSize": 12,
     	              "horizontalGap": 24,
     	              "labelWidth": 200,
     	              "marginLeft": 20,
     	              "marginRight": 20,
     	              "markerLabelGap": 12,
     	              "markerSize": 12,
     	              "markerType": "circle",
     	              "maxColumns": 0,
     	              "position": "absolute",
     	              "verticalGap": 12,
     	              "right": 0,
     	              "width": 284,
     	              "valueText": ""
     	            },
     	        		"titles": [],
     	    	    "export": {
     	    	        "enabled": true,
     	              "libs"  : {
     	                "path": "/scripts/amcharts_3.19.4/amcharts/plugins/export/libs/"
     	              }, 
     	              "menu": []
     	    	    }	
     			}
     	);

    }
    
    
</script>

    </head>
<body>
<form id="myForm" name="myForm" method="post">
			<!-- sort시 필요 -->
	<input type="hidden" id="orderBy" name="orderBy" value="" />
	<input type="hidden" id="sortClass" name="sortClass" value="" />
  	<input type="hidden" id="startHour" name="startHour" value="" />
  	<input type="hidden" id="startMin"  name="startMin"  value="" />
  	<input type="hidden" id="endHour" name="endHour"   value="" />
  	<input type="hidden" id="endMin"  name="endMin"    value="" />
    <input type="hidden" id="titleName"  name="titleName"    value="${titleName}" />
  	<input type="hidden" id="dateformat" name="dateformat" value="${dateformat}" />

		<!-- content -->
		<div class="content">
             <div class="cont_data">

                    <div class="search_area">
                    	<div>
                    	<div class="select_period">
	                         <label>Period</label>
	                         <!--<p class="btn_area">
	                         <button type="button">지난1일</button><button type="button">지난1시간</button>
	                         </p>-->
			                <div class="period">
		                        <div class="input-period">
		                            <div class="input-group date" data-date-end-date="0d">
		                                <input type="text" readonly="readonly" id="startDate" name="startDate"  class="form-control" value="${startDate}">
		                                <span class="input-group-addon icon"></span> </div>
		                        </div>
		                        <div class="input-period clockpicker" data-placement="bottom" data-align="top" data-autoclose="true">
		                            <input type="text"  readonly="readonly"  id="startTime" name="startTime" class="form-control" value="00:00">
		                            <span class="input-period-addon"></span> </div>
		                        <span class="dash"></span>
		                        <div class="input-period">
		                            <div class="input-group date" data-date-start-date="0d">
		                                <input type="text"  readonly="readonly" id="endDate" name="endDate"  class="form-control" value="${endDate}">
		                                <span class="input-group-addon icon"></span> </div>
		                        </div>
		                        <div class="input-period clockpicker" data-placement="bottom" data-align="top" data-autoclose="true">
		                            <input type="text"  readonly="readonly" id="endTime" name="endTime" class="form-control" value="00:00">
		                            <span class="input-period-addon"></span> </div>
		                    </div>
                        </div>
                    
                        <div class="select_single"><label><spring:message code="label.alarm.statistics.cycle.text"/></label>
	                        <select id="typeId" name="typeId" class="single">
	                                  <c:forEach items="${listSearchType}" var="SearchType" varStatus="status">
						              	<option value="${SearchType.ID}">${SearchType.NAME}</option>
						              </c:forEach>
	                        </select>
                        </div>
                        
                        <div class="select_group"><label><spring:message code="label.alarm.statistics.PackageSystem.text"/></label>
	                         <select id="system_id" name="system_id" class="group" multiple="multiple" value="checkAll">
	                            <c:forEach items="${Package}" var="Packagelist" varStatus="status">
		                            <optgroup label="${Packagelist.NAME}">
			                            <c:forEach items="${System}" var="Systemlist" varStatus="status">
			                               <c:if test="${Packagelist.ID eq Systemlist.PACKAGEID}">
			                               		<option value="${Systemlist.ID}">${Systemlist.NAME}</option>
			                               </c:if>
			                            </c:forEach>
		                            </optgroup>
	                            </c:forEach>
	                        </select>
                        </div>
                        <div class="select_single"><label><spring:message code="label.alarm.statistics.severity.text"/></label>
                        <select id="severity" name="severity"  class="single">
                                  <option value="all">ALL</option>
                                  <c:forEach items="${listAlarmSeverity}" var="AlarmSeverity" varStatus="status">
					              <option value="${AlarmSeverity.ID}">${AlarmSeverity.NAME}</option>
					              </c:forEach>
                        </select>
                        </div>
                        <button  type="button" id="btn_search" class="srch" title="<spring:message code="label.common.search"/>"><spring:message code="label.common.search"/></button>
                   	</div>
                    </div><!-- //search_area -->
                    
                    <div class="util_btn">
		                <div class="dropdown">
		                    <button type="button" class="dropbtn"><spring:message code="label.common.downlaod" /></button>
		                    <ul class="dropdown_content">
		                        <li><a href="javascript:exportCharts('${titleName}');"><spring:message code="label.common.pdf" /></a></li>
		                        <li><a href="javascript:fnExcel();"><spring:message code="label.common.excel" /></a></li>
		                    </ul>
		                </div>
	                </div>
<!-- 차트 start-->
		            <div class="chart_area sum"><!-- Total 필요 없을때는 class에서 sum 삭제 -->
		                <div id="chartdiv"></div>
		                <div class="info">
		                    <h5>Alarm Count <span>Total</span></h5>
		                    <p id="alarm_count"></p>
		                    <h6>System</h6>
		                </div>
		            </div>            
<!-- 차트 end-->
			<!-- listAction inner Html -->
			<div id="dataTable"></div>                   
			<!-- list Action -->             
             
             </div><!-- //cont_body -->
        
</div><!--// content -->
</form>

</body>
</html>
