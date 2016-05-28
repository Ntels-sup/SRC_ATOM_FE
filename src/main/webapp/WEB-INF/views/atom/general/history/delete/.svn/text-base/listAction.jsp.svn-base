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


//-->
</script>
<!-- 리스트 start -->                    
            <div class="data listData">
                 <table class="tbl_header">
                    <colgroup>
                       	<col width="10%" />
			 			<col width="10%" />
			 			<col width="20%" />
			 			<col width="10%" />
			 			<col width="20%" />
			 			<col width="10%" />
			 			<col width="10%" />
			 			<col width="*"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th id="PKG_NAME"><spring:message code="label.general.history.delete.pkg_name.text"/></th>
                            <th id="NODE_NAME"><spring:message code="label.general.history.delete.node_name.text"/></th>
                            <th class="date sort up" id="PRC_DATE" onClick="listSort(this)" ><spring:message code="label.general.history.delete.date.text"/></th>
                            <th id="CATEGORY"><spring:message code="label.general.history.delete.category.text"/></th>
                            <th id="DELETE_COUNT"><spring:message code="label.general.history.delete.delete_cnt.text"/></th>
                            <th id="FILE_SIZE"><spring:message code="label.general.history.delete.file_size.text"/></th>
                            <th id="PROCESS_RESULT_NM"><spring:message code="label.general.history.delete.process_result.text"/></th>
                            <th id="DESCRIPTION"><spring:message code="label.general.history.delete.description.text"/></th>
                        </tr>
                    </thead>
                 </table>
                 <div class="scroll sml link"">
                    <table class="tbl_list">
                      	<colgroup>
                        	<col width="10%" />
				 			<col width="10%" />
				 			<col width="20%" />
				 			<col width="10%" />
				 			<col width="20%" />
				 			<col width="10%" />
				 			<col width="10%" />
				 			<col width="*" />
                      	</colgroup>
                      	<tbody>
                          <c:forEach items="${deleteHitList.lists}" var="deleteHitList" varStatus="status">
						    <tr>
						      <td>${deleteHitList.pkg_name} </td>
						      <td>${deleteHitList.node_name} </td>
						      <td class="date">${deleteHitList.prc_date}</td>
						      <td>${deleteHitList.group_code_nm}</td>
						      <td><fmt:formatNumber value="${deleteHitList.delete_count}" type="number"/></td>
						      <td><fmt:formatNumber value="${deleteHitList.file_size}" type="number"/></td>
						      <td>${deleteHitList.process_result_nm}</td>
						      <td>${deleteHitList.description}</td>
						    </tr>
						  </c:forEach>
 						  <c:if test="${empty deleteHitList.lists}">
						    <tr class="odd" style="cursor:default;">
						      <td align="center" colspan="9"><spring:message code="label.empty.list" /></td>
						    </tr>
						  </c:if>
                      	</tbody>
                     </table>
                 </div>
           </div>
<!-- 리스트 end -->

<!-- 페이징 start -->
			 <div class="cont_footer">
				<ntels:perPageControl totalCount="${deleteHitList.totalCount}" 
				                      perPage="${deleteHitList.perPage}" 
				                      page="${deleteHitList.page}">
				                      <spring:message code="label.common.perpage.normal.text" />
				</ntels:perPageControl>                    
                <ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#historyTable" 
                              active="${deleteHitList.page}"  
                              total_count="${deleteHitList.totalCount}" 
                              per_page="${deleteHitList.perPage}" 
                              per_size="${deleteHitList.perSize}"/>    

			 </div><!-- //cont_footer -->
<!-- 페이징 end -->



