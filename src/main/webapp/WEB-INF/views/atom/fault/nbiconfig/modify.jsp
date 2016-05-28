<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" charset="utf-8" src="/scripts/stringUtil.js"></script>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
    	
        $("#btn_cancel").click(function() {
        	fnCancel();
        });
        
        $("#btn_save").click(function() {
            fnSave();
        });
        
    	$("#addTrapIpBtn").click(function() {
    		fnAddTrapIp();
        });
    	
    	$("#rmvTrapIpChk").click(function() {
    		fnRmvTrapIpChk();
        });
    });
    
    //nbi config cancel
    function fnCancel(){
    	$("#modifyForm").attr("action", "/atom/fault/nbiconfig/list");
        $("#modifyForm").submit();   
    }
    
    //nbi config sava
    function fnSave(){
        if($("#trap_version").val() == "" || $("#trap_version").val() == null) {
        	openAlertModal("","<spring:message code="msg.snmptrap.config.common.need.trap_verion" />",function(){$("#trap_version").focus();});
        	return;
        }
        if($("#agent_hostname").val() == "" || $("#agent_hostname").val() == null) {
        	openAlertModal("","<spring:message code="msg.snmptrap.config.common.need.agent_host_name" />",function(){$("#agent_hostname").focus();});
        	return;
        } 
        else if(agent_hostname.length > 31) {
        	openAlertModal("","<spring:message code="msg.snmptrap.config.common.need.agent_host_name_length" />",function(){$("#agent_hostname").focus();});
        	return;
        }
        if($("#agent_ip").val() == "" || $("#agent_ip").val() == null) {
        	openAlertModal("","<spring:message code="msg.snmptrap.config.common.need.agent_ip" />",function(){$("#agent_ip").focus();});
        	return;
        }
        else if(!isValidIpAddress($("#agent_ip").val())) {
        	openAlertModal("","<spring:message code="msg.snmptrap.config.common.need.agent_ip_check" />",function(){$("#agent_ip").focus();});
            return;
        }
        if($("#trap_proc").val() == "" || $("#trap_proc").val() == null) {
        	openAlertModal("","<spring:message code="msg.snmptrap.config.common.need.trap_process" />",function(){$("#trap_proc").focus();});
        	return;
        }
        if(!fnValChkTrapIp()){
        	return;
        }
        
        openConfirmModal("", "<spring:message code="msg.common.save" />", function(){
        	var param = new Object();
        	param = $("#modifyForm").serialize();
    		
            $.ajax({
                url : "modifyAction",
                type : 'POST',
                dataType : 'json',
                data : param,
                success : function(data) {
                	openAlertModal("","<spring:message code="msg.common.saved" />",function(){
                		$("#modifyForm").attr("action", "/atom/fault/nbiconfig/list");
                        $("#modifyForm").submit();
                	});
                },
                error: function(e){
                	openAlertModal("",e.responseText);
                },
                complete : function() {
                	
                }
            });
        });
    }

    //nbi config fnValChkTrapIp
    function fnValChkTrapIp() {
    	var valChk = true;
    	var trapIpLength = $(".list table tbody tr").length;
    	
    	for(var i=0; i<trapIpLength; i++){
    		if($(".list table tbody tr").eq(i).find("input[name=ip]").val() == "" || $(".list table tbody tr").eq(i).find("input[name=ip]").val() == null){
				openAlertModal("","<spring:message code="msg.snmptrap.config.common.need.ip" />",function(){$(".list table tbody tr").eq(i).find("input[name=ip]").focus();});
				valChk = false;
				return false;
    		} else if(!isValidIpAddress($(".list table tbody tr").eq(i).find("input[name=ip]").val())){
   				openAlertModal("","<spring:message code="msg.snmptrap.config.common.need.ip_check" />",function(){$(".list table tbody tr").eq(i).find("input[name=ip]").focus();});
   				valChk = false;
   				return false;
    		}
    		if($(".list table tbody tr").eq(i).find("input[name=port]").val() == "" || $(".list table tbody tr").eq(i).find("input[name=port]").val() == null){
    			openAlertModal("","<spring:message code="msg.snmptrap.config.common.need.port" />",function(){$(".list table tbody tr").eq(i).find("input[name=port]").focus();});
    			valChk = false;
    			return false;
    		} else if(!$.isNumeric($(".list table tbody tr").eq(i).find("input[name=port]").val())){
    			openAlertModal("","<spring:message code="msg.snmptrap.config.common.need.port" />",function(){$(".list table tbody tr").eq(i).find("input[name=port]").focus();});
    			valChk = false;
    			return false;
    		}
    		if($(".list table tbody tr").eq(i).find("input[name=community]").val() == "" || $(".list table tbody tr").eq(i).find("input[name=community]").val() == null){
    			openAlertModal("","<spring:message code="msg.snmptrap.config.common.need.community" />",function(){$(".list table tbody tr").eq(i).find("input[name=community]").focus();});
    			valChk = false;
    			return false;
    		}
    		if($(".list table tbody tr").eq(i).find("input[name=host_name]").val() == "" || $(".list table tbody tr").eq(i).find("input[name=host_name]").val() == null){
    			openAlertModal("","<spring:message code="msg.snmptrap.config.common.need.host_name" />",function(){$(".list table tbody tr").eq(i).find("input[name=host_name]").val().focus();});
    			valChk = false;
    			return false;
    		}
    	}
  		return valChk;
	}
    
    //nbi config fnAddTrapIp
	function fnAddTrapIp() {
		var rowIdx = $(".list table tbody tr").length;
		var insertRow = "<tr>"+ 
						"   <td class=\"chk\"><input type=\"checkbox\" id=\"check"+rowIdx+"\" name=\"chk\"><label for=\"check"+rowIdx+"\">check</label></td>"+
		                "	<td><input type=\"text\" id=\"ip\" name=\"ip\" maxlength=\"40\" placeholder=\"<spring:message code='label.snmptrap.config.list.trap_ip_title.text' />\" value=\"\" /></td>"+
		                "	<td><input type=\"text\" id=\"port\" name=\"port\" maxlength=\"5\" placeholder=\"<spring:message code='label.snmptrap.config.list.port.text' />\" value=\"\" /></td>"+
		                "	<td><input type=\"text\" id=\"community\" name=\"community\" maxlength=\"64\" placeholder=\"<spring:message code='label.snmptrap.config.list.community.text' />\" value=\"\" /></td>"+
		                "	<td><input type=\"text\" id=\"host_name\" name=\"host_name\" maxlength=\"128\" placeholder=\"<spring:message code='label.snmptrap.config.list.host_name.text' />\" value=\"\" /></td>"+
		                "	<td><input type=\"text\" id=\"description\" name=\"description\" maxlength=\"50\" placeholder=\"<spring:message code='label.snmptrap.config.list.description.text' />\" value=\"\" /></td>"+
		                "   <td><button type=\"button\" class=\"btn_row del\" onClick=\"fnDelTrapIp(this)\"><span><spring:message code='label.common.delete.text' /></span></button></td>"+
		                "</tr>";
		
		                
		if ("${trapIpCount}" >= 10) {
			openAlertModal("","<spring:message code="msg.snmptrap.config.common.alert.registeredover" />");
			return;
		}

		if(rowIdx >= 10){
			openAlertModal("","<spring:message code="msg.snmptrap.config.common.alert.registeredover" />");
			return;
		}
              
		$(".list table tbody").append(insertRow);
    }
    
    //nbi config fnDelTrapIp
    function fnDelTrapIp(obj){
    	$(obj).parent().parent().remove();
   	}
    
    //nbi config fnRmvTrapIpChk
    function fnRmvTrapIpChk(){
    	var $obj = $("input[name='chk']");
    	var checkCount = $obj.size();
		
    	for(var i=0; i<checkCount; i++){
    		if($obj.eq(i).is(":checked")){
    			$obj.eq(i).parent().parent().remove();
    		}
    	}
    }
    	
</script>   

	<div class="content">
		<div class="cont_body">
			<header><h3><spring:message code="label.snmptrap.config.list.title.text" /></h3></header>
			<!-- 수정시 필요 -->
			<form id="modifyForm" name="modifyForm">
				<div class="detail">
					<input type="hidden" id="enterprise_oid" name="enterprise_oid" value="${trapConfig.enterprise_oid}" />
					
					<table class="tb1_detail register">
						<caption><spring:message code="label.snmptrap.config.list.title.text" /></caption>
						<colgroup>
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
						</colgroup>
						<tr>
							<th colspan="2" scope="col"><spring:message code="label.snmptrap.config.list.enterprise_oid.text" /></th>
							<th scope="col"><spring:message code="label.snmptrap.config.list.trap_version.text" /></th>
						</tr>
						<tr>
							<td colspan="2">${trapConfig.enterprise_oid}</td>
							<td><input type="text" id="trap_version" name="trap_version" maxlength="10" value="${trapConfig.trap_version}" /></td>
						</tr>
						<tr>
				            <th scope="col"><spring:message code="label.snmptrap.config.list.agent_host_name.text" /></th>
				            <th scope="col"><spring:message code="label.snmptrap.config.list.agent_ip.text" /></th>
				            <th scope="col"><spring:message code="label.snmptrap.config.list.trap_process.text" /></th>
						</tr>
						<tr>
							<td><input type="text" id="agent_hostname" name="agent_hostname" maxlength="31" value="${trapConfig.agent_hostname}" /></td>
							<td><input type="text" id="agent_ip" name="agent_ip" maxlength="40" value="${trapConfig.agent_ip}" /></td>
							<td><input type="text" id="trap_proc" name="trap_proc" maxlength="50" value="${trapConfig.trap_proc}" /></td>
						</tr>
					</table>
				</div>
			
				<header>
					<h3><spring:message code="label.snmptrap.config.list.trap_ip_title.text" /></h3>
					<span class="btn_area">
						<button type="button" class="btn_row add" id="addTrapIpBtn"><span><spring:message code="label.snmptrap.config.list.row_add.text" /></span></button>
						<button type="button" class="btn_row del_sel"  id="rmvTrapIpChk"><span><spring:message code="label.snmptrap.config.list.checked_del.text" /></span></button>
					</span>
				</header>
				<div class="list">
					<table class="tbl_update">
						<caption><spring:message code="label.snmptrap.config.list.trap_ip_title.text" /></caption>
						<colgroup>
							<col>
							<col width="*" />
							<col width="150px" />
							<col width="*" />
							<col width="*" />
							<col width="*" />
							<col>
						</colgroup>
						<thead>
							<tr>
								<th class="chk"></th>
								<th class="imp"><spring:message code="label.snmptrap.config.list.ip.text" /></th>
								<th><spring:message code="label.snmptrap.config.list.port.text" /></th>
								<th><spring:message code="label.snmptrap.config.list.community.text" /></th>
								<th><spring:message code="label.snmptrap.config.list.host_name.text" /></th>
								<th><spring:message code="label.snmptrap.config.list.description.text" /></th>
								<th class="ico"></th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${!empty trapIpList}">
							<c:forEach items="${trapIpList}" var="trapIp" varStatus="status">
								<tr>
									<td class="chk"><input type="checkbox" id="check${status.index}" name="chk"><label for="check${status.index}">check</label></td>
									<td><input type="hidden" name="ip" value="${trapIp.ip}" />${trapIp.ip}</td>
									<td><input type="text" id="port" name="port" maxlength="5" placeholder="<spring:message code="label.snmptrap.config.list.port.text" />" value="${trapIp.port}" /></td>
									<td><input type="text" id="community" name="community" maxlength="64" placeholder="<spring:message code="label.snmptrap.config.list.community.text" />" value="${trapIp.community}" /></td>
									<td><input type="text" id="host_name" name="host_name" maxlength="128" placeholder="<spring:message code="label.snmptrap.config.list.host_name.text" />" value="${trapIp.host_name}" /></td>
									<td><input type="text" id="description" name="description" maxlength="128" placeholder="<spring:message code="label.snmptrap.config.list.description.text" />" value="${trapIp.description}" /></td>
									<td><button type="button" class="btn_row del" onClick="fnDelTrapIp(this)"><span><spring:message code="label.common.delete.text" /></span></button></td>
								</tr>
							</c:forEach>
						</c:if>
						</tbody>
					</table>
				</div>
			</form>
		</div>
		<!-- //cont_body -->
		
        <div class="cont_footer">
            <div class="btn_area">
                <button id="btn_cancel" type="button"><spring:message code="label.common.cancel.text" /></button>
                <ntels:auth auth="${authType}">
                <button id="btn_save" type="button" class="major"><spring:message code="label.common.update.text" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 