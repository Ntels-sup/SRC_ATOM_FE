<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$(document).ready(function() {
	if (g_data != null && g_data.pkgList != null) {
		for (var i=0;i<g_data.pkgList.length;i++) {
			var pkg = g_data.pkgList[i];
			var sHtml = "";
			sHtml += "<tr>";
			sHtml += "	<td>"+pkg.pkg_name+"</td>";
			sHtml += "	<td>"+pkg.vnf_text+"</td>";
			sHtml += "	<td>"+nullCheck(pkg.description)+"</td>";
			sHtml += "</tr>";
			$("#pkgListModalDiv #pkgListTbody").append(sHtml);
		}
		$("#pkgListModalDiv #rowCount").text(g_data.pkgList.length);
	} else {
		$("#pkgListModalDiv #rowCount").text("0");
	}
    openModal("#pkgListModalDiv");
});
</script>
<div id="pkgListModalDiv" style="display:none;">
	<div class="popup">
		<h2><spring:message code="label.configuration.networkmanager.packageinformation.text"/></h2>
		<a class="close" href="javascript:closeModal();">&times;</a>
		<div class="pop_cont">
			<header>
				<div class="util"><span><em id="rowCount"></em> <spring:message code="label.configuration.networkmanager.rows.text"/></span></div>
				<span class="btn_area">
				</span>
			</header>
			<div class="list common">
				<table class="tbl_update">
					<colgroup>
						<col width="130px"/>
						<col width="90px"/>
						<col width="*"/>
						<col width="10px"/>                    
					</colgroup>
					<thead>
						<tr>
							<th><spring:message code="label.configuration.networkmanager.packagename.text"/></th>
							<th><spring:message code="label.configuration.networkmanager.vnf.text"/></th>
							<th><spring:message code="label.configuration.networkmanager.remark.text"/></th>
							<th class="src"></th>
						</tr>
					</thead>
				</table>
				<div class="scroll"> 
					<table class="tbl_update">
						<colgroup>
							<col width="130px"/>
							<col width="90px"/>
							<col width="*"/>
						</colgroup>
						<tbody id="pkgListTbody">
						</tbody>
					</table>
				</div>
			</div>
			<!--// list -->
		</div>
		<div class="btn_area">
		<a href="javascript:closeModal();"><button type="button" ><spring:message code="label.common.close"/></button></a>
		</div>
	</div>
</div>