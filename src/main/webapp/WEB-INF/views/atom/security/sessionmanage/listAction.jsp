<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	 			<col width="*"/>
                <col width="*"/>
                <col width="20%"/>
                <col width="14%"/>
                <col width="14%"/>
                <col width="15%"/>
                <col width="10px"/>
	 		</colgroup>
	 		<thead>
	 			<tr>
	 				<th><spring:message code="label.security.sessionmanage.user_id.text" /></th>
	 				<th class="sort down" id="USER_NAME" onClick="listSort(this)"><spring:message code="label.security.sessionmanage.user_name.text" /></th>
	 				<th id="LOGIN_DATE" onClick="listSort(this)"><spring:message code="label.security.sessionmanage.date.text" /></th>
	 				<th><spring:message code="label.security.sessionmanage.ip.text" /></th>
	 				<th><spring:message code="label.security.sessionmanage.type.text" /></th>
	 				<th class="t_c"><spring:message code="label.security.sessionmanage.session_status.text" /></th>
	 				<th></th>
	 			</tr>
	 		</thead>
	 	</table>
	 	<div class="scroll sml">
	 		<table class="tbl_list">
	 			<colgroup>
		 			<col width="*"/>
                    <col width="*"/>
                    <col width="20%"/>
                    <col width="14%"/>
                    <col width="14%"/>
                    <col width="15%"/>
	 			</colgroup>
	 			<tbody>
	 				<c:if test="${!empty sessionManageList.lists}">
		 				<c:forEach items="${sessionManageList.lists}" var="list" varStatus="status">
		 					<tr>
		 						<td>${list.user_id}</td>
		 						<td>${list.user_name}</td>
		 						<td>${list.login_date}</td>
		 						<td>${list.gateway_ip}</td>
		 						<td>${list.type_name}</td>
		 						<td class="t_c">
			 						<c:choose>
				 						<c:when test="${list.user_id eq sessionUserId and list.gateway_ip eq remoteIp}">
				 							&nbsp;
				 						</c:when>
				 						<c:when test="${list.type eq 1}">
				 							&nbsp;
				 						</c:when>
				 						<c:otherwise>
				 							<ntels:auth auth="${authType}">
				 							<button type="button" class="btn_stroke" onclick="stopSession('${list.user_id}','${list.session_id}','${list.gateway_ip}')"><spring:message code="label.security.sessionmanage.session_stop.text" /></button>
				 							</ntels:auth>			 						
				 						</c:otherwise>
			 						</c:choose>
		 						</td>
		 					</tr>
		 				</c:forEach>
	 				</c:if>
	 				<c:if test="${empty sessionManageList.lists}">
						<tr>
			    			<td class="t_c" colspan="6"><spring:message code="label.empty.list" /></td>
			    		</tr>
	 				</c:if>
	 			</tbody>
	 		</table>
		</div>
	</div>

	<!-- 페이징 start -->
	<div class="cont_footer">
		<ntels:perPageControl totalCount="${sessionManageList.totalCount}" perPage="${sessionManageList.perPage}" page="${sessionManageList.page}"> <spring:message code="label.common.perpage.normal.text" /></ntels:perPageControl>                    
		<ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#sessionManageTable" active="${sessionManageList.page}"  total_count="${sessionManageList.totalCount}" per_page="${sessionManageList.perPage}" per_size="${sessionManageList.perSize}"/>
	</div>
	<!-- 페이징 end -->