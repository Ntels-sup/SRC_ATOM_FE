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
                          <col width="10%"/>
                          <col>
                          <col width="15%"/>
                          <c:forEach items="${HEADCOL}" var="viewCol" varStatus="status">
                          	<col width="*"/>
                          </c:forEach>
                          <col width="10px">
                          </colgroup>
                          <thead>
                            <tr>
                              <th>SEQUENCE</th>
                              <th class="date sort up" id="PRC_DATE" onClick="listSort(this)"><spring:message code="label.preformance.history.date.text"/></th>
                              <th><spring:message code="label.preformance.history.system.text"/></th>
                              <c:forEach items="${HEADCOL}" var="viewCol" varStatus="status">
                              <th>${viewCol}</th>
                              </c:forEach>

                              <th></th>
                            </tr>
                          </thead>
                        </table>
                        <div class="scroll sml">
                        
                        
                        
                        <table class="tbl_list">
                          <colgroup>
                          <col width="10%"/>
                          <col>
                          <col width="15%"/>
                          <c:forEach items="${HEADCOL}" var="viewCol" varStatus="status">
                          	<col width="*"/>
                          </c:forEach>
                          </colgroup>
                          <tbody>
                          <c:forEach items="${resultList.lists}" var="map" varStatus="status">
						    <tr>
							    <c:forEach items="${map}" var="listMap" varStatus="statuslist">
							      <td <c:if test="${statuslist.index eq '1' }">class="date"</c:if> >${listMap.value}</td>
							    </c:forEach>
						    </tr>
						  </c:forEach> 
						  <c:if test="${empty resultList.lists}">
						    <tr class="odd" style="cursor:default;">
						      <spring:message code="label.empty.list" />
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
