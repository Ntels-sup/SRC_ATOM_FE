<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link rel="stylesheet" href="/styles/style.css">
<script src="/scripts/jquery.1.11.2.min.js"></script>
<script src="/scripts/stringUtil.js"></script>
<script src="/scripts/modal.js"></script>
<script src="/scripts/jquery.alphanumeric.js"></script>
<script src="/scripts/jquery-ui.min.js"></script>
<jsp:include page="../config/networkmanager/flowdesign.jsp"/>
<script>
$(document).ready(function () {
	$(this).contextmenu(function() {
		return false;
	});
	initFlowDesign("#flowdesignDiv");
	searchFlowDesign(true);
	g_data = {"readonly": true};
});

function loadPkg(pkgList) {
	$("#pkgListDiv").html("");
	for (var i=0;i<pkgList.length;i++) {
		var pkg = pkgList[i];
		addPkgFigure(pkg);
	}
}

function loadNode(nodeList) {
	for (var i=0; i<nodeList.length;i++) {
		var node = nodeList[i];
		addNodeFigure(node);
	}
}

// websocket 20002 action
// change node color
// change node count
function reloadNodeStatus(messages) {
	var param = new Object();
	$.ajax({
		url: "reloadNodeStatus",
		data: param,
		type: 'POST',
		dataType: 'json',
		success: function(data) {
			var nodeList = data.nodeList;
			var allNodeList = data.allNodeList;
			g_data.nodeList = nodeList;
			g_data.allNodeList = allNodeList;
			for (var i=0;i<nodeList.length;i++) {
				var node = nodeList[i];
				var image_uuid = node.image_uuid;
				if (!isEmpty(image_uuid)) {
					var atomNode = g_canvas.getFigure(image_uuid);
					if (atomNode !== null) {
						atomNode.setBackgroundColor(node.image_bgcolor);
						if (atomNode.atomCount != null) {
							atomNode.atomCount.atomLabel.setText(node.node_count);
						}
					}
					atomNode = g_minimap.getFigure(image_uuid);
					if (atomNode !== null) {
						atomNode.setBackgroundColor(node.image_bgcolor);
					}
				}
			}
		},
		error: function(e) {
			var error = JSON.parse(e.responseText);
			openAlertModal(error.errorMsg.cause.localizedMessage);
		},
		complete: function() {
		}
	});
}

//websocket 20004, 20018 action
//change line color
//change line count
function reloadConnectionStatus(messages) {
	var param = new Object();
	$.ajax({
		url: "reloadConnectionStatus",
		data: param,
		type: 'POST',
		dataType: 'json',
		success: function(data) {
			g_data.connectionList = data.connectionList;
			var lines = g_canvas.lines.data;
			for (var i=0;i<lines.length;i++) {
				var line = lines[i];
				line.level = null;
				var userData = line.userData;
				line.setUserData(userData);
			}
		}
	});
}
</script>
<div class="draw type2">
	<div class="tools" style="width:100%;background:none;position:absolute;z-index:1;"><!-- 아이콘 선택 및 드래그시 on 클래스 추가 -->
		<p>
			<span>
				<button id="_atomZoomInButton" type="button" title="<spring:message code="label.configuration.networkmanager.zoomin.text"/>" class="tool_zoomin"><spring:message code="label.configuration.networkmanager.zoomin.text"/></button>
				<button id="_atomZoomOutButton" type="button" title="<spring:message code="label.configuration.networkmanager.zoomout.text"/>" class="tool_zoomout"><spring:message code="label.configuration.networkmanager.zoomout.text"/></button>
				<button id="_atomResetZoomButton" type="button" title="<spring:message code="label.configuration.networkmanager.fit.text"/>" class="tool_fitsize"><spring:message code="label.configuration.networkmanager.fit.text"/></button>
				<button id="_atomToggleMinimapButton" type="button" title="<spring:message code="label.configuration.networkmanager.minimap.text"/>" class="tool_minimap on"><spring:message code="label.configuration.networkmanager.minimap.text"/></button><!-- 미니맵이 켜지면 on 클래스 추가 -->
			</span>
		</p>
	</div>
	<div id="flowdesignDiv" style="width:100%;height:100%;"></div>
</div>