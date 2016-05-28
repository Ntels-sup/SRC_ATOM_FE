<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
$(document).ready(function() {
	// row 선택 이벤트
	$("#almCodeDefTbody tr").click(function() {
		if ($(this).hasClass("act")) {
			$(this).removeClass("act");
			$("#almMonitorDefDiv").html("");
		} else {
			$("#almCodeDefTbody tr").removeClass("act");
			$(this).addClass("act");
		}
	});
	
	// Select 초기화
	$("select.bottom").multipleSelect({
	     single: true,
	     selectAll: false,
	     multiple: false,
	     position: 'top',
	     onClick: function(view) {
	    	 fnShowLoading("#almCodeDefDiv");
	    	 goPostPage("#almCodeDefDiv", "listAlmCodeDef.ajax", "${resultList.page}", view.value, "${resultList.perSize}");
	     }
	 });
	
	// Modify 버튼
	$("#modifyButton").click(function() {
		var trAct = $("#almCodeDefTbody tr.act");
		if ($(trAct).length == 0) {
			openAlertModal("<spring:message code="msg.fulat.alarmlevel.list.selectrow"/>");
			return;
		}
		$("#pkg_name").val($(trAct).find("#pkg_name").text());
		$("#code").val($(trAct).find("#code").text());
		$("#probable_cause").val($(trAct).find("#probable_cause").text());
		$("#myForm").attr("action", "listAlmMonitorDef");
		$("#myForm").submit();
	});
	
	$("#page").val("${resultList.page}");
});
</script>
<div class="data type02 text_all">
	<table class="tbl_list">
		<colgroup>
			<col width="15%"/>
			<col width="12%"/>
			<col width="22%"/>
			<col width="*"/>
			<col width="10px"/>
		</colgroup>
		<thead>
			<tr>
				<th><spring:message code="label.fault.alarmlevel.packagename.text"/></th>
				<th><spring:message code="label.fault.alarmlevel.alarmcode.text"/></th>
				<th><spring:message code="label.fault.alarmlevel.probablecause.text"/></th>
				<th><spring:message code="label.fault.alarmlevel.description.text"/></th>
				<th></th>
			</tr>
		</thead>
	</table>
	<div class="scroll link">
		<table class="tbl_list">
			<colgroup>
				<col width="15%"/>
				<col width="12%"/>
				<col width="22%"/>
				<col width="*"/>
			</colgroup>
			<tbody id="almCodeDefTbody">
				<c:forEach items="${resultList.lists}" var="item" varStatus="status">
					<tr>
						<td id="pkg_name">${item.pkg_name}</td>
						<td id="code">${item.code}</td>
						<td id="probable_cause">${item.probable_cause}</td>
						<td id="description">${item.description}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<div id="_atomPagingDiv" class="cont_footer" style="margin-top:15px;">
	<ntels:perPageControl totalCount="${resultList.totalCount}" 
			perPage="${resultList.perPage}" 
			page="${resultList.page}">
		<spring:message code="label.common.perpage.normal.text" />
	</ntels:perPageControl>
	<ntels:paging is_ajax="true" ajax_method="goPostPage" ajax_url="listAlmCodeDef.ajax" ajax_target="#almCodeDefDiv" 
			active="${resultList.page}"
			total_count="${resultList.totalCount}"
			per_page="${resultList.perPage}"
			per_size="${resultList.perSize}"/>
	<div class="btn_area">
		<button id="modifyButton" type="button" class="major"><spring:message code="label.common.modify"/></button>
	</div>
</div>
