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

	
	
/* 	$("select.single").multipleSelect({
        single: true,
        selectAll: false,
        multiple: false
    }); */
	
	//$("select.multi,select.group").multipleSelect("checkAll");
	
	$("#pkg_name").multipleSelect({
    	single		: true
      , selectAll	: false
      , multiple	: false
  	  , onClick		: function(view) {
		
  		  	console.log(view.value);
  	     	
  		  	//	일단 다 감추고
		    //$('[name*="group_name"]').hide();
  	     	
  	     	$("#pkg_name").val( view.value );
  	     	var param = $("#myForm").serialize();

  	     	var optionTag = "";
  	     	
	     	$("select[name='group_name'] option").remove();
	     	$("#group_name").html('<option value="">All</option>');
	     	
	     	$("#group_name").append(optionTag).multipleSelect('refresh');
	     	
	     	$.post('listSchedulerGroupAjax.ajax', param, function(data) {
  	     		
  	     		$.each(data,function(index,obj) {
  	     			optionTag = $('<option value="'+obj.group_name+'">'+obj.group_name+'</option>');
  	    			$("#group_name").append(optionTag).multipleSelect('refresh');
  	     		});
  	        });
	     	
          }
   });
	
	
	$("#group_name").multipleSelect({
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
});

function fnInit(){
	
// 	if("${searchVal.pkg_name}" != ""){
		$("#pkg_name").multipleSelect('setSelects',["${searchVal.pkg_name}"]);
		
		$("#pkg_name").val( "${searchVal.pkg_name}" );
	    var param = $("#myForm").serialize();

	    var optionTag = "";
	     	
     	$("select[name='group_name'] option").remove();
     	$("#group_name").html('<option value="">All</option>');
     	
     	$("#group_name").append(optionTag).multipleSelect('refresh');
     	
     	$.post('listSchedulerGroupAjax.ajax', param, function(data) {
	     		
     		$.each(data,function(index,obj) {
     			optionTag = $('<option value="'+obj.group_name+'">'+obj.group_name+'</option>');
    			$("#group_name").append(optionTag).multipleSelect('refresh');
     		});
        });
// 	}
	
	goSearch();
} 

function goSearch(){

// 	var pscheck = $("#pkg_name").val();
	
// 	// 시스템 콤보 선택 체크
// 	if(pscheck == null || pscheck == ''){
// 		openAlertModal('<spring:message code="msg.alarm.history.systemNoncheck" />');
// 	    return;
// 	}
	
	fnShowLoading();
	
	var param = $("#myForm").serialize();
    $.post('listSchedulerGroup.ajax', param, function(data) {
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
	var pscheck = $("#pkg_name").val();
	// 시스템 콤보 선택 체크
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="msg.alarm.history.systemNoncheck" />');
	    return;
	}
	
	var param = $("#myForm").serialize();
    $.download('exportAction.xls',param,'post');
} 

function updateBatchGroup(pkg_name, group_name) {
	
	console.log( "[mirinae.maru] updateBatchGroup : " + pkg_name +"\t"+ group_name );
	
	myForm.pkg_name.value = pkg_name;
	myForm.group_name.value = group_name;
	
	myForm.action = "/atom/general/scheduler/viewSchedulerGroup.ajax";
	myForm.submit();
}  
    
function configBatchFlow() {
	myForm.action = "/atom/general/scheduler/listBatchJob";
	myForm.submit();
}

function insertBatchGroup() {
	myForm.action = "/atom/general/scheduler/insertSchedulerGroup.ajax";
	myForm.submit();
}


</script>

    </head>
<body>
<form id="myForm" name="myForm" method="post">
	<!-- sort시 필요 -->
	<input type="hidden" id="orderBy" name="orderBy" value="" />
	<input type="hidden" id="sortClass" name="sortClass" value="" />
	<input type="hidden" id="titleName"  name="titleName"    value="SchedulerGroup" />
  	<input type="hidden" id="dateformat" name="dateformat" value="${dateformat}" />

		<!-- content -->
		<div class="content">
             <div class="cont_data">
                    <div class="search_area">
                    <div>
                    	
                    	<div class="select_single" id=""><label><spring:message code="label.security.usergroup.package.text"/></label>
	                         <select id="pkg_name" name="pkg_name" class="single">
	                         	<option value="">All</option>
	                            <c:forEach items="${Package}" var="Packagelist" varStatus="status">
		                            <option value="${Packagelist.NAME}">${Packagelist.NAME}</option>
	                            </c:forEach>
	                        </select>
                        </div>
                        
                        <div class="select_single">
		                    <label><spring:message code="label.pfnm.batch.batch_group.text"/></label>
		                    <select id="group_name" name="group_name" class="single" style="width:120px;">
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
