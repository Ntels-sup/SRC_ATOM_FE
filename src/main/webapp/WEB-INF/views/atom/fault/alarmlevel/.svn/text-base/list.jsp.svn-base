<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="/scripts/stringUtil.js"></script>
<script src="/scripts/js/paging.js"></script>
<style>
.cont_top_right button{width:30px !important;padding:0 !important;min-width:25px !important;}
.cont_top_right .dropdown{display:inline-block;}
.cont_top_right .dropdown_content{display:none;width:70px;position:absolute;z-index:100;margin-left:-17px;background-color:#f9f9f9;box-shadow:2px 4px 9px -1px rgba(0,0,0,0.2);border:1px solid #aaaeb3;border-radius:5px;overflow:hidden;}
.cont_top_right .dropdown_content a{color:black;padding:12px 16px;text-decoration:none;display:block;text-align:center;}
.cont_top_right .dropdown_content a:hover{background-color:#f1f1f1}
.cont_top_right .dropdown:hover .dropdown_content{display:block;}
.cont_top_right .dropdown_content li{border-top:1px solid #e0e3e6;}
.cont_top_right .dropdown_content li:first-child{border-top:none;}
</style>
<script>
$(document).ready(function() {
	var pkg_names = "${param.pkg_names}";
	var page = "${param.page}";
	var perPage = "${param.perPage}";

	// Select 초기화
	$("#pkgSelect").multipleSelect({
		filter: true,
        multiple: true,
        multipleWidth: 150,
        width: "602px"
    });
	
	if (!isEmpty(pkg_names) && !isEmpty(page && !isEmpty(perPage))) {
		var arr = pkg_names.split(",");
		$("#pkgSelect").multipleSelect("setSelects", arr);
	} else {
		$("#pkgSelect").multipleSelect("checkAll");
	}
	
	$(".select_group input[type=checkbox]").change(function() {
		goSearch();
	});
	goSearch(page, perPage);
});

// 엑셀다운로드
function fnExcel() {
	var arr = $("#pkgSelect").val();
	if (arr != null) {
		$("#pkg_names").val(arr.join());
	} else {
		$("#pkg_names").val("");
	}
	var param = $("#myForm").serialize();
	$.download("exportAction.xls", param, "post");
}

// 목록 조회
function goSearch(page, perPage) {
	var arr = $("#pkgSelect").val();
	if (arr != null) {
		$("#pkg_names").val(arr.join());
	} else {
		$("#pkg_names").val("");
	}
	if (isEmpty(page)) {
		page = 1;
	}
	if (isEmpty(perPage)) {
		perPage = $("#perPage").val();
	}
	goPostPage("#almCodeDefDiv", "listAlmCodeDef.ajax", page, perPage);
	fnShowLoading("#almCodeDefDiv");
}

// 로딩이미지 출력
function fnShowLoading(selector) {
    var loadImage = '<div class="scroll" id="loading" style="height:100%;"><div class="loading"><span class="loading-inner"></span></div></div>';
    $(selector).children().remove();
    $(selector).append(loadImage);
}
</script>
<form id="myForm" name="myForm" method="post">
	<input type="hidden" id="page" name="page"/>
	<input type="hidden" id="pkg_names" name="pkg_names"/>
	<input type="hidden" id="pkg_name" name="pkg_name"/>
	<input type="hidden" id="code" name="code"/>
	<input type="hidden" id="probable_cause" name="probable_cause"/>
	<input type="hidden" id="titleName"  name="titleName"    value="${titleName}" />
	<div class="content">
		<div class="cont_body">
			<header>
				<h3><spring:message code="label.fault.alarmlevel.alarmcodelist.text"/></h3>
				<p><spring:message code="label.fault.alarmlevel.alarmcodelist.description"/></p>
			</header>
			<div class="cont_top_right">
				<div class="select_group type3">
					<label><spring:message code="label.fault.alarmlevel.package.text"/></label>
					<select id="pkgSelect" class="group" multiple="multiple">
						<c:forEach items="${Package}" var="Packagelist" varStatus="status">
							<option value="${Packagelist.NAME}">${Packagelist.NAME}</option>
						</c:forEach>
					</select>
				</div>
				<div class="dropdown">
					<button type="button" class="btn_icon download dropbtn" title="<spring:message code="label.common.downlaod"/>"><span><spring:message code="label.common.downlaod"/></span></button>
					<ul class="dropdown_content">
						<li><a href="javascript:fnExcel();">Excel</a></li>
					</ul>
				</div>
			</div>
			<div id="almCodeDefDiv"></div>
		</div>
	</div>
</form>