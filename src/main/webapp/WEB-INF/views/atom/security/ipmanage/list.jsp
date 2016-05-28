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
    	if("${searchVal.searchAllowYn}" != ""){
    		$("#searchAllowYn").multipleSelect('setSelects',["${searchVal.searchAllowYn}"]);
    	}
    	if("${searchVal.searchIp}" != ""){
    		$("#searchIp").val("${searchVal.searchIp}");
    	}
    	goSearch();
    }
    
    //ip manage search
	function goSearch(){
		fnShowLoading();
		
		var param = new Object();
		param = $("#myForm").serialize();

		$.ajax({
            url : "listAction",
            data : param,
            type : 'POST',
            success : function(data) {
               $("#ipManageTable").html(data);
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {
				
            }
		});
    }
    
    //ip manage goDetail
    function goDetail(ip_manager_no){
		$("#ip_manager_no").val(ip_manager_no);
		
		$("#myForm").attr("action","/atom/security/ipmanage/detail");
		$("#myForm").submit();
    }

    //ip manage goAdd
    function goAdd(){
		$("#myForm").attr("action","/atom/security/ipmanage/add");
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
			<form id="myForm" name="myForm" method="POST">
				<!-- sort시 필요 -->
	  			<input type="hidden" id="orderBy" name="orderBy" value="" />
	  			<input type="hidden" id="sortClass" name="sortClass" value="" />
				<!-- detail 화면이동시 필요  -->
				<input type="hidden" id="ip_manager_no" name="ip_manager_no">
				<!-- excelDownload시 필요 -->
				<input type="hidden" id="titleName"  name="titleName" value="${titleName}" />
				
				<!-- search_area -->
				<div class="search_area">
					<div>
						<div class="select_single">
							<label><spring:message code="label.security.ipmanage.login_allowance.text" /></label>
							<select class="single" id="searchAllowYn" name="searchAllowYn">
								<option value="all"><spring:message code="label.common.all" /></option>
		                    	<c:forEach items="${listAllowYn}" var="allowYn" varStatus="status">
		                    		<option value="${allowYn.ID}">${allowYn.NAME}</option>
		                    	</c:forEach>
							</select>
						</div>
						
						<div class="select_keyword">
							<label><spring:message code="label.security.ipmanage.ip_address.text" /></label>
							<br/>
							<input type="text" id="searchIp" name="searchIp" placeholder="<spring:message code="label.security.ipmanage.ip_address.text" />" maxlength="20"/>
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
				
				<div id="ipManageTable">
					<div class="scroll" id="loading">
						<div class="loading"><span class="loading-inner"></span></div>
					</div>
				</div>
			</form>
		</div>
	</div>
