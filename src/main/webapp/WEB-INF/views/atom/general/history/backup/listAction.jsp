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
		
		    	 
    });
    
    function goDetail(obj){
    	$("#pkg_name").val($($(obj).find("td")[0]).text());
    	$("#node_name").val($($(obj).find("td")[1]).text());
    	$("#prc_date").val($($(obj).find("td")[2]).text());
    	$("#group_code_nm").val($($(obj).find("td")[3]).text());
    	$("#backup_name").val($($(obj).find("td")[4]).text());
    	$("#file_size").val($($(obj).find("td")[5]).text());
    	$("#backup_path").val($($(obj).find("td")[8]).text());
    	$("#nodeId").val($($(obj).find("td")[9]).text());
    	$("#groupCode").val($($(obj).find("td")[10]).text());
    	$("#node_type").val($($(obj).find("td")[11]).text());
    	$("#result_no").val($($(obj).find("td")[12]).text());
    	$("#dst_flag").val($($(obj).find("td")[13]).text());
    	
    	$("#myForm").attr("action","/atom/general/history/backup/detail");
		$("#myForm").submit();
    }
    
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
                            <th id="PKG_NAME"><spring:message code="label.general.history.backup.pkg_name.text"/></th>
                            <th id="NODE_NAME"><spring:message code="label.general.history.backup.node_name.text"/></th>
                            <th class="date sort up" id="PRC_DATE" onClick="listSort(this)" ><spring:message code="label.general.history.backup.date.text"/></th>
                            <th id="CATEGORY"><spring:message code="label.general.history.backup.category.text"/></th>
                            <th id="BACKUP_NAME"><spring:message code="label.general.history.backup.file_name.text"/></th>
                            <th id="FILE_SIZE"><spring:message code="label.general.history.backup.file_size.text"/></th>
                            <th id="PROCESS_RESULT_NM"><spring:message code="label.general.history.backup.process_result.text"/></th>
                            <th id="DESCRIPTION"><spring:message code="label.general.history.backup.description.text"/></th>
                        	<th id="BACKUP_PATH" style="display:none;"></th>
                        	<th id="NODE_ID"   style="display:none;" ></th>
                        	<th id="GROUP_CODE"  style="display:none;"  ></th>
                        	<th id="NODE_TYPE" style="display:none;" ></th>
                        	<th id="RESULT_NO" style="display:none;" ></th>
                        	<th id="DST_FLAG" style="display:none;"></th>
                        </tr>
                    </thead>
                 </table>
                 <div class="scroll sml">
                    <table class="tbl_list">
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
                      	<tbody>
                          <c:forEach items="${backupHitList.lists}" var="backupHitList" varStatus="status">
						    <tr onClick='javascript:goDetail(this);'>
						      <td>${backupHitList.pkg_name} </td>
						      <td>${backupHitList.node_name} </td>
						      <td class="date">${backupHitList.prc_date}</td>
						      <td>${backupHitList.group_code_nm}</td>
						      <td>${backupHitList.backup_name}</td>
						      <td><fmt:formatNumber value="${backupHitList.file_size}" type="number"/></td>
						      <td>${backupHitList.process_result_nm}</td>
						      <td>${backupHitList.description}</td>
						      <td style="display:none;">${backupHitList.backup_path}</td>
						      <td  style="display:none;">${backupHitList.node_id}</td>
						      <td  style="display:none;">${backupHitList.group_code}</td>
						      <td style="display:none;">${backupHitList.node_type}</td>
						      <td style="display:none;">${backupHitList.result_no}</td>
						      <td style="display:none;">${backupHitList.dst_flag}</td>
						    </tr>
						  </c:forEach>
 						  <c:if test="${empty backupHitList.lists}">
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
				<ntels:perPageControl totalCount="${backupHitList.totalCount}" 
				                      perPage="${backupHitList.perPage}" 
				                      page="${backupHitList.page}">
				                      <spring:message code="label.common.perpage.normal.text" />
				</ntels:perPageControl>                    
                <ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#historyTable" 
                              active="${backupHitList.page}"  
                              total_count="${backupHitList.totalCount}" 
                              per_page="${backupHitList.perPage}" 
                              per_size="${backupHitList.perSize}"/>    
			 </div><!-- //cont_footer -->
<!-- 페이징 end -->



