<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>


<script type="text/javascript">
//Ajax로 첫 화면의 데이터 호출
//화면 먼저 보이고 데이터를 불러야 사용자가 덜 답답해 함
$(document).ready(function(){
	
	$("input[type=text]").blur(function() {
        fnCheckStr($(this));
   	});
        
    $("textarea").blur(function() {
    	fnCheckStr($(this));
  	});
    
	init();
	
	$('#dynatree').dynatree("getTree").activateKey('${menu.menu_id}');
	
	//버튼 클릭시
	
	$("#btn_goDetail").click(function() {
		getViewMenuPage('${menu.menu_id}');
	});	
	
	$("#btn_update").click(function() {
		goUpdate();
	});
	$("#btn_delete").click(function() {
		goDelete();
	});
});

function init() {
	var tmp_is_folder = "${menu.is_folder}";

	if(tmp_is_folder != "") {
		if(tmp_is_folder == "Y") {
			$("#is_folder_Y").attr("checked", "Y");
		} else
			$("#is_folder_N").attr("checked", "N");
	} else {
		var param_is_folder = "${is_folder}";
		
		if(param_is_folder == "Y") {
			$("#is_folder_Y").attr("checked", "Y");
		} else
			$("#is_folder_N").attr("checked", "N");
	}
	
	$("#tmp_menu_path").val( "${menu.menu_path}" );
	
	var popup_yn = "${menu.popup_yn}";
	if(popup_yn == "Y") {	
		$("#c_popup_yn").attr("checked", true);
	} else {
		$("#c_popup_yn").attr("checked", false);
	}

}



function goUpdate() {
	if($("#menu_name").val() == "") {
		openAlertModal('<spring:message code="NotEmpty.menu.menu_name"/>');
		$("#menu_name").focus();
		return;
	}

	if($("#c_popup_yn").is(":checked")) {
		$("#popup_yn").val("Y");
	} else {
		$("#popup_yn").val("N");
	}

	
	openConfirmModal("",'<spring:message code="msg.common.save" />',function(){	
		$("#menu_path").val($("#tmp_menu_path").val());
		var param = $("#menu").serialize();
		$.ajax({
	        url : "/atom/security/menu/updateAction.ajax",
	        data : param,
	        type : 'POST',
	        dataType : 'json',
	        async: false,
	        success : function(data) {
				result = data.returnMsg;
				if (result == "SUCCESS") {
					openAlertModal( "",data.resultMsg,function(){ $("#menu").submit(); } );  // index로 다시 이동
				}else{
					openAlertModal(data.resultMsg);
				}
	        },
	        error: function(e){
	        	openAlertModal("",e.responseText);
	        },
	        complete : function() {
	        }
		});
	});
	
	
	
  
	

}

function goDelete() {
	var node = $('#dynatree').dynatree("getActiveNode");
	
	if(!node) {
		alert('<spring:message code="msg.need.select.menu.text"/>');
		return;
	}
	
	// 상위 메뉴 삭제 금지...
	if(node.data.key == "0")
		return;
	
	if(node.data.isFolder)
		if(node.countChildren() > 0) { // 자식노드가 있는경우는 삭제금지.
			openAlertModal('<spring:message code="msg.need.select.submenu.text"/>');
			return;
		}

	openConfirmModal("", '<spring:message code="label.confirm.delete" />', function(){
		var param = new Object();
		param.menu_id = $("#menu_id").val();
		$.ajax({
	        url : "/atom/security/menu/deleteAction.ajax",
	        data : param,
	        type : 'POST',
	        dataType : 'json',
	        async: false,
	        success : function(data) {
				result = data.returnMsg;
				if (result == "SUCCESS") {
					$("#menu_id").val($("#up_menu_id").val());
					openAlertModal("",data.resultMsg,function(){ $("#menu").submit(); });  // index로 다시 이동
				}else{
					openAlertModal(data.resultMsg);
				}
	        },
	        error: function(e){
	        	openAlertModal("",e.responseText);
	        },
	        complete : function() {

	        }
		});
	
	
	
	});

}


</script>
					<form:form name="menu" commandName="menu" method="post" action="/atom/security/menu/index">
					<input type="hidden" id="menu_id" name="menu_id" value="${menu.menu_id}" />
					<input type="hidden" id="up_menu_id" name="up_menu_id" value="${menu.up_menu_id}" />
					<input type="hidden" id="depth" name="depth" value="${menu.depth}" />
					<input type="hidden" id="display_order" name="display_order" value="${menu.display_order}" />
					<input type="hidden" id="is_folder" name="is_folder" value="${menu.is_folder}" />
					<input type="hidden" id="menu_path" name="menu_path" value="${menu.menu_path}" />
					<input type="hidden" id="popup_yn" name="popup_yn" value="${menu.popup_yn}" />
					<input type="hidden" id="pkg_name" name="pkg_name" value="${menu.pkg_name}" />
					
					<header><spring:message code="label.security.menu.menu_properties.text"/></header>
		            <div class="detail">
		                <table class="tbl_detail register">
		                    <caption><spring:message code="label.security.menu.menu_properties.text"/></caption>
		                    <colgroup>
		                    <col width="50%"/>
		                    <col width="50%"/>
		                    </colgroup>
		                    <tr>
		                        <th colspan="2" scopt="col" class="imp"><spring:message code="label.security.menu.menu_type.text"/></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2">
		                            <input type="radio" id="is_folder_Y" name="is_folder_Y" value="Y" disabled/>
		                            <label for="c1"><spring:message code="label.security.menu.menu_group.text"/></label>
		                            <input type="radio" id="is_folder_N" name="is_folder_N" value="N" disabled/>
		                            <label for="c2"><spring:message code="label.security.menu.menu.text"/></label>
		                        </td>
		                    </tr>
		                    <tr>
		                        <th scopt="col" class="imp"><spring:message code="label.security.menu.menu_name.text"/></th>
		                        <th scopt="col">Link Path</th>
		                    </tr>
		                    <tr>
		                        <td><input type="text" id="menu_name" name="menu_name" value="${menu.menu_name}"  placeholder="<spring:message code="label.security.menu.menu_name.text"/>" /></td>
		                        <td><input type="text" id="tmp_menu_path" name="tmp_menu_path" value="${menu.menu_path}"  placeholder="<spring:message code="label.security.menu.link_path.text"/>" /></td>
		                    </tr>
		                    <tr>
		                        <th scopt="col"><spring:message code="label.security.menu.popup_flag.text"/></th>
		                        <th scopt="col"><spring:message code="label.security.menu.imgage_path.text"/></th>
		                    </tr>
		                    <tr>
		                        <td>
		                        	<span class="switch blue">
										<input id="c_popup_yn"  class="toggle toggle-round" type="checkbox">
										<label for="c_popup_yn"></label>
									</span>
									<span><spring:message code="label.security.menu.popup_flag_explanation.text"/></span>
		                        </td>
		                        <td><input type="text" id="img_path" name="img_path" value="${menu.img_path}" placeholder="<spring:message code="label.security.menu.imgage_path.text"/>" /></td>
		                    </tr>
		                    <tr>
		                        <th colspan="2" scopt="col"><spring:message code="label.security.menu.description.text"/></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2"><textarea id="description" name="description" placeholder="<spring:message code="label.security.menu.description.text"/>" rows="3" >${menu.description}</textarea></td>
		                    </tr>
		                </table>
		            </div>
		            <div class="btn_area">
		                <button type="button" id="btn_goDetail"><spring:message code="label.common.cancel"/></button>
		                <button type="button" id="btn_delete"><spring:message code="label.delete"/></button>
		                <button type="button" class="major" id="btn_update"><spring:message code="label.common.save"/></button>
		            </div>
</form:form>

