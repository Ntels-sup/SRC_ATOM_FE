<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<script type="text/javascript">
//Ajax로 첫 화면의 데이터 호출
$(document).ready(function() {
	sortInit();
	
	$("select.bottom").multipleSelect({
		single: true,
	    selectAll: false,
	    multiple: false,
	    position: 'top',
	    onClick: function(view) {
	    	setPerPage(view.value);
		}

	});
	
	//초기 페이지당 보여줄 갯수 선택창 view 숨김 설정
    //$("#selectPerPage").hide();
    
    //페이지당 보여줄 갯수 선택창 view 여부 처리
    $("#currentPerPage").click(function() {
        $("#selectPerPage").toggle();
    });
    
    $("#selectPerPage").click(function() {
        alert($("#selectPerPage").val());
    });
});
    
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

<!-- 리스트 start -->                    
<div class="data">
	<div>
    	<table class="tbl_list">
       	<colgroup>
           	<col width="120px">
            <col width="120px">
            <col width="180px">
            <col width="120px">
            <col width="120px">
            <col width="120px">
            <col width="120px">
            <col width="80px">
            <col width="*">
            <col width="10px">
		</colgroup>
		<thead>
		<tr>
			<th><spring:message code="label.common.package"/></th>
			<th><spring:message code="label.pfnm.batch.batch_group.text"/></th>
			<th class="date"><spring:message code="label.pfnm.batch.register_date.text"/></th>
			<th class="date"><spring:message code="label.pfnm.batch.apply_date.text"/></th>
			<th class="date"><spring:message code="label.pfnm.batch.expire_date.text"/></th>
			<th><spring:message code="label.pfnm.batch.cycle_period.text"/></th>
			<th><spring:message code="label.pfnm.batch.cycle_type.text"/></th>
			<th><spring:message code="label.configuration.networkmanager.use.text"/></th>
			<th><spring:message code="label.common.description"/></th>
			<th></th>
		</tr>
		</thead>
        
		<tbody>
		<c:forEach items="${resultList.lists}" var="resultModel" varStatus="status">
  		<tr onclick="updateBatchGroup('${resultModel.pkg_name}','${resultModel.group_name}');" style="cursor:pointer;">
			<td>${resultModel.pkg_name}</td>
			<td>${resultModel.group_name}</td>
			<td class="date">${resultModel.create_date}</td>
			<td class="date">${resultModel.start_date}</td>
			<td class="date">${resultModel.expire_date}</td>
			<td>${resultModel.schedule_cycle}</td>
			<td>${resultModel.schedule_cycle_type_nm}</td>
			<td>${resultModel.use_yn}</td>
			<td>${resultModel.description}</td>
  			<td></td>
		</tr>
		</c:forEach>
		
		<c:if test="${empty resultList.lists}">
		<tr class="odd" style="cursor:default;">
			<td align="center" colspan="9" ><spring:message code="label.empty.list" /></td>
		</tr>
		</c:if>                          
       	
       	</tbody>
     	</table>
     </div>
</div>
<!-- 리스트 end -->

<!-- 페이징 start -->
<div class="cont_footer">
	<ntels:perPageControl totalCount="${resultList.totalCount}" 
			perPage="${resultList.perPage}" 
			page="${resultList.page}">
		<spring:message code="label.common.perpage.normal.text" />
	</ntels:perPageControl>                    

	<ntels:paging is_ajax="true"
			ajax_method="goPostPage" 
			ajax_url="listSchedulerGroup.ajax" 
			ajax_target="#dataTable" 
            active="${resultList.page}"  
			total_count="${resultList.totalCount}" 
			per_page="${resultList.perPage}" 
			per_size="${resultList.perSize}"/>    
			
	<div class="btn_area">
 		<button type="button" class="major" onclick="javascript:configBatchFlow();">Batch Flow 설정</button>
		<button type="button" class="major" onclick="javascript:insertBatchGroup();"><spring:message code="label.pfnm.batch.add_batch_group.text" /></button>
	</div>			
			
</div><!-- //cont_footer -->
<!-- 페이징 end -->


