<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/scripts/stringUtil.js"></script>
<script src="/scripts/modal.js"></script>
<script src="/scripts/jquery.alphanumeric.js"></script>
<jsp:include page="../networkmanager/flowdesign.jsp"/>
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
	
	$("#nodeTypeSelect").multipleSelect({
		single: true,
		selectAll: false,
		multiple: false,
		allSelected: null,
		placeholder: "<spring:message code="label.configuration.processmanager.selectnodetype.text"/>",
		onClick: function(obj) {
			searchSvc(obj.value);
		}
	});
	
	$("#svcSelect").multipleSelect({
		single: true,
		selectAll: false,
		multiple: false,
		allSelected: null,
		placeholder: "<spring:message code="label.configuration.processmanager.selectservice.text"/>",
		onClick: function() {
			doSearch();
		}
	});
});

function searchObjects() {
	var txt = $("#searchInput").val().toUpperCase();
	$("#procBaseListDiv>div").each(function() {
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
	if (isEmpty($("#nodeTypeSelect").val())) {
		return;
	}
	if (isEmpty($("#svcSelect").val())) {
		return;
	}
	var pkg = $("#nodeTypeSelect option:selected").parent("optgroup").data("pkg");
	var param = new Object();
	param.pkg_name = pkg.pkg_name;
	param.node_type = $("#nodeTypeSelect").val();
	param.node_name = $("#nodeTypeSelect option:selected").text();
	param.svc_no = $("#svcSelect").val();
	param.svc_name = $("#svcSelect option:selected").text();
	searchFlowDesign(true, param);
}

function searchSvc(node_type, svc_no) {
	if (svc_no == null) {
		svc_no = g_data.svc.svc_no;
	}
	$("#svcSelect").html("");
	for (var i=0;i<g_data.svcList.length;i++) {
		var svc = g_data.svcList[i];
		if (svc.node_type == node_type) {
			var sHtml = "<option value=\""+svc.svc_no+"\">"+svc.svc_name+"</option>";
			$("#svcSelect").append(sHtml);
			$("#svcSelect option:last").data("svc", svc);
		}
	}
	$("#svcSelect").val(svc_no);
	$("#svcSelect").multipleSelect("refresh");
}

function openSvcModal() {
	hideDetailDiv();
	if (isEmpty($("#nodeTypeSelect").val())) {
		openAlertModal("<spring:message code="msg.configuration.processmanager.node.empty"/>", "", function() {$("#nodeTypeSelect").focus();});
		return;
	}
	$("#svcModalDiv").remove();
	var param = new Object();
	$.ajax({
        url: "listSvc",
        data: param,
        type: 'POST',
        success: function(data) {
           $("body").append(data);
        },
        error: function(e){
            openAlertModal(e.reponseText);
        },
        complete: function() {
        }
	});
}

function loadPkg(pkgList) {
	var loaded = $("#nodeTypeSelect").data("loaded");
	if (loaded) {
		return;
	}
	$("#nodeTypeSelect").html("");
	for (var i=0;i<pkgList.length;i++) {
		var pkg = pkgList[i];
		var sOptionHtml = "<optgroup label=\""+pkg.pkg_name+"\"></optgroup>";
		$("#nodeTypeSelect").append(sOptionHtml);
		$("#nodeTypeSelect optgroup:last").data("pkg", pkg);
	}
}

function getOptGroup(pkg_name) {
	for (var i=0;i<$("#nodeTypeSelect optgroup").length;i++) {
		var optGroup = $("#nodeTypeSelect optgroup").eq(i);
		var pkg = optGroup.data("pkg");
		if (pkg.pkg_name == pkg_name) {
			return optGroup;
		}
	}
	return null;
}

function loadNodeType(nodeTypeList) {
	var loaded = $("#nodeTypeSelect").data("loaded");
	if (loaded) {
		return;
	}
	for (var i=0; i<nodeTypeList.length;i++) {
		var nodeType = nodeTypeList[i];
		var optGroup = getOptGroup(nodeType.pkg_name);
		var sHtml = "<option value=\""+nodeType.node_type+"\">"+nodeType.node_type+"</option>";
		$(optGroup).append(sHtml);
		$(optGroup).children("option").last().data("nodeType", nodeType);
	}
	$("#nodeTypeSelect").val(g_data.svc.node_type);
	$("#nodeTypeSelect").multipleSelect("refresh");
	$("#nodeTypeSelect").data("loaded", true);
}


function loadSvc(svcList) {
	if (svcList == null) {
		return;
	}
}

function loadProcBase(procBaseList) {
	$("#procBaseListDiv").html("");
	if (procBaseList == null) {
		return;
	}
	for (var i=0;i<procBaseList.length;i++) {
		var procBase = procBaseList[i];
		var i = $("#procBaseListDiv>div").length;
		var sHtml = "<div id=\"procBase_"+procBase.base_name.replace(/ /g, "_")+"\" style=\"cursor:move;\"><img src=\"/images/icon/i01.svg\"><span>"+procBase.base_name+"</span></div>";
		$("#procBaseListDiv").append(sHtml);
		$("#procBaseListDiv>div:last").data("procBase", procBase);
		
		$("#procBaseListDiv>div:last").draggable({
			helper: function(event, ui) {
				var outerHtml = event.currentTarget.outerHTML;
				var procBase = $(event.currentTarget).data("procBase");
				outerHtml = outerHtml.replace("style=\"", "id=\"procBase_"+procBase.base_name+"\" style=\"z-index:99;");
				return outerHtml;
			},
			start: function() {
				$("#_atomDroppableDiv").show();
			},
			stop: function() {
				$("#_atomDroppableDiv").hide();
			}
		});
	}
}

function loadProc(procList) {
	if (procList == null) {
		return;
	}
	for (var i=0;i<procList.length;i++) {
		var proc = procList[i];
		if (!isEmpty(proc.image_x) && !isEmpty(proc.image_y) && proc.svc_no == g_data.svc.svc_no) {
			var atomProc = new AtomProc ({
				path: proc.image_name,
				label: proc.proc_name,
				width: 62,
				height: 62,
				userData: proc,
				x: proc.image_x,
				y: proc.image_y,
				bgColor: proc.image_bgcolor
			});
			g_canvas.addFigure(atomProc);
			atomProc.toFront();
			$(atomProc.shape[0]).attr("filter", "url(#AtomNodeFilter)");
		}
	}
}

function cancelSearchFlowDesign() {
	$("#nodeTypeSelect").val(g_data.svc.node_type);
	$("#nodeTypeSelect").multipleSelect("refresh");
	searchSvc(g_data.svc.node_type);
}
</script>
<!-- content -->
<div class="content" style="height:calc(100% - 120px);">
	<div class="cont_data">
		<div class="draw">    
			<div class="items">
				<div class="filter">
					<div class="common">
						<p class="search"><input id="searchInput" type="text" name="txtbox" placeholder="Search" maxlength="40"/><button id="searchButton" type="button" title="Search" class="srh">Search</button></p>
					</div>
				</div>
				<!--// filter -->
				<div class="item_section scroll-type2">
					<button class="accordion active"><spring:message code="label.configuration.processmanager.process.text"/></button>
					<div id="procBaseListDiv" class="panel node scroll-type2 show"></div>
				</div>
				<!--// item_section -->
			</div>
			<!--// items -->
			<div class="tools"><!-- 아이콘 선택 및 드래그시 on 클래스 추가 -->
				<div class="default search_area">
					<div>
						<div class="select_single">
							<select id="nodeTypeSelect" class="single" style="width:150px;"></select>
						</div>
						<div class="select_single">
							<select id="svcSelect" class="single" style="width:150px;"></select>
						</div>
					</div>
				</div>
				<span class="link_area">
					<button id="serviceManagementButton" type="button" class="link_btn"><spring:message code="label.configuration.processmanager.servicemanagement.text"/></button> 
				</span>
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