<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title><spring:message code="label.title"/></title>
<link rel="stylesheet" href="<c:url value="/styles/basic.css" />" type="text/css" />

<script type="text/javascript" src="<c:url value="/scripts/jquery/jquery-1.6.2.js" />"></script>
<script type="text/javascript" src="<c:url value="/scripts/jquery/jquery-ui-1.8.11.custom.min.js" />"></script>
<script type="text/javascript">
<!--

	$(document).ready(function() {

		window.resizeTo(526,233);
	});

	// 추가
	function updateBatchFlow() {
	
		if($("#exit_value").val() == "") {
			alert('<spring:message code="msg.pfnm.batch.exit_value.text"/>');
			$("#exit_value").focus();
			return;
		}
		
		frm.submit();
	}
	
	// 삭제
	function deleteBatchFlow() {
	
		frm.action="/pfnm/designer/batch/deleteFlowAction.ajax";
		frm.submit();
	}	
	
	// 창 닫기
	function closeWindow() {
	
		self.close();
	}
	
//-->
</script>
</head>

<body>
	<!--s : popup layer-->
	<div id="pop_layer" style="width:500px;">
		<section>
			<header>
				<spring:message code="label.pfnm.batch.line.text"/><a href="javascript:closeWindow();"><spring:message code="label.pfnm.batch.close.text"/></a>
			</header>
			<article>
				<form id="frm" name="frm" method="post"
					action="/pfnm/designer/batch/updateFlowAction.ajax">
				<input type="hidden" id="system_id" name="system_id" value="${batchFlow.system_id}"/>
				<input type="hidden" id="package_id" name="package_id" value="${batchFlow.package_id}"/>
				<input type="hidden" id="batch_group_id" name="batch_group_id" value="${batchFlow.batch_group_id}"/>
				<input type="hidden" id="batch_job_id" name="batch_job_id" value="${batchFlow.batch_job_id}"/>
				<input type="hidden" id="next_job_id" name="next_job_id" value="${batchFlow.next_job_id}"/>
				<input type="hidden" id="user_id" name="user_id" value="test"/>							
				<table class="modif">
					<colgroup>
						<col width="40%">
						<col width="60%">
					</colgroup>
					<tr>
						<th><label for="exit_value"><strong>*</strong><spring:message code="label.pfnm.batch.exit_value.text"/></label>
						</th>
						<td><input type="text" id="exit_value" name="exit_value" value="${batchFlow.exit_value}" readonly="readonly">
						</td>
					</tr>
					<tr>
						<th><label for="remark"><spring:message code="label.pfnm.batch.remark.text"/></label>
						</th>
						<td><input type="text" id="remark" name="remark" value="${batchFlow.remark}">
						</td>
					</tr>										
				</table>
				</form>
				<div class="pop_btn">
					<a href="javascript:updateBatchFlow();" class="button"><span><spring:message code="label.common.button.save.text"/></span>
					</a>
					<a href="javascript:deleteBatchFlow();" class="button"><span><spring:message code="label.common.button.delete.text"/></span>
					</a>					 
					<a href="javascript:closeWindow();" class="button"><span><spring:message code="label.common.button.cancel.text"/></span>
					</a>
				</div>
			</article>
		</section>
	</div>
	<!--e : popup layer-->
</body>
</html>		