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
	 			<col width="150px" />
	 			<col width="*" />
	 			<col width="15%" />
	 			<col width="15%" />
	 			<col width="*" />
	 			<col width="10px" />
	 		</colgroup>
	 		<thead>
	 			<tr>
	 				<th><spring:message code="label.fault.alarmconfig.package.text" /></th>
	 				<th class="sort down" id="CODE" onClick="listSort(this)"><spring:message code="label.fault.alarmconfig.alarm_code.text" /></th>
	 				<th class="sort down" id="PROBABLE_CAUSE" onClick="listSort(this)"><spring:message code="label.fault.alarmconfig.probable_cause.text" /></th>
	 				<th class="sort down" id="TYPE_CCD" onClick="listSort(this)"><spring:message code="label.fault.alarmconfig.alarm_type.text" /></th>
	 				<th class="sort down" id="GROUP_CCD" onClick="listSort(this)"><spring:message code="label.fault.alarmconfig.group.text" /></th>
	 				<th><spring:message code="label.fault.alarmconfig.description.text" /></th>
	 				<th></th>
	 			</tr>
	 		</thead>
	 	</table>
	 	<div class="scroll sml link">
	 		<table class="tbl_list">
	 			<colgroup>
	 				<col width="10%" />
		 			<col width="150px" />
		 			<col width="*" />
		 			<col width="15%" />
		 			<col width="15%" />
		 			<col width="*" />
	 			</colgroup>
	 			<tbody>
	 				<c:if test="${!empty alarmConfigList.lists}">
		 				<c:forEach items="${alarmConfigList.lists}" var="list" varStatus="status">
		 					<tr onClick='javascript:goDetail("${list.code}","${list.pkg_name}");'>
		 						<td>${list.pkg_name}</td>
		 						<td>${list.alias_code}</td>
		 						<td>${list.probable_cause}</td>
		 						<td>${list.type_ccd_name}</td>
		 						<td>${list.group_ccd_name}</td>
		 						<td>${list.description}</td>
		 					</tr>
		 				</c:forEach>
	 				</c:if>
	 				<c:if test="${empty alarmConfigList.lists}">
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
		<ntels:perPageControl totalCount="${alarmConfigList.totalCount}" perPage="${alarmConfigList.perPage}" page="${alarmConfigList.page}"> <spring:message code="label.common.perpage.normal.text" /></ntels:perPageControl>                    
		<ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#alarmConfigTable" active="${alarmConfigList.page}"  total_count="${alarmConfigList.totalCount}" per_page="${alarmConfigList.perPage}" per_size="${alarmConfigList.perSize}"/>
	</div>
	<!-- 페이징 end -->