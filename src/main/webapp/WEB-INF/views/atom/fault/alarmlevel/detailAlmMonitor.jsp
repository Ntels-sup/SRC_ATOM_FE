<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link rel="stylesheet" href="/styles/colResizable.css">
<script src="/scripts/colResizable-1.5.min.js"></script>
<script>
$(document).ready(function() {
	$("#detailAlmMonitorDiv #range").colResizable({
		liveDrag: true, 
		draggingClass: "rangeDrag", 
		gripInnerHtml: "<div class='rangeGrip'></div>", 
		onDrag: onSlide,
		minWidth: 8
	});
	
	$("#detailAlmMonitorDiv #cancelButton").click(function() {
		$("#almMonitorDefTbody tr.act").trigger("click");
	});
	
	$("#detailAlmMonitorDiv #saveButton").click(function() {
		var values = "";
		$("#detailAlmMonitorDiv #range tr td").each(function() {
			if (!isEmpty(values)) {
				values += ",";
			}
			values += $(this).text();
		});
		$("#almMonitorForm #values").val(values);
		
		var param = $("#almMonitorForm").serialize();
		$.ajax({
			url: "saveAlmLevel",
			data: param,
			type: 'POST',
			dataType: 'json',
			success: function(data) {
				var result = data.result;
				if (result == "succ") {
					var almMonitor = data.almMonitor;
					var monitor_id = almMonitor.monitor_id;
					$("#almMonitorForm #monitor_id").val(monitor_id);
					openAlertModal("<spring:message code="msg.fault.alarmlevel.save.almlevel.succ"/>");
				} else {
					openAlertModal(result);
				}
			},
			error: function(e) {
				var error = JSON.parse(e.responseText);
				openAlertModal(error.errorMsg.cause.localizedMessage);
			},
			complete: function() {
			}
		});
	});
});

function onSlide(e) {
	var values = new Array();
	var sum = 0;
	$("#detailAlmMonitorDiv #range tr td").each(function() {
		var width = $(this).width();
		values.push(sum+width);
		sum += width;
	});
	var max_value = values[values.length-1];
	var unit_value = parseInt("${almMonitorDef.unit_value}");
	for (var i=0;i<values.length;i++) {
		var value = values[i] * parseInt("${almMonitorDef.max_value}") / max_value;
		$("#detailAlmMonitorDiv #range tr td").eq(i+1).text(Math.round(value / unit_value) * unit_value);
	}
}
</script>
<div id="detailAlmMonitorDiv">
	<form id="almMonitorForm">
		<input type="hidden" id="monitor_id" name="monitor_id" value="${almMonitor.monitor_id}"/>
		<input type="hidden" name="pkg_name" value="${almMonitorDef.pkg_name}"/>
		<input type="hidden" name="code" value="${almMonitorDef.code}"/>
		<input type="hidden" name="target" value="${almMonitorDef.target}"/>
		<input type="hidden" name="node_type" value="${almMonitorDef.node_type}"/>
		<input type="hidden" name="severity_ccds" value="5,3,2,1"/>
		<input type="hidden" id="values" name="values" value=""/>
		
		<div id="slider" style="text-align:center;">
			<table id="range" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<c:choose>
						<c:when test="${fn:length(almLevelList) > 0}">
							<c:set var="prevValue" value=""/>
							<c:forEach items="${almLevelList}" var="item" varStatus="status">
								<c:if test="${!status.first}">
									<td width="${item.value - prevValue}%">${prevValue}</td>
								</c:if>
								<c:if test="${status.last}">
									<td width="${almMonitorDef.max_value - item.value}%">${item.value}</td> 
								</c:if>
								<c:set var="prevValue" value="${item.value}"/>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<td width="50%">0</td>
							<td width="10%"><fmt:formatNumber value="${almMonitorDef.max_value *  50 / 100}" type="number" pattern="#"/></td>
							<td width="10%"><fmt:formatNumber value="${almMonitorDef.max_value *  60 / 100}" type="number" pattern="#"/></td>
							<td width="30%"><fmt:formatNumber value="${almMonitorDef.max_value *  70 / 100}" type="number" pattern="#"/></td>
						</c:otherwise>
					</c:choose>
				</tr>
			</table>
		</div>
		
		<table id="alarmLevelDescTable">
			<colgroup>
				<col width="50%"/>
				<col width="50%"/>
			</colgroup>
			<thead>
				<tr>
					<th>Alarm Severity</th>
					<th>Value</th>
				</tr>
			</thead>
			<tbody>
				<tr><td>Normal</td><td></td>
				<tr><td>Minor</td><td></td>
				<tr><td>Major</td><td></td>
				<tr><td>Critical</td><td></td>
			</tbody>
		</table>
		
		<div class="cont_footer">
			<div class="btn_area">
				<button id="cancelButton" type="button"><spring:message code="label.common.cancel"/></button>
				<button id="saveButton" type="button" class="major"><spring:message code="label.common.save"/></button>
			</div>
		</div>
	</form>
</div>