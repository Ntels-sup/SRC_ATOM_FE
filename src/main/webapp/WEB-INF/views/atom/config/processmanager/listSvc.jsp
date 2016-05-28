<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$(document).ready(function() {
	var rowCount = 0;
	for (var i=0;i<g_data.svcList.length;i++) {
		var svc = g_data.svcList[i];
		if (svc.node_type == $("#nodeTypeSelect").val()) {
			var sHtml = "";
			sHtml += "<tr data-node_type="+svc.node_type+">\n";
			sHtml += "	<td>"+svc.svc_no+"</td>\n";
			sHtml += "	<td>"+svc.svc_name+"</td>\n";
			sHtml += "	<td>"+nullCheck(svc.description, "")+"</td>\n";
			sHtml += "	<td>\n";
			sHtml += "		<button type=\"button\" class=\"btn_row edit\" onClick=\"javascript:modifySvc(this);\"><span><spring:message code="label.common.modify"/></span></button>";
			sHtml += "		<button type=\"button\" class=\"btn_row del\" onClick=\"javascript:deleteSvc(this);\"><span><spring:message code="label.common.delete"/></span></button>";
			sHtml += "	</td>\n";
			sHtml += "</tr>\n";
			$("#svcModalDiv #svcTbody").append(sHtml);
			rowCount++;
		}
	}
	$("#svcModalDiv #rowCount").text(rowCount);
	$("#svcModalDiv #pkg_name").text($("#nodeTypeSelect option:selected").parent("optgroup").attr("label"));
	$("#svcModalDiv #node_name").text($("#nodeTypeSelect").val());
	var option = new Object();
	option.onClose = function() {
		closeSvcModal();
	}
    openModal("#svcModalDiv", option);
});

function closeSvcModal() {
	var svc_no = $("#svcSelect").val();
	var oldSvcList = g_data.svcList;
	var svcList = new Array();
	for (var i=0;i<oldSvcList.length;i++) {
		var svc = oldSvcList[i];
		if (svc.node_type != $("#nodeTypeSelect").val()) {
			svcList.push(svc);
		}
	}
	$("#svcTbody tr").each(function() {
		var node_type = $(this).data("node_type");
		var svc_no = $(this).children("td").eq(0);
		var svc_name = $(this).children("td").eq(1);
		var description = $(this).children("td").eq(2);
		var input = $(svc_no).children("input");
		if ($(input).length == 0) {
			var svc = new Object();
			svc.node_type = node_type;
			svc.svc_no = $(svc_no).text();
			svc.svc_name = $(svc_name).text();
			svc.description = $(description).text();
			svcList.push(svc);
		} else if ($(input).prop("readonly")) {
			var svc = new Object();
			svc.node_type = node_type;
			svc.svc_no = $(svc_no).children("input").val();
			svc.svc_name = $(svc_name).children("input").val();
			svc.description = $(description).children("input").val();
			svcList.push(svc);
		}
	});
	g_data.svcList = svcList;
	loadSvc(g_data.svcList, "process");
	searchSvc($("#nodeTypeSelect").val(), svc_no);

	if (!isEmpty(svc_no)) {
		// 기존에 선택되어있던 서비스가 삭제된 경우 캔버스를 리로드한다.
		var bExist = false;
		for (var i=0;i<g_data.svcList.length;i++) {
			var svc = g_data.svcList[i];
			if (svc.svc_no == svc_no) {
				bExist = true;
				break;
			}
		}
		if (!bExist) {
			var param = new Object();
			param.pkg_name = $("#nodeTypeSelect option:selected").parent("optgroup").attr("label");
			param.node_type = $("#nodeTypeSelect").val();
			param.node_name = $("#nodeTypeSelect option:selected").text();
			searchFlowDesign(true, param);
		}
	}
	
	closeModal();
}

function addSvcRow() {
	var sHtml = "";
	sHtml += "<tr data-node_type=\""+$("#nodeTypeSelect").val()+"\">"
	sHtml += "	<td><input type=\"text\" id=\"svc_no\" placeholder=\"<spring:message code="label.configuration.processmanager.serviceid.text"/>\" style=\"width:100%;\" maxlength=\"9\"/></td>\n";
	sHtml += "	<td><input type=\"text\" id=\"svc_name\" placeholder=\"<spring:message code="label.configuration.processmanager.servicename.text"/>\" style=\"width:100%;\" maxlength=\"40\"/></td>\n";
	sHtml += "	<td><input type=\"text\" id=\"description\" placeholder=\"<spring:message code="label.configuration.processmanager.description.text"/>\" style=\"width:100%;\" maxlength=\"128\"/></td>\n";
	sHtml += "	<td>\n";
	sHtml += "		<button type=\"button\" class=\"btn_row save\" onClick=\"javascript:insertSvc(this);\"><span><spring:message code="label.common.save"/></span></button>";
	sHtml += "		<button type=\"button\" class=\"btn_row del\" onClick=\"javascript:deleteSvcRow(this);\"><span><spring:message code="label.common.delete"/></span></button>";
	sHtml += "	</td>\n";
	sHtml += "</tr>\n"
	$("#svcTbody").append(sHtml);
	$("#svcTbody tr:last #svc_no").focus();
}

function isValidSvc(obj) {
	$("#svcModalDiv #errorSpan").attr("class", "hide");
	var tr = $(obj).parent("td").parent("tr");
	var svc_no = $(tr).find("#svc_no");
	var svc_name = $(tr).find("#svc_name");
	if (isEmpty($(svc_no).val())) {
		$("#svcModalDiv #errorSpan").text("<spring:message code="msg.configuration.processmanager.serviceid.empty"/>");
		$("#svcModalDiv #errorSpan").attr("class", "show");
		$(svc_no).focus();
		return false;
	}
	if (!isValidNaturalNumber($(svc_no).val())) {
		$("#svcModalDiv #errorSpan").text("<spring:message code="msg.configuration.processmanager.serviceid.invalid"/>");
		$("#svcModalDiv #errorSpan").attr("class", "show");
		$(svc_no).focus();
		return false;
	}
	if (isEmpty($(svc_name).val())) {
		$("#svcModalDiv #errorSpan").text("<spring:message code="msg.configuration.processmanager.servicename.empty"/>");
		$("#svcModalDiv #errorSpan").attr("class", "show");
		$(svc_name).focus();
		return false;
	}
	if (!isValidName($(svc_name).val())) {
		$("#svcModalDiv #errorSpan").text("<spring:message code="msg.configuration.processmanager.servicename.invalid"/>");
		$("#svcModalDiv #errorSpan").attr("class", "show");
		$(svc_name).focus();
		return false;
	}
	return true;
}

function updateSvc(obj) {
	if (!isValidSvc(obj)) {
		return;
	}
	var tr = $(obj).parent("td").parent("tr");
	var svc_no = $(tr).find("#svc_no");
	var svc_name = $(tr).find("#svc_name");
	var description = $(tr).find("#description");
	var param = new Object();
	param.node_type = $("#nodeTypeSelect").val();
	param.svc_no = $(svc_no).val();
	param.svc_name = $(svc_name).val();
	param.description = $(description).val();
	$.ajax({
		url : "updateSvc",
		data : param,
		type : 'POST',
		dataType : 'json',
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				$("#svcModalDiv #errorSpan").text("<spring:message code="msg.configuration.processmanager.service.update.succ"/>");
				$("#svcModalDiv #errorSpan").attr("class", "show");
				var sHtml = "";
				sHtml += "						<td>" + param.svc_no + "</td>\n";
				sHtml += "						<td>" + param.svc_name + "</td>\n";
				sHtml += "						<td>" + param.description + "</td>\n";
				sHtml += "						<td>\n";
				sHtml += "							<button type=\"button\" class=\"btn_row edit\" onClick=\"javascript:modifySvc(this);\"><span><spring:message code="label.common.modify"/></span></button>";
				sHtml += "							<button type=\"button\" class=\"btn_row del\" onClick=\"javascript:deleteSvc(this);\"><span><spring:message code="label.common.delete"/></span></button>";
				sHtml += "						</td>\n";
				$(tr).html(sHtml);
			} else {
				$("#svcModalDiv #errorSpan").text(result);
				$("#svcModalDiv #errorSpan").attr("class", "show");
			}
		},
		error : function(e) {
			$("#svcModalDiv #errorSpan").text(e.reponseText);
			$("#svcModalDiv #errorSpan").attr("class", "show");
		},
		complete : function() {
		}
	});
}

function insertSvc(obj) {
	if (!isValidSvc(obj)) {
		return;
	}
	var tr = $(obj).parent("td").parent("tr");
	var svc_no = $(tr).find("#svc_no");
	var svc_name = $(tr).find("#svc_name");
	var description = $(tr).find("#description");
	var param = new Object();
	param.pkg_name = $("#nodeTypeSelect option:selected").parent("optgroup").attr("label");
	param.node_type = $("#nodeTypeSelect").val();
	param.svc_no = $(svc_no).val();
	param.svc_name = $(svc_name).val();
	param.description = $(description).val();
	$.ajax({
		url : "insertSvc",
		data : param,
		type : 'POST',
		dataType : 'json',
		success : function(data) {
			var result = data.result;
			var svc = data.svc;
			if (result == "succ") {
				$("#svcModalDiv #errorSpan").text("<spring:message code="msg.configuration.processmanager.service.insert.succ"/>");
				$("#svcModalDiv #errorSpan").attr("class", "show");
				var sHtml = "";
				sHtml += "						<td>" + svc.svc_no + "</td>\n";
				sHtml += "						<td>" + svc.svc_name + "</td>\n";
				sHtml += "						<td>" + svc.description + "</td>\n";
				sHtml += "						<td>\n";
				sHtml += "							<button type=\"button\" class=\"btn_row edit\" onClick=\"javascript:modifySvc(this);\"><span><spring:message code="label.common.modify"/></span></button>";
				sHtml += "							<button type=\"button\" class=\"btn_row del\" onClick=\"javascript:deleteSvc(this);\"><span><spring:message code="label.common.delete"/></span></button>";
				sHtml += "						</td>\n";
				$(tr).html(sHtml);
				$("#svcSelect").append("<option value=\""+svc.svc_no+"\">"+svc.svc_name+"</option>");
				$("#svcSelect option:last").data("svc", svc).show();
				$("#svcModalDiv #rowCount").text(parseInt($("#svcModalDiv #rowCount").text())+1);
			} else {
				$("#svcModalDiv #errorSpan").text(result);
				$("#svcModalDiv #errorSpan").attr("class", "show");
			}
		},
		error : function(e) {
			$("#svcModalDiv #errorSpan").text(e.reponseText);
			$("#svcModalDiv #errorSpan").attr("class", "show");
		},
		complete : function() {
		}
	});
}

function modifySvc(obj) {
	var svc_no = $(obj).parent("td").parent("tr").children("td").eq(0).text();
	var svc_name = $(obj).parent("td").parent("tr").children("td").eq(1).text();
	var description = $(obj).parent("td").parent("tr").children("td").eq(2).text();
	var sHtml = "";
	sHtml += "	<td><input type=\"text\" id=\"svc_no\" placeholder=\"<spring:message code="label.configuration.processmanager.serviceid.text"/>\" style=\"width:100%;\" value=\""+svc_no+"\" readonly=true/></td>\n";
	sHtml += "	<td><input type=\"text\" id=\"svc_name\" placeholder=\"<spring:message code="label.configuration.processmanager.servicename.text"/>\" style=\"width:100%;\" value=\""+svc_name+"\" maxlength=\"40\"/></td>\n";
	sHtml += "	<td><input type=\"text\" id=\"description\" placeholder=\"<spring:message code="label.configuration.processmanager.description.text"/>\" style=\"width:100%;\" value=\""+description+"\" maxlength=\"128\"/></td>\n";
	sHtml += "	<td>\n";
	sHtml += "		<button type=\"button\" class=\"btn_row save\" onClick=\"javascript:updateSvc(this);\"><span><spring:message code="label.common.save"/></span></button>";
	sHtml += "		<button type=\"button\" class=\"btn_row del\" onClick=\"javascript:deleteSvc(this);\"><span><spring:message code="label.common.delete"/></span></button>";
	sHtml += "	</td>\n";
	$(obj).parent("td").parent("tr").html(sHtml);
}

function deleteSvc(obj) {
	var svc_no = $(obj).parent("td").parent("tr").children("td").eq(0).text();
	if (isEmpty(svc_no)) {
		svc_no = $(obj).parent("td").parent("tr").children("td").eq(0).children("input").val();
	}
	var param = new Object();
	param.svc_no = svc_no;
	$.ajax({
		url : "deleteSvc",
		data : param,
		type : 'POST',
		dataType : 'json',
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				$("#svcModalDiv #errorSpan").text("<spring:message code="msg.configuration.processmanager.service.delete.succ"/>");
				$("#svcModalDiv #errorSpan").attr("class", "show");
				deleteSvcRow(obj);
				$("#svcModalDiv #rowCount").text(parseInt($("#svcModalDiv #rowCount").text())-1);
			} else {
				$("#svcModalDiv #errorSpan").text(result);
				$("#svcModalDiv #errorSpan").attr("class", "show");
			}
		},
		error : function(e) {
			$("#svcModalDiv #errorSpan").text(e.reponseText);
			$("#svcModalDiv #errorSpan").attr("class", "show");
		},
		complete : function() {
		}
	});
}

function deleteSvcRow(obj) {
	$(obj).parent("td").parent("tr").remove();
}
</script>
<div id="svcModalDiv" style="display:none;">
	<div class="popup">
		<h2><spring:message code="label.configuration.processmanager.serviceinformation.text"/></h2>
		<a class="close" href="javascript:closeSvcModal();">&times;</a>
		<div class="pop_cont">
			<div class="list common" style="width:480px;padding:20px 20px 20px 20px;">
				<span><spring:message code="label.configuration.networkmanager.packagename.text"/>: </span><span id="pkg_name"></span>
				<br/>
				<br/>
				<span><spring:message code="label.configuration.networkmanager.nodetypename.text"/>: </span><span id="node_name"></span>
			</div>
			<header>
				<div class="util"><span style="margin-left: 20px;"><em id="rowCount"></em> <spring:message code="label.configuration.networkmanager.rows.text"/></span></div>
				<span class="btn_area">
					<button type="button" class="btn_row add" onClick="javascript:addSvcRow();">
						<span><spring:message code="label.configuration.networkmanager.addrow.text"/></span>
					</button>
				</span>
			</header>
			<div class="list common">
				<table class="tbl_update">
					<colgroup>
						<col width="100px"/>
						<col width="120px"/>
						<col width="*"/>
						<col width="90px"/>
						<col width="10px"/>
					</colgroup>
					<thead>
						<tr>
							<th><spring:message code="label.configuration.processmanager.serviceid.text"/></th>
							<th><spring:message code="label.configuration.processmanager.servicename.text"/></th>
							<th><spring:message code="label.configuration.processmanager.description.text"/></th>
							<th class="ico"></th>
							<th class="src"></th>
						</tr>
					</thead>
				</table>
				<div class="scroll"> 
					<table class="tbl_update">
						<colgroup>
							<col width="100px"/>
							<col width="120px"/>
							<col width="*"/>
							<col width="90px"/>
						</colgroup>
						<tbody id="svcTbody">
						</tbody>
					</table>
				</div>
			</div>
			<span id="errorSpan" class="hide" style="color:#ff0000;margin-left:20px;"></span>
			<!--// list -->
		</div>
		<div class="btn_area">
			<a href="javascript:closeSvcModal();"><button type="button" ><spring:message code="label.common.close"/></button></a>
		</div>
	</div>
</div>