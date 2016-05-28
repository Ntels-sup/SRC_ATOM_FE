<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">

$(document).ready(function() {
	var msg = '<spring:message code="msg.general.backup.backuprestore.restoreable.text" arguments="${cnt}" />';
// 	alert(msg);
	$("#restoreableMsg").html(msg);
	//alert(${cnt});
});

</script>
	
<!-- 오른쪽 테이블영역 -->
<div class="data type02">
	<table class="tbl_list">
		<colgroup>
			<col width="12%">
			<col width="12%">
			<col width="12%">
			<col width="*">

			<col width="12%">
			<col width="15%">
			<col width="130px">
			<col width="10px">
		</colgroup>
		<thead>
			<tr>
				<th><spring:message code="label.general.history.backup.pkg_name.text" /></th><!-- Package -->
				<th><spring:message code="label.general.history.backup.node_name.text" /></th><!-- Node -->
				<th><spring:message code="label.general.history.backup.category.text" /></th><!-- Category -->
				<th><spring:message code="label.general.history.backup.file_name2.text" /></th><!-- File Name -->
			
				<th><spring:message code="label.general.backup.backuprestore.creationtime.text" /></th><!-- Create Time -->
				<th class="t_r"><spring:message code="label.general.backup.backuprestore.filesize.text" /></th><!-- File Size (Byte) -->
				<th class="t_c"><spring:message code="label.general.backup.backuprestore.restore.text" /></th><!-- Restore -->
				<th></th>
			</tr>
		</thead>
	</table>

	<div class="scroll">
		<table class="tbl_list">
			<colgroup>
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="*">

				<col width="12%">
				<col width="15%">
				<col width="130px">
			</colgroup>
			<tbody>
				<c:forEach items="${list}" var="result" varStatus="status">
				<tr>
					<td>${result.pkg_name}</td>
					<td>${result.node_name}</td>
					<td>${result.category}</td>
					<td>${result.backup_file}</td>
			
					<td>${result.prc_date}</td>
					<td class="t_r"><fmt:formatNumber value="${result.file_size}" type="number"/></td>
					<td class="t_c">
						<button type="button" class="btn_stroke" onclick="javascript:fnRestore('${result.backup_path}', '${result.backup_file}')">Restore</button>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<!-- 오른쪽 테이블영역 -->