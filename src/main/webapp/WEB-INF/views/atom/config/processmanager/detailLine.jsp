<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$(document).ready(function() {
	$("#lineModalDiv #pkg_name").text(nullCheck(g_data.svc.pkg_name));
	$("#lineModalDiv #node_type").text(nullCheck(g_data.svc.node_type));
	$("#lineModalDiv #svc_name").text(nullCheck(g_data.svc.svc_name));
	
	var source = getAtomFigure("${line.source_type}", "${line.source_id}");
	$("#lineModalDiv #source_name").text(source.atomLabel.text);
	var target = getAtomFigure("${line.target_type}", "${line.target_id}");
	$("#lineModalDiv #target_name").text(target.atomLabel.text);
	if ("${line.full_duplex}" == "Y") {
		$("#lineModalDiv #full_duplex").prop("checked", true);
	} else {
		$("#lineModalDiv #simplex").prop("checked", true);
	}
	if (nullCheck("${line.dropped}") == "true") {
		$("#lineModalDiv #deleteLineButton").hide();
	}
	if ("${line.multi_type}" == "N") {
		$("#lineModalDiv #single").prop("checked", true);
	} else if ("${line.multi_type}" == "R") {
		$("#lineModalDiv #multi1").prop("checked", true);
	} else if ("${line.multi_type}" == "W") {
		$("#lineModalDiv #multi2").prop("checked", true);
	}
	$("#lineModalDiv #elem_cnt").val("${line.elem_cnt}");
	$("#lineModalDiv #line_desc").val("${line.line_desc}");
	
	if (nullCheck("${line.dropped}") == "true") {
		$("#lineModalDiv #deleteButton").hide();
	} else {
		$("#lineModalDiv .btn_area button").css("width", "calc(30% - 12px)");
		$("#lineModalDiv #deleteButton").show();
		$("#lineModalDiv #deleteButton").click(function() {
			var atomLine = g_canvas.getLine("${line.image_uuid}");
			hideDetailDiv();
			confirmDeleteFigure(atomLine);
		});
	}
	
	showDetailDiv("lineModalDiv");
    hideContextMenu();
	$("#lineModalDiv #right-menu-close, #lineModalDiv #cancelButton").click(function() {
		hideDetailDiv();
	});
	$("#lineModalDiv #okButton").click(function() {
		updateLine();
	});
	$("#lineModalDiv #elem_cnt").numeric();
});

function updateLine() {
	if (isEmpty($("#elem_cnt").val())) {
		openAlertModal("<spring:message code="msg.configuration.processmanager.line.queuesize.empty"/>", "", function() {$("#elem_cnt").focus()});
		return;
	}
	if (!isValidNaturalNumber($("#elem_cnt").val()) || parseInt($("#elem_cnt").val()) == 0) {
		openAlertModal("<spring:message code="msg.configuration.processmanager.line.queuesize.invalid"/>", "", function() {$("#elem_cnt").focus()});
		return;
	}
	var line = $.extend({}, $("#lineModalDiv").data("line"));
	line.router = draw2d.shape.basic.PolyLine.DEFAULT_ROUTER.NAME;
	if ($("#lineModalDiv #full_duplex").prop("checked")) {
		line.full_duplex = "Y";
		line.bi_dir_yn = "Y";
	} else {
		line.full_duplex = "N";
		line.bi_dir_yn = "N";
	}
	line.multi_type = $("#lineModalDiv [name=multi_type]:checked").val();
	line.elem_cnt = $("#lineModalDiv #elem_cnt").val();
	line.line_desc = $("#lineModalDiv #line_desc").val();
	
	var atomLine = g_canvas.getLine(line.image_uuid);
	var newAttributes = new Object();
	newAttributes.userData = line;
	if (atomLine != null) {
		var commandAttr = new AtomCommandAttr(atomLine, newAttributes);
		g_canvas.commandStack.execute(commandAttr);
		// atomLine.setUserData(line);
		
		var mAtomLine = g_minimap.getLine(atomLine.id);
		var mCommandAttr = new AtomCommandAttr(mAtomLine, newAttributes);
		g_minimap.commandStack.execute(mCommandAttr);
	} else {
		g_updateLine = true;
		createLine(line);
		g_updateLine = false;
	}
	hideDetailDiv();
	// refreshMinimap();
	updateUndoRedoButton();
}
</script>
<div id="lineModalDiv" class="properties scroll-type2">
	<h4><em><spring:message code="label.configuration.networkmanager.line.text"/></em> <spring:message code="label.configuration.networkmanager.properties.text"/></h4><button type="button" id="right-menu-close" title="Close">Close</button>
	<div class="form">
		<div class="form_group">
			<div class="common">
				<label><spring:message code="label.configuration.networkmanager.packagename.text"/></label>
				<span id="pkg_name"></span>
			</div>
			<div class="common">
				<label><spring:message code="label.configuration.networkmanager.nodetypename.text"/></label>
				<span id="node_type"></span>
			</div>
			<div class="common">
				<label><spring:message code="label.configuration.processmanager.servicename.text"/></label>
				<span id="svc_name"></span>
			</div>
		</div>
		<div class="form_group line">
			<div class="common">
				<label><spring:message code="label.configuration.processmanager.inputprocessname.text"/></label>
				<span id="source_name"></span>
			</div>
			<div class="common">
				<label><spring:message code="label.configuration.processmanager.outputprocessname.text"/></label>
				<span id="target_name"></span>
			</div>
		</div>
		<div class="form_group line">
			<div class="common">
				<label class="imp"><spring:message code="label.configuration.processmanager.queuetype.text"/></label>
				<p>
					<input type="radio" id="single" name="multi_type" value="N" checked/>
					<label for="single"><spring:message code="label.configuration.processmanager.single.text"/></label>
					<input type="radio" id="multi1" name="multi_type" value="R" />
					<label for="multi1"><spring:message code="label.configuration.processmanager.multi1.text"/></label>
					<input type="radio" id="multi2" name="multi_type" value="W" />
					<label for="multi2"><spring:message code="label.configuration.processmanager.multi2.text"/></label>
				</p>
			</div>
			<div class="common">
				<label class="imp"><spring:message code="label.configuration.networkmanager.connectiontype.text"/></label>
				<p>
					<input type="radio" id="simplex" name="full_duplex" checked/>
					<label for="simplex"><spring:message code="label.configuration.networkmanager.simplex.text"/></label>
					<input type="radio" id="full_duplex" name="full_duplex" />
					<label for="full_duplex"><spring:message code="label.configuration.networkmanager.fullduplex.text"/></label>
				</p>
			</div>
			<div class="common">
				<label class="imp"><spring:message code="label.configuration.processmanager.queuesize.text"/></label>
				<input id="elem_cnt" type="text" name="txtbox" placeholder="<spring:message code="label.configuration.processmanager.queuesize.text"/>" maxlength="9"/>
			</div>
			<div class="common">
				<label><spring:message code="label.configuration.networkmanager.linedesc.text"/></label>
				<input id="line_desc" type="text" name="txtbox" placeholder="<spring:message code="label.configuration.networkmanager.linedesc.text"/>" maxlength="128"/>
			</div>
			<span class="btn_area">
				<button id="cancelButton" type="button" class="btn_type2"><spring:message code="label.common.cancel"/></button>
				<button id="deleteButton" type="button" class="btn_type2 minor"><spring:message code="label.common.delete"/></button>
				<button id="okButton" type="button" class="btn_type2 major"><spring:message code="label.common.ok"/></button>
			</span>
		</div>
	</div><!--// form -->
</div><!--// properties -->