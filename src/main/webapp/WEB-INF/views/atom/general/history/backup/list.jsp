<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>

<script src="/scripts/locales/bootstrap-datepicker.${language}.min.js" charset="UTF-8"></script>
<script src="/scripts/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

<script type="text/javascript">
var language = '${language}';
	$(document).ready(function() {
		var node_id="${node_id}";
		var group_code="${group_code}";
		
		$("select.single").multipleSelect({
	        single: true,
	        selectAll: false,
	       // maxHeight: 100,
            multiple: false
		});
		
		if(node_id != ""){
			$("#node_id").multipleSelect("setSelects",["${node_id}"]);
		} 
		if(group_code !="" ){
			$("#group_code").multipleSelect("setSelects",["${group_code}"]);
		} 
		
		fnInit();
		
		 $(".clockpicker").clockpicker().find("input").change(function(){});
    	
		 /* Calendar */
        $('.input-group.date').datepicker({
       	        format: '${fn:toLowerCase(dateformat)}',       
       	        language: language,
   	            autoclose: true,
   	            todayHighlight: true
        });
   	
		//조회 버튼 클릭시
		$("#btn_search").click(function() {
			goSearch();
		});

		//엑셀 다운로드 클릭시
		$("#btn_export").click(function() {
			goExcel();
		});
		
	});

    function fnInit(){
   		//$("select.single").multipleSelect("checkAll");
    	
        $("#startDate").val("${startDate}");
        $("#endDate").val("${endDate}");
        
        goSearch();
    }

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
		
		var param = $("#myForm").serialize();
		fnShowLoading();
		
		$.ajax({
            url : "listAction",
            data : param,
            type : 'POST',
            success : function(data) {
               $("#historyTable").html(data);
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {
				
            }
		});
	}
	
/* 	function goDetail(tr){
		console.log(tr)
		console.log(this);
		//$("#nodeId").val(node_id);
		
		//$("#myForm").attr("action","/atom/general/history/backup/detail");
		//$("#myForm").submit();
	} */

	function fnExcel(){
    	if($("tbody > tr > td").html() == '<spring:message code="label.empty.list" />') {
        	openAlertModal('<spring:message code="msg.common.excel.download.backup" />');
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
    
	/**
	 * 조회시 로딩.. 이미지
	 */
	    function fnShowLoading() {
	        var loadImage =  '<div class="scroll" id="loading"><div class="loading"><span class="loading-inner"></span></div></div>';;
	        $('#historyTable').children().remove();
	        $('#historyTable').append(loadImage);   
	    }

 
//-->
</script>
<body>
		 <form id="myForm" name="myForm" method="post">
		 	<!-- Hour, Min 셋팅 -->
			<input type="hidden" id="startHour" name="startHour" />
			<input type="hidden" id="startMin" name="startMin" />
			<input type="hidden" id="endHour" name="endHour" />
			<input type="hidden" id="endMin" name="endMin" />
			<!-- sort시 필요 -->
  			<input type="hidden" id="orderBy" name="orderBy" >
  			<input type="hidden" id="sortClass" name="sortClass">
			<input type="hidden" id="titleName"  name="titleName"    value="${titleName}" />
			<input type="hidden" id="dateformat" name="dateformat" value="${dateformat}" />
			<!-- 화면이동시필요 -->
			<input type="hidden" id="nodeId" name="nodeId">
			<input type="hidden" id="group_code_nm" name="group_code_nm">
			<input type="hidden" id="pkg_name" name="pkg_name">
			<input type="hidden" id="node_name" name="node_name">
			<input type="hidden" id="prc_date" name="prc_date">
			<input type="hidden" id="groupCode" name="groupCode">
			<input type="hidden" id="backup_name" name="backup_name">
			<input type="hidden" id="file_size" name="file_size">
			<input type="hidden" id="backup_path" name="backup_path">
			<input type="hidden" id="node_type" name="node_type">
			<input type="hidden" id="result_no" name="result_no">
			<input type="hidden" id="dst_flag" name="dst_flag">
				<div class="content">
					<div class="cont_data">
						<!-- search-area -->
							<div class="search_area">
								<div>
									<div class="select_period">
										<label><spring:message code="label.general.history.backup.period.text"/></label>
										<div class="period">
											<!-- StartDate -->
											<div class="input-period">
												 <div class="input-group date" data-date-end-date="0d">
						                                <input type="text" readonly="readonly"  id="startDate" name="startDate"  class="form-control"  value="${startDate}">
						                                <span class="input-group-addon icon"></span> 
						                         </div>
											</div>
											<!-- StartTime -->
											<div class="input-period clockpicker" data-placement="bottom" data-align="top" data-autoclose="true">
												<input type="text"  readonly="readonly"  class="form-control" id="startTime" name="startTime" value="${startHour}:${startMin}">
												<span class="input-period-addon"></span>
											</div>
											<span class="dash"></span>
											<!-- endData -->
											<div class="input-period">
						                            <div class="input-group date" data-date-end-date="0d">
						                                <input type="text" readonly="readonly"  id="endDate" name="endDate"  class="form-control" value="${endDate}">
						                                <span class="input-group-addon icon"></span> 
						                            </div>
						                    </div>
						                    <!-- endTime -->
											<div class="input-period clockpicker" data-placement="bottom" data-align="top" data-autoclose="true">
												<input type="text"readonly="readonly"   class="form-control" id="endTime" name="endTime" value="${endHour}:${endMin}">
												<span class="input-period-addon"></span>
											</div>
										</div>
									</div>
									<!-- //select_period -->
									<div class="select_group">
										<label><spring:message code="label.general.history.backup.PackageSystem.text"/></label>
										<select id="node_id" name="node_id" class="single" >
												<option value="all">All</option>
											<c:forEach items="${Package}" var="Packagelist" varStatus="status">
												<optgroup label="${Packagelist.NAME}">
													<c:forEach items="${System}" var="Systemlist" varStatus="status">
														<c:if test="${Packagelist.NAME eq Systemlist.PACKAGEID}">
															<option value="${Systemlist.ID}">${Systemlist.NAME}</option>
														</c:if>
						                            </c:forEach>
					                            </optgroup>
				                            </c:forEach>
				                        </select>
									</div>
									<div class="select_single"><label><spring:message code="label.general.history.backup.category.text" /></label>
										<select id="group_code" name="group_code" class="single" style="width:180px">
												<option value="all">All</option>
											<c:forEach items="${Group}" var="Grouplist" varStatus="status">
												<option value="${Grouplist.ID}">${Grouplist.NAME}</option>
											</c:forEach>
										</select>
									</div>
									<button id="btn_search" type="button" class="srch" title='<spring:message code="label.common.search.text" />'><spring:message code="label.common.search.text"/></button>
								</div>
							</div>
							<!-- search-area -->
				            <div class="util_btn">
				                <div class="dropdown">
				                    <button type="button" class="dropbtn"><spring:message code="label.common.downlaod" /></button>
				                    <ul class="dropdown_content">
				                        <li><a href="javascript:fnExcel();"><spring:message code="label.common.excel" /></a></li>
				                    </ul>
				                </div>
				            </div>

				<div id="historyTable"></div> <!-- 데이터는 다른 화면에서 미리 만들고 ajax로 호출함 -->
	  		</div>
		</div>
	</form>
</body>