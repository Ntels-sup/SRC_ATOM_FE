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
	
	 $("select.multi").multipleSelect({
		   	filter: true,
         multiple: true,
			multipleWidth: 150,
         width: "162px"
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
	
	
	goSearch();
	


});

function fnInit(){
	
	var endTime = "${endHour}"+":"+"${endMin}";
    $("#endTime").val(endTime);
} 

function goSearch(){

	var pscheck = $("#system_id").val();
	// 시스템 콤보 선택 체크
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="msg.alarm.history.systemNoncheck" />');
	    return;
	}
	
	// 그룹 콤보 선택 체크	
	pscheck = $("#group_id").val();
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="msg.alarm.history.groupNoncheck" />');
	    return;
	}
	
	// Severity
	pscheck = $("#severity_id").val();
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="msg.alarm.history.severityNoncheck" />');
	    return;
	}
	
	//날짜 체크
	var startTime = $("#startTime").val().split(":");
	$("#startHour").val(startTime[0]);
	$("#startMin").val(startTime[1]);
	var endTime = $("#endTime").val().split(":");
	$("#endHour").val(endTime[0]);
	$("#endMin").val(endTime[1]);
	
	var returnMsg = fnCheckHistPeriod(startDate, startHour, startMin, endDate, endHour, endMin, '${fn:toLowerCase(dateformat)}');
	if(returnMsg != "") {
   		openAlertModal('<spring:message code="msg.alarm.statistics.wrong_period" />');
   		return;
	}	
	
	//$("#keyTextBox").val($.trim($("#keyTextBox").val()));
	
	var startTimeArray = $("#startTime").val().split(':');
	$("#startHour").val(startTimeArray[0]); 
	$("#startMin").val(startTimeArray[1]); 
	
	var endTimeArray = $("#endTime").val().split(':');
	$("#endHour").val(endTimeArray[0]); 
	$("#endMin").val(endTimeArray[1]); 
	
 		
   	
	fnShowLoading();
	
	var param = $("#myForm").serialize();
        $.post('listAction.ajax', param, function(data) {
            $('#dataTable').html(data);
        });
    }
    

	
    function fnTypeAction(){
        var typeId = $("#typeId").val();

		if (typeId == '2') {//Hour
            $("#startHour").removeAttr("disabled");
            $("#startMin").attr("disabled",true);
            
            $("#endHour").removeAttr("disabled");  
            $("#endMin").attr("disabled",true);
        }else if (typeId == '3' || typeId == '4') {//Day,Month
            $("#startHour").attr("disabled",true);
            $("#startMin").attr("disabled",true);
            
            $("#endHour").attr("disabled",true);
            $("#endMin").attr("disabled",true);
        }else { //5Min,10Min,30Min
            $("#startHour").removeAttr("disabled");
            $("#startMin").removeAttr("disabled");
            
            $("#endHour").removeAttr("disabled");  
            $("#endMin").removeAttr("disabled");
        }
    }
    
    /**
     * Loading image
     */
    function fnShowLoading() {
        var loadImage =  '<div class="scroll" id="loading"><div class="loading"><span class="loading-inner"></span></div></div>';;
        $('.data').children().remove();
        $('.data').append(loadImage);   
    }

    function fnExcel(){
    	if($("tbody > tr > td").html() == '<spring:message code="label.empty.list" />') {
        	openAlertModal('<spring:message code="msg.common.excel.download.alarm" />');
            return;
        }
    	var pscheck = $("#system_id").val();
    	// 시스템 콤보 선택 체크
    	if(pscheck == null || pscheck == ''){
    		openAlertModal('<spring:message code="msg.alarm.history.systemNoncheck" />');
    	    return;
    	}
    	// 그룹 콤보 선택 체크	
    	pscheck = $("#group_id").val();
    	if(pscheck == null || pscheck == ''){
    		openAlertModal('<spring:message code="msg.alarm.history.groupNoncheck" />');
    	    return;
    	}
    	// Severity
    	pscheck = $("#severity_id").val();
    	if(pscheck == null || pscheck == ''){
    		openAlertModal('<spring:message code="msg.alarm.history.severityNoncheck" />');
    	    return;
    	}

    	//날짜 체크
    	var startTime = $("#startTime").val().split(":");
    	$("#startHour").val(startTime[0]);
    	$("#startMin").val(startTime[1]);
    	var endTime = $("#endTime").val().split(":");
    	$("#endHour").val(endTime[0]);
    	$("#endMin").val(endTime[1]);
    	
    	var returnMsg = fnCheckHistPeriod(startDate, startHour, startMin, endDate, endHour, endMin, '${fn:toLowerCase(dateformat)}');
    	if(returnMsg != "") {
       		openAlertModal('<spring:message code="msg.alarm.statistics.wrong_period" />');
       		return;
    	}
    	
    	var param = $("#myForm").serialize();
        $.download('exportAction.xls',param,'post');
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
		                                <input type="text" readonly="readonly" id="startDate" name="startDate"  class="form-control"  value="${startDate}">
		                                <span class="input-group-addon icon"></span> </div>
		                           </div>
		                        <div class="input-period clockpicker" data-placement="bottom" data-align="top" data-autoclose="true">
		                            <input type="text" readonly="readonly" id="startTime" name="startTime" class="form-control" value="00:00">
		                            <span class="input-period-addon"></span> </div>
		                        <span class="dash"></span>
		                        <div class="input-period">
		                            <div class="input-group date" data-date-end-date="0d">
		                                <input type="text" readonly="readonly" id="endDate" name="endDate"  class="form-control" value="${endDate}">
		                                <span class="input-group-addon icon"></span> </div>
		                        </div>
		                        <div class="input-period clockpicker" data-placement="bottom" data-align="top" data-autoclose="true">
		                            <input type="text" readonly="readonly" id="endTime" name="endTime" class="form-control" value="00:00">
		                            <span class="input-period-addon"></span> </div>
		                    </div>
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
                        
                        <div class="select_multi">
		                    <label><spring:message code="label.alarm.history.group_type.text"/></label>
		                    <select id="group_id" name="group_id"  class="multi" multiple="multiple">
                                  <c:forEach items="${listAlmGroup}" var="AlmGroup" varStatus="status">
					              	<option value="${AlmGroup.ID}">${AlmGroup.NAME}</option>
					              </c:forEach>
		                    </select>
                		</div>
                		
                		<div class="select_multi"><label><spring:message code="label.alarm.history.severity.text"/></label>
                		<select id="severity_id" name="severity_id"  class="multi" multiple="multiple">
                                  <c:forEach items="${listAlarmSeverity}" var="AlarmSeverity" varStatus="status">
					              <option value="${AlarmSeverity.ID}">${AlarmSeverity.NAME}</option>
					              </c:forEach>
                        </select>
                		</div>
		                <div class="select_single">
		                    <label><spring:message code="label.alarm.history.cleared_flag.text"/></label>  
		                    <select id="cleared_flag" name="cleared_flag" class="single">
		                        <option value="all" Selected>All</option>
		                        <option value="Y">Y</option>
		                        <option value="N">N</option>
		                    </select>
		                </div>
                		

                        <div class="select_keyword">
                        <label>Keyword</label>
                        <select class="single" id="keyWord" name="keyWord" >
                            <option value="code" Selected>Code</option>
                            <option value="location">Location</option>
                            <option value="probableCause">Probable Cause</option>
                        </select>
                        <input type="text" id="keyTextBox" name="keyTextBox" placeholder="Keywords"/>
                        </div>
                        
                        <button  type="button" id="btn_search" class="srch" title="<spring:message code="label.common.search"/>"><spring:message code="label.common.search"/></button>  
                    </div>
                    </div><!-- //search_area -->
		             
		            <div class="util_btn">
		                <div class="dropdown">
		                    <button type="button" class="dropbtn"><spring:message code="label.common.downlaod" /></button>
		                    <ul class="dropdown_content">
		                        <li><a href="javascript:fnExcel();"><spring:message code="label.common.excel" /></a></li>
		                    </ul>
		                </div>
		             </div>
			<!-- listAction inner Html -->
			<div id="dataTable"></div>                   
			<!-- list Action -->             
             
             </div><!-- //cont_body -->
        
</div><!--// content -->
</form>

</body>
</html>
