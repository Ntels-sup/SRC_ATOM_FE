<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link rel="stylesheet" href="/styles/style.css">
<script src="/scripts/jquery.1.11.2.min.js"></script>
<script src="/scripts/stringUtil.js"></script>
<script src="/scripts/modal.js"></script>
<script src="/scripts/jquery.alphanumeric.js"></script>
<script src="/scripts/jquery-ui.min.js"></script>
<script src="/scripts/multiple-select.js"></script>
<jsp:include page="../config/networkmanager/flowdesign.jsp"/>
<script>
$(document).ready(function () {
	$(this).contextmenu(function() {
		return false;
	});
	initFlowDesign("#flowdesignDiv");
	var param = new Object();
	param.pkg_name = nullCheck($("#pkgSelect").val(), "");
	param.group_name = nullCheck($("#batchGroupSelect").val(), "");
	searchFlowDesign(true, param);
	
	g_data = {"readonly": true};
	
	$("#pkgSelect").multipleSelect({
		single: true,
		selectAll: false,
		multiple: false,
		allSelected: null,
		onClick: function(obj) {
			searchBatchGroup(obj.value);
		}
	});
	
	$("#batchGroupSelect").multipleSelect({
		single: true,
		selectAll: false,
		multiple: false,
		allSelected: null,
		onClick: function(obj) {
			doSearch();
		}
	});
});

function doSearch() {
	setTimeout(function() {
		searchAction();
	}, 0);
}

function searchAction() {
	if (!g_bLoaded) {
		return;
	}
	if (isEmpty($("#pkgSelect").val())) {
		return;
	}
	if (isEmpty($("#batchGroupSelect").val())) {
		return;
	}
	var param = new Object();
	param.pkg_name = $("#pkgSelect").val();
	param.group_name = $("#batchGroupSelect").val();
	searchFlowDesign(true, param);
}

function searchBatchGroup(pkg_name) {
	$("#batchGroupSelect").html("");
	for (var i=0;i<g_data.batchGroupList.length;i++) {
		var batchGroup = g_data.batchGroupList[i];
		if (batchGroup.pkg_name == pkg_name) {
			var sHtml = "<option value=\""+batchGroup.group_name+"\">"+batchGroup.group_name+"</option>";
			$("#batchGroupSelect").append(sHtml);
			$("#batchGroupSelect option:last").data("batchGroup", batchGroup);
		}
	}
	$("#batchGroupSelect").val(g_data.schedulerGroup.group_name);
	$("#batchGroupSelect").multipleSelect("refresh");
}

function loadPkg(pkgList) {
	$("#pkgSelect").html("");
	for (var i=0;i<pkgList.length;i++) {
		var pkg = pkgList[i];
		var sOptionHtml = "<option value=\""+pkg.pkg_name+"\">"+pkg.pkg_name+"</option>";
		$("#pkgSelect").append(sOptionHtml);
		$("#pkgSelect option:last").data("pkg", pkg);
	}
	$("#pkgSelect").val(g_data.schedulerGroup.pkg_name);
	$("#pkgSelect").multipleSelect("refresh");
}

function loadNodeType(nodeTypeList) {
	if (nodeTypeList == null) {
		return;
	}
	$("#nodeTypeSelect").html("");
	for (var i=0; i<nodeTypeList.length;i++) {
		var nodeType = nodeTypeList[i];
		var sOptionHtml = "<option value=\""+nodeType.node_type+"\">"+nodeType.node_type+"</option>";
		$("#nodeTypeSelect").append(sOptionHtml);
		$("#nodeTypeSelect option:last").data("nodeType", nodeType);
	}
	// $("#nodeTypeSelect").val(g_data.schedulerGroup.node_type);
	$("#nodeTypeSelect").multipleSelect("refresh");
}

function loadBatchGroup(batchGroupList) {
	if (batchGroupList == null) {
		return;
	}
	searchBatchGroup(g_data.schedulerGroup.pkg_name);
}

function loadBatchJob(batchJobList) {
	if (batchJobList == null) {
		return;
	}
	for (var i=0;i<batchJobList.length;i++) {
		var batchJob = batchJobList[i];
		if (!isEmpty(batchJob.image_x) && !isEmpty(batchJob.image_y)) {
			var atomBatchJob = new AtomBatchJob({
				path : batchJob.image_name,
				label : batchJob.job_name,
				userData : batchJob,
				x: batchJob.image_x,
				y: batchJob.image_y,
				bgColor: batchJob.image_bgcolor
			});
			g_canvas.addFigure(atomBatchJob);
			atomBatchJob.toFront();
			atomBatchJob.setWidth(atomBatchJob.atomLabel.getBoundingBox().w+40);
			$(atomBatchJob.shape[0]).attr("filter", "url(#AtomPkgFilter)");
		}
	}
}
</script>
<div class="draw">
	<div class="tools" style="width:100%;background:none;position:absolute;z-index:1;"><!-- 아이콘 선택 및 드래그시 on 클래스 추가 -->
		<div class="default search_area">
			<div>
				<div class="select_single">
					<select id="pkgSelect" class="single" style="width:100px;"></select>
				</div>
				<div class="select_single">
					<select id="batchGroupSelect" class="single" style="width:100px;"></select>
				</div>
			</div>
		</div>
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