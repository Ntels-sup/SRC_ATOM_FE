<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {    	
    	// multiple select single 
		$("select.single").multipleSelect({
	        single: true,
	        selectAll: false,
            multiple: false
		});
		
    	// multiple select multi
    	$("select.multi").multipleSelect({
			filter: true,
	        multiple: true,
			multipleWidth: 150,
	        width: "162px"
	    });
		 
  		$("#btn_search").click(function(){
    		goSearch();
    	});
		
  		fnInit();
    });
    
    //init function
    function fnInit(){
    	$("select.multi,select.group").multipleSelect("checkAll");
    	
		if("${searchVal.alarmType}" != ""){
			$("#alarmType").multipleSelect('setSelects',[${searchVal.alarmType}]);
		}
		if("${searchVal.alarmGroup}" != ""){
			$("#alarmGroup").multipleSelect('setSelects',[${searchVal.alarmGroup}]);
		} 
		if("${searchVal.pkgName}" != ""){
			var pkgName = "${searchVal.pkgName}";
			var pkgNameArr = pkgName.split(",");

			$("#pkgName").multipleSelect('setSelects',pkgNameArr);
		} 
		if("${searchVal.searchType}" != ""){
			$("#searchType").multipleSelect('setSelects',["${searchVal.searchType}"]);
		}
		if("${searchVal.searchText}" != ""){
			$("#searchText").val("${searchVal.searchText}");
		}
		goSearch();
    }
    
    //alarm Config search
	function goSearch(){
		if($("#alarmType").val() == "" || $("#alarmType").val() == null){
			openAlertModal("","<spring:message code="msg.fault.alarmconfig.need.alarm_type" />");
			return;
		}
		if($("#alarmGroup").val() == "" || $("#alarmGroup").val() == null){
			openAlertModal("","<spring:message code="msg.fault.alarmconfig.need.alarm_group" />");
			return;
		}
		if($("#pkgName").val() == "" || $("#pkgName").val() == null){
			openAlertModal("","<spring:message code="msg.fault.alarmconfig.need.pkg_name" />");
			return;
		}
    	
		fnShowLoading();
		
		var param = new Object();
		param = $("#myForm").serialize();

		$.ajax({
            url : "listAction",
            data : param,
            type : 'POST',
            success : function(data) {
               $("#alarmConfigTable").html(data);
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {
				
            }
		});
    }
    
    //alarm Config goDeatil 
    function goDetail(code, pkg_name){
		$("#code").val(code);
		$("#pkg_name").val(pkg_name);
		
		$("#myForm").attr("action","/atom/fault/alarmconfig/detail");
		$("#myForm").submit();
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

		var param = new Object();
		param = $("#myForm").serialize();
        $.download('exportAction.xls',param,'post');
    }  
    
</script>   

	<div class="content">
		<div class="cont_data">
			<form id="myForm" name="myForm">
				<!-- detail 화면이동시 필요  -->
				<input type="hidden" id="code" name="code" />
				<input type="hidden" id="pkg_name" name="pkg_name" />
				<!-- sort시 필요 -->
	  			<input type="hidden" id="orderBy" name="orderBy" />
	  			<input type="hidden" id="sortClass" name="sortClass" />
				<!-- excelDownload시 필요 -->
				<input type="hidden" id="titleName"  name="titleName" value="${titleName}" />
				
				<!-- search_area -->
				<div class="search_area">
					<div>
						<div class="select_single">
							<label><spring:message code="label.fault.alarmconfig.search.alarm_type.text" /></label>
							<select class="multi" id="alarmType" name="alarmType" multiple="multiple">
								<c:forEach items="${listAlarmType}" var="alarmType" varStatus="status">
									<option value="${alarmType.ID}">${alarmType.NAME}</option>
								</c:forEach>
							</select>
						</div>
						
						<div class="select_single">
							<label><spring:message code="label.fault.alarmconfig.search.group.text" /></label>
							<select class="multi" id="alarmGroup" name="alarmGroup" multiple="multiple">
								<c:forEach items="${listAlarmGroup}" var="alaramGroup" varStatus="status">
									<option value="${alaramGroup.ID}">${alaramGroup.NAME}</option>
								</c:forEach>
							</select>
						</div>
						
						<div class="select_single">
							<label><spring:message code="label.fault.alarmconfig.search.package.text" /></label>
							<select class="multi" id="pkgName" name="pkgName" multiple="multiple">
								<c:forEach items="${listPackage}" var="Package" varStatus="status">
									<option value="${Package.ID}">${Package.NAME}</option>
								</c:forEach>
							</select>
						</div>
						
						<div class="select_keyword">
							<label><spring:message code="label.fault.alarmconfig.search.keyword.text" /></label>
							<select class="single" id="searchType" name="searchType">
								<option value="code"><spring:message code="label.fault.alarmconfig.code.text" /></option>
								<option value="probable_cause"><spring:message code="label.fault.alarmconfig.probable_cause.text" /></option>
								<option value="description"><spring:message code="label.fault.alarmconfig.description.text" /></option>
							</select>
							<input type="text" id="searchText" name="searchText" placeholder="<spring:message code="label.fault.alarmconfig.search.keyword.text" />"/>
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
				
				<div id="alarmConfigTable">
					<div class="scroll" id="loading">
						<div class="loading"><span class="loading-inner"></span></div>
					</div>
				</div>
			</form>
		</div>
	</div>

