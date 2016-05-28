<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
$(document).ready(function() {
	$("#detailAlmCodeDefDiv #severity_ccd${almCodeDef.severity_ccd}").prop("checked", true);
	$("#detailAlmCodeDefDiv #cancelButton").click(function() {
		goListPage();
	});
	$("#detailAlmCodeDefDiv #saveButton").click(function() {
		if ($("input[name=severity_ccd]:checked").length == 0) {
			openAlertModal("Please Select Alarm Severity");
			return;
		}
		var param = $("#almCodeDefForm").serialize();
		$.ajax({
			url: "saveAlmCodeDef",
			data: param,
			type: 'POST',
			dataType: 'json',
			success: function(data) {
				var result = data.result;
				if (result == "succ") {
					openAlertModal("<spring:message code="msg.fault.alarmlevel.save.almcodedef.succ"/>", "", function() {
						goListPage();
					});
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

function goListPage() {
	$("#almCodeDefForm").attr("action", "list");
	$("#almCodeDefForm").submit();
}
</script>
<form id="almCodeDefForm" name="almCodeDefForm" method="post">
	<input type="hidden" name="pkg_name" value="${almCodeDef.pkg_name}"/>
	<input type="hidden" name="code" value="${almCodeDef.code}"/>
	<input type="hidden" id="page" name="page" value="${param.page}"/>
	<input type="hidden" id="perPage" name="perPage" value="${param.perPage}"/>
	<input type="hidden" id="pkg_names" name="pkg_names" value="${param.pkg_names}"/>
	
	<div id="detailAlmCodeDefDiv" class="content">
		<div class="cont_body">
			<header>
				<h3><spring:message code="label.fault.alarmlevel.severitysetting.text"/></h3>
				<p><spring:message code="label.fault.alarmlevel.severitysetting.description"/></p>
			</header>
			<div class="list type02">
				<table class="tbl_list">
					<caption><spring:message code="label.fault.alarmlevel.severitysetting.text"/></caption>
					<colgroup>
						<col/>
					</colgroup>
					<tbody>
						<tr>
							<td class="t_c">
								<div>
									<input type="radio" id="severity_ccd1" name="severity_ccd" value="1">
									<label for="severity_ccd1"><spring:message code="label.fault.alarmlevel.critical.text"/></label>
									<input type="radio" id="severity_ccd2" name="severity_ccd" value="2">
									<label for="severity_ccd2"><spring:message code="label.fault.alarmlevel.major.text"/></label>
									<input type="radio" id="severity_ccd3" name="severity_ccd" value="3">
									<label for="severity_ccd3"><spring:message code="label.fault.alarmlevel.minor.text"/></label>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="cont_footer">
			<div class="btn_area">
				<button id="cancelButton" type="button"><spring:message code="label.common.cancel"/></button>
				<button id="saveButton" type="button" class="major"><spring:message code="label.common.save"/></button>
			</div>
		</div>
	</div>
</form>
