<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$(document).ready(function() {
	$("#batchJobModalDiv #image_x").numeric();
	$("#batchJobModalDiv #image_y").numeric();

	$("#batchJobModalDiv #dropped").val(nullCheck("${batchJob.dropped}"));
	$("#batchJobModalDiv #pkg_name").text(nullCheck(g_data.schedulerGroup.pkg_name));
	$("#batchJobModalDiv #node_type").text(nullCheck("${batchJob.node_type}"));
	$("#batchJobModalDiv #proc_name").text(nullCheck("${batchJob.proc_name}"));
	$("#batchJobModalDiv #job_name").val(nullCheck("${batchJob.job_name}"));
	if ("${batchJob.run_yn}" == "Y") {
		$("#batchJobModalDiv #run_yn").prop("checked", true);
	}
	if ("${batchJob.fail_cont_yn}" == "Y") {
		$("#batchJobModalDiv #fail_cont_yn").prop("checked", true);
	}
	for (var i=0;i<g_data.nodeList.length;i++) {
		var node = g_data.nodeList[i];
		var sHtml = "<option value=\""+node.node_no+"\">"+node.node_name+"</option>";
		$("#batchJobModalDiv #node_no").append(sHtml);
	}
	$("#batchJobModalDiv #node_no").val(nullCheck("${batchJob.node_no}"));
	$("#batchJobModalDiv #node_no").multipleSelect({
		single: true,
		selectAll: false,
		multiple: false,
		allSelected: null
	});
	$("#batchJobModalDiv #description").val(nullCheck("${batchJob.description}"));
	$("#batchJobModalDiv #image_x").val(nullCheck("${batchJob.image_x}"));
	$("#batchJobModalDiv #image_y").val(nullCheck("${batchJob.image_y}"));
	
	$("#batchJobModalDiv input[name=image_bgcolor]").each(function() {
		var bgColor = rgbToHexColor(window.getComputedStyle($("#batchJobModalDiv label[for="+$(this).attr("id")+"]")[0], ":before").backgroundColor);
		if (bgColor.toUpperCase() == nullCheck("${batchJob.image_bgcolor}").toUpperCase()) {
			$(this).prop("checked", true);
		}
	});
	
	/* $("#batchJobModalDiv input[name=image_name]").each(function() {
		var imagePath = getImagePath(window.getComputedStyle($("#batchJobModalDiv label[for="+$(this).attr("id")+"]")[0], ":before").backgroundImage);
		if (imagePath == nullCheck("${batchJob.image_name}")) {
			$(this).prop("checked", true);
		}
	}); */
	
	if (nullCheck("${batchJob.dropped}") == "true") {
		$("#batchJobModalDiv #deleteButton").hide();
	} else {
		$("#batchJobModalDiv .btn_area button").css("width", "calc(30% - 12px)");
		$("#batchJobModalDiv #deleteButton").show();
		$("#batchJobModalDiv #deleteButton").click(function() {
			var atomProc = getAtomFigure(LINE_OBJECT_TYPE_BATCHJOB, "${batchJob.image_uuid}");
			confirmDeleteFigure(atomProc);
		});
	}
	
	showDetailDiv("batchJobModalDiv");
    hideContextMenu();
    
    $("#batchJobModalDiv #right-menu-close, #batchJobModalDiv #cancelButton").click(function() {
		hideDetailDiv();
	});
	$("#batchJobModalDiv #okButton").click(function() {
		updateBatchJob();
	});
});

function updateBatchJob() {
	var userData = $.extend({}, $("#batchJobModalDiv").data("batchJob"));
	userData.job_name = $("#batchJobModalDiv #job_name").val();
	
	if ($("#batchJobModalDiv #job_name").val() == "") {
		openAlertModal("<spring:message code="msg.general.batch.batchjobmanager.batchjob.empty"/>", "", function() {$("#batchJobModalDiv #job_name").focus();});
		return;
	}
	
	if (!isValidName($("#batchJobModalDiv #job_name").val())) {
		openAlertModal("<spring:message code="msg.general.batch.batchjobmanager.batchjob.invalid"/>", "<spring:message code="msg.general.batch.batchjobmanager.batchjob.invalid.description"/>", function() {$("#batchJobModalDiv #job_name").focus();});
		return;
	}
	
	for (var i=0;i<g_data.batchJobList.length;i++) {
		var batchJob = g_data.batchJobList[i];
		if (isEmpty(batchJob.image_x) && isEmpty(batchJob.image_y)) {
			if (batchJob.job_name == userData.job_name) {
				openAlertModal("<spring:message code="msg.general.batch.batchjobmanager.batchjob.exist.front"/>+"\""+userData.job_name+"\""+<spring:message code="msg.general.batch.batchjobmanager.batchjob.exist.back"/>", "", function() {$("#batchJobModalDiv #job_name").focus();});
				return;
			}
		}
	}

	var figures = g_canvas.figures.data;
	for (var i=0;i<figures.length;i++) {
		var figure = figures[i];
		if (figure instanceof AtomBatchJob) {
			var batchJob = figure.userData;
			if (userData.image_uuid != batchJob.image_uuid && userData.job_name == batchJob.job_name) {
				openAlertModal("<spring:message code="msg.general.batch.batchjobmanager.batchjob.exist.front"/>+"\""+userData.job_name+"\""+<spring:message code="msg.general.batch.batchjobmanager.batchjob.exist.back"/>", "", function() {$("#batchJobModalDiv #job_name").focus();});
				return;
			}
		}
	}
	
	if ($("#batchJobModalDiv #image_x").val() == "") {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.x.empty"/>", "", function() {$("#batchJobModalDiv #image_x").focus();});
		return;
	}
	if (!isValidNaturalNumber($("#batchJobModalDiv #image_x").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.x.invalid"/>", "", function() {$("#batchJobModalDiv #image_x").focus();});
		return;
	}
	if ($("#batchJobModalDiv #image_y").val() == "") {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.y.empty"/>", "", function() {$("#batchJobModalDiv #image_y").focus();});
		return;
	}
	if (!isValidNaturalNumber($("#batchJobModalDiv #image_y").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.y.invalid"/>", "", function() {$("#batchJobModalDiv #image_y").focus();});
		return;
	}
	if (!isValidPosition(parseInt($("#batchJobModalDiv #image_x").val()), parseInt($("#batchJobModalDiv #image_y").val()), AtomBatchJob.prototype.WIDTH, AtomBatchJob.prototype.HEIGHT)) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.image.position.invalid"/>", "", function() {$("#pkgModalDiv #image_x").focus();});
		return;
	}
	
	userData.run_yn = "N";
	if ($("#batchJobModalDiv #run_yn").prop("checked")) {
		userData.run_yn = "Y";
	}
	userData.fail_cont_yn = "N";
	if ($("#batchJobModalDiv #fail_cont_yn").prop("checked")) {
		userData.fail_cont_yn = "Y";
	}
	userData.node_no = $("#batchJobModalDiv #node_no").val();
	userData.description = $("#batchJobModalDiv #description").val();
	userData.image_x = $("#batchJobModalDiv #image_x").val();
	userData.image_y = $("#batchJobModalDiv #image_y").val();
	// userData.image_name = getImagePath(window.getComputedStyle($("#batchJobModalDiv label[for="+$("input[name=image_name]:checked").attr("id")+"]")[0], ":before").backgroundImage);
	userData.image_bgcolor = rgbToHexColor(window.getComputedStyle($("#batchJobModalDiv label[for="+$("input[name=image_bgcolor]:checked").attr("id")+"]")[0], ":before").backgroundColor);

	g_canvas.commandStack.startTransaction();
	
	var atomBatchJob;
	var newAttributes = new Object();
	var newLabelAttributes = new Object();
	if (userData.dropped) {
		atomBatchJob = new AtomBatchJob({
			// path : userData.image_name,
			label : userData.job_name,
			userData : userData,
			x: userData.image_x,
			y: userData.image_y,
			bgColor: userData.image_bgcolor
		});
		
		var commandAdd = new draw2d.command.CommandAdd(g_canvas, atomBatchJob, parseInt(userData.image_x), parseInt(userData.image_y));
		g_canvas.commandStack.execute(commandAdd);
		
		// g_canvas.addFigure(atomBatchJob);
	} else {
		atomBatchJob = getAtomFigure(LINE_OBJECT_TYPE_BATCHJOB, userData.image_uuid);
		/* atomBatchJob.atomLabel.setText(userData.job_name);
		// atomBatchJob.atomRectangle.setBackgroundColor(userData.image_bgcolor);
		atomBatchJob.setX(userData.image_x);
		atomBatchJob.setY(userData.image_y);
		atomBatchJob.userData = userData;
		atomBatchJob.setWidth(atomBatchJob.atomLabel.getBoundingBox().w+40); */
		newAttributes.bgColor = userData.image_bgcolor;
		newAttributes.x = userData.image_x;
		newAttributes.y = userData.image_y;
		newAttributes.userData = userData;
		
		var commandAttr = new AtomCommandAttr(atomBatchJob, newAttributes);
		g_canvas.commandStack.execute(commandAttr);
		
		newLabelAttributes.text = userData.job_name;
		var commandLabelAttr = new AtomCommandAttr(atomBatchJob.atomLabel, newLabelAttributes);
		g_canvas.commandStack.execute(commandLabelAttr);
	}
	
	g_canvas.commandStack.commitTransaction();
	
	atomBatchJob.setWidth(atomBatchJob.atomLabel.getBoundingBox().w+40);
	if (userData.dropped) {
		atomBatchJob.toFront();
		atomBatchJob.userData.image_uuid = atomBatchJob.id;
		$(atomBatchJob.shape[0]).attr("filter", "url(#AtomPkgFilter)");
	}
	
	
	g_minimap.commandStack.startTransaction();
	
	var mAtomBatchJob = g_minimap.getFigure(atomBatchJob.id);
	if (mAtomBatchJob == null) {
		mAtomBatchJob = new AtomBatchJob({
			// path : userData.image_name,
			// label : userData.job_name,
			userData : userData,
			x: userData.image_x,
			y: userData.image_y,
			bgColor: userData.image_bgcolor
		});
		// g_minimap.addFigure(mAtomBatchJob);
		var mCommandAdd = new draw2d.command.CommandAdd(g_minimap, mAtomBatchJob, parseInt(userData.image_x), parseInt(userData.image_y));
		g_minimap.commandStack.execute(mCommandAdd);
	} else {
		/* // mAtomBatchJob.atomLabel.setText(userData.job_name);
		// mAtomBatchJob.atomRectangle.setBackgroundColor(userData.image_bgcolor);
		mAtomBatchJob.setX(userData.image_x);
		mAtomBatchJob.setY(userData.image_y);
		mAtomBatchJob.userData = userData;
		mAtomBatchJob.setWidth(atomBatchJob.atomLabel.getBoundingBox().w+40); */
		var mCommandAttr = new AtomCommandAttr(mAtomBatchJob, newAttributes);
		g_minimap.commandStack.execute(mCommandAttr);
	}
	
	g_minimap.commandStack.commitTransaction();
	
	mAtomBatchJob.setWidth(atomBatchJob.atomLabel.getBoundingBox().w+40);
	if (userData.dropped) {
		mAtomBatchJob.toFront();
		mAtomBatchJob.userData.image_uuid = mAtomBatchJob.id;
		mAtomBatchJob.setWidth(atomBatchJob.atomLabel.getBoundingBox().w+40);
		$(mAtomBatchJob.shape[0]).attr("filter", "url(#AtomPkgFilter)");
		mAtomBatchJob.id = atomBatchJob.id;
	}
	
	hideDetailDiv();
	updateUndoRedoButton();
	g_bChanged = true;
}
</script>
<div id="batchJobModalDiv" class="properties scroll-type2">
	<h4><em><spring:message code="label.general.batch.batchjobmanager.batchjob.text"/></em> <spring:message code="label.configuration.networkmanager.properties.text"/></h4><button type="button" id="right-menu-close" title="<spring:message code="label.common.close"/>"><spring:message code="label.common.close"/></button>
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
				<label><spring:message code="label.general.batch.batchjobmanager.scriptname.text"/></label>
				<span id="proc_name"></span>
			</div>
		</div>
		<div class="form_group line">
			<div class="common">
				<label class="imp"><spring:message code="label.general.batch.batchjobmanager.batchjobname.text"/></label>
				<input id="job_name" type="text" name="txtbox"/>
			</div>
			<div class="common swch">
				<label class="imp"><spring:message code="label.general.batch.batchjobmanager.run.text"/></label>
				<span><spring:message code="label.general.batch.batchjobmanager.run.description"/></span>
				<span class="switch area">
					<input id="run_yn" class="toggle toggle-round" type="checkbox">
					<label for="run_yn"></label>
				</span>
			</div>
			<div class="common swch">
				<label class="imp"><spring:message code="label.general.batch.batchjobmanager.continue.text"/></label>
				<span><spring:message code="label.general.batch.batchjobmanager.continue.description"/></span>
				<span class="switch area">
					<input id="fail_cont_yn" class="toggle toggle-round" type="checkbox">
					<label for="fail_cont_yn"></label>
				</span>
			</div>
			<div class="common">
				<label><spring:message code="label.general.batch.batchjobmanager.runnodename.text"/></label>
				<select id="node_no" class="single"></select>
			</div>
			<div class="common">
				<label><spring:message code="label.general.batch.batchjobmanager.description.text"/></label>
				<input id="description" type="text" name="txtbox"/>
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
					<input type="radio" id="color16" name="image_bgcolor" checked/>
					<label for="color16"><spring:message code="label.configuration.networkmanager.color.text"/>1</label>
					<input type="radio" id="color17" name="image_bgcolor"/>
					<label for="color17"><spring:message code="label.configuration.networkmanager.color.text"/>2</label>
					<input type="radio" id="color18" name="image_bgcolor"/>
					<label for="color18"><spring:message code="label.configuration.networkmanager.color.text"/>3</label>
					<input type="radio" id="color19" name="image_bgcolor"/>
					<label for="color19"><spring:message code="label.configuration.networkmanager.color.text"/>4</label>
					<input type="radio" id="color20" name="image_bgcolor"/>
					<label for="color20"><spring:message code="label.configuration.networkmanager.color.text"/>5</label>
				</span>
			</div>
			<%-- <div class="common">
				<label class="imp"><spring:message code="label.configuration.networkmanager.icontype.text"/></label>
				<span class="icon">
					<input type="radio" id="icon01" name="image_name" checked/>
					<label for="icon01"><spring:message code="label.configuration.networkmanager.icon.text"/>1</label>
					<input type="radio" id="icon02" name="image_name"/>
					<label for="icon02"><spring:message code="label.configuration.networkmanager.icon.text"/>2</label>
					<input type="radio" id="icon03" name="image_name"/>
					<label for="icon03"><spring:message code="label.configuration.networkmanager.icon.text"/>3</label>
					<input type="radio" id="icon04" name="image_name"/>
					<label for="icon04"><spring:message code="label.configuration.networkmanager.icon.text"/>4</label>
					<input type="radio" id="icon05" name="image_name"/>
					<label for="icon05"><spring:message code="label.configuration.networkmanager.icon.text"/>5</label>
					<input type="radio" id="icon06" name="image_name"/>
					<label for="icon06"><spring:message code="label.configuration.networkmanager.icon.text"/>6</label>
					<input type="radio" id="icon07" name="image_name"/>
					<label for="icon07"><spring:message code="label.configuration.networkmanager.icon.text"/>7</label>
					<input type="radio" id="icon08" name="image_name"/>
					<label for="icon08"><spring:message code="label.configuration.networkmanager.icon.text"/>8</label>
					<input type="radio" id="icon09" name="image_name"/>
					<label for="icon09"><spring:message code="label.configuration.networkmanager.icon.text"/>9</label>
					<input type="radio" id="icon10" name="image_name"/>
					<label for="icon10"><spring:message code="label.configuration.networkmanager.icon.text"/>10</label>
					<input type="radio" id="icon11" name="image_name"/>
					<label for="icon11"><spring:message code="label.configuration.networkmanager.icon.text"/>1</label>
					<input type="radio" id="icon12" name="image_name"/>
					<label for="icon12"><spring:message code="label.configuration.networkmanager.icon.text"/>2</label>
					<input type="radio" id="icon13" name="image_name"/>
					<label for="icon13"><spring:message code="label.configuration.networkmanager.icon.text"/>3</label>
					<input type="radio" id="icon14" name="image_name"/>
					<label for="icon14"><spring:message code="label.configuration.networkmanager.icon.text"/>4</label>
					<input type="radio" id="icon15" name="image_name"/>
					<label for="icon15"><spring:message code="label.configuration.networkmanager.icon.text"/>5</label>
					<input type="radio" id="icon16" name="image_name"/>
					<label for="icon16"><spring:message code="label.configuration.networkmanager.icon.text"/>6</label>
					<input type="radio" id="icon17" name="image_name"/>
					<label for="icon17"><spring:message code="label.configuration.networkmanager.icon.text"/>7</label>
					<input type="radio" id="icon18" name="image_name"/>
					<label for="icon18"><spring:message code="label.configuration.networkmanager.icon.text"/>8</label>
					<input type="radio" id="icon19" name="image_name"/>
					<label for="icon19"><spring:message code="label.configuration.networkmanager.icon.text"/>9</label>
					<input type="radio" id="icon20" name="image_name"/>
					<label for="icon20"><spring:message code="label.configuration.networkmanager.icon.text"/>10</label>
				</span>
			</div> --%>
			<span class="btn_area">
				<button id="cancelButton" type="button" class="btn_type2"><spring:message code="label.common.cancel"/></button>
				<button id="deleteButton" type="button" class="btn_type2 minor"><spring:message code="label.common.delete"/></button>
				<button id="okButton" type="button" class="btn_type2 major"><spring:message code="label.common.ok"/></button>
			</span>
		</div>
	</div><!--// form -->
</div><!--// properties -->