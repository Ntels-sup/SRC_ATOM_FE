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
<!-- 리스트 start -->                    
            <div class="data xscroll">
                 <div>
                 <table class="tbl_list">
                    <colgroup>
                    <col>
                    <col>
                    <col width="120px">
                    <col width="*">
                    <col width="120px">
                    <col width="160px">
                    <col width="160px">
                    <col width="*">
                    <col width="120px">
                    <col width="100px">
                    <col width="120px">
                    <col width="*">
                    <col width="135px">
                    <col width="10px">
                    </colgroup>
                    <thead>
                        <tr>
                            <th class="date sort down" id="PRC_DATE" onClick="listSort(this)" ><spring:message code="label.alarm.history.table_hd.prc_date.text"/></th>
                            <th class="date sort down" id="CLEARED_DATE" onClick="listSort(this)" ><spring:message code="label.alarm.history.cleared_date.text"/></th>
                            <th class="sort down" id="CODE" onClick="listSort(this)" ><spring:message code="label.alarm.history.code.text"/></th>
                            <th class="sort down" id="PROBABLE_CAUSE" onClick="listSort(this)" ><spring:message code="label.alarm.history.probable_cause.text"/></th>
                            <th class="sort down" id="PKG_NAME" onClick="listSort(this)" ><spring:message code="label.alarm.history.package.text"/></th>
                            <th class="sort down" id="NODE_NAME" onClick="listSort(this)" ><spring:message code="label.alarm.history.system.text"/></th>
                            <th class="sort down" id="SEVERITY_CCD" onClick="listSort(this)" ><spring:message code="label.alarm.history.severity.text"/></th>
                            <th><spring:message code="label.alarm.history.location.text"/></th>
                            <th class="sort down" id="DURATION" onClick="listSort(this)" ><spring:message code="label.alarm.history.duration.text"/></th>
                            <th><spring:message code="label.alarm.history.snmpsend.text"/></th>
                            <th><spring:message code="label.alarm.history.clear_type.text"/></th>
                            <th><spring:message code="label.alarm.history.additional_text.text"/></th>
                            <th><spring:message code="label.alarm.history.tracking_id.text"/></th>
                            <th></th>
                        </tr>
                    </thead>
                        </table>
                        <div class="scroll">
                        <table class="tbl_list">
	                        <colgroup>
	                        <col>
	                        <col>
                            <col width="120px">
                            <col width="*">
                            <col width="120px">
                            <col width="160px">
                            <col width="160px">
                            <col width="*">
                            <col width="120px">
                            <col width="100px">
                            <col width="120px">
                            <col width="*">
                            <col width="135px">
	                        </colgroup>
                          <tbody>
                          <c:forEach items="${resultList.lists}" var="resultModel" varStatus="status">
						    <tr>
						      <td class="date">${resultModel.prc_date}</td>
						      <td class="date">${resultModel.cleared_date}</td>
						      <td>${resultModel.code}</td>
						      <td title="${resultModel.probable_cause}" >${resultModel.probable_cause}</td>
						      <td>${resultModel.pkg_name}</td>
						      <td>${resultModel.node_name}</td>
						      <td    class='sev <c:if test="${resultModel.severity_ccd eq '0'}">ind</c:if>
											    <c:if test="${resultModel.severity_ccd eq '1'}">cr</c:if>
											    <c:if test="${resultModel.severity_ccd eq '2'}">ma</c:if>
											    <c:if test="${resultModel.severity_ccd eq '3'}">mi</c:if>
											    <c:if test="${resultModel.severity_ccd eq '4'}">wa</c:if>
											    <c:if test="${resultModel.severity_ccd eq '5'}">cl</c:if>
						      '>${resultModel.severity_nm}</td>
						      <td title="${resultModel.location}">${resultModel.location}</td>
						      <td class="date">
						      	<c:if test="${!empty resultModel.duration}" >${resultModel.duration}</c:if>
						      	<c:if test="${empty resultModel.duration}" >--</c:if>
						      </td>
						      <td>
						      <c:if test="${resultModel.snmp_send_yn eq 'Y'}" >YES</c:if>
						      <c:if test="${resultModel.snmp_send_yn eq 'N'}" >NO</c:if>
						      </td>
						      <td>${resultModel.clear_type}</td>
						      <td title="${resultModel.additional_text}" >${resultModel.additional_text}</td>
						      <td>${resultModel.tracking_id}</td>
						    </tr>
						  </c:forEach>
						  <c:if test="${empty resultList.lists}">
						    <tr class="odd" style="cursor:default;">
						      <td align="center" colspan="14" ><spring:message code="label.empty.list" /></td>
						    </tr>
						  </c:if>                          
                          
                          </tbody>
                        </table>
                        </div>
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
                <ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#dataTable" 
                              active="${resultList.page}"  
                              total_count="${resultList.totalCount}" 
                              per_page="${resultList.perPage}" 
                              per_size="${resultList.perSize}"/>    

			 </div><!-- //cont_footer -->
<!-- 페이징 end -->



