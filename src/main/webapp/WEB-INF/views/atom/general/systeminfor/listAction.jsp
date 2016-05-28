<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript">


    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() { 
    	sortIinit();

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
		
        //페이지당 보여줄 갯수 선택창 view 여부 처리
        $("#currentPerPage").click(function() {
            $("#selectPerPage").toggle();
        });
        
        $("#selectPerPage").click(function() {
            alert($("#selectPerPage").val());
        });
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
	<div class="data listData">
		<table class="tbl_header">
	 		<colgroup>
	 				<col width="7%" />
		 			<col width="7%" />
		 			<col width="13%" />
		 			<col width="18%" />
		 			<col width="18%" />
		 			<col width="18%" />
		 			<col width="12%">
		 			<col width="9%" />
		 			<col width="7%" />
	 		</colgroup>
	 		<thead>
	 			<tr>
	 				<th><spring:message code="label.general.systeminformation.package.text" /></th>
	 				<th><spring:message code="label.general.systeminformation.system.text" /></th>
	 				<th  class="date"><spring:message code="label.general.systeminformation.date.text" /></th>
	 				<th><spring:message code="label.general.systeminformation.db.text" /></th>
	 				<th><spring:message code="label.general.systeminformation.os.text" /></th>
	 				<th><spring:message code="label.general.systeminformation.cpu.text" /></th>
	 				<th><spring:message code="label.general.systeminformation.kernel.text" /></th>
	 				<th><spring:message code="label.general.systeminformation.totalmemory.text" /></th>
	 				<th><spring:message code="label.general.systeminformation.python.text" /></th>
	 			</tr>
	 		</thead>
	 	</table>
	 	<div class="scroll">
	 		<table class="tbl_list">
	 			<colgroup>
					<col width="7%" />
		 			<col width="7%" />
		 			<col width="13%" />
		 			<col width="18%" />
		 			<col width="18%" />
		 			<col width="18%" />
		 			<col width="12%">
		 			<col width="9%" />
		 			<col width="7%" />
	 			</colgroup>
	 			<tbody>
	 				<c:if test="${!empty systemInforList.lists}">
		 				<c:forEach items="${systemInforList.lists}" var="list" varStatus="status">
		 					<tr>
		 						<td>${list.pkg_name}</td>
		 						<td>${list.node_name}</td>
		 						<td>${list.prc_date}</td>		 						
		 						<td title="${list.db_name}">${list.db_name}</td>
		 						<td title="${list.os}">${list.os}"></td>
		 						<td title="${list.cpu_name}">${list.cpu_name}</td>
		 						<td title="${list.kernel}">${list.kernel}</td>
		 						<td title="${list.memory}">${list.memory}</td>
		 						<td title="${list.python}">${list.python}</td>
		 					</tr>
		 				</c:forEach>
	 				</c:if>
	 				<c:if test="${empty systemInforList.lists}">
						<tr>
			    			<td class="t_c" colspan="11"><spring:message code="label.empty.list" /></td>
			    		</tr>
	 				</c:if>
	 			</tbody>
	 		</table>
		</div>
	</div>

	<!-- 페이징 start -->
	<div class="cont_footer">
		<ntels:perPageControl totalCount="${systemInforList.totalCount}" perPage="${systemInforList.perPage}" page="${systemInforList.page}"> <spring:message code="label.common.perpage.normal.text" /></ntels:perPageControl>                    
		<ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#systeminforHistTable" active="${systemInforList.page}"  total_count="${systemInforList.totalCount}" per_page="${systemInforList.perPage}" per_size="${systemInforList.perSize}"/>
	</div>
	<!-- 페이징 end -->