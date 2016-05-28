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
		// multiple select end //
		
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
	 			<col width="15%" />
	 			<col width="15%" />
	 			<col width="15%" />
	 			<col width="20%" />
	 			<col width="10%" />
	 			<col width="20%" />
	 			<col width="10%" />
	 			<col width="10%" />
	 			<col>
	 			<col>
	 			<col width="10px" />
	 		</colgroup>
	 		<thead>
	 			<tr>
	 				<th><spring:message code="label.security.loginhist.user_id.text"/></th>
	 				<th class="sort down" id="GROUP_NAME" onClick="listSort(this)"><spring:message code="label.security.loginhist.user_group.text"/></th>
	 				<th class="sort down" id="LEVEL_TITLE" onClick="listSort(this)"><spring:message code="label.security.loginhist.user_level.text"/></th>
	 				<th class="sort down" id="USER_NAME" onClick="listSort(this)"><spring:message code="label.security.loginhist.user_name.text"/></th>
	 				<th><spring:message code="label.security.loginhist.remark.text"/></th>
	 				<th><spring:message code="label.security.loginhist.client_type.text"/></th>
	 				<th><spring:message code="label.security.loginhist.ip.text"/></th>
	 				<th><spring:message code="label.security.loginhist.login_status.text"/></th>
	 				<th><spring:message code="label.security.loginhist.logout_status.text"/></th>
	 				<th class="date"><spring:message code="label.security.loginhist.login_time.text"/></th>
	 				<th class="date"><spring:message code="label.security.loginhist.logout_time.text"/></th>
	 				<th></th>
	 			</tr>
	 		</thead>
	 	</table>
	 	<div class="scroll">
	 		<table class="tbl_list">
	 			<colgroup>
		 			<col width="10%" />
		 			<col width="15%" />
		 			<col width="15%" />
		 			<col width="15%" />
		 			<col width="20%" />
		 			<col width="10%" />
		 			<col width="20%" />
		 			<col width="10%" />
		 			<col width="10%" />
		 			<col>
		 			<col>
	 			</colgroup>
	 			<tbody>
	 				<c:if test="${!empty loginHistList.lists}">
		 				<c:forEach items="${loginHistList.lists}" var="list" varStatus="status">
		 					<tr>
		 						<td>${list.user_id}</td>
		 						<td>${list.group_name}</td>
		 						<td>${list.level_title}</td>
		 						<td>${list.user_name}</td>
		 						<td>${list.description}</td>
		 						<td>${list.login_client_type}</td>
		 						<td>${list.login_ip}</td>
		 						<td>${list.login_result}</td>
		 						<td>${list.logout_result}</td>
		 						<td class="date">${list.login_date}</td>
		 						<td class="date">${list.logout_date}</td>
		 					</tr>
		 				</c:forEach>
	 				</c:if>
	 				<c:if test="${empty loginHistList.lists}">
						<tr>
			    			<td class="t_c" colspan="10"><spring:message code="label.empty.list" /></td>
			    		</tr>
	 				</c:if>
	 			</tbody>
	 		</table>
		</div>
	</div>

	<!-- 페이징 start -->
	<div class="cont_footer">
		<ntels:perPageControl totalCount="${loginHistList.totalCount}" perPage="${loginHistList.perPage}" page="${loginHistList.page}"> <spring:message code="label.common.perpage.normal.text" /></ntels:perPageControl>                    
		<ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#loginHistTable" active="${loginHistList.page}"  total_count="${loginHistList.totalCount}" per_page="${loginHistList.perPage}" per_size="${loginHistList.perSize}"/>
	</div>
	<!-- 페이징 end -->