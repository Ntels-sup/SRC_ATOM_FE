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
	 			<col width="10%" />
	 			<col width="10%" />
	 			<col width="10%" />
	 			<col width="15%" />
	 			<col width="15%" />
	 			<col width="15%" />
	 			<col>
	 			<col width="10%" />
	 			<col width="10px" />
	 		</colgroup>
	 		<thead>
	 			<tr>
	 				<th><spring:message code="label.security.usermanage.user_id.text" /></th>
	 				<th><spring:message code="label.security.usermanage.user_name.text" /></th>
	 				<th><spring:message code="label.security.usermanage.user_group.text" /></th>
	 				<th><spring:message code="label.security.usermanage.user_level.text" /></th>
	 				<th><spring:message code="label.security.usermanage.email.text" /></th>
	 				<th><spring:message code="label.security.usermanage.phone_number.text" /></th>
	 				<th class="date"><spring:message code="label.security.usermanage.user_account_expiration.text" /></th>
	 				<th><spring:message code="label.security.usermanage.status.text" /></th>
	 				<th></th>
	 			</tr>
	 		</thead>
	 	</table>
	 	<div class="scroll sml link">
	 		<table class="tbl_list">
	 			<colgroup>
	 			<col width="10%" />
	 			<col width="10%" />
	 			<col width="10%" />
	 			<col width="15%" />
	 			<col width="15%" />
	 			<col width="15%" />
	 			<col>
	 			<col width="10%" />
	 			</colgroup>
	 			<tbody>
	 				<c:if test="${!empty userManageList.lists}">
		 				<c:forEach items="${userManageList.lists}" var="list" varStatus="status">
		 					<tr onClick='javascript:goDetail("${list.user_id}");'>
		 						<td>${list.user_id}</td>
		 						<td>${list.user_name}</td>
		 						<td>${list.group_name}</td>
		 						<td>${list.level_name}</td>
		 						<td>${list.user_email}</td>
		 						<td>${list.user_phone}</td>
		 						<td class="date">${list.account_exfire}</td>
		 						<td>${list.status}</td>
		 					</tr>
		 				</c:forEach>
	 				</c:if>
	 				<c:if test="${empty userManageList.lists}">
						<tr>
			    			<td class="t_c"colspan="9"><spring:message code="label.empty.list" /></td>
			    		</tr>
	 				</c:if>
	 			</tbody>
	 		</table>
		</div>
	</div>

	<!-- 페이징 start -->
	<div class="cont_footer">
		<ntels:perPageControl totalCount="${userManageList.totalCount}" perPage="${userManageList.perPage}" page="${userManageList.page}"> <spring:message code="label.common.perpage.normal.text" /></ntels:perPageControl>                    
		<ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#userManageTable" active="${userManageList.page}"  total_count="${userManageList.totalCount}" per_page="${userManageList.perPage}" per_size="${userManageList.perSize}"/>
		<div class="btn_area">
			<ntels:auth auth="${authType}">
			<button id="btn_add" type="button" class="major"><spring:message code="label.common.insert.text" /></button>
			</ntels:auth>
		</div>
	</div>
	<!-- 페이징 end -->