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
		
		// chrome fix.
		document.onselectstart = function () { return false; };	

		var height = 205;

		<c:forEach items="${listBatchGroup}" var="batchGroup" varStatus="status">
		
			height += 26;
			
		</c:forEach>
		
		window.resizeTo(925,height);		
	});

	// 추가
	function insertBatchGroup() {
	
		frm.action = "/pfnm/designer/batch/insertBatchGroup.ajax";
		frm.submit();
	}
	
	// 수정
	function updateBatchGroup(id) {
		
		frm.batch_group_id.value = id;
		
		frm.action = "/pfnm/designer/batch/updateBatchGroup.ajax";
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
	<div id="pop_layer" style="width:900px;">
		<section>
			<header>
				<spring:message code="label.pfnm.batch.manage_batch_group.text"/><a href="javascript:closeWindow();"><spring:message code="label.pfnm.batch.close.text"/></a>
			</header>
			<article>
				<form id="frm" name="frm" method="post"
					action="/pfnm/designer/batch/listBatchGroup.ajax">
				<input type="hidden" id="system_id" name="system_id" value="${batchGroup.system_id}"/>
				<input type="hidden" id="package_id" name="package_id" value="${batchGroup.package_id}"/>
				<input type="hidden" id="batch_group_id" name="batch_group_id" value=""/>
				<table class="view">
					<caption>Data Format</caption>
					<thead>
						<tr>
							<th scope="col"><spring:message code="label.pfnm.batch.batch_group.text"/></th>
							<th scope="col"><spring:message code="label.pfnm.batch.register_date.text"/></th>
							<th scope="col"><spring:message code="label.pfnm.batch.apply_date.text"/></th>
							<th scope="col"><spring:message code="label.pfnm.batch.expire_date.text"/></th>
							<th scope="col"><spring:message code="label.pfnm.batch.schedule_cycle_type.text"/></th>
							<th scope="col"><spring:message code="label.pfnm.batch.schedule_cycle.text"/></th>
							<th scope="col"><spring:message code="label.pfnm.batch.holiday_exception_yn.text"/></th>
							<th scope="col"><spring:message code="label.pfnm.batch.last_schedule_date.text"/></th>
							<th scope="col"><spring:message code="label.pfnm.batch.remark.text"/></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${listBatchGroup}" var="batchGroup" varStatus="status">	
						<tr onclick="updateBatchGroup('${batchGroup.batch_group_id}');" style="cursor:pointer;">
							<td>${batchGroup.batch_group_name}</td>
							<td>${batchGroup.register_date}</td>
							<td>${batchGroup.apply_date}</td>
							<td>${batchGroup.expire_date}</td>
							<td>${batchGroup.schedule_cycle_type}</td>							
							<td>${batchGroup.schedule_cycle}</td>
							<td>${batchGroup.holiday_exception_yn}</td>
							<td>${batchGroup.last_schedule_date}</td>
							<td>${batchGroup.remark}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				</form>
				<div class="pop_btn">
					<a href="javascript:insertBatchGroup();" class="button"><span><spring:message code="label.common.button.add.text"/></span>
					</a> 
					<a href="javascript:closeWindow();" class="button"><span><spring:message code="label.common.button.close.text"/></span>
					</a>
				</div>
			</article>
		</section>
	</div>
	<!--e : popup layer-->
</body>
</html>