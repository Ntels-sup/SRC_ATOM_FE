<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$(document).ready(function() {
	$("#pkgModalDiv #selectImageTable td").click(function() {
		$("#selectImageTable td").removeClass("selected");
		$(this).addClass("selected");
	});
	$("#pkgModalDiv #image_x").numeric();
	$("#pkgModalDiv #image_y").numeric();
	$("#pkgModalDiv #image_width").numeric();
	$("#pkgModalDiv #image_height").numeric();

	$("#pkgModalDiv #pkg_name").val(nullCheck("${pkg.pkg_name}"));
	$("#pkgModalDiv #pkg_name").text(nullCheck("${pkg.pkg_name}"));
	$("#pkgModalDiv #description").val(nullCheck("${pkg.description}"));
	$("#pkgModalDiv #vnf_text").text(nullCheck("${pkg.vnf_text}"));
	$("#pkgModalDiv #image_x").val(nullCheck("${pkg.image_x}"));
	$("#pkgModalDiv #image_y").val(nullCheck("${pkg.image_y}"));
	$("#pkgModalDiv #image_width").val(nullCheck("${pkg.image_width}", 300));
	$("#pkgModalDiv #image_height").val(nullCheck("${pkg.image_height}", 100));
	$("#pkgModalDiv input[name=image_bgcolor]").each(function() {
		var bgColor = rgbToHexColor(window.getComputedStyle($("#pkgModalDiv label[for="+$(this).attr("id")+"]")[0], ":before").backgroundColor);
		if (bgColor.toUpperCase() == nullCheck("${pkg.image_bgcolor}").toUpperCase()) {
			$(this).prop("checked", true);
		}
	});
	if (nullCheck("${pkg.dropped}") == "true") {
		$("#pkgModalDiv #deleteButton").hide();
	} else {
		$("#pkgModalDiv .btn_area button").css("width", "calc(30% - 12px)");
		$("#pkgModalDiv #deleteButton").show();
		$("#pkgModalDiv #deleteButton").click(function() {
			var atomPkg = getAtomFigure(LINE_OBJECT_TYPE_PACKAGE, "${pkg.pkg_name}");
			confirmDeleteFigure(atomPkg);
		});
	}
	showDetailDiv("pkgModalDiv");
	hideContextMenu();
	$("#pkgModalDiv #right-menu-close, #pkgModalDiv #cancelButton").click(function() {
		hideDetailDiv();
	});
	$("#pkgModalDiv #okButton").click(function() {
		updatePkg();
	});
});

function updatePkg() {
	if (isEmpty($("#pkgModalDiv #image_x").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.x.empty"/>", "", function() {$("#pkgModalDiv #image_x").focus();});
		return;
	}
	if (!isValidNaturalNumber($("#pkgModalDiv #image_x").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.x.invalid"/>", "", function() {$("#pkgModalDiv #image_x").focus();});
		return;
	}
	if (isEmpty($("#pkgModalDiv #image_y").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.y.empty"/>", "", function() {$("#pkgModalDiv #image_y").focus();});
		return;
	}
	if (!isValidNaturalNumber($("#pkgModalDiv #image_y").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.y.invalid"/>", "", function() {$("#pkgModalDiv #image_y").focus();});
		return;
	}
	if (isEmpty($("#pkgModalDiv #image_width").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.width.empty"/>", "", function() {$("#pkgModalDiv #image_width").focus();});
		return;
	}
	if (!isValidNaturalNumber($("#pkgModalDiv #image_width").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.width.invalid"/>", "", function() {$("#pkgModalDiv #image_width").focus();});
		return;
	}
	if (isEmpty($("#pkgModalDiv #image_height").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.height.empty"/>", "", function() {$("#pkgModalDiv #image_height").focus();});
		return;
	}
	if (!isValidNaturalNumber($("#pkgModalDiv #image_height").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.height.invalid"/>", "", function() {$("#pkgModalDiv #image_height").focus();});
		return;
	}
	if (!isValidPosition(parseInt($("#pkgModalDiv #image_x").val()), parseInt($("#pkgModalDiv #image_y").val()), parseInt($("#pkgModalDiv #image_width").val()), parseInt($("#pkgModalDiv #image_height").val()))) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.image.position.invalid"/>", "", function() {$("#pkgModalDiv #image_x").focus();});
		return;
	}
	
	var userData = $.extend({}, $("#pkgModalDiv").data("pkg"));
	userData.image_x = $("#pkgModalDiv #image_x").val();
	userData.image_y = $("#pkgModalDiv #image_y").val();
	userData.image_width = $("#pkgModalDiv #image_width").val();
	userData.image_height = $("#pkgModalDiv #image_height").val();
	userData.image_bgcolor = rgbToHexColor(window.getComputedStyle($("#pkgModalDiv label[for="+$("input[name=image_bgcolor]:checked").attr("id")+"]")[0], ":before").backgroundColor);
	// var path = $("#pkgModalDiv td.selected img").attr("src");
	var atomPkg = getAtomFigure(LINE_OBJECT_TYPE_PACKAGE, userData.pkg_name);
	var newAttributes = new Object();
	if (atomPkg != null) {
		newAttributes.x = userData.image_x;
		newAttributes.y = userData.image_y;
		newAttributes.width = userData.image_width;
		newAttributes.height = userData.image_height;
		newAttributes.bgColor = userData.image_bgcolor;
		newAttributes.color = (new draw2d.util.Color(userData.image_bgcolor)).darker(0.3).hash();
		newAttributes.userData = userData;
		
		var commandAttr = new AtomCommandAttr(atomPkg, newAttributes);
		g_canvas.commandStack.execute(commandAttr);
		
		/* atomPkg.setX(userData.image_x);
		atomPkg.setY(userData.image_y);
		atomPkg.setWidth(userData.image_width);
		atomPkg.setHeight(userData.image_height);
		atomPkg.setBackgroundColor(userData.image_bgcolor);
		atomPkg.setColor(atomPkg.getBackgroundColor().darker(0.3).hash());
		atomPkg.setUserData(userData); */
		// atomPkg.setIconPath(path);
	} else {
		atomPkg = addPkgFigure(userData);
		resetDraggableElementsAttr();
	}
	
	var mAtomPkg = g_minimap.getFigure(atomPkg.id);
	if (mAtomPkg != null) {
		var mCommandAttr = new AtomCommandAttr(mAtomPkg, newAttributes);
		g_minimap.commandStack.execute(mCommandAttr);
		/* mAtomPkg.setX(userData.image_x);
		mAtomPkg.setY(userData.image_y);
		mAtomPkg.setWidth(userData.image_width);
		mAtomPkg.setHeight(userData.image_height);
		mAtomPkg.setBackgroundColor(userData.image_bgcolor);
		mAtomPkg.setColor(mAtomPkg.getBackgroundColor().darker(0.3).hash());
		mAtomPkg.setUserData(userData);
		// mAtomPkg.setIconPath(path); */
	} else {
		mAtomPkg = new AtomPkg({
			width : userData.image_width,
			height : userData.image_height,
			userData : userData,
			x : userData.image_x,
			y : userData.image_y,
			bgColor : userData.image_bgcolor
			// , path : path
		});
		// g_minimap.add(mAtomPkg);
		
		var mCommandAdd = new draw2d.command.CommandAdd(g_minimap, mAtomPkg, parseInt(userData.image_x), parseInt(userData.image_y));
		g_minimap.commandStack.execute(mCommandAdd);
		
		mAtomPkg.toBack();
		$(mAtomPkg.shape[0]).attr("filter", "url(#AtomPkgFilter)");
		mAtomPkg.id = atomPkg.id;
	}
	
	updateUndoRedoButton();
	hideDetailDiv();
	g_bChanged = true;
}
</script>
<div id="pkgModalDiv" class="properties scroll-type2">
	<h4><em><spring:message code="label.configuration.networkmanager.package.text"/></em> <spring:message code="label.configuration.networkmanager.properties.text"/></h4><button type="button" id="right-menu-close" title="<spring:message code="label.common.close"/>"><spring:message code="label.common.close"/></button>
	<div class="form">
		<div class="form_group">
			<div class="common">
				<label><spring:message code="label.configuration.networkmanager.packagename.text"/></label>
				<span id="pkg_name"> </span>
			</div>
			<div class="common">
				<label><spring:message code="label.configuration.networkmanager.vnfflag.text"/></label>
				<span id="vnf_text"></span>
			</div>
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
			<div class="common col1">
				<label class="imp"><spring:message code="label.configuration.networkmanager.width.text"/></label>
				<input id="image_width" type="text" name="txtbox" maxlength="4"/>
			</div>
			<div class="common col2">
				<label class="imp"><spring:message code="label.configuration.networkmanager.height.text"/></label>
				<input id="image_height" type="text" name="txtbox" maxlength="4"//>
			</div>
			<div class="common">
				<label class="imp"><spring:message code="label.configuration.networkmanager.color.text"/></label>
				<span class="color">
					<input type="radio" id="color6" name="image_bgcolor" checked/>
					<label for="color6"><spring:message code="label.configuration.networkmanager.color.text"/>1</label>
					<input type="radio" id="color7" name="image_bgcolor"/>
					<label for="color7"><spring:message code="label.configuration.networkmanager.color.text"/>2</label>
					<input type="radio" id="color8" name="image_bgcolor"/>
					<label for="color8"><spring:message code="label.configuration.networkmanager.color.text"/>3</label>
					<input type="radio" id="color9" name="image_bgcolor"/>
					<label for="color9"><spring:message code="label.configuration.networkmanager.color.text"/>4</label>
					<input type="radio" id="color10" name="image_bgcolor"/>
					<label for="color10"><spring:message code="label.configuration.networkmanager.color.text"/>5</label>
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