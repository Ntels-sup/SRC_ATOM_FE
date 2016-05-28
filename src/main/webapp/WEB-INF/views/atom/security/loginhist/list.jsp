<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>
<script src="/scripts/locales/bootstrap-datepicker.${language}.min.js" charset="UTF-8"></script>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
    	//datepicker
        $(".input-group.date").datepicker({
   	        format: '${fn:toLowerCase(dateformat)}',       
   	        language: "${language}",
	        autoclose: true,
	        todayHighlight: true
		});
    	
        //clockpicker
        $(".clockpicker").clockpicker();
        
    	// multiple select 
		$("select.single").multipleSelect({
	        single: true,
	        selectAll: false,
	        maxHeight: 500,
            multiple: false
		});
		
  		$("#btn_search").click(function(){
    		goSearch();
    	});

  		fnInit();
    });
    
    //init function
    function fnInit(){
    	goSearch();
    }
    
    //oprationHist search
	function goSearch(){
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
		
		fnShowLoading();
				
		var param = new Object();
		param = $("#myForm").serialize();
		console.log(param);

		$.ajax({
            url : "listAction",
            data : param,
            type : 'POST',
            success : function(data) {
               $("#loginHistTable").html(data);
            },
            error : function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {
				
            }
		});
    }
    
    //loading...
   	function fnShowLoading() {
		var loadImage = '<div class="scroll" id="loading"><div class="loading"><span class="loading-inner"></span></div></div>';
	
		$(".data").children().remove();
		$(".data").append(loadImage);
	}
    
    //exportAtion
    function fnExcel(){
    	if($("tbody > tr > td").html() == '<spring:message code="label.empty.list" />') {
    		openAlertModal("","<spring:message code="msg.common.excel.download.alarm" />");
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
		
		var param = new Object();
		param = $("#myForm").serialize();
		$.download('exportAction.xls',param,'post');
    } 
    
    
</script>  
 
	<div class="content">
		<div class="cont_data">
			<form id="myForm" name="myForm">
				<!-- Hour, Min 셋팅 -->
				<input type="hidden" id="startHour" name="startHour" />
				<input type="hidden" id="startMin" name="startMin" />
				<input type="hidden" id="endHour" name="endHour" />
				<input type="hidden" id="endMin" name="endMin" />
				<!-- sort시 필요 -->
	  			<input type="hidden" id="orderBy" name="orderBy">
	  			<input type="hidden" id="sortClass" name="sortClass">
				<!-- excelDownload시 필요 -->
				<input type="hidden" id="titleName"  name="titleName" value="${titleName}" />
				
				<!-- search_area -->
				<div class="search_area">
					<div>
						<div class="select_period">
							<label><spring:message code="label.security.loginhist.period.text" /></label>
							<!-- period--> 
							<div class="period">
								<!-- startDate -->
								<div class="input-period">
									<div class="input-group date" data-date-end-date="0d">
										<input type="text" class="form-control" id="startDate" name="startDate" value="${startDate}" readonly="readonly">
										<span class="input-group-addon icon"></span>
									</div>
								</div>
								<!-- startTime -->
								<div class="input-period clockpicker" data-placement="bottom" data-align="top" data-autoclose="true">
									<input type="text" class="form-control" id="startTime" name="startTime" value="00:00" readonly="readonly">
									<span class="input-period-addon"></span>
								</div>
								<span class="dash"></span>
								<!-- endData -->
								<div class="input-period">
									<div class="input-group date" data-date-end-date="0d">
										<input type="text" class="form-control" id="endDate" name="endDate" value="${endDate}" readonly="readonly">
										<span class="input-group-addon icon"></span>
									</div>
								</div>
								<!-- endTime -->
								<div class="input-period clockpicker" data-placement="bottom" data-align="top" data-autoclose="true">
									<input type="text" class="form-control" id="endTime" name="endTime" value="${endHour}:${endMin}" readonly="readonly">
									<span class="input-period-addon"></span>
								</div>
							</div>
							<!-- //period--> 
						</div>
						
						<!-- //select_period -->
		                <div class="select_single">
		                    <label><spring:message code="label.security.loginhist.user_group.text" /></label>
		                    <select class="single" id="groupNo" name="groupNo">
		                    	<c:forEach items="${listUserGroup}" var="userGruop" varStatus="status">
		                    		<option value="${userGruop.ID}">${userGruop.NAME}</option>
		                    	</c:forEach>
		                    </select>
		                </div>
		                <div class="select_single">
		                    <label><spring:message code="label.security.loginhist.user_level.text" /></label>  
		                    <select class="single" id="levelId" name="levelId">
		                    	<c:forEach items="${listUserLevel}" var="userLevel" varStatus="status">
		                    		<option value="${userLevel.ID}">${userLevel.NAME}</option>
		                    	</c:forEach>
		                    </select>
		                </div>
						<div class="select_keyword">
							<label><spring:message code="label.fault.alarmconfig.search.keyword.text" /></label>
							<select class="single" id="searchType" name="searchType">
								<option value="userId"><spring:message code="label.fault.alarmconfig.search.user_id.text" /></option>
								<option value="userName"><spring:message code="label.fault.alarmconfig.search.user_name.text" /></option>
							</select>
							<input type="text" id="searchText" name="searchText" placeholder="<spring:message code="label.fault.alarmconfig.search.keyword.text" />" maxlength="20"/>
						</div>
						<button id="btn_search" type="button" class="srch" title='<spring:message code="label.common.search.text" />'><spring:message code="label.common.search.text" /></button>
					</div>
				</div>
				<!-- //search_area -->
				
				<!-- util_btn  -->
				<div class="util_btn">
					<div class="dropdown">
						<button type="button" class="dropbtn"><spring:message code="label.common.downlaod" /></button>
						<ul class="dropdown_content">
							<li><a href="#" onclick="fnExcel()"><spring:message code="label.common.excel" /></a></li>
						</ul>
					</div>
				</div>
				<!-- //util_btn -->
				
				<div id="loginHistTable">
					<div class="scroll" id="loading">
						<div class="loading"><span class="loading-inner"></span></div>
					</div>
				</div>
			</form>
		</div>
	</div>
