<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$(document).ready(function() {
	var sourceId = "${line.source_id}";
	if (!isNaN(sourceId)) {
		targetId = parseInt(sourceId);
	}
	var source = getAtomFigure("${line.source_type}", sourceId);
	$("#lineModalDiv #source_name").text(source.atomLabel.text);
	var targetId = "${line.target_id}";
	if (!isNaN(targetId)) {
		targetId = parseInt(targetId);
	}
	var target = getAtomFigure("${line.target_type}", targetId);
	$("#lineModalDiv #target_name").text(target.atomLabel.text);
	
	if (source instanceof AtomLinkedNode || target instanceof AtomLinkedNode) {
		$("#connectionTypeDiv").hide();
	}
	
	if ("${line.full_duplex}" == "Y") {
		$("#lineModalDiv #full_duplex").prop("checked", true);
	} else {
		$("#lineModalDiv #simplex").prop("checked", true);
	}
	if (nullCheck("${line.dropped}") == "true") {
		$("#lineModalDiv #deleteLineButton").hide();
	}
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
});

function updateLine() {
	var line = $.extend({}, $("#lineModalDiv").data("line"));
	line.router = draw2d.shape.basic.PolyLine.DEFAULT_ROUTER.NAME;
	if ($("#lineModalDiv #full_duplex").prop("checked")) {
		line.full_duplex = "Y";
	} else {
		line.full_duplex = "N";
	}
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
	<h4><em><spring:message code="label.configuration.networkmanager.line.text"/></em> <spring:message code="label.configuration.networkmanager.properties.text"/></h4><button type="button" id="right-menu-close" title="<spring:message code="label.common.close"/>"><spring:message code="label.common.close"/></button>
	<div class="form">
		<div class="form_group">
			<div class="common">
				<label><spring:message code="label.configuration.networkmanager.inputnodename.text"/></label>
				<span id="source_name"></span>
			</div>
			<div class="common">
				<label><spring:message code="label.configuration.networkmanager.outputnodename.text"/></label>
				<span id="target_name"></span>
			</div>
		</div>
		<div class="form_group line">
			<div id="connectionTypeDiv" class="common">
				<label class="imp"><spring:message code="label.configuration.networkmanager.connectiontype.text"/></label>
				<p>
					<input type="radio" id="simplex" name="full_duplex" checked/>
					<label for="simplex"><spring:message code="label.configuration.networkmanager.simplex.text"/></label>
					<input type="radio" id="full_duplex" name="full_duplex" />
					<label for="full_duplex"><spring:message code="label.configuration.networkmanager.fullduplex.text"/></label>
				</p>
			</div>
			<div class="common">
				<label><spring:message code="label.configuration.networkmanager.linedesc.text"/></label>
				<input id="line_desc" type="text" name="txtbox" placeholder="<spring:message code="label.configuration.networkmanager.linedesc.text"/>"  maxlength="128"/>
			</div>
			<span class="btn_area">
				<button id="cancelButton" type="button" class="btn_type2"><spring:message code="label.common.cancel"/></button>
				<button id="deleteButton" type="button" class="btn_type2 minor"><spring:message code="label.common.delete"/></button>
				<button id="okButton" type="button" class="btn_type2 major"><spring:message code="label.common.ok"/></button>
			</span>
		</div>
	</div><!--// form -->
</div><!--// properties -->