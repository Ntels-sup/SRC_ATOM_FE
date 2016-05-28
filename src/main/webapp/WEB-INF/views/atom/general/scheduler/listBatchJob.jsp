<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/scripts/stringUtil.js"></script>
<script src="/scripts/modal.js"></script>
<script src="/scripts/jquery.alphanumeric.js"></script>
<jsp:include page="../../config/networkmanager/flowdesign.jsp"/>
<script type="text/javascript">
$(document).ready(function () {
	initFlowDesign("#flowdesignDiv");
	searchFlowDesign(true);
	
	$("#searchButton").click(function() {
		searchObjects();
	});
	
	$("#searchInput").keyup(function(e) {
		if (e.keyCode == 13) {
			searchObjects();
		}
	});
	
	$("#serviceManagementButton").click(function() {
		openSvcModal();
	});
	
	$("#searchButton").click(function() {
		searchObjects();
	});
	
	$("#searchInput").keyup(function(e) {
		if (e.keyCode == 13) {
			searchObjects();
		}
	});
	
	setTimeout(function() {
		$("#flowDesignDivDescription").slideUp();
	}, 10000);
	
	$("#pkgSelect").multipleSelect({
		single: true,
		selectAll: false,
		multiple: false,
		allSelected: null,
		placeholder: "<spring:message code="label.general.batch.batchjobmanager.selectpackage.text"/>",
		onClick: function(obj) {
			searchBatchGroup(obj.value);
		}
	});
	
	$("#batchGroupSelect").multipleSelect({
		single: true,
		selectAll: false,
		multiple: false,
		allSelected: null,
		placeholder: "<spring:message code="label.general.batch.batchjobmanager.selectbatchgroup.text"/>",
		onClick: function(obj) {
			doSearch();
		}
	});
	
	$("#nodeTypeSelect").multipleSelect({
		single: true,
		selectAll: false,
		multiple: false,
		allSelected: null,
		onClick: function(obj) {
			searchProc(obj.value);
		}
	});
});

function searchObjects() {
	var txt = $("#searchInput").val().toUpperCase();
	$("#procListDiv>div").each(function() {
		if ($(this).text().toUpperCase().indexOf(txt) >= 0) {
			$(this).show();
		} else {
			$(this).hide();
		}
	});
}

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

function loadProc(procList) {
	if (procList == null) {
		return;
	}
	$("#procListDiv").html("");
	for (var i=0;i<procList.length;i++) {
		var proc = procList[i];
		var sHtml = "<div id=\"proc_"+proc.proc_name.replace(/ /g, "_")+"\" style=\"width:calc(100% - 10px);text-align:center;cursor:move;\">"+proc.proc_name+"<br/>"+proc.node_type+"</div>";
		$("#procListDiv").append(sHtml);
		$("#procListDiv>div:last").data("proc", proc);
		if (proc.pkg_name == $("#pkgSelect").val()) {
			$("#procListDiv>div:last").show();
		} else {
			$("#procListDiv>div:last").hide();
		}
	}
	$("#procListDiv>div").draggable({
		scroll : false,
		appendTo : 'body',
		containment : 'body',
		helper : function(event, ui) {
			var currentTarget = event.currentTarget;
			var outerHtml = currentTarget.outerHTML;
			var proc = $(currentTarget).data("proc");
			var sHtml = "";
			sHtml += "<div id=\"proc_"+proc.proc_name.replace(/ /g, "_")+"\" ";
			sHtml += "style=\"z-index:99;position:absolute;width:"+currentTarget.clientWidth+"px;height:"+currentTarget.clientHeight+"px;";
			sHtml += "float: left;padding: 7px;height: 50px;display: inline-block;background: #ebecf0;border: 2px solid #fff;color: #293239;";
			sHtml += "font-weight: bold;box-shadow: 0px 1px 4px -1px rgba(0,0,0,0.56);word-break: break-all;border-radius: 5px;overflow: hidden;text-align:center;\">";
			sHtml += proc.proc_name;
			sHtml += "<br/>"
			sHtml += proc.node_type;
			sHtml += "</div>";
			return sHtml;
		},
		containment : 'window',
		start : function() {
			$("#_atomDroppableDiv").show();
		},
		stop : function() {
			$("#_atomDroppableDiv").hide();
		}
	});
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

function searchProc(node_type) {
	var pkg_name = $("#pkgSelect").val();
	$("#procListDiv>div").show(); 
	if (!isEmpty(node_type)) {
		$("#procListDiv>div").each(function() {
			var proc = $(this).data("proc");
			if (proc.pkg_name != pkg_name || proc.node_type != node_type) {
				$(this).hide();
			}
		});
	}
}

function cancelSearchFlowDesign() {
	$("#pkgSelect").val(g_data.schedulerGroup.pkg_name);
	$("#pkgSelect").multipleSelect("refresh");
	searchBatchGroup(g_data.schedulerGroup.pkg_name);
}
</script>
<!-- content -->
<div class="content" style="height:calc(100% - 120px);">
	<div class="cont_data">
		<div class="draw">    
			<div class="items">
				<div class="filter">
					<div class="common">
						<p class="search"><input id="searchInput" type="text" name="txtbox" placeholder="Search"/><button id="searchButton" type="button" title="Search" class="srh">Search</button></p>
					</div>
				</div>
				<div class="filter">
					<div class="common">
						<p class="search"><select id="nodeTypeSelect"></select></p>
					</div>
				</div>
				<!--// filter -->
				<div class="item_section scroll-type2" style="height:calc(100% - 63px - 63px);">
					<button class="accordion active"><spring:message code="label.configuration.processmanager.process.text"/></button>
					<div id="procListDiv" class="panel show package scroll-type2"></div>
				</div>
				<!--// item_section -->
			</div>
			<!--// items -->
			<div class="tools"><!-- 아이콘 선택 및 드래그시 on 클래스 추가 -->
				<div class="default search_area">
					<div>
						<div class="select_single">
							<select id="pkgSelect" class="single" style="width:150px;"></select>
						</div>
						<div class="select_single">
							<select id="batchGroupSelect" class="single" style="width:150px;"></select>
						</div>
					</div>
				</div>
				<button type="button" title="List" class="btn_list">List</button>
				<p>
					<span>
						<button id="_atomUndoButton" type="button" title="<spring:message code="label.configuration.networkmanager.undo.text"/>" class="tool_undo" disabled><spring:message code="label.configuration.networkmanager.undo.text"/></button>
						<button id="_atomRedoButton" type="button" title="<spring:message code="label.configuration.networkmanager.redo.text"/>" class="tool_redo" disabled><spring:message code="label.configuration.networkmanager.redo.text"/></button>
						<button id="_atomDeleteButton" type="button" title="<spring:message code="label.configuration.networkmanager.delete.text"/>" class="tool_del"><spring:message code="label.configuration.networkmanager.delete.text"/></button>
					</span>
					<span>
						<button id="_atomZoomInButton" type="button" title="<spring:message code="label.configuration.networkmanager.zoomin.text"/>" class="tool_zoomin"><spring:message code="label.configuration.networkmanager.zoomin.text"/></button>
						<button id="_atomZoomOutButton" type="button" title="<spring:message code="label.configuration.networkmanager.zoomout.text"/>" class="tool_zoomout"><spring:message code="label.configuration.networkmanager.zoomout.text"/></button>
						<button id="_atomResetZoomButton" type="button" title="<spring:message code="label.configuration.networkmanager.fit.text"/>" class="tool_fitsize"><spring:message code="label.configuration.networkmanager.fit.text"/></button>
						<button id="_atomToggleMinimapButton" type="button" title="<spring:message code="label.configuration.networkmanager.minimap.text"/>" class="tool_minimap on"><spring:message code="label.configuration.networkmanager.minimap.text"/></button><!-- 미니맵이 켜지면 on 클래스 추가 -->
						<button id="_atomResizeButton" type="button" title="<spring:message code="label.configuration.networkmanager.resize.text"/>" class="tool_resize"><spring:message code="label.configuration.networkmanager.resize.text"/></button><!-- 미니맵이 켜지면 on 클래스 추가 -->
					</span>
					<span class="line">
						<button id="DirectRouter" type="button" title="<spring:message code="label.configuration.networkmanager.directrouter.text"/>" class="tool_type1 on"><spring:message code="label.configuration.networkmanager.directrouter.text"/></button><!-- 네가지 라인 타입중 선택되면 on 클래스 추가 -->
						<button id="ManhattanConnectionRouter" type="button" title="<spring:message code="label.configuration.networkmanager.manhattanconnectionrouter.text"/>" class="tool_type2"><spring:message code="label.configuration.networkmanager.manhattanconnectionrouter.text"/></button>
						<button id="SplineConnectionRouter" type="button" title="<spring:message code="label.configuration.networkmanager.splineconnectionrouter.text"/>" class="tool_type3"><spring:message code="label.configuration.networkmanager.splineconnectionrouter.text"/></button>
						<%-- <button id="FanConnectionRouter" type="button" title="<spring:message code="label.configuration.networkmanager.fanconnectionrouter.text"/>" class="tool_type4"><spring:message code="label.configuration.networkmanager.fanconnectionrouter.text"/></button> --%>
					</span>
				</p>
				<span class="right_btn">
					<button id="_atomSaveButton" type="button" id="right-menu" title="<spring:message code="label.common.save"/>" class="save"><spring:message code="label.common.save"/></button>
				</span>
			</div><!--// tools -->
			<div id="flowdesignDiv" class="draw_cont">
				<span id="flowDesignDivDescription" style="position:absolute;z-index:5;" class="desc"><spring:message code="label.configuration.networkmanager.dragndropdescription.text"/></span>
			</div>
		</div>
	</div>
	<!-- //cont_data -->
</div>
<!--// content -->