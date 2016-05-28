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
		
  		$("#btn_add").click(function(){
    		goAdd();
    	});
		
    	sortInit();
    });
    
  	//sortInit function
    function sortInit(){
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
	 			<col>
	 			<col width="15%" />
	 			<col width="15%" />
	 			<col width="10%" />
	 			<col width="15%" />
	 			<col width="10%" />
	 			<col width="100px" />
	 			<col width="100px" />
	 			<col width="20%" />
	 			<col width="10px" />
	 		</colgroup>
	 		<thead>
	 			<tr>
	 				<th class="sort no"><spring:message code="label.conifg.nodemanagement.no.text" /></th>
	 				<th class="sort down" id="NODE_NAME" onClick="listSort(this)"><spring:message code="label.conifg.nodemanagement.node_name.text" /></th>
	 				<th class="sort down" id="IP" onClick="listSort(this)"><spring:message code="label.conifg.nodemanagement.ip.text" /></th>
	 				<th class="sort down" id="PKG_NAME" onClick="listSort(this)"><spring:message code="label.conifg.nodemanagement.package.text" /></th>
	 				<th><spring:message code="label.conifg.nodemanagement.node_group.text" /></th>
	 				<th><spring:message code="label.conifg.nodemanagement.node_type.text" /></th>
	 				<th><spring:message code="label.conifg.nodemanagement.internal_node.text" /></th>
	 				<th><spring:message code="label.conifg.nodemanagement.use.text" /></th>
	 				<th><spring:message code="label.conifg.nodemanagement.description.text" /></th>
	 				<th></th>
	 			</tr>
	 		</thead>
	 	</table>
	 	<div class="scroll sml link">
	 		<table class="tbl_list">
	 			<colgroup>
		 			<col>
		 			<col width="15%" />
		 			<col width="15%" />
		 			<col width="10%" />
		 			<col width="15%" />
		 			<col width="10%" />
		 			<col width="100px" />
		 			<col width="100px" />
		 			<col width="20%" />
	 			</colgroup>
	 			<tbody>
	 				<c:if test="${!empty nodeManagementList.lists}">
		 				<c:forEach items="${nodeManagementList.lists}" var="list" varStatus="status">
		 					<tr onClick='javascript:goDetail("${list.node_no}");'>
		 						<td class="no">${list.rownum}</td>
		 						<td>${list.node_name}</td>
		 						<td>${list.ip}</td>
		 						<td>${list.pkg_name}</td>
		 						<td>${list.node_grp_name}</td>
		 						<td>${list.node_type}</td>
		 						<td>${list.internal_yn}</td>
		 						<td>${list.use_yn}</td>
		 						<td>${list.description}</td>
		 					</tr>
		 				</c:forEach>
	 				</c:if>
	 				<c:if test="${empty nodeManagementList.lists}">
						<tr>
			    			<td class="t_c"colspan=9"><spring:message code="label.empty.list" /></td>
			    		</tr>
	 				</c:if>
	 			</tbody>
	 		</table>
		</div>
	</div>

	<!-- 페이징 start -->
	<div class="cont_footer">
		<ntels:perPageControl totalCount="${nodeManagementList.totalCount}" perPage="${nodeManagementList.perPage}" page="${nodeManagementList.page}"> <spring:message code="label.common.perpage.normal.text" /></ntels:perPageControl>                    
		<ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#nodeManagementTable" active="${nodeManagementList.page}"  total_count="${nodeManagementList.totalCount}" per_page="${nodeManagementList.perPage}" per_size="${nodeManagementList.perSize}"/>
		<div class="btn_area">
			<ntels:auth auth="${authType}">
			<button id="btn_add" type="button" class="major"><spring:message code="label.common.insert.text" /></button>
			</ntels:auth>
		</div>
	</div>
	<!-- 페이징 end -->