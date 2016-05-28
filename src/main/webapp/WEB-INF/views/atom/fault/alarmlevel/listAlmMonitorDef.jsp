<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="/scripts/slider.js"></script>
<script src="/scripts/stringUtil.js"></script>
<script>
$(document).ready(function() {
	// Select 초기화
	$("#nodeTypeSelect").multipleSelect({
        single: true,
        selectAll: false,
        multiple: false,
        onClick: function(param) {
        	var value = param.value;
        	$("#alarmLevelTbody>tr").show();
        	if (!isEmpty(value)) {
            	$("#alarmLevelTbody>tr").each(function() {
            		var node_type = $(this).find("#node_type").text();
            		if (value != node_type) {
            			$(this).hide();
            		}
            	});
        	}
        }
    });
	
	// 전체 체크박스 클릭 이벤트
	$("#chk_list").click(function() {
		var bChecked = $(this).prop("checked");
		$("#alarmLevelTbody>tr").each(function() {
			$(this).find("input[name=chk]").prop("checked", bChecked);
		});
	});
	
	// 체크박스 클릭 이벤트
	$("#alarmLevelTbody input[name=chk]").click(function() {
		var bCheckedAll = false;
		if ($("#alarmLevelTbody [name=chk]:checked").length == $("#alarmLevelTbody [name=chk]").length) {
			bCheckedAll = true;
		}
		$("#chk_list").prop("checked", bCheckedAll);
	});
	
	// slider 초기화
	$("#alarmLevelTbody>tr").each(function() {
		var index = $(this).index();
		initColResizable(index);
	});
	
	// Default 버튼
	$("#defaultButton").click(function() {
		setDefaultValue();
	});
	
	// Cancel 버튼
	$("#cancelButton").click(function() {
		goListPage();
	});
	
	// Save 버튼
	$("#saveButton").click(function() {
		saveAlmMonitor();
	});
});

// Alarm Level 을 저장한다.
function saveAlmMonitor() {
	if ($("#alarmLevelTbody>tr:visible").length == 0) {
		openAlertModal("<spring:message code="msg.fulat.alarmlevel.save.nodata"/>");
		return;
	}
	var arr = new Array();
	$("#alarmLevelTbody>tr:visible").each(function(index, obj) {
		updateInfo(index);
		var almMonitor = new Object();
		almMonitor.pkg_name = $("#pkg_name").val();
		almMonitor.code = $("#code").val();
		almMonitor.target = $(this).find("#target").text();
		almMonitor.node_type = $(this).find("#node_type").text();
		almMonitor.severity_ccds = "5, 3, 2, 1";
		var values = "0";
		$("#range"+index+" td").each(function() {
			if ($(this).index() < $("#range"+index+" td").length - 1) {
				if (!isEmpty(values)) {
					values += ",";
				}
				values += $(this).data("value");
			}
		});
		almMonitor.values = values;
		arr.push(almMonitor);
	});
	var param = new Object();
	param.jsonStr = JSON.stringify(arr);
	$.ajax({
		url: "saveAlmLevel",
		data: param,
		type: 'POST',
		dataType: 'json',
		success: function(data) {
			var result = data.result;
			if (result == "succ") {
				openAlertModal("<spring:message code="msg.fault.alarmlevel.save.almcodedef.succ"/>", "", function() {
					// goListPage();
				});
			} else {
				openAlertModal(result);
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

// slider 를 초기화한다.
function initColResizable(index) {
	var tableWidth = $("#range"+index).width();
	var tr = $("#alarmLevelTbody>tr").eq(index);
	var max_value = parseInt($(tr).find("#max_value").text());
	var unit_value = parseInt($(tr).find("#unit_value").text());
	
	$("#range"+index).colResizable({disable: true});
	$("#range"+index).colResizable({
		liveDrag: true,
		draggingClass: "rangeDrag",
		gripInnerHtml: "<div class='rangeGrip'></div>",
		onDrag: function(e) {
			updateInfo(index);
		},
		minWidth: tableWidth * unit_value / max_value
	});
}

// index 에 해당하는 row 의 정보를 업데이트한다.
function updateInfo(index) {
	var tr = $("#alarmLevelTbody>tr").eq(index);
	var max_value = parseInt($(tr).find("#max_value").text());
	var unit_value = parseInt($(tr).find("#unit_value").text());
	var totalWidth = $("#range"+index).width();
	var sum = 0;
	$("#range"+index+" td").each(function() {
		var width = $(this).width();
		sum += width;
		var value = Math.round(sum * max_value / totalWidth);
		value = parseInt(value / unit_value) * unit_value;
		$(this).data("value", value);
		
		var tdIndex = $(this).index();
		var prevValue = 0;
		if (tdIndex > 0) {
			prevValue = $(this).prev("td").data("value");
		}
		var sHtml = prevValue.format() + " =< " + value.format();
		if (tdIndex == $("#range"+index+" td").length - 1) {
			sHtml += " <spring:message code="label.aggregation.sec"/>";
		} else {
			sHtml += " <span class=\"divi\">/</span>";
		}
		$("#info"+index+" li").eq(tdIndex).html(sHtml);
	});
}

// 체크된 row 를 Default Value 로 셋팅한다. 
function setDefaultValue() {
	if ($("#alarmLevelTbody input[name=chk]:checked").length == 0) {
		openAlertModal("<spring:message code="msg.fulat.alarmlevel.list.default.selectrow"/>");
		return;
	}
	var defaultValues = new Array();
	<c:forEach items="${defaultAlarmLevelList}" var="item" varStatus="status">
		defaultValues.push(parseInt("${item.ID}"));
	</c:forEach>
	$("#alarmLevelTbody input[name=chk]:checked").each(function() {
		var tr = $(this).parent("td").parent("tr");
		var index = $(tr).index();
		var max_value = parseInt($(tr).find("#max_value").text());
		var totalWidth = $("#range"+index).width();
		
		$("#range"+index).prev("div.JCLRgrips").remove();
		$("#range"+index).remove();
		
		var sHtml = "";
		sHtml += "<table id=\"range"+index+"\" class=\"rangeslide\">";
		sHtml += "	<tr>";
		for (var i=0;i<defaultValues.length;i++) {
			var defaultValue = defaultValues[i];
			var nextValue = 100;
			if (i < defaultValues.length - 1) {
				nextValue = defaultValues[i + 1];
			}
			var width = Math.round(totalWidth * (nextValue - defaultValue) / 100);
			sHtml += "		<td width=\""+width+"%\" class=\"bar0"+(i+1)+"\"></td>";
		}
		sHtml += "	</tr>";
		sHtml += "</table>";
		
		$(tr).find("div.rangeWrap").append(sHtml);
		initColResizable(index);
		updateInfo(index);
		
		return;
		$("#range"+index+" td").each(function(tdIndex, obj) {
			var defaultValue = defaultValues[tdIndex];
			var nextValue = 100;
			if (tdIndex < $("#range"+index+" td").length - 1) {
				nextValue = defaultValues[tdIndex + 1];
			}
			var width = totalWidth * (nextValue - defaultValue) / 100;
			$(obj).css("width", width+"px");
			
			
			/* if (tdIndex < $("#range"+index+" td").length - 1) {
				var left = totalWidth * nextValue / 100 + 1;
				$("#range"+index).parent("div").find(".JCLRgrip").eq(tdIndex).css("left", left);
			} */
		});
	});
}

// 목록화면으로 돌아간다.
function goListPage() {
	$("#almMonitorDefForm").attr("action", "list");
	$("#almMonitorDefForm").submit();
}
</script>
<form id="almMonitorDefForm" name="almMonitorDefForm" method="post">
	<input type="hidden" id="pkg_name" name="pkg_name" value="${almCodeDef.pkg_name}"/>
	<input type="hidden" id="code" name="code" value="${almCodeDef.code}"/>
	<input type="hidden" id="page" name="page" value="${param.page}"/>
	<input type="hidden" id="perPage" name="perPage" value="${param.perPage}"/>
	<input type="hidden" id="pkg_names" name="pkg_names" value="${param.pkg_names}"/>
	<div class="content">
		<div class="cont_body">
			<header>
				<h3><spring:message code="label.fault.alarmlevel.levelsetting.text"/></h3>
				<p><spring:message code="label.fault.alarmlevel.levelsetting.description"/></p>
			</header>
			<div class="cont_top_right">
				<label><spring:message code="label.fault.alarmlevel.nodetype.text"/></label>
				<select id="nodeTypeSelect" class="single type3">
					<option value="">ALL</option>
					<c:forEach items="${nodeTypeList}" var="item" varStatus="status">
						<option value="${item.node_type}">${item.node_type}</option>
					</c:forEach>
				</select>
			</div>
			<div class="list type02">
				<table class="tbl_list">
					<colgroup>
						<col>
						<col width="10%">
						<col width="12%">
						<col width="*">
						<col width="*">
						<col width="35%">
						<col width="10px">
					</colgroup>
					<thead>
						<tr>
							<th class="chk">
								<input type="checkbox" id="chk_list" name="chk_list" value=""/>
								<label for="chk_list"><spring:message code="label.common.check"/></label>
							</th>
							<th><spring:message code="label.fault.alarmlevel.alarmcode.text"/></th>
							<th><spring:message code="label.fault.alarmlevel.nodetype.text"/></th>
							<th><spring:message code="label.fault.alarmlevel.probablecause.text"/></th>
							<th><spring:message code="label.fault.alarmlevel.target.text"/></th>
							<th>
								<spring:message code="label.fault.alarmlevel.levelsetting.setting.text"/>
								(<span class="setting">
									<span class="dot01"></span><em class="txt01"><spring:message code="label.fault.alarmlevel.levelsetting.normal.text"/></em>
									<span class="dot02"></span><em class="txt02"><spring:message code="label.fault.alarmlevel.levelsetting.minor.text"/></em>
									<span class="dot03"></span><em class="txt03"><spring:message code="label.fault.alarmlevel.levelsetting.major.text"/></em>
									<span class="dot04"></span><em class="txt04"><spring:message code="label.fault.alarmlevel.levelsetting.critical.text"/></em>
								</span>)
							</th>
							<th></th>
						</tr>
					</thead>
				</table>
				<div class="scroll">
					<table class="tbl_list">
						<colgroup>
							<col>
							<col width="10%">
							<col width="12%">
							<col width="*">
							<col width="*">
							<col width="35%">
						</colgroup>
						<tbody id="alarmLevelTbody">
							<c:forEach items="${almMonitorDefList}" var="item" varStatus="status">
								<tr>
									<td class="chk">
										<input type="checkbox" id="check${status.index}" name="chk"><label for="check${status.index}"><spring:message code="label.common.check"/></label>
									</td>
									<td id="code">${item.code}</td>
									<td id="node_type">${item.node_type}</td>
									<td id="probable_cause">${almCodeDef.probable_cause}</td>
									<td id="target">${item.target}</td>
									<td>
										<div class="rangeWrap">
											<ul id="info${status.index}" class="info">
												<c:choose>
													<c:when test="${fn:length(item.almLevelList) > 0}">
														<c:set var="prevValue" value="0"/>
														<c:forEach items="${item.almLevelList}" var="subItem" varStatus="subStatus">
															<c:if test="${subStatus.index > 0}">
																<li class="info0${subStatus.index}"><fmt:formatNumber value="${prevValue}" pattern="#,###" /> =&lt; <fmt:formatNumber value="${subItem.value}" pattern="#,###" /> <span class="divi">/</span></li>
															</c:if>
															<c:set var="prevValue" value="${subItem.value}"/>
														</c:forEach>
														<li class="info0${fn:length(item.almLevelList)}"><fmt:formatNumber value="${prevValue}" pattern="#,###" /> =&lt; <fmt:formatNumber value="${item.max_value}" pattern="#,###" /> <spring:message code="label.aggregation.sec"/></li>
													</c:when>
													<c:otherwise>
														<c:set var="prevValue" value="0"/>
														<c:forEach items="${defaultAlarmLevelList}" var="subItem" varStatus="subStatus">
															<c:if test="${subStatus.index > 0}">
																<li class="info0${subStatus.index}"><fmt:formatNumber value="${prevValue}" pattern="#,###" /> =&lt; <fmt:formatNumber value="${subItem.ID}" pattern="#,###" /> <span class="divi">/</span></li>
															</c:if>
															<c:set var="prevValue" value="${subItem.ID}"/>
														</c:forEach>
														<li class="info0${fn:length(defaultAlarmLevelList)}"><fmt:formatNumber value="${prevValue}" pattern="#,###" /> =&lt; <fmt:formatNumber value="${item.max_value}" pattern="#,###" /> <spring:message code="label.aggregation.sec"/></li>
													</c:otherwise>
												</c:choose>
											</ul>
											<table id="range${status.index}" class="rangeslide">
												<tr>
													<c:choose>
														<c:when test="${fn:length(item.almLevelList) > 0}">
															<c:set var="prevValue" value="0"/>
															<c:forEach items="${item.almLevelList}" var="subItem" varStatus="subStatus">
																<c:if test="${subStatus.index > 0}">
																	<td width="${(subItem.value-prevValue)*100/item.max_value}%" class="bar0${subStatus.index}"></td>
																</c:if>
																<c:set var="prevValue" value="${subItem.value}"/>
															</c:forEach>
															<td width="${(item.max_value-prevValue)*100/item.max_value}%" class="bar0${fn:length(item.almLevelList)}"></td>
														</c:when>
														<c:otherwise>
															<c:set var="prevValue" value="0"/>
															<c:forEach items="${defaultAlarmLevelList}" var="subItem" varStatus="subStatus">
																<c:if test="${subStatus.index > 0}">
																	<td width="${(subItem.ID-prevValue)*100/item.max_value}%" class="bar0${subStatus.index}"></td>
																</c:if>
																<c:set var="prevValue" value="${subItem.ID}"/>
															</c:forEach>
															<td width="${(item.max_value-prevValue)*100/item.max_value}%" class="bar0${fn:length(defaultAlarmLevelList)}"></td>
														</c:otherwise>
													</c:choose>
												</tr>
											</table>
										</div>
									</td>
									<td id="pkg_name" hidden="true">${almCodeDef.pkg_name}</td>
									<td id="max_value" hidden="true">${item.max_value}</td>
									<td id="unit_value" hidden="true">${item.unit_value}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="cont_footer">
			<div class="btn_area">
				<button id="defaultButton" type="button"><spring:message code="label.standardization.default.value"/></button>
				<button id="cancelButton" type="button"><spring:message code="label.common.cancel"/></button>
				<button id="saveButton" type="button" class="major"><spring:message code="label.common.save"/></button>
			</div>
		</div>
	</div>
</form>
