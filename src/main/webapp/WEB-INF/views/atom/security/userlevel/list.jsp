<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>

<script type="text/javascript">
			
    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {		
    	// multiple select start // 
		$("select.single").multipleSelect({
	        single: true,
	        selectAll: false,
            multiple: false
		});
		
  		$("#btn_search").click(function(){
    		goSearch();
    	});
		
  		fnInit();
    });
    
    //init function
    function fnInit(){
    	if("${searchVal.levelId}" != ""){
    		$("#levelId").multipleSelect('setSelects',["${searchVal.levelId}"]);
    	}
    	goSearch();
    }
    
    //user Level Manage search
	function goSearch(){
		fnShowLoading();
		
		var param = new Object();
		param = $("#myForm").serialize();

		$.ajax({
            url : "listAction",
            data : param,
            type : 'POST',
            success : function(data) {
               $("#userLevelTable").html(data);
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {
				
            }
		});
    }
    
    //user Level Manage goDetail
    function goDetail(level_id){
		$("#level_id").val(level_id);

		$("#myForm").attr("action","/atom/security/userlevel/detail");
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
			<!-- sort시 필요 -->
  			<input type="hidden" id="orderBy" name="orderBy" value="" />
  			<input type="hidden" id="sortClass" name="sortClass" value="" />
			<!-- detail 화면이동시 필요  -->
			<input type="hidden" id="level_id" name="level_id">
			<!-- excelDownload시 필요 -->
			<input type="hidden" id="titleName"  name="titleName" value="${titleName}" />
			
			<!-- search_area -->
			<div class="search_area">
				<div>
					<div class="select_single">
						<label><spring:message code="label.security.userlevel.user_level.text" /></label>
						<select class="single" id="levelId" name="levelId">
							<option value="all"><spring:message code="label.common.all" /></option>
	                    	<c:forEach items="${listUserLevel}" var="userLevel" varStatus="status">
	                    		<option value="${userLevel.ID}">${userLevel.NAME}</option>
	                    	</c:forEach>
						</select>
					</div>
					<button id="btn_search" type="button" class="srch" title='<spring:message code="label.common.search.text" />'><spring:message code="label.common.search.text" /></button>
				</div>
			</div>
			<!-- //search_area -->
			
			<!-- util_btn -->
			<div class="util_btn">
				<div class="dropdown">
					<button type="button" class="dropbtn"><spring:message code="label.common.downlaod" /></button>
					<ul class="dropdown_content">
						<li><a href="#" onclick="fnExcel()"><spring:message code="label.common.excel" /></a></li>
					</ul>
				</div>
			</div>
			<!-- //util_btn -->
			
			<div id="userLevelTable">
				<div class="scroll" id="loading">
					<div class="loading"><span class="loading-inner"></span></div>
				</div>
			</div>
		</form>
	</div>
</div>
