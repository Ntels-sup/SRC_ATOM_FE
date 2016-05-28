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
				 			<col width="10%" />
				 			<col width="10%" />
				 			<col width="*" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th id="PKG_NAME"><spring:message code="label.general.history.restore.pkg_name.text"/></th>
                            <th id="NODE_NAME"><spring:message code="label.general.history.restore.node_name.text"/></th>
                            <th class="date sort up" id="PRC_DATE" onClick="listSort(this)" ><spring:message code="label.general.history.restore.date.text"/></th>
                            <th id="BACKUP_NAME"><spring:message code="label.general.history.restore.file_name.text"/></th>
                            <th id="OVERWRITE_FLAG"><spring:message code="label.general.history.restore.overwrite.text"/></th>
                            <th id="RESTORE_PATH"><spring:message code="label.general.history.restore.restore_path.text"/></th>
                            <th id="DESCRIPTION"><spring:message code="label.general.history.restore.description.text"/></th>
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
				 			<col width="10%" />
				 			<col width="10%" />
				 			<col width="*" />
                      	</colgroup>
                      	<tbody>
                          <c:forEach items="${restoreHitList.lists}" var="restoreHitList" varStatus="status">
						    <tr>
						      <td>${restoreHitList.pkg_name} </td>
						      <td>${restoreHitList.node_name} </td>
						      <td class="date">${restoreHitList.prc_date}</td>
						      <td>${restoreHitList.backup_name}</td>
						      <td>${restoreHitList.overwrite_flag}</td>
						      <td>${restoreHitList.restore_path}</td>
						      <td>${restoreHitList.description}</td>
						    </tr>
						  </c:forEach>
 						  <c:if test="${empty restoreHitList.lists}">
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
				<ntels:perPageControl totalCount="${restoreHitList.totalCount}" 
				                      perPage="${restoreHitList.perPage}" 
				                      page="${restoreHitList.page}">
				                      <spring:message code="label.common.perpage.normal.text" />
				</ntels:perPageControl>                    
                <ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#historyTable" 
                              active="${restoreHitList.page}"  
                              total_count="${restoreHitList.totalCount}" 
                              per_page="${restoreHitList.perPage}" 
                              per_size="${restoreHitList.perSize}"/>    

			 </div><!-- //cont_footer -->
<!-- 페이징 end -->



