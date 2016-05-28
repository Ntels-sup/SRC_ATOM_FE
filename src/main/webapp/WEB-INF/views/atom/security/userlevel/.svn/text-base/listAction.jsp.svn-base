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
	 			<col width="15%" />
	 			<col>
	 			<col>
	 			<col>
	 			<col>
	 			<col width="10%">
	 			<col>
	 			<col width="15%" />
	 			<col width="10px" />
	 		</colgroup>
	 		<thead>
	 			<tr>
	 				<th class="no"><spring:message code="label.security.usergroup.no.text" /></th>
	 				<th><spring:message code="label.security.userlevel.user_level.text" /></th>
	 				<th class="no"><spring:message code="label.security.userlevel.account_expiration.text" /></th>
	 				<th class="no"><spring:message code="label.security.userlevel.account_report.text" /></th>
	 				<th class="no"><spring:message code="label.security.userlevel.password_expiration.text" /></th>
	 				<th class="no"><spring:message code="label.security.userlevel.password_report.text" /></th>
	 				<th><spring:message code="label.security.userlevel.password_lock_type.text" /></th>
	 				<th class="no"><spring:message code="label.security.userlevel.account_lock.text" /></th>
	 				<th><spring:message code="label.security.userlevel.description.text" /></th>
	 				<th></th>
	 			</tr>
	 		</thead>
	 	</table>
	 	<div class="scroll sml link">
	 		<table class="tbl_list">
	 			<colgroup>
		 			<col>
		 			<col width="15%" />
		 			<col>
		 			<col>
		 			<col>
		 			<col>
		 			<col width="10%">
		 			<col>
		 			<col width="15%" />
	 			</colgroup>
	 			<tbody>
	 				<c:if test="${!empty userLevelList.lists}">
		 				<c:forEach items="${userLevelList.lists}" var="list" varStatus="status">
		 					<tr onClick='javascript:goDetail("${list.level_id}");'>
		 						<td class="no">${list.rownum}</td>
		 						<td>${list.level_title}</td>
		 						<td class="no">${list.account_life_cycle}</td>
		 						<td class="no">${list.account_noti_day}</td>
		 						<td class="no">${list.passwd_life_cycle}</td>
		 						<td class="no">${list.passwd_noti_day}</td>
		 						<td>${list.lock_type_name}</td>
		 						<td class="no">${list.absent_lock_day}</td>
		 						<td>${list.description}</td>
		 					</tr>
		 				</c:forEach>
	 				</c:if>
	 				<c:if test="${empty userLevelList.lists}">
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
		<ntels:perPageControl totalCount="${userLevelList.totalCount}" perPage="${userLevelList.perPage}" page="${userLevelList.page}"> <spring:message code="label.common.perpage.normal.text" /></ntels:perPageControl>                    
		<ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#userLevelTable" active="${userLevelList.page}"  total_count="${userLevelList.totalCount}" per_page="${userLevelList.perPage}" per_size="${userLevelList.perSize}"/>
	</div>
	<!-- 페이징 end -->