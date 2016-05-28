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
	

	//버튼 클릭시
    $("#btn_insert").click(function() {
    	goInsert()
    });
	 
    //페이지당 보여줄 갯수 선택창 view 여부 처리
    $("#currentPerPage").click(function() {
        $("#selectPerPage").toggle();
    });
    
    $("#selectPerPage").click(function() {
        alert($("#selectPerPage").val());
    });
	
    
    
});

function goInsert(){
	$("#myForm").attr("action","/atom/fault/tcaconfig/insert");
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

function detailView(pkg_name,node_no,table_name,column_name){
	$("#pkg_name").val(pkg_name);
	$("#node_no").val(node_no);
	$("#table_name").val(table_name);
	$("#column_name").val(column_name);
	$("#myForm").attr("action","detailView");
	$("#myForm").submit();
}



</script>


<!-- 리스트 start -->                             
                 <div class="data type02">
                        <table class="tbl_list">
							<colgroup>
								<col width="15%">
								<col width="15%">
								<col width="*">
								<col width="*">
								<col width="10%">
								<col width="10px">
							</colgroup>
                          <thead>
                            <tr>
								<th><spring:message code="label.common.package"/></th>
								<th><spring:message code="label.common.node"/></th>
								<th><spring:message code="label.fault.tca.statisticstable"/></th>
								<th><spring:message code="label.fault.tca.statisticscolumn"/></th>
								<th><spring:message code="label.fault.tca.use"/></th>
								<th></th>
                            </tr>
                          </thead>
                        </table>
                        
                        <div class="scroll link">
                        	<table class="tbl_list">
								<colgroup>
									<col width="15%">
									<col width="15%">
									<col width="*">
									<col width="*">
									<col width="10%">
								</colgroup>
                          <tbody>
                          <c:forEach items="${resultList.lists}" var="resultModel" varStatus="status">
						    <tr onclick="detailView('${resultModel.pkg_name}','${resultModel.node_no}','${resultModel.table_name}','${resultModel.column_name}');"  >
						      <td>${resultModel.pkg_name}</td>
						      <td>${resultModel.node_name}</td>
						      <td>${resultModel.table_name}</td>
						      <td>${resultModel.column_name}</td>
						      <td>${resultModel.act_yn}</td>
						    </tr>
						  </c:forEach> 
						  <c:if test="${empty resultList.lists}">
						    <tr class="odd" style="cursor:default;">
						      <td><spring:message code="label.empty.list" /></td>
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
                <ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#dataTable" 
                              active="${resultList.page}"  
                              total_count="${resultList.totalCount}" 
                              per_page="${resultList.perPage}" 
                              per_size="${resultList.perSize}"/>   
                              
             <div class="btn_area">
                <button type="button" id="btn_insert" class="major"><spring:message code="label.common.add"/></button>
             </div>                

			 </div><!-- //cont_footer -->
<!-- 페이징 end -->
