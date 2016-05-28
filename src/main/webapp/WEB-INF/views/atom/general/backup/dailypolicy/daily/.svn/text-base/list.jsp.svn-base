<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>


<script type="text/javascript">
	/**
	 * 초기화
	 */
	$(document).ready(function() {
		
		var node_id="${node_id}"
		$("select.single").multipleSelect({
	        single: true,
	        selectAll: false,
            multiple: false
		});
		
		if(node_id != ""){
			$("select.single").multipleSelect("setSelects",["${node_id}"]);
			fnInit();
		} 

		
		 $("#btn_search").click(function() {
			goSearch();
        });
		 
		 
		$("#btn_mod").click(function() {
            listUpdate();
        });
		 
		
		
	});
	
	/** 
	 * initialization
	 */
 	 function fnInit() {
		goSearch();
	} 
	 
	function goSearch(){
		var nodeId=$('#node_id').val();
		if(nodeId=='select'){
			openAlertModal("","<spring:message code="msg.general.backup.dailypolicy.node.empty" />", function(){
        	});
			return;
		}
		
		fnShowLoading();
		var param = new Object();
		param = $("#daily").serialize();
		$.ajax({
            url : "listAction",
            data : param,
            type : 'POST',
            success : function(data) {
               $("#dailyPolicyTable").html(data);
            },
            error: function(e){
                alert(e.reponseText);
            },
            complete : function() {
				
            }
		});
	}	
	
	
	function fnShowLoading() {
		var loadImage = '<div class="scroll" id="loading"><div class="loading"><span class="loading-inner"></span></div></div>';
		
		$("#dailyPolicyTable").children().remove();
		$("#dailyPolicyTable").append(loadImage);
	}
    
	
	/* function listUpdate(){
		$("#daily").attr("action", "/atom/general/backup/dailypolicy/daily/update");
        $("#daily").submit();
	} */
</script>
<div class="content">
	<div class="cont_data">
		<form id="daily" name="daily" method="post">
			<!-- search-area -->
		    <div class="search_area">
		    	<div>
                    <div class="select_single"><label><spring:message code="label.general.backup.dailypolicy.PackageSystem.text" /></label>
                      <select id="node_id" name="node_id" class="single" >
                      		<option value="select">Select</option>  
                         	<c:forEach items="${Package}" var="Packagelist" varStatus="status">
								<optgroup label="${Packagelist.NAME}">
									<c:forEach items="${System}" var="Systemlist" varStatus="status">
										<c:if test="${Packagelist.NAME eq Systemlist.PACKAGEID}">
											<option value="${Systemlist.NAME}">${Systemlist.NAME}</option>
										</c:if>
		                            </c:forEach>
	                            </optgroup>
                            </c:forEach>
                      </select>
                    </div>
					<button id="btn_search" type="button" class="srch" title='<spring:message code="label.common.search.text" />'><spring:message code="label.common.search.text" /></button>
				</div>
			 </div>
			 <!-- //search_area -->
			 
			 <div id="dailyPolicyTable">
				<!--  <div class="scroll" id="loading">
					<div class="loading"><span class="loading-inner"></span></div>
				</div>   -->
			</div>
 	 </form>
	</div>
</div>

