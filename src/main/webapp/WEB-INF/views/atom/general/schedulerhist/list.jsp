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
<script type="text/javascript" charset="utf-8" src="/scripts/clockpicker.min.js"></script>


<script src="/scripts/locales/bootstrap-datepicker.${sessionUser.language}.min.js" charset="UTF-8"></script>


    
<script type="text/javascript">
var language = '${sessionUser.language}';

$(document).ready(function() {
	
	var tdObj = $(".select_group");
	var pkgOption = "";
	
	
	pkgOption = '<label><spring:message code="label.security.operationhist.package_system.text"/></label><select id="system_id" name="system_id" class="group" multiple="multiple">';
	pkgOption = pkgOption + '<c:forEach items="${Package}" var="Packagelist" varStatus="status">';
	pkgOption = pkgOption + '    <optgroup label="${Packagelist.NAME}">';
	pkgOption = pkgOption + '        <c:forEach items="${System}" var="Systemlist" varStatus="status">';
	pkgOption = pkgOption + '           <c:if test="${Packagelist.ID eq Systemlist.PACKAGEID}">';
	pkgOption = pkgOption + '           		<option value="${Systemlist.NAME}">${Systemlist.NAME}</option>';
	pkgOption = pkgOption + '           </c:if>';
	pkgOption = pkgOption + '        </c:forEach>';
	pkgOption = pkgOption + '    </optgroup>';
	pkgOption = pkgOption + '</c:forEach>';
	pkgOption = pkgOption + '</select>';

	//package selectbox refresh
// 	pkgOption = '<select class="group" id="pkg_name" name="pkg_name">';
// 	<c:forEach items="${listPackage}" var="Package" varStatus="status">
// 		pkgOption += '<option value="${Package.ID}">${Package.NAME}</option>';
// 	</c:forEach>
// 	pkgOption += '</select>';
	
// 	alert(pkgOption);

 	$(tdObj).empty();
 	$(tdObj).append(pkgOption);
	
	$("select[id=system_id]").multipleSelect({
		filter		: true,
		single		: false,
		selectAll	: true,
        multiple	: true,
        multipleWidth: 150,
        width		: "602px",
        onClick		: function(view){
       		//alert('Ah~~~');
       		refreshGroupSelectBox( view );
        } 
	},"refresh");
	
	$("select.multi,select.group").multipleSelect("checkAll");
	
	$("#group_name").multipleSelect({
    	single		: true
      , selectAll	: false
      , multiple	: false
  	  , onClick		: function(view) {
		
  		  	console.log(view.value);
  	     	
  	     	$("#group_name").val( view.value );
  	     	var param = $("#myForm").serialize();

  	     	var optionTag = "";
  	     	
	     	$("select[name='job_name'] option").remove();
	     	$("#job_name").html('<option value="">All</option>');
	     	
	     	$("#job_name").append(optionTag).multipleSelect('refresh');
	     	
	     	$.post('listJobName.ajax', param, function(data) {
  	     		
  	     		$.each(data,function(index,obj) {
  	     			optionTag = $('<option value="'+obj.job_name+'">'+obj.job_name+'</option>');
  	    			$("#job_name").append(optionTag).multipleSelect('refresh');
  	     		});
  	        });
	     	
          }
   	});
	

	$("#group_name").multipleSelect({
		single		: true
      , selectAll	: false
      , multiple	: false
  	});

	$("#job_name").multipleSelect({
		single		: true
      , selectAll	: false
      , multiple	: false
  	});
	
	//버튼 클릭시
    $("#btn_search").click(function() {
    	$("#page").val("1");
        goSearch();
    });
	
    fnInit();

	/* Calendar */
    $('.input-group.date').datepicker({
   	        format: '${fn:toLowerCase(sessionUser.patternDate)}',       
   	        language: "${sessionUser.language}",
	            autoclose: true,
	            todayHighlight: true
    });
	
    /* Clock */
    $(".clockpicker").clockpicker().find("input").change(function(){
   		console.log(this.value);
   	});
});

function refreshGroupSelectBox( view ) {
	
 	//console.log( "[mirinae.maru] refreshGroupSelectBox start... " + view.value );
 	console.log( "[mirinae.maru] refreshGroupSelectBox start... " );
 	var param = $("#myForm").serialize();
 	console.log( "[mirinae.maru] param : " + param );
	var optionTag = "";
     	
 	$("select[name='group_name'] option").remove();
 	$("#group_name").html('<option value="">All</option>');

 	console.log( "[mirinae.maru] reset..." );
 	
  	$("#group_name").append(optionTag).multipleSelect('refresh');
 	
  	$.post('listGroupName.ajax', param, function(data) {
		
  		console.log( "[mirinae.maru] post listGroupName.ajax..." );
    		$.each(data,function(index,obj) {
    			optionTag = $('<option value="'+obj.group_name+'">'+obj.group_name+'</option>');
   			$("#group_name").append(optionTag).multipleSelect('refresh');
    		});
 	});
 	
  	console.log( "[mirinae.maru] refreshGroupSelectBox end..." );
}

function fnInit(){
	
	refreshGroupSelectBox();
	
// 	if("${searchVal.pkg_name}" != ""){
// 		$("#pkg_name").multipleSelect('setSelects',["${searchVal.pkg_name}"]);
		
// 		$("#pkg_name").val( "${searchVal.pkg_name}" );
// 	    var param = $("#myForm").serialize();

// 	    var optionTag = "";
	     	
//      	$("select[name='group_name'] option").remove();
//      	$("#group_name").html('<option value="">All</option>');
     	
//      	$("#group_name").append(optionTag).multipleSelect('refresh');
     	
//      	$.post('listGroupName.ajax', param, function(data) {
	     		
// 	     		$.each(data,function(index,obj) {
// 	     			optionTag = $('<option value="'+obj.group_name+'">'+obj.group_name+'</option>');
// 	    			$("#group_name").append(optionTag).multipleSelect('refresh');
// 	     		});
// 	        });
// 	}
	
	goSearch();
} 

function goSearch(){
	
	fnShowLoading();
	
// 	if($("#pkg_name").val() == null || $("#pkg_name").val() == ''){
// 		openAlertModal('<spring:message code="msg.pfnm.batch.package.text" />');
// 	    return;
// 	}
	
// 	if($("#group_name").val() == null || $("#group_name").val() == ''){
// 		openAlertModal('<spring:message code="msg.pfnm.batch.group.text" />');
// 	    return;
// 	}
	
// 	if($("#job_name").val() == null || $("#job_name").val() == ''){
// 		openAlertModal('<spring:message code="msg.pfnm.batch.job.text" />');
// 	    return;
// 	}
	
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

function fnExcel(){
	
	if($("tbody > tr > td").html() == '<spring:message code="label.empty.list" />') {
    	openAlertModal('<spring:message code="msg.common.excel.download.alarm" />');
        return;
    }

// 	if($("#pkg_name").val() == null || $("#pkg_name").val() == ''){
// 		openAlertModal('<spring:message code="msg.pfnm.batch.package.text" />');
// 	    return;
// 	}
	
// 	if($("#group_name").val() == null || $("#group_name").val() == ''){
// 		openAlertModal('<spring:message code="msg.pfnm.batch.group.text" />');
// 	    return;
// 	}
	
// 	if($("#job_name").val() == null || $("#job_name").val() == ''){
// 		openAlertModal('<spring:message code="msg.pfnm.batch.job.text" />');
// 	    return;
// 	}
	
	var param = $("#myForm").serialize();
    $.download('exportAction.xls',param,'post');
} 
</script>

    </head>
<body>
<form id="myForm" name="myForm" method="post">
	<input type="hidden" id="orderBy" name="orderBy" value="" />
	<input type="hidden" id="sortClass" name="sortClass" value="" />
	<input type="hidden" id="gubun" name="gubun" value="start" />
	<!-- sort시 필요 -->
	<input type="hidden" id="titleName" name="titleName"    value="SchedulerHistory" />

		<!-- content -->
		<div class="content">
             <div class="cont_data">
                    <div class="search_area">
                    <div>
                    	
                    	<div class="select_period">
							<label><spring:message code="label.general.history.backup.period.text"/></label>
							<div class="period">
								<!-- StartDate -->
								<div class="input-period">
									 <div class="input-group date" data-date-end-date="0d">
			                                <input type="text" id="startDt" name="startDt"  class="form-control"  value="${condition.startDt}">
			                                <span class="input-group-addon icon"></span> 
			                         </div>
								</div>
								<!-- StartTime -->
								<div class="input-period clockpicker" data-placement="bottom" data-align="top" data-autoclose="true">
									<input type="text" class="form-control" id="startTm" name="startTm" value="${condition.startTm}">
									<span class="input-period-addon"></span>
								</div>
								<span class="dash"></span>
								<!-- endData -->
								<div class="input-period">
			                            <div class="input-group date" data-date-start-date="0d">
			                                <input type="text"id="endDt" name="endDt"  class="form-control" value="${condition.endDt}">
			                                <span class="input-group-addon icon"></span> 
			                            </div>
			                    </div>
			                    <!-- endTime -->
								<div class="input-period clockpicker" data-placement="bottom" data-align="top" data-autoclose="true">
									<input type="text" class="form-control" id="endTm" name="endTm" value="${condition.endTm}">
									<span class="input-period-addon"></span>
								</div>
							</div>
						</div>
						
<%--                     	<div class="select_multi" id=""><label><spring:message code="label.general.history.backup.PackageSystem.text"/></label> --%>
<!-- 	                         <select id="pkg_name" name="pkg_name" class="multi" style="width:120px;"> -->
<%-- 	                            <c:forEach items="${Package}" var="Packagelist" varStatus="status"> --%>
<%-- 		                            <option value="${Packagelist.pkg_name}">${Packagelist.pkg_name}</option> --%>
<%-- 	                            </c:forEach> --%>
<!-- 	                        </select> -->
<!--                         </div> -->
						
						<div class="select_group"><label><spring:message code="label.security.operationhist.package_system.text"/></label>
	                         <select id="system_id" name="system_id" class="group" multiple="multiple">
	                            <c:forEach items="${Package}" var="Packagelist" varStatus="status">
		                            <optgroup label="${Packagelist.NAME}">
			                            <c:forEach items="${System}" var="Systemlist" varStatus="status">
			                               <c:if test="${Packagelist.ID eq Systemlist.PACKAGEID}">
			                               		<option value="${Systemlist.NAME}">${Systemlist.NAME}</option>
			                               </c:if>
			                            </c:forEach>
		                            </optgroup>
	                            </c:forEach>
	                        </select>
                        </div>
                        
                        <div class="select_single">
		                    <label><spring:message code="label.pfnm.batch.batch_group.text"/></label>
		                    <select id="group_name" name="group_name" class="single" style="width:120px;">
                            </select>
                		</div>
                        
                        <div class="select_single">
		                    <label><spring:message code="label.pfnm.batch.batch_job.text"/></label>
		                    <select id="job_name" name="job_name" class="single" style="width:120px;">
                            </select>
                		</div>
                        
                        <button type="button" id="btn_search" class="srch" title="<spring:message code="label.common.search"/>"><spring:message code="label.common.search"/></button>  
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
