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
    });
    

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
	 			<col width="20%" />
	 			<col width="20%" />
	 			<col width="20%" />
	 			<col width="*" />
	 			<col width="10px" />
	 		</colgroup>
	 		<thead>
	 			<tr>
	 				<th class="no"><spring:message code="label.security.ipmanage.no.text" /></th>
	 				<th><spring:message code="label.security.ipmanage.ip_address.text" /></th>
	 				<th><spring:message code="label.security.ipmanage.login_allowance.text" /></th>
	 				<th><spring:message code="label.security.ipmanage.sessions.text" /></th>
	 				<th><spring:message code="label.security.ipmanage.description.text" /></th>
	 				<th></th>
	 			</tr>
	 		</thead>
	 	</table>
	 	<div class="scroll sml link">
	 		<table class="tbl_list">
	 			<colgroup>
	 				<col>
		 			<col width="20%" />
		 			<col width="20%" />
		 			<col width="20%" />
		 			<col width="*" />
	 			</colgroup>
	 			<tbody>
	 				<c:if test="${!empty ipManageList.lists}">
		 				<c:forEach items="${ipManageList.lists}" var="list" varStatus="status">
		 					<tr onClick='javascript:goDetail("${list.ip_manager_no}");'>
		 						<td class="no">${list.ip_manager_no}</td>
		 						<td>${list.ip}</td>
		 						<td>${list.allow_name}</td>
		 						<td>${list.max_simult}</td>
		 						<td>${list.description}</td>
		 					</tr>
		 				</c:forEach>
	 				</c:if>
	 				<c:if test="${empty ipManageList.lists}">
						<tr>
			    			<td class="t_c"colspan="5"><spring:message code="label.empty.list" /></td>
			    		</tr>
	 				</c:if>
	 			</tbody>
	 		</table>
		</div>
	</div>

	<!-- 페이징 start -->
	<div class="cont_footer">
		<ntels:perPageControl totalCount="${ipManageList.totalCount}" perPage="${ipManageList.perPage}" page="${ipManageList.page}"> <spring:message code="label.common.perpage.normal.text" /></ntels:perPageControl>                    
		<ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#ipManageTable" active="${ipManageList.page}"  total_count="${ipManageList.totalCount}" per_page="${ipManageList.perPage}" per_size="${ipManageList.perSize}"/>
		<div class="btn_area">
			<ntels:auth auth="${authType}">
			<button id="btn_add" type="button" class="major"><spring:message code="label.common.insert.text" /></button>
			</ntels:auth>
		</div>
	</div>
	<!-- 페이징 end -->