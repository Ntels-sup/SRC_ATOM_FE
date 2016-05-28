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
    	if("${searchVal.groupNo}" != ""){
    		$("#groupNo").multipleSelect('setSelects',["${searchVal.groupNo}"]);
    	}
    	goSearch();
    }
    
    //user manage search
	function goSearch(){
		fnShowLoading();
		
		var param = new Object();
		param = $("#myForm").serialize();

		$.ajax({
            url : "listAction",
            data : param,
            type : 'POST',
            success : function(data) {
               $("#userManageTable").html(data);
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {
				
            }
		});
    }
    
    //user Manage goDetail
    function goDetail(user_id){
		$("#user_id").val(user_id);
		
		$("#myForm").attr("action","/atom/security/usermanage/detail");
		$("#myForm").submit();
    }

    //user Manage goAdd
    function goAdd(){
		$("#myForm").attr("action","/atom/security/usermanage/add");
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
				<input type="hidden" id="user_id" name="user_id">
				<!-- excelDownload시 필요 -->
				<input type="hidden" id="titleName"  name="titleName" value="${titleName}" />
				
				<!-- search_area -->
				<div class="search_area">
					<div>
						<div class="select_single">
							<label><spring:message code="label.security.usermanage.user_group.text" /></label>
							<select class="single" id="groupNo" name="groupNo">
								<option value="all"><spring:message code="label.common.all" /></option>
		                    	<c:forEach items="${listUserGroup}" var="userGroup" varStatus="status">
		                    		<option value="${userGroup.ID}">${userGroup.NAME}</option>
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
				
				<div id="userManageTable">
					<div class="scroll" id="loading">
						<div class="loading"><span class="loading-inner"></span></div>
					</div>
				</div>
			</form>
		</div>
	</div>
