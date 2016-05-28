<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$(document).ready(function() {
	if (g_data != null && g_data.nodeGrpList != null) {
		for (var i=0;i<g_data.nodeGrpList.length;i++) {
			var nodeGrp = g_data.nodeGrpList[i];
			var sHtml = "";
			sHtml += "<tr>";
			sHtml += "	<td>"+nodeGrp.node_grp_id+"</td>";
			sHtml += "	<td>"+nodeGrp.node_grp_name+"</td>";
			sHtml += "	<td>";
			sHtml += "		<button type=\"button\" class=\"btn_row edit\" onClick=\"javascript:modifyNodeGrp(this);\"><span><spring:message code="label.common.modify"/></span></button>";
			sHtml += "		<button type=\"button\" class=\"btn_row del\" onClick=\"javascript:deleteNodeGrp(this);\"><span><spring:message code="label.common.delete"/></span></button>";
			sHtml += "	</td>";
			sHtml += "</tr>";
			$("#nodeGrpModalDiv #nodeGrpTbody").append(sHtml);
		}
		$("#nodeGrpModalDiv #rowCount").text(g_data.nodeGrpList.length);
	} else {
		$("#nodeGrpModalDiv #rowCount").text("0");
	}
	var option = new Object();
	option.onClose = function() {
		closeNodeGrpModal();
	};
    openModal("#nodeGrpModalDiv", option);
});

function closeNodeGrpModal() {
	if (g_data != null && g_data.nodeGrpList != null) {
		var nodeGrpList = new Array();
		$("#nodeGrpModalDiv #nodeGrpTbody tr").each(function() {
			var node_grp_id = $(this).children("td").eq(0);
			var node_grp_name = $(this).children("td").eq(1);
			var input = $(node_grp_id).children("input");
			if ($(input).length == 0) {
				var nodeGrp = new Object();
				nodeGrp.node_grp_id = $(node_grp_id).text();
				nodeGrp.node_grp_name = $(node_grp_name).text();
				nodeGrpList.push(nodeGrp);
			} else if ($(input).prop("readonly")) {
				var nodeGrp = new Object();
				nodeGrp.node_grp_id = $(node_grp_id).children("input").val();
				nodeGrp.node_grp_name = $(node_grp_name).children("input").val();
				nodeGrpList.push(nodeGrp);
			}
		});
		g_data.nodeGrpList = nodeGrpList;
	}
	closeModal();
}

function addNodeGrpRow() {
	var sHtml = "";
	sHtml += "<tr>"
	sHtml += "	<td><input type=\"text\" id=\"node_grp_id\" placeholder=\"<spring:message code="label.configuration.networkmanager.nodegroupid.text"/>\" style=\"width:100%;\" maxlength=\"9\"/></td>\n";
	sHtml += "	<td><input type=\"text\" id=\"node_grp_name\" placeholder=\"<spring:message code="label.configuration.networkmanager.nodegroupname.text"/>\" style=\"width:100%;\" maxlength=\"18\"/></td>\n";
	sHtml += "	<td>\n";
	sHtml += "		<button type=\"button\" class=\"btn_row save\" onClick=\"javascript:insertNodeGrp(this);\"><span><spring:message code="label.common.save"/></span></button>";
	sHtml += "		<button type=\"button\" class=\"btn_row del\" onClick=\"javascript:deleteNodeGrpRow(this);\"><span><spring:message code="label.common.delete"/></span></button>";
	sHtml += "	</td>\n";
	sHtml += "</tr>\n";
	$("#nodeGrpModalDiv #nodeGrpTbody").append(sHtml);
	$("#nodeGrpModalDiv #nodeGrpTbody tr:last #node_grp_id").focus();
}

function isValidNodeGrp(obj) {
	$("#nodeGrpModalDiv #errorSpan").attr("class", "hide");
	var tr = $(obj).parent("td").parent("tr");
	var node_grp_id = $(tr).find("#node_grp_id");
	var node_grp_name = $(tr).find("#node_grp_name");
	if (isEmpty($(node_grp_id).val())) {
		$("#nodeGrpModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.nodegroupid.empty"/>");
		$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
		$(node_grp_id).focus();
		return false;
	}
	if (!isValidNaturalNumber($(node_grp_id).val())) {
		$("#nodeGrpModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.nodegroupid.invalid"/>");
		$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
		$(node_grp_id).focus();
		return false;
	}
	if (isEmpty($(node_grp_name).val())) {
		$("#nodeGrpModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.nodegroupname.empty"/>");
		$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
		$(node_grp_name).focus();
		return false;
	}
	if (!isValidName($(node_grp_name).val())) {
		$("#nodeGrpModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.nodegroupname.invalid"/>");
		$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
		$(node_grp_name).focus();
		return false;
	}
	return true;
}

function updateNodeGrp(obj) {
	if (!isValidNodeGrp(obj)) {
		return;
	}
	var tr = $(obj).parent("td").parent("tr");
	var node_grp_id = $(tr).find("#node_grp_id");
	var node_grp_name = $(tr).find("#node_grp_name");
	var param = new Object();
	param.node_grp_id = $(node_grp_id).val();
	param.node_grp_name = $(node_grp_name).val();
	$.ajax({
		url : "updateNodeGrp",
		data : param,
		type : 'POST',
		dataType : 'json',
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				$("#nodeGrpModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.nodegroup.update.succ"/>");
				$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
				var sHtml = "";
				sHtml += "						<td>" + param.node_grp_id + "</td>\n";
				sHtml += "						<td>" + param.node_grp_name + "</td>\n";
				sHtml += "						<td>\n";
				sHtml += "							<button type=\"button\" class=\"btn_row edit\" onClick=\"javascript:modifyNodeGrp(this);\"><span><spring:message code="label.common.modify"/></span></button>";
				sHtml += "							<button type=\"button\" class=\"btn_row del\" onClick=\"javascript:deleteNodeGrp(this);\"><span><spring:message code="label.common.delete"/></span></button>";
				sHtml += "						</td>\n";
				$(tr).html(sHtml);
			} else {
				$("#nodeGrpModalDiv #errorSpan").text(result);
				$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
			}
		},
		error : function(e) {
			$("#nodeGrpModalDiv #errorSpan").text(e.reponseText);
			$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
		},
		complete : function() {
		}
	});
}

function insertNodeGrp(obj) {
	if (!isValidNodeGrp(obj)) {
		return;
	}
	var tr = $(obj).parent("td").parent("tr");
	var node_grp_id = $(tr).find("#node_grp_id");
	var node_grp_name = $(tr).find("#node_grp_name");
	var param = new Object();
	param.node_grp_id = $(node_grp_id).val();
	param.node_grp_name = $(node_grp_name).val();
	$.ajax({
		url : "insertNodeGrp",
		data : param,
		type : 'POST',
		dataType : 'json',
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				$("#nodeGrpModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.nodegroup.insert.succ"/>");
				$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
				var sHtml = "";
				sHtml += "						<td>" + param.node_grp_id + "</td>\n";
				sHtml += "						<td>" + param.node_grp_name + "</td>\n";
				sHtml += "						<td>\n";
				sHtml += "							<button type=\"button\" class=\"btn_row edit\" onClick=\"javascript:modifyNodeGrp(this);\"><span><spring:message code="label.common.modify"/></span></button>";
				sHtml += "							<button type=\"button\" class=\"btn_row del\" onClick=\"javascript:deleteNodeGrp(this);\"><span><spring:message code="label.common.delete"/></span></button>";
				sHtml += "						</td>\n";
				$(tr).html(sHtml);
				$("#nodeGrpModalDiv #rowCount").text(parseInt($("#nodeGrpModalDiv #rowCount").text())+1);
			} else {
				$("#nodeGrpModalDiv #errorSpan").text(result);
				$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
			}
		},
		error : function(e) {
			$("#nodeGrpModalDiv #errorSpan").text(e.reponseText);
			$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
		},
		complete : function() {
		}
	});
}

function modifyNodeGrp(obj) {
	var node_grp_id = $(obj).parent("td").prev("td").prev("td").text();
	var node_grp_name = $(obj).parent("td").prev("td").text();
	var sHtml = "";
	sHtml += "	<td><input type=\"text\" id=\"node_grp_id\" placeholder=\"<spring:message code="label.configuration.networkmanager.nodegroupid.text"/>\" style=\"width:100%;\" value=\""+node_grp_id+"\" readonly=true maxlength=\"9\"/></td>\n";
	sHtml += "	<td><input type=\"text\" id=\"node_grp_name\" placeholder=\"<spring:message code="label.configuration.networkmanager.nodegroupname.text"/>\" style=\"width:100%;\" value=\""+node_grp_name+"\" maxlength=\"18\"/></td>\n";
	sHtml += "	<td>\n";
	sHtml += "		<button type=\"button\" class=\"btn_row save\" onClick=\"javascript:updateNodeGrp(this);\"><span><spring:message code="label.common.save"/></span></button>";
	sHtml += "		<button type=\"button\" class=\"btn_row del\" onClick=\"javascript:deleteNodeGrp(this);\"><span><spring:message code="label.common.delete"/></span></button>";
	sHtml += "	</td>\n";
	$(obj).parent("td").parent("tr").html(sHtml);
}

function deleteNodeGrp(obj) {
	var node_grp_id = $(obj).parent("td").prev("td").prev("td").text();
	var node_grp_name = $(obj).parent("td").prev("td").text();
	if (isEmpty(node_grp_id)) {
		node_grp_id = $(obj).parent("td").parent("tr").children("td").eq(0).children("input").val();
		node_grp_name = $(obj).parent("td").parent("tr").children("td").eq(1).children("input").val();
	}
	
	for (var i=0;i<g_data.nodeList.length;i++) {
		var node = g_data.nodeList[i];
		if (node.node_grp_id == node_grp_id) {
			$("#nodeGrpModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.nodegroup.delete.inuse.front"/>+"\""+node_grp_name+"\""+<spring:message code="msg.configuration.networkmanager.nodegroup.delete.inuse.back"/>");
			$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
			return;
		}
	}
	
	var param = new Object();
	param.node_grp_id = node_grp_id;
	$.ajax({
		url : "deleteNodeGrp",
		data : param,
		type : 'POST',
		dataType : 'json',
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				$("#nodeGrpModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.nodegroup.delete.succ"/>");
				$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
				deleteNodeGrpRow(obj);
				$("#nodeGrpModalDiv #rowCount").text(parseInt($("#nodeGrpModalDiv #rowCount").text())-1);
			} else {
				$("#nodeGrpModalDiv #errorSpan").text(result);
				$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
			}
		},
		error : function(e) {
			$("#nodeGrpModalDiv #errorSpan").text(e.reponseText);
			$("#nodeGrpModalDiv #errorSpan").attr("class", "show");
		},
		complete : function() {
		}
	});
}

function deleteNodeGrpRow(obj) {
	$(obj).parent("td").parent("tr").remove();
}
</script>
<div id="nodeGrpModalDiv" style="display:none;">
	<div class="popup">
		<h2><spring:message code="label.configuration.networkmanager.nodegroupmanagement.text"/></h2>
		<a class="close" href="javascript:closeNodeGrpModal();">&times;</a>
		<div class="pop_cont">
			<header>
				<div class="util"><span style="margin-left: 20px;"><em id="rowCount"></em> <spring:message code="label.configuration.networkmanager.rows.text"/></span></div>
				<span class="btn_area">
					<button type="button" class="btn_row add" onClick="javascript:addNodeGrpRow();">
						<span><spring:message code="label.configuration.networkmanager.addrow.text"/></span>
					</button>
				</span>
			</header>
			<div class="list common">
				<table class="tbl_update">
					<colgroup>
						<col width="140px"/>
						<col width="*"/>                    
						<col width="90px"/>
						<col width="10px"/>
					</colgroup>
					<thead>
						<tr>
							<th><spring:message code="label.configuration.networkmanager.nodegroupid.text"/></th>
							<th><spring:message code="label.configuration.networkmanager.nodegroupname.text"/></th>
							<th class="ico"></th>
							<th class="src"></th>
						</tr>
					</thead>
				</table>
				<div class="scroll"> 
					<table class="tbl_update">
						<colgroup>
							<col width="140px"/>
							<col width="*"/>                    
							<col width="90px"/>
						</colgroup>
						<tbody id="nodeGrpTbody">
						</tbody>
					</table>
				</div>
			</div>
			<span id="errorSpan" class="hide" style="color:#ff0000;margin-left:20px;"></span>
			<!--// list -->
		</div>
		<div class="btn_area">
			<a href="javascript:closeNodeGrpModal();"><button type="button" ><spring:message code="label.common.ok"/></button></a>
		</div>
	</div>
</div>