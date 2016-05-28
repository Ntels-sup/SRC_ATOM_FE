<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$(document).ready(function() {
	$("#procModalDiv #start_order").numeric();
	$("#procModalDiv #stop_order").numeric();
	$("#procModalDiv #image_x").numeric();
	$("#procModalDiv #image_y").numeric();

	$("#procModalDiv #dropped").val(nullCheck("${proc.dropped}"));
	$("#procModalDiv #pkg_name").text(nullCheck(g_data.svc.pkg_name));
	$("#procModalDiv #node_type").text(nullCheck(g_data.svc.node_type));
	$("#procModalDiv #svc_name").text(nullCheck(g_data.svc.svc_name));
	$("#procModalDiv #proc_name").val(nullCheck("${proc.proc_name}"));
	if ("${proc.exec_yn}" == "Y") {
		$("#procModalDiv #exec_yn").prop("checked", true);
	}
	if ("${proc.use_yn}" == "Y") {
		$("#procModalDiv #use_yn").prop("checked", true);
	}
	$("#procModalDiv #start_order").val(nullCheck("${proc.start_order}"));
	$("#procModalDiv #stop_order").val(nullCheck("${proc.stop_order}"));
	$("#procModalDiv #image_x").val(nullCheck("${proc.image_x}"));
	$("#procModalDiv #image_y").val(nullCheck("${proc.image_y}"));
	
	$("#procModalDiv input[name=image_bgcolor]").each(function() {
		var bgColor = rgbToHexColor(window.getComputedStyle($("#procModalDiv label[for="+$(this).attr("id")+"]")[0], ":before").backgroundColor);
		if (bgColor.toUpperCase() == nullCheck("${proc.image_bgcolor}").toUpperCase()) {
			$(this).prop("checked", true);
		}
	});
	
	$("#procModalDiv input[name=image_name]").each(function() {
		var imagePath = getImagePath(window.getComputedStyle($("#procModalDiv label[for="+$(this).attr("id")+"]")[0], ":before").backgroundImage);
		if (imagePath == nullCheck("${proc.image_name}")) {
			$(this).prop("checked", true);
		}
	});
	
	if (nullCheck("${proc.dropped}") == "true") {
		$("#procModalDiv #deleteButton").hide();
	} else {
		$("#procModalDiv .btn_area button").css("width", "calc(30% - 12px)");
		$("#procModalDiv #deleteButton").show();
		$("#procModalDiv #deleteButton").click(function() {
			var atomProc = getAtomFigure(LINE_OBJECT_TYPE_PROCESS, "${proc.image_uuid}");
			confirmDeleteFigure(atomProc);
		});
	}
	
	showDetailDiv("procModalDiv");
    hideContextMenu();
    
    $("#procModalDiv #right-menu-close, #procModalDiv #cancelButton").click(function() {
		hideDetailDiv();
	});
	$("#procModalDiv #okButton").click(function() {
		updateProc();
	});
});

function updateProc() {
	var userData = $.extend({}, $("#procModalDiv").data("proc"));
	userData.proc_name = $("#procModalDiv #proc_name").val();
	
	if ($("#procModalDiv #proc_name").val() == "") {
		openAlertModal("<spring:message code="msg.configuration.processmanager.procname.empty"/>", "", function() {$("#procModalDiv #proc_name").focus();});
		return;
	}
	
	if (!isValidName($("#procModalDiv #proc_name").val())) {
		openAlertModal("<spring:message code="msg.configuration.processmanager.procname.invalid"/>", "<spring:message code="msg.configuration.processmanager.procname.invalid.description"/>", function() {$("#procModalDiv #proc_name").focus();});
		return;
	}
	
	for (var i=0;i<g_data.procList.length;i++) {
		var proc = g_data.procList[i];
		// if (isEmpty(proc.image_x) && isEmpty(proc.image_y)) {
			if (proc.proc_name.toUpperCase() == userData.proc_name.toUpperCase()) {
				openAlertModal("<spring:message code="msg.configuration.processmanager.procname.exist.front"/>+"\""+userData.proc_name+"\""+<spring:message code="msg.configuration.processmanager.procname.exist.back"/>", "", function() {$("#procModalDiv #proc_name").focus();});
				return;
			}
		// }
	}
	
	var figures = g_canvas.figures.data;
	for (var i=0;i<figures.length;i++) {
		var figure = figures[i];
		if (figure instanceof AtomProc) {
			var proc = figure.userData;
			if (proc.image_uuid != userData.image_uuid && proc.proc_name.toUpperCase() == userData.proc_name.toUpperCase()) {
				openAlertModal("<spring:message code="msg.configuration.processmanager.procname.exist.front"/>+"\""+userData.proc_name+"\""+<spring:message code="msg.configuration.processmanager.procname.exist.back"/>", "", function() {$("#procModalDiv #proc_name").focus();});
				return;
			}
		}
	}
	
	if ($("#procModalDiv #start_order").val() == "") {
		openAlertModal("<spring:message code="msg.configuration.processmanager.startorder.empty"/>", "", function() {$("#procModalDiv #start_order").focus();});
		return;
	}
	if (!isValidNaturalNumber($("#procModalDiv #start_order").val())) {
		openAlertModal("<spring:message code="msg.configuration.processmanager.startorder.invalid"/>", "", function() {$("#procModalDiv #start_order").focus();});
		return;
	}
	if ($("#procModalDiv #stop_order").val() == "") {
		openAlertModal("<spring:message code="msg.configuration.processmanager.stoporder.empty"/>", "", function() {$("#procModalDiv #stop_order").focus();});
		return;
	}
	if (!isValidNaturalNumber($("#procModalDiv #stop_order").val())) {
		openAlertModal("<spring:message code="msg.configuration.processmanager.stoporder.invalid"/>", "", function() {$("#procModalDiv #stop_order").focus();});
		return;
	}
	if ($("#procModalDiv #image_x").val() == "") {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.x.empty"/>", "", function() {$("#procModalDiv #image_x").focus();});
		return;
	}
	if (!isValidNaturalNumber($("#procModalDiv #image_x").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.x.invalid"/>", "", function() {$("#procModalDiv #image_x").focus();});
		return;
	}
	if ($("#procModalDiv #image_y").val() == "") {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.y.empty"/>", "", function() {$("#procModalDiv #image_y").focus();});
		return;
	}
	if (!isValidNaturalNumber($("#procModalDiv #image_y").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.y.invalid"/>", "", function() {$("#procModalDiv #image_y").focus();});
		return;
	}
	if (!isValidPosition(parseInt($("#procModalDiv #image_x").val()), parseInt($("#procModalDiv #image_y").val()), AtomProc.prototype.WIDTH, AtomProc.prototype.HEIGHT)) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.image.position.invalid"/>", "", function() {$("#procModalDiv #image_x").focus();});
		return;
	}
	
	userData.exec_yn = "N";
	if ($("#procModalDiv #exec_yn").prop("checked")) {
		userData.exec_yn = "Y";
	}
	userData.use_yn = "N";
	if ($("#procModalDiv #use_yn").prop("checked")) {
		userData.use_yn = "Y";
	}
	userData.start_order = $("#procModalDiv #start_order").val();
	userData.stop_order = $("#procModalDiv #stop_order").val();
	userData.image_x = $("#procModalDiv #image_x").val();
	userData.image_y = $("#procModalDiv #image_y").val();
	userData.image_name = getImagePath(window.getComputedStyle($("#procModalDiv label[for="+$("input[name=image_name]:checked").attr("id")+"]")[0], ":before").backgroundImage);
	userData.image_bgcolor = rgbToHexColor(window.getComputedStyle($("#procModalDiv label[for="+$("input[name=image_bgcolor]:checked").attr("id")+"]")[0], ":before").backgroundColor);

	g_canvas.commandStack.startTransaction();
	
	var proc_no = userData.proc_no;
	var atomProc;
	var newAttributes = new Object();
	var newLabelAttributes = new Object();
	var newIconAttributes = new Object();
	if (userData.dropped) {
		userData.job_name_old = userData.job_name;
		atomProc = addProcFigure(userData);
		// resetDraggableElementsAttr();
	} else {
		atomProc = getAtomFigure(LINE_OBJECT_TYPE_PROCESS, userData.image_uuid);
		/* atomProc.atomLabel.setText(userData.proc_name);
		atomProc.setBackgroundColor(userData.image_bgcolor);
		atomProc.atomIcon.setPath(userData.image_name);
		atomProc.setX(userData.image_x);
		atomProc.setY(userData.image_y);
		atomProc.userData = userData; */
		newAttributes.bgColor = userData.image_bgcolor;
		newAttributes.x = userData.image_x;
		newAttributes.y = userData.image_y;
		newAttributes.userData = userData;
		
		var commandAttr = new AtomCommandAttr(atomProc, newAttributes);
		g_canvas.commandStack.execute(commandAttr);
		
		newLabelAttributes.text = userData.proc_name;
		var commandLabelAttr = new AtomCommandAttr(atomProc.atomLabel, newLabelAttributes);
		g_canvas.commandStack.execute(commandLabelAttr);
		
		newIconAttributes.path = userData.image_name;
		var commandIconAttr = new AtomCommandAttr(atomProc.atomIcon, newIconAttributes);
		g_canvas.commandStack.execute(commandIconAttr);
	}
	
	g_canvas.commandStack.commitTransaction();
	
	if (userData.dropped) {
		afterAddProcFigure(atomProc);
	}

	
	g_minimap.commandStack.startTransaction();
	
	var mAtomProc = g_minimap.getFigure(atomProc.id);
	if (mAtomProc == null) {
		mAtomProc = new AtomProc({
			path: userData.image_name,
			userData: userData,
			x: userData.image_x,
			y: userData.image_y,
			bgColor: userData.image_bgcolor
		});
		// g_minimap.addFigure(mAtomProc);
		
		var mCommandAdd = new draw2d.command.CommandAdd(g_minimap, mAtomProc, parseInt(userData.image_x), parseInt(userData.image_y));
		g_minimap.commandStack.execute(mCommandAdd);
	} else {
		/* mAtomProc.setBackgroundColor(userData.image_bgcolor);
		mAtomProc.atomIcon.setPath(userData.image_name);
		mAtomProc.setX(userData.image_x);
		mAtomProc.setY(userData.image_y);
		mAtomProc.userData = userData; */
		
		var mCommandAttr = new AtomCommandAttr(mAtomProc, newAttributes);
		g_minimap.commandStack.execute(mCommandAttr);
		
		var mCommandIconAttr = new AtomCommandAttr(mAtomProc.atomIcon, newIconAttributes);
		g_minimap.commandStack.execute(mCommandIconAttr);
	}
	
	g_minimap.commandStack.commitTransaction();
	
	if (userData.dropped) {
		mAtomProc.toFront();
		$(mAtomProc.shape[0]).attr("filter", "url(#AtomNodeFilter)");
		mAtomProc.id = atomProc.id;
	}
	
	updateUndoRedoButton();
	hideDetailDiv();
	g_bChanged = true;
}
</script>
<div id="procModalDiv" class="properties scroll-type2">
	<h4><em><spring:message code="label.configuration.processmanager.process.text"/></em> <spring:message code="label.configuration.networkmanager.properties.text"/></h4><button type="button" id="right-menu-close" title="<spring:message code="label.common.close"/>"><spring:message code="label.common.close"/></button>
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
				<label class="imp"><spring:message code="label.configuration.processmanager.processname.text"/></label>
				<input id="proc_name" type="text" name="txtbox"/>
			</div>
			<div class="common swch">
				<label class="imp"><spring:message code="label.configuration.processmanager.execute.text"/></label>
				<span><spring:message code="label.configuration.processmanager.execute.description"/></span>
				<span class="switch area">
					<input id="exec_yn" class="toggle toggle-round" type="checkbox">
					<label for="exec_yn"></label>
				</span>
			</div>
			<div class="common swch">
				<label class="imp"><spring:message code="label.configuration.processmanager.use.text"/></label>
				<span><spring:message code="label.configuration.processmanager.use.description"/></span>
				<span class="switch area">
					<input id="use_yn" class="toggle toggle-round" type="checkbox">
					<label for="use_yn"></label>
				</span>
			</div>
			<div class="common col1">
				<label class="imp"><spring:message code="label.configuration.processmanager.startorder.text"/></label>
				<input id="start_order" type="text" name="txtbox"/>
			</div>
			<div class="common col2">
				<label class="imp"><spring:message code="label.configuration.processmanager.stoporder.text"/></label>
				<input id="stop_order" type="text" name="txtbox"/>
			</div>
			<div class="common"></div>
		</div>
		<div class="form_group line">
			<div class="common col1">
				<label class="imp"><spring:message code="label.configuration.networkmanager.x.text"/></label>
				<input id="image_x" type="text" name="txtbox"/>
			</div>
			<div class="common col2">
				<label class="imp"><spring:message code="label.configuration.networkmanager.y.text"/></label>
				<input id="image_y" type="text" name="txtbox"/>
			</div>
			<div class="common">
				<label class="imp"><spring:message code="label.configuration.networkmanager.color.text"/></label>
				<span class="color">
					<input type="radio" id="color11" name="image_bgcolor" checked/>
					<label for="color11"><spring:message code="label.configuration.networkmanager.color.text"/>1</label>
					<input type="radio" id="color12" name="image_bgcolor"/>
					<label for="color12"><spring:message code="label.configuration.networkmanager.color.text"/>2</label>
					<input type="radio" id="color13" name="image_bgcolor"/>
					<label for="color13"><spring:message code="label.configuration.networkmanager.color.text"/>3</label>
					<input type="radio" id="color14" name="image_bgcolor"/>
					<label for="color14"><spring:message code="label.configuration.networkmanager.color.text"/>4</label>
					<input type="radio" id="color15" name="image_bgcolor"/>
					<label for="color15"><spring:message code="label.configuration.networkmanager.color.text"/>5</label>
				</span>
			</div>
			<div class="common">
				<label class="imp"><spring:message code="label.configuration.networkmanager.icontype.text"/></label>
				<span class="icon">
					<c:forEach begin="11" end="27" var="var">
						<c:set var="checked" value=""/>
						<c:if test="${var == 11}">
							<c:set var="checked" value=" checked"/>
						</c:if>
						<input type="radio" id="icon${var}" name="image_name"${checked}/>
						<label for="icon${var}"><spring:message code="label.configuration.networkmanager.icon.text"/>${var}</label>
					</c:forEach>
				</span>
			</div>
			<span class="btn_area">
				<button id="cancelButton" type="button" class="btn_type2"><spring:message code="label.common.cancel"/></button>
				<button id="deleteButton" type="button" class="btn_type2 minor"><spring:message code="label.common.delete"/></button>
				<button id="okButton" type="button" class="btn_type2 major"><spring:message code="label.common.ok"/></button>
			</span>
		</div>
	</div><!--// form -->
</div><!--// properties -->