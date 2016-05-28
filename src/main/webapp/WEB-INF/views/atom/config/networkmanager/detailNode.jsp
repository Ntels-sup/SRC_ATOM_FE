<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
.common button span{width:calc(100% - 40px);}
</style>
<script>
$(document).ready(function() {
	for (var i=0;i<g_data.pkgList.length;i++) {
		var pkg = g_data.pkgList[i];
		var sHtml = "<option value=\""+pkg.pkg_name+"\">"+pkg.pkg_name+"</option>\n";
		$("#nodeModalDiv #pkg_name").append(sHtml);
	}
	for (var i=0;i<g_data.nodeGrpList.length;i++) {
		var nodeGrp = g_data.nodeGrpList[i];
		var sHtml = "<option value=\""+nodeGrp.node_grp_id+"\">"+nodeGrp.node_grp_name+"</option>\n";
		$("#nodeModalDiv #node_grp_id").append(sHtml);
	}
	for (var i=0;i<g_data.nodeTypeList.length;i++) {
		var nodeType = g_data.nodeTypeList[i];
		if (nodeType.pkg_name == "${node.pkg_name}") {
			var sHtml = "<option value=\""+nodeType.node_type+"\">"+nodeType.node_type+"</option>\n";
			$("#nodeModalDiv #node_type").append(sHtml);
		}
	}
	
	$("#nodeModalDiv #selectImageTable td").click(function() {
		$("#selectImageTable td").removeClass("selected");
		$(this).addClass("selected");
	});
	$("#nodeModalDiv #image_x").numeric();
	$("#nodeModalDiv #image_y").numeric();

	$("#nodeModalDiv #pkg_name").val(nullCheck("${node.pkg_name}"));
	$("#nodeModalDiv #node_name").val(nullCheck("${node.node_name}"));
	$("#nodeModalDiv #node_grp_id").val("${node.node_grp_id}");
	$("#nodeModalDiv #node_type").val("${node.node_type}");
	$("#nodeModalDiv #ip").val(nullCheck("${node.ip}"));
	$("#nodeModalDiv #image_x").val(nullCheck("${node.image_x}"));
	$("#nodeModalDiv #image_y").val(nullCheck("${node.image_y}"));
	
	$("#nodeModalDiv input[name=image_bgcolor]").each(function() {
		var bgColor = rgbToHexColor(window.getComputedStyle($("#nodeModalDiv label[for="+$(this).attr("id")+"]")[0], ":before").backgroundColor);
		if (bgColor.toUpperCase() == nullCheck("${node.image_bgcolor}").toUpperCase()) {
			$(this).prop("checked", true);
		}
	});
	
	$("#nodeModalDiv input[name=image_name]").each(function() {
		var imagePath = getImagePath(window.getComputedStyle($("#nodeModalDiv label[for="+$(this).attr("id")+"]")[0], ":before").backgroundImage);
		if (imagePath == nullCheck("${node.image_name}")) {
			$(this).prop("checked", true);
		}
	});
	
	if (nullCheck("${node.use_yn}") == "Y") {
		$("#nodeModalDiv #use_yn").prop("checked", true);
	}
	if (nullCheck("${node.dropped}") == "true") {
		$("#nodeModalDiv #deleteButton").hide();
	} else {
		$("#nodeModalDiv .btn_area button").css("width", "calc(30% - 12px)");
		$("#nodeModalDiv #deleteButton").show();
		$("#nodeModalDiv #deleteButton").click(function() {
			var atomNode = getAtomFigure(LINE_OBJECT_TYPE_NODE, "${node.node_name_old}");
			confirmDeleteFigure(atomNode);
		});
	}
	
	if (isEmpty("${node.create_date}") || isEmpty("${node.update_date}")) {
		$("#nodeModalDiv #dateDiv").hide();
	}
	$("#nodeModalDiv #create_date").text("${node.create_date}");
	$("#nodeModalDiv #update_date").text("${node.update_date}");
	
	showDetailDiv("nodeModalDiv");
	hideContextMenu();
	$("#nodeModalDiv #right-menu-close, #nodeModalDiv #cancelButton").click(function() {
		hideDetailDiv();
	});
	$("#nodeModalDiv #okButton").click(function() {
		updateNode();
	});
	$("#nodeModalDiv #pkg_name").multipleSelect({
        single: true,
        selectAll: false,
        multiple: false,
        allSelected: null,
        onClick: function(obj) {
        	$("#nodeModalDiv #node_type").html("");
        	for (var i=0;i<g_data.nodeTypeList.length;i++) {
        		var nodeType = g_data.nodeTypeList[i];
        		if (nodeType.pkg_name == obj.value) {
        			var sHtml = "<option value=\""+nodeType.node_type+"\">"+nodeType.node_type+"</option>\n";
        			$("#nodeModalDiv #node_type").append(sHtml);
        		}
        		$("#nodeModalDiv #node_type").val("");
        		$("#nodeModalDiv #node_type").multipleSelect("refresh");
        	}
        }
    });
	
	$("#nodeModalDiv #node_grp_id, #nodeModalDiv #node_type").multipleSelect({
        single: true,
        selectAll: false,
        multiple: false,
        allSelected: null,
    });
});

function updateNode() {
	var userData = $.extend({}, $("#nodeModalDiv").data("node"));
	
	if (isEmpty($("#nodeModalDiv #pkg_name").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.package.empty"/>", "", function() {$("#nodeModalDiv #pkg_name").focus();});
		return;
	}
	if (isEmpty($("#nodeModalDiv #node_name").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.nodename.empty"/>", "", function() {$("#nodeModalDiv #node_name").focus();});
		return;
	}
	if (!isValidName($("#nodeModalDiv #node_name").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.nodename.invalid"/>", "<spring:message code="msg.configuration.networkmanager.nodename.invalid.description"/>", function() {$("#nodeModalDiv #node_name").focus();});
		return;
	}
	
	userData.node_name = $("#nodeModalDiv #node_name").val();

	for (var i=1;i<$("#nodeListDiv").children("div").length;i++) {
		var node = $("#nodeListDiv>div").eq(i).data("node");
		if (userData.node_name_old != node.node_name_old && userData.node_name.toUpperCase() == node.node_name.toUpperCase()) {
			openAlertModal("<spring:message code="msg.configuration.networkmanager.nodename.exist.front"/> \""+userData.node_name+"\" <spring:message code="msg.configuration.networkmanager.nodename.exist.back"/>", "", function() {$("#nodeModalDiv #node_name").focus();});
			return;
		}
	}
	
	for (var i=1;i<$("#linkedNodeListDiv").children("div").length;i++) {
		var node = $("#linkedNodeListDiv>div").eq(i).data("node");
		if (userData.node_name_old != node.node_name_old && userData.node_name.toUpperCase() == node.node_name.toUpperCase()) {
			openAlertModal("<spring:message code="msg.configuration.networkmanager.nodename.exist.front"/> \""+userData.node_name+"\" <spring:message code="msg.configuration.networkmanager.nodename.exist.back"/>", "", function() {$("#nodeModalDiv #node_name").focus();});
			return;
		}
	}
	
	if (isEmpty($("#nodeModalDiv #node_grp_id").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.nodegroup.empty"/>", "", function() {$("#nodeModalDiv #node_grp_id").focus();});
		return;
	}
	if (isEmpty($("#nodeModalDiv #ip").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.ip.empty"/>", "", function() {$("#nodeModalDiv #ip").focus();});
		return;
	}
	if (!isValidIpAddress($("#nodeModalDiv #ip").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.ip.invalid"/>", "", function() {$("#nodeModalDiv #ip").focus();});
		return;
	}
	if (isEmpty($("#nodeModalDiv #node_type").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.nodetype.empty"/>", "", function() {$("#nodeModalDiv #node_type").focus();});
		return;
	}
	if (isEmpty($("#nodeModalDiv #image_x").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.x.empty"/>", "", function() {$("#nodeModalDiv #image_x").focus();});
		return;
	}
	if (!isValidNaturalNumber($("#nodeModalDiv #image_x").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.x.invalid"/>", "", function() {$("#nodeModalDiv #image_x").focus();});
		return;
	}
	if (isEmpty($("#nodeModalDiv #image_y").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.y.empty"/>", "", function() {$("#nodeModalDiv #image_y").focus();});
		return;
	}
	if (!isValidNaturalNumber($("#nodeModalDiv #image_y").val())) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.y.invalid"/>", "", function() {$("#nodeModalDiv #image_y").focus();});
		return;
	}
	var internal_yn = "${node.internal_yn}";
	var width = AtomNode.prototype.WIDTH;
	var height = AtomNode.prototype.HEIGHT;
	if (internal_yn != "N") {
		width = AtomLinkedNode.prototype.WIDTH;
		height = AtomLinkedNode.prototype.HEIGHT;
	}
	if (!isValidPosition(parseInt($("#nodeModalDiv #image_x").val()), parseInt($("#nodeModalDiv #image_y").val()), width, height)) {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.image.position.invalid"/>", "", function() {$("#pkgModalDiv #image_x").focus();});
		return;
	}
	
	userData.pkg_name = $("#nodeModalDiv #pkg_name").val();
	userData.node_grp_id = $("#nodeModalDiv #node_grp_id").val();
	userData.ip = $("#nodeModalDiv #ip").val();
	userData.use_yn = "N";
	if ($("#nodeModalDiv #use_yn").prop("checked")) {
		userData.use_yn = "Y";
	}
	userData.image_x = $("#nodeModalDiv #image_x").val();
	userData.image_y = $("#nodeModalDiv #image_y").val();
	userData.image_name = getImagePath(window.getComputedStyle($("#nodeModalDiv label[for="+$("input[name=image_name]:checked").attr("id")+"]")[0], ":before").backgroundImage);
	userData.image_bgcolor = rgbToHexColor(window.getComputedStyle($("#nodeModalDiv label[for="+$("input[name=image_bgcolor]:checked").attr("id")+"]")[0], ":before").backgroundColor);
	userData.internal_yn = internal_yn;
	userData.ems_yn = "N";
	userData.rddc_yn = "N";
	userData.status_flag = "N";
	userData.node_type = $("#nodeModalDiv #node_type").val();
	
	g_canvas.commandStack.startTransaction();

	var bAdded = false;
	var atomNode;
	var newAttributes = new Object();
	var newLabelAttributes = new Object();
	var newIconAttributes = new Object();
	if (isEmpty(userData.node_name_old)) {
		userData.node_name_old = userData.node_name;
		atomNode = addNode(userData, "network");
		resetDraggableElementsAttr();
		bAdded = true;
	} else {
		atomNode = getAtomFigure(LINE_OBJECT_TYPE_NODE, userData.node_name_old);
		if (atomNode == null) {
			atomNode = addNodeFigure(userData);
			resetDraggableElementsAttr();
			bAdded = true;
		} else {
			if (atomNode instanceof AtomNode) {
				if (userData.use_yn == "Y") {
					newAttributes.color = "#ffffff";
				} else {
					newAttributes.color = new draw2d.util.Color(31, 30, 52);
				}
			}
			newAttributes.bgColor = userData.image_bgcolor;
			newAttributes.x = userData.image_x;
			newAttributes.y = userData.image_y;
			newAttributes.userData = userData;
			
			var commandAttr = new AtomCommandAttr(atomNode, newAttributes);
			g_canvas.commandStack.execute(commandAttr);
			
			newLabelAttributes.text = userData.node_name;
			var commandLabelAttr = new AtomCommandAttr(atomNode.atomLabel, newLabelAttributes);
			g_canvas.commandStack.execute(commandLabelAttr);
			
			newIconAttributes.path = userData.image_name;
			var commandIconlAttr = new AtomCommandAttr(atomNode.atomIcon, newIconAttributes);
			g_canvas.commandStack.execute(commandIconlAttr);
			
			/* atomNode.atomLabel.setText(userData.node_name);
			if (atomNode instanceof AtomNode) {
				atomNode.setBackgroundColor(userData.image_bgcolor);
				if (userData.use_yn == "Y") {
					atomNode.setColor("#ffffff");
				} else {
					atomNode.setColor(new draw2d.util.Color(31, 30, 52));
				}
			} else if (atomNode instanceof AtomLinkedNode) {
				atomNode.setBackgroundColor(userData.image_bgcolor);
			}
			atomNode.atomIcon.setPath(userData.image_name);
			atomNode.setX(userData.image_x);
			atomNode.setY(userData.image_y);
			atomNode.userData = userData; */
		}
		$("#node_"+userData.node_name_old+" span").text(userData.node_name);
		$("#node_"+userData.node_name_old+" img").attr("src", userData.image_name);
		$("#node_"+userData.node_name_old).css("background-color", userData.image_bgcolor);
		$("#node_"+userData.node_name_old).data("node", userData);
	}
	
	g_canvas.commandStack.commitTransaction();
	
	if (bAdded) {
		afterAddNodeFigure(atomNode);
	}
	
	g_minimap.commandStack.startTransaction();
	
	var mAtomNode = g_minimap.getFigure(atomNode.id);
	if (mAtomNode == null) {
		if (userData.internal_yn == "Y") {
			mAtomNode = new AtomNode({
				path: userData.image_name,
				userData: userData,
				x: userData.image_x,
				y: userData.image_y,
				bgColor: userData.image_bgcolor
			});
		} else {
			mAtomNode = new AtomLinkedNode({
				path: userData.image_name,
				userData: userData,
				x: userData.image_x,
				y: userData.image_y,
				bgColor: userData.image_bgcolor
			});
		}
		var mCommandAdd = new draw2d.command.CommandAdd(g_minimap, mAtomNode, parseInt(userData.image_x), parseInt(userData.image_y));
		g_minimap.commandStack.execute(mCommandAdd);
	} else {
		var mCommandAttr = new AtomCommandAttr(mAtomNode, newAttributes);
		g_minimap.commandStack.execute(mCommandAttr);
		
		var mCommandIconlAttr = new AtomCommandAttr(mAtomNode.atomIcon, newIconAttributes);
		g_minimap.commandStack.execute(mCommandIconlAttr);
		
		/* if (mAtomNode instanceof AtomNode) {
			mAtomNode.setBackgroundColor(userData.image_bgcolor);
			if (userData.use_yn == "Y") {
				mAtomNode.setColor("#ffffff");
			} else {
				mAtomNode.setColor(new draw2d.util.Color(31, 30, 52));
			}
		} else if (mAtomNode instanceof AtomLinkedNode) {
			mAtomNode.setBackgroundColor(userData.image_bgcolor);
		}
		mAtomNode.atomIcon.setPath(userData.image_name);
		mAtomNode.setX(userData.image_x);
		mAtomNode.setY(userData.image_y);
		mAtomNode.userData = userData; */
	}
	
	g_minimap.commandStack.commitTransaction();
	
	mAtomNode.toFront();
	$(mAtomNode.shape[0]).attr("filter", "url(#AtomNodeFilter)");
	mAtomNode.id = atomNode.id;
	
	updateUndoRedoButton();
	hideDetailDiv();
	g_bChanged = true;
}
</script>
<div id="nodeModalDiv" class="properties scroll-type2">
	<h4><em><spring:message code="label.configuration.networkmanager.node.text"/></em> <spring:message code="label.configuration.networkmanager.properties.text"/></h4><button type="button" id="right-menu-close" title="<spring:message code="label.common.close"/>"><spring:message code="label.common.close"/></button>
	<div class="form">
		<div class="form_group">
			<div class="common">
				<label class="imp"><spring:message code="label.configuration.networkmanager.package.text"/></label>
				<select id="pkg_name" class="single">
				</select>
			</div>
			<div class="common">
				<label class="imp"><spring:message code="label.configuration.networkmanager.nodename.text"/></label>
				<input id="node_name" type="text" name="txtbox" maxlength="40"/>
			</div>
			<div class="common">
				<label class="imp"><spring:message code="label.configuration.networkmanager.nodegroupname.text"/></label>
				<select id="node_grp_id" class="single">
				</select>
			</div>
		</div>
		<div class="form_group line">
			<div class="common">
				<label class="imp"><spring:message code="label.configuration.networkmanager.ipaddress.text"/></label>
				<input id="ip" type="text" name="txtbox"/>
			</div>
			<div class="common swch">
				<label class="imp"><spring:message code="label.configuration.networkmanager.use.text"/></label>
				<span><spring:message code="label.configuration.networkmanager.usenode.text"/></span>
				<span class="switch area">
					<input id="use_yn" class="toggle toggle-round" type="checkbox">
					<label for="use_yn"></label>
				</span>
			</div>
			<div class="common">
				<label class="imp"><spring:message code="label.configuration.networkmanager.nodetypename.text"/></label>
				<select id="node_type" class="single">
				</select>
			</div>
		</div>
		<div id="dateDiv" class="form_group line">
			<div class="common">
				<label><spring:message code="label.configuration.networkmanager.createdate.text"/></label>
				<span id="create_date"></span>
			</div>
			<div class="common">
				<label><spring:message code="label.configuration.networkmanager.updatedate.text"/></label>
				<span id="update_date"></span>
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
			<div class="common">
				<label class="imp"><spring:message code="label.configuration.networkmanager.color.text"/></label>
				<span class="color">
					<c:choose>
						<c:when test="${node.internal_yn == 'Y'}">
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
						</c:when>
						<c:otherwise>
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
						</c:otherwise>
					</c:choose>
				</span>
			</div>
			<div class="common">
				<label class="imp"><spring:message code="label.configuration.networkmanager.icontype.text"/></label>
				<span class="icon">
					<c:choose>
						<c:when test="${node.internal_yn == 'Y'}">
							<c:forEach begin="1" end="5" var="var" varStatus="status">
								<c:set var="checked" value=""/>
								<c:if test="${var == 1}">
									<c:set var="checked" value=" checked"/>
								</c:if>
								<input type="radio" id="icon${var}" name="image_name"${checked}/>
								<label for="icon${var}"><spring:message code="label.configuration.networkmanager.icon.text"/>${var}</label>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach begin="6" end="10" var="var" varStatus="status">
								<c:set var="checked" value=""/>
								<c:if test="${var == 6}">
									<c:set var="checked" value=" checked"/>
								</c:if>
								<input type="radio" id="icon${var}" name="image_name"${checked}/>
								<label for="icon${var}"><spring:message code="label.configuration.networkmanager.icon.text"/>${var}</label>
							</c:forEach>
						</c:otherwise>
					</c:choose>
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