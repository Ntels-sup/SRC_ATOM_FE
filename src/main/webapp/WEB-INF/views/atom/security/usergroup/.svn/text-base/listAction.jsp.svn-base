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
	 			<col width="30%" />
	 			<col width="*" />
	 			<col width="10px" />
	 		</colgroup>
	 		<thead>
	 			<tr>
	 				<th class="no"><spring:message code="label.security.usergroup.no.text" /></th>
	 				<th><spring:message code="label.security.usergroup.user_group.text" /></th>
	 				<th><spring:message code="label.security.usergroup.package.text" /></th>
	 				<th><spring:message code="label.security.usergroup.description.text" /></th>
	 				<th></th>
	 			</tr>
	 		</thead>
	 	</table>
	 	<div class="scroll sml link">
	 		<table class="tbl_list">
	 			<colgroup>
	 			<col>
	 			<col width="20%" />
	 			<col width="30%" />
	 			<col width="*" />
	 			</colgroup>
	 			<tbody>
	 				<c:if test="${!empty userGroupList.lists}">
		 				<c:forEach items="${userGroupList.lists}" var="list" varStatus="status">
		 					<tr onClick='javascript:goDetail("${list.group_no}");'>
		 						<td class="no">${list.group_no}</td>
		 						<td>${list.group_name}</td>
		 						<td>${list.pkg_name}</td>
		 						<td>${list.description}</td>
		 					</tr>
		 				</c:forEach>
	 				</c:if>
	 				<c:if test="${empty userGroupList.lists}">
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
		<ntels:perPageControl totalCount="${userGroupList.totalCount}" perPage="${userGroupList.perPage}" page="${userGroupList.page}"> <spring:message code="label.common.perpage.normal.text" /></ntels:perPageControl>                    
		<ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#userGroupTable" active="${userGroupList.page}"  total_count="${userGroupList.totalCount}" per_page="${userGroupList.perPage}" per_size="${userGroupList.perSize}"/>
		<div class="btn_area">
			<ntels:auth auth="${authType}">
			<button id="btn_add" type="button" class="major"><spring:message code="label.common.insert.text" /></button>
			</ntels:auth>
		</div>
	</div>
	<!-- 페이징 end -->