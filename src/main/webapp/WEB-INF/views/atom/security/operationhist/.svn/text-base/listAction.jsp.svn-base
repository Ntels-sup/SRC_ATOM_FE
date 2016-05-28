<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {    	
    	// multiple select start // 
		$("select.bottom").multipleSelect({
			single: true,
		    selectAll: false,
		    multiple: false,
		    position: 'top',
		    onClick: function(view) {
				setPerPage(view.value);
		    }
		});
		
    	sortIinit();
    });
    
  	//sortIinit function
    function sortIinit(){
    	sortClass($("#sortClass").val());
    }
    
    //페이지당 보여줄 갯수 선택
    function setPerPage(perPage) {
        $("#page").val("1");
        $("#perPage").val(perPage); //실제 setting.
        $("#selectPageSize").text(perPage + '<spring:message code="label.common.list.line.text"/>'); //화면에 Display.

        goSearch();
    }
    
</script>   

	<div class="data">
		<table class="tbl_list">
	 		<colgroup>
	 			<col width="10%" />
	 			<col width="10%" />
	 			<col width="10%" />
	 			<col width="120px" />
	 			<col width="15%" />
	 			<col width="10%" />
	 			<col width="100px" />
	 			<col width="15%" />
	 			<col>
	 			<col>
	 			<col width="15%" />
	 			<col width="15%" />
	 			<col width="10px" />
	 		</colgroup>
	 		<thead>
	 			<tr>
	 				<th><spring:message code="label.security.operationhist.package_name.text" /></th>
	 				<th><spring:message code="label.security.operationhist.node_name.text" /></th>
	 				<th><spring:message code="label.security.operationhist.user_id.text" /></th>
	 				<th class="sort down" id="OPER_TARGET" onClick="listSort(this)"><spring:message code="label.security.operationhist.target.text" /></th>
	 				<th class="sort down" id="MENU_NAME" onClick="listSort(this)"><spring:message code="label.security.operationhist.function.text" /></th>
	 				<th><spring:message code="label.security.operationhist.message.text" /></th>
	 				<th><spring:message code="label.security.operationhist.result.text" /></th>
	 				<th><spring:message code="label.security.operationhist.ip.text" /></th>
	 				<th class="date"><spring:message code="label.security.operationhist.request_time.text" /></th>
	 				<th class="date"><spring:message code="label.security.operationhist.response_time.text" /></th>
	 				<th><spring:message code="label.security.operationhist.command.text" /></th>
	 				<th><spring:message code="label.security.operationhist.additional_info.text" /></th>
	 				<th></th>
	 			</tr>
	 		</thead>
	 	</table>
	 	<div class="scroll">
	 		<table class="tbl_list">
	 			<colgroup>
		 			<col width="10%" />
		 			<col width="10%" />
		 			<col width="10%" />
		 			<col width="120px" />
		 			<col width="15%" />
		 			<col width="10%" />
		 			<col width="100px" />
		 			<col width="15%" />
		 			<col>
		 			<col>
		 			<col width="15%" />
		 			<col width="15%" />
	 			</colgroup>
	 			<tbody>
	 				<c:if test="${!empty operationHistList.lists}">
		 				<c:forEach items="${operationHistList.lists}" var="list" varStatus="status">
		 					<tr>
		 						<td>${list.pkg_name}</td>
		 						<td>${list.node_name}</td>
		 						<td>${list.user_id}</td>
		 						<td>${list.oper_target_name}</td>
		 						<td>${list.menu_name}</td>
		 						<td>${list.oper_message}</td>
		 						<td class="t_c">${list.result_yn}</td>
		 						<td>${list.oper_ip}</td>
		 						<td class="date">${list.prc_date}</td>
		 						<td class="date">${list.res_date}</td>
		 						<td>${list.oper_cmd}</td>
		 						<td>${list.cmd_arg}</td>
		 					</tr>
		 				</c:forEach>
	 				</c:if>
	 				<c:if test="${empty operationHistList.lists}">
						<tr>
			    			<td class="t_c" colspan="12"><spring:message code="label.empty.list" /></td>
			    		</tr>
	 				</c:if>
	 			</tbody>
	 		</table>
		</div>
	</div>

	<!-- 페이징 start -->
	<div class="cont_footer">
		<ntels:perPageControl totalCount="${operationHistList.totalCount}" perPage="${operationHistList.perPage}" page="${operationHistList.page}"> <spring:message code="label.common.perpage.normal.text" /></ntels:perPageControl>                    
		<ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#operationHistTable" active="${operationHistList.page}"  total_count="${operationHistList.totalCount}" per_page="${operationHistList.perPage}" per_size="${operationHistList.perSize}"/>
	</div>
	<!-- 페이징 end -->