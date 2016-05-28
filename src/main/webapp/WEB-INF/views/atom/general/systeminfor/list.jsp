<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>
<script src="/scripts/locales/bootstrap-datepicker.${language}.min.js" charset="UTF-8"></script>
<script src="/scripts/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

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
    	$("select.group").multipleSelect({
			filter		: true,
            multiple	: true,
            multipleWidth: 150, 
            width		: "602px"
    	});
       
 
		$("select.multi,select.group").multipleSelect("checkAll");
		
 
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
    	var nodeId=$("#node_id").val();
    	
		if(nodeId==null){
			openAlertModal("","<spring:message code="msg.general.systeminformation.node.empty" />", function(){
        	});
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
               $("#systeminforHistTable").html(data);
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
    	
    	var nodeId=$("#node_id").val();
    	
		if(nodeId==null){
			openAlertModal("","<spring:message code="msg.general.systeminformation.node.empty" />", function(){
        	});
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
			<!-- sort시 필요 -->
  			<input type="hidden" id="orderBy" name="orderBy">
  			<input type="hidden" id="sortClass" name="sortClass">
			<!-- excelDownload시 필요 -->
			<input type="hidden" id="titleName"  name="titleName" value="${titleName}" />
			<!-- search_area -->
 			<div class="search_area">
				<div>
					<!-- //select_period -->
					<div class="select_group">
						<label><spring:message code="label.general.systeminformation.PackageSystem.text" /></label>
                         <select id="node_id" name="node_id" class="group" multiple="multiple" value="checkAll">
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
					<button  type="button" id="btn_search" class="srch" title="<spring:message code="label.common.search"/>"><spring:message code="label.common.search"/></button>
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
			
			<div id="systeminforHistTable">
				<div class="scroll" id="loading">
					<div class="loading"><span class="loading-inner"></span></div>
				</div>
			</div>
		</form>
	</div>
</div>

