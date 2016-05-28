<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/scripts/stringUtil.js"></script>
<script src="/scripts/modal.js"></script>
<script src="/scripts/jquery.alphanumeric.js"></script>
<jsp:include page="flowdesign.jsp"/>
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
	
	$("#openPkgListButton").click(function() {
		openPkgListModal();
	});
	
	$("#openNodeGroupButton").click(function() {
		openNodeGrpModal();
	});
	
	setTimeout(function() {
		$("#flowDesignDivDescription").slideUp();
	}, 10000);
});

function searchObjects() {
	var txt = $("#searchInput").val().toUpperCase();
	$("#pkgListDiv>div").each(function() {
		if ($(this).text().toUpperCase().indexOf(txt) >= 0) {
			$(this).show();
		} else {
			$(this).hide();
		}
	});
	$("#nodeListDiv>div>span, #linkedNodeListDiv>div>span").each(function() {
		if ($(this).text().toUpperCase().indexOf(txt) >= 0) {
			$(this).parent("div").show();
		} else {
			$(this).parent("div").hide();
		}
	});
}

function openPkgListModal() {
	hideDetailDiv();
	$("#pkgListModalDiv").remove();
	var param = new Object();
	$.ajax({
        url: "listPkg",
        data: param,
        type: 'POST',
        success: function(data) {
           $("body").append(data);
        },
        error: function(e){
        	var error = JSON.parse(e.responseText);
			openAlertModal(error.errorMsg.cause.localizedMessage);
        },
        complete: function() {
        }
	});
}

function openNodeGrpModal() {
	hideDetailDiv();
	$("#nodeGrpModalDiv").remove();
	var param = new Object();
	$.ajax({
        url: "listNodeGrp",
        data: param,
        type: 'POST',
        success: function(data) {
           $("body").append(data);
        },
        error: function(e){
        	var error = JSON.parse(e.responseText);
			openAlertModal(error.errorMsg.cause.localizedMessage);
        },
        complete: function() {
        }
	});
}

function loadPkg(pkgList) {
	$("#pkgListDiv").html("");
	for (var i=0;i<pkgList.length;i++) {
		var pkg = pkgList[i];
		var sHtml = "<div id=\"pkg_"+pkg.pkg_name.replace(/ /g, "_")+"\" style=\"cursor:move;\">"+pkg.pkg_name + "</div>";
		$("#pkgListDiv").append(sHtml);
		$("#pkgListDiv>div:last").data("pkg", pkg);

		addPkgFigure(pkg);
	}
	$("#pkgListDiv>div").draggable({
		scroll: false,
		appendTo: 'body',
		containment: 'body',
		helper: function(event, ui) {
			var currentTarget = event.currentTarget;
			var outerHtml = currentTarget.outerHTML;
			var pkg = $(currentTarget).data("pkg");
			var sHtml = "";
			sHtml += "<div id=\"pkg_"+pkg.pkg_name.replace(/ /g, "_")+"\" ";
			sHtml += "style=\"z-index:99;position:absolute;width:"+currentTarget.clientWidth+"px;height:"+currentTarget.clientHeight+"px;";
			sHtml += "float: left;padding: 7px;height: 50px;display: inline-block;background: #ebecf0;border: 2px solid #fff;color: #293239;";
			sHtml += "font-weight: bold;box-shadow: 0px 1px 4px -1px rgba(0,0,0,0.56);word-break: break-all;border-radius: 5px;overflow: hidden;\">";
			sHtml += pkg.pkg_name;
			sHtml += "</div>";
			return sHtml;
		},
		containment: 'window',
		start: function() {
			$("#_atomDroppableDiv").show();
		},
		stop: function() {
			$("#_atomDroppableDiv").hide();
		}
	});
}

function loadNode(nodeList) {
	$("#nodeListDiv").html("");
	$("#linkedNodeListDiv").html("");
	addNode({
		node_name_old: "emptyNode",
		node_name: "NEW",
		image_name: "/images/icon/node_new.svg",
		internal_yn: "Y"
	});
	addNode({
		node_name_old: "emptyLinkedNode",
		node_name: "NEW",
		image_name: "/images/icon/node_new.svg",
		internal_yn: "N"
	});

	for (var i=0; i<nodeList.length;i++) {
		var node = nodeList[i];
		addNode(node);
	}
}

function addNode(node) {
	var atomNode = addNodeFigure(node);
	var sHtml = "<div id=\"node_"+node.node_name_old.replace(/ /g, "_")+"\" style=\"background-color:"+node.image_bgcolor+";\"><img src=\""+nullCheck(node.image_name, "")+"\"><span>"+node.node_name+"</span></div>";
	var divId;
	if (node.internal_yn == "Y") {
		divId = "nodeListDiv";
	} else {
		divId = "linkedNodeListDiv";
	}
	$("#"+divId).append(sHtml);
	$("#"+divId+">div:last").data("node", node);

	$("#"+divId+">div:last").draggable({
		helper: function(event) {
			var outerHtml = event.currentTarget.outerHTML;
			var node = $(event.currentTarget).data("node");
			outerHtml = outerHtml.replace("style=\"", "id=\"node_"+node.node_name_old.replace(/ /g, "_")+"\" style=\"z-index:99;");
			return outerHtml;
		},
		start: function() {
			$("#_atomDroppableDiv").show();
		},
		stop: function() {
			$("#_atomDroppableDiv").hide();
		}
	});
	return atomNode;
}
</script>
<!-- content -->
<div class="content" style="height:calc(100% - 120px);">
	<div class="cont_data">
		<div class="draw">    
			<div class="items">
				<div class="filter">
					<div class="common">
						<p class="search"><input id="searchInput" type="text" name="txtbox" placeholder="Search" maxlength="60"/><button id="searchButton" type="button" title="<spring:message code="label.common.search"/>" class="srh"><spring:message code="label.common.search"/></button></p>
					</div>
				</div>
				<!--// filter -->
				<div class="item_section scroll-type2">
					<button class="accordion active"><spring:message code="label.configuration.networkmanager.package.text"/></button>
					<div id="pkgListDiv" class="panel show package scroll-type2"></div>
					<button class="accordion node"><spring:message code="label.configuration.networkmanager.node.text"/></button>
					<div id="nodeListDiv" class="panel node scroll-type2"></div>
					<button class="accordion linked"><spring:message code="label.configuration.networkmanager.linkednode.text"/></button>
					<div id="linkedNodeListDiv" class="panel linked scroll-type2"></div>
				</div>
				<!--// item_section -->
			</div>
			<!--// items -->
			<div class="tools"><!-- 아이콘 선택 및 드래그시 on 클래스 추가 -->
				<span class="link_area">
					<button id="openPkgListButton" type="button" class="link_btn"><spring:message code="label.configuration.networkmanager.packageinformation.text"/></button> 
					<button id="openNodeGroupButton" type="button" class="link_btn"><spring:message code="label.configuration.networkmanager.nodegroupmanagement.text"/></button> 
				</span>
				<button type="button" title="<spring:message code="label.common.list"/>" class="btn_list"><spring:message code="label.common.list"/></button>
				<p>
					<span>
						<button id="_atomUndoButton" type="button" title="<spring:message code="label.configuration.networkmanager.undo.text"/>" class="tool_undo" style="opacity:0.2;" disabled><spring:message code="label.configuration.networkmanager.undo.text"/></button>
						<button id="_atomRedoButton" type="button" title="<spring:message code="label.configuration.networkmanager.redo.text"/>" class="tool_redo" style="opacity:0.2;" disabled><spring:message code="label.configuration.networkmanager.redo.text"/></button>
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