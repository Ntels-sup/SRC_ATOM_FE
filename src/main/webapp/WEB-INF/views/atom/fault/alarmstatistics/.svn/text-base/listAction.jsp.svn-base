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
    	
        
        fnPushChart();
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

function fnPushChart() {
	var dateForm = "${fn:toUpperCase(patternDate)}";
	var type = "${typeId}";
	
	if( type == '1' || type == '5' || type == '6'){
		dateForm = dateForm + " HH:NN";
	}else if(type == '2'){
		dateForm = dateForm + " HH";
	}

chart.dataDateFormat = dateForm;
chart.chartCursor.categoryBalloonDateFormat = dateForm;
chart.graphs =[
			   <c:forEach items="${topSystem}" var="system" varStatus="status">
			   <c:if test="${status.index > 0}">,</c:if> 
			   {"balloonText": "[[title]]: <b>[[value]]</b>","bullet": "round", "bulletSize": 1, "minBulletSize": 1,"id": "AmGraph-'${status.index+1}'","lineThickness": 2,"title": '${system.NODE_NAME}' , "valueField": '${system.NODE_NAME}'}
			   </c:forEach>
			];
chart.dataProvider = ${alarmChart};
chart.validateData();



$('#alarm_count').html('${resultList.map.ALARM_CNT}'); 

}	

</script>
<!-- 리스트 start -->                    
                    <div class="data">
                        <table class="tbl_list">
                          <colgroup>
                          <col>
                          <col width="20%"/>
                          <col width="30%"/>
                          <col width="30%"/>
                          <col width="10%"/>
                          <col width="10px">
                          </colgroup>
                          <thead>
                            <tr>
                              <th class="date sort up" id="PRC_DATE" onClick="listSort(this)"><spring:message code="label.alarm.statistics.prc_date.text"/></th>
                              <th class="sort down" id="PKG_NAME" onClick="listSort(this)"><spring:message code="label.alarm.statistics.Package.text"/></th>
                              <th class="sort down" id="NODE_NAME" onClick="listSort(this)"><spring:message code="label.alarm.statistics.system.text"/></th>
                              <th><spring:message code="label.alarm.statistics.severity.text"/></th>
                              <th class="t_r "><spring:message code="label.alarm.statistics.alarm_cnt.text"/></th>
                              <th></th>
                            </tr>
                          </thead>
                        </table>
                        <div class="scroll sml">
                        <table class="tbl_list">
                          <colgroup>
                          <col>
                          <col width="20%"/>
                          <col width="30%"/>
                          <col width="30%"/>
                          <col width="10%"/>
                          </colgroup>
                          <tbody>
                          <c:forEach items="${resultList.lists}" var="resultModel" varStatus="status">
						    <tr>
						      <td class="date">${resultModel.prc_date}</td>
						      <td>${resultModel.pkg_name}</td>
						      <td>${resultModel.node_name}</td>
						      <td <c:if test="${resultModel.severity_nm eq 'INTERMINATE'}"> class='sev ind'</c:if>
								  <c:if test="${resultModel.severity_nm eq 'CRITICAL'}">    class='sev cr' </c:if>
								  <c:if test="${resultModel.severity_nm eq 'MAJOR'}">       class='sev ma' </c:if>
								  <c:if test="${resultModel.severity_nm eq 'MINOR'}">       class='sev mi' </c:if>
								  <c:if test="${resultModel.severity_nm eq 'WARNING'}">     class='sev wa' </c:if>
								  <c:if test="${resultModel.severity_nm eq 'CLEARED'}">     class='sev st' </c:if>
						      >
						      ${resultModel.severity_nm}</td>
						      <td class="count"><fmt:formatNumber value="${resultModel.alarm_cnt}" type="number" /></td>
						    </tr>
						  </c:forEach>
						  <c:if test="${empty resultList.lists}">
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



