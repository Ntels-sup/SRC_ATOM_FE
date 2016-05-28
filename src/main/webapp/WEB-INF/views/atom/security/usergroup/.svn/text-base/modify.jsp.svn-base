<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" charset="utf-8" src="/scripts/stringUtil.js"></script>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
    	// multiple select start // 
		$("select.single").multipleSelect({
	        single: true,
	        selectAll: false,
            multiple: false
		});
		
		$("#btn_cancel").click(function(){
			fnCancel();
		});
		
		$("#btn_save").click(function(){
			fnModify();
		});
		
    	$("#addPkgBtn").click(function() {
    		fnAddPackage();
        });
		
    	fnInit();
    });
    
    //value setting
    function fnInit(){

    }
    
    //user Group Manage cancel
    function fnCancel(){
		$("#modifyForm").attr("action","/atom/security/usergroup/detail");
		$("#modifyForm").submit();
    }

    //user Group Manage update
 	function fnModify(){
    	//dupl pkg check value
 		var duplPkg = fnDuplChkPkg();
    	
    	if($("#group_name").val() == "" || $("#group_name").val() == null){
    		openAlertModal("","<spring:message code="msg.security.usergroup.check.user_group" />",function(){$("#group_name").focus();});
    		return;
    	} else if(!fnDuplChkGrpName()){
    		openAlertModal("","<spring:message code="msg.security.usergroup.check.dupl_group_name" />",function(){$("#group_name").focus();});  
    		return;
    	}
    	if(duplPkg != ""){
    		openAlertModal("","<spring:message code="msg.security.usergroup.check.dupl_package" />"+"  -  ( "+duplPkg+" )");
    		return;
    	}
    	
    	var param = new Object();
    	param = $("#modifyForm").serialize();

 		$.ajax({
            url : "modifyAction",
            data : param,
            type : 'POST',
            dataType : 'json',
            success : function(data) {
            	openAlertModal("","<spring:message code="msg.common.saved" />",function(){
            		$("#modifyForm").attr("action","/atom/security/usergroup/list");
            		$("#modifyForm").submit();
            	});
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {

            }
		});
 	}
    
    //user Group Manage fnAddPackage
	function fnAddPackage() {
		var rowIdx = $(".list table tbody tr").length;
		var insertRow = '<tr>'+ 
						'   <td class="no">'+(rowIdx+1)+'</td>'+
		                '	<td>'+
						'		<div class="select_single">'+ 
						'				<select class="single" id="pkg_name" name="pkg_name">'+
				        '            	<c:forEach items="${packageList}" var="Package" varStatus="status">'+
				        '            		<option value="${Package.ID}">${Package.NAME}</option>'+
				        '      			</c:forEach>'+
						'			</select>'+
						'		</div>'+
		                '	<td><input type="text" id="userGroupPkgDesc" name="userGroupPkgDesc" maxlength="128" placeholder="<spring:message code="label.security.usergroup.description.text" />" value="" /></td>'+
		                '   <td><button type="button" class="btn_row del" onClick="fnRmvPackage(this)"><span><spring:message code="label.common.delete.text" /></span></button></td>'+
		                '</tr>';
		
		//packageList Cnt까지만  행추가 가능 
   		if(rowIdx >= "${packageCnt}") {
   			openAlertModal("","<spring:message code="msg.security.usergroup.check.package" />");
   			return;
   		}
   		
		$(".list table tbody").append(insertRow);
		
		$("select.single").multipleSelect({
			single: true,
	        selectAll: false,
            multiple: false,
            position: "top"
            
		},"refresh");
    }

    //user Group Manage fnDuplChkGrpName
    function fnDuplChkGrpName(){
    	var returnVal = true;
    	
    	var param = new Object();
    	param.groupName = $("#group_name").val();
    	param.groupNo = $("#group_no").val();
		
 		$.ajax({
            url : "duplChkGrpName",
            data : param,
            type : 'POST',
            dataType : 'json',
            async: false,
            success : function(data) {
            	if(data.duplCnt > 0){
            		returnVal = false;
            	} 
            }           
		});
 		return returnVal;
    }
    
    //user Group Manage fnDuplChkPkg
    function fnDuplChkPkg(){
    	var returnVal = "";
    	var groupPkgLength = $("select[name=pkg_name]").size();

    	//duplication check
    	for(var i=0; i<groupPkgLength; i++){
    		for(var j=0; j<groupPkgLength; j++){
    			//같은 셀렉트 박스 check 제외
    			if(i != j){
	    			if($("select[name=pkg_name]").eq(i).val() == $("select[name=pkg_name]").eq(j).val()){
	    				returnVal = $("select[name=pkg_name]").eq(i).val();
	    			}
    			}
    		}
    	}
    	return returnVal;
    }
    
    //user Group Manage fnRmvPackage
    function fnRmvPackage(obj){
		$(obj).parent().parent().remove();
		updateRowNum();
   	}
    
    //user Group updateRowNum
    function updateRowNum() {
    	$("table.tbl_update tbody tr").each(function(index, obj) {
    		$(this).children("td").eq(0).text((index+1));
    	});
    }
        
</script>   

	<div class="content">
		<div class="cont_body">
		    <header><h3><spring:message code="label.security.usergroup.user_group.text" /></h3></header>
			<form id="modifyForm" name="modifyForm">
				<div class="detail">
	           		<!-- 수정시, detail 화면이동시 필요 -->
	            	<input type="hidden" id="group_no" name="group_no" value="${userGroup.group_no}">
	            	<!-- list 화면이동시 필요 -->
	            	<input type="hidden" id="groupNo" name="groupNo" value="${searchVal.groupNo}">
					
					<table class="tb1_detail register">
						<caption><spring:message code="label.security.usergroup.user_group.text" /></caption>
						<colgroup>
							<col width="30%" />
							<col width="30%" />
							<col width="30%" />
						</colgroup>
						<tr>
							<th scope="col" class="imp"><spring:message code="label.security.usergroup.user_group.text" /></th>
							<th colspan="2" scope="col"><spring:message code="label.security.usergroup.description.text" /></th>
						</tr>
						<tr>
							<td><input type="text" id="group_name" name="group_name" maxlength="15" placeholder="<spring:message code="label.security.usergroup.user_group.text" />" value="${userGroup.group_name}" /></td>
							<td colspan="2"><input type="text" id="userGroupDesc" name="userGroupDesc" maxlength="128" placeholder="<spring:message code="label.security.usergroup.description.text" />" value="${userGroup.description}" /></td>
						</tr>
					</table>
				</div>
				<!-- //detail -->
			
				<header>
					<h3><spring:message code="label.security.usergroup.related_package.text" /></h3>
					<span class="btn_area">
						<button id="addPkgBtn" type="button" class="btn_row add"><span><spring:message code="label.security.usergroup.row_add.text" /></span></button>
					</span>
				</header>
				<div class="list">
					<table class="tbl_update">
						<caption><spring:message code="label.security.usergroup.related_package.text" /></caption>
						<colgroup>
							<col>
							<col width="25%" />
							<col width="50%" />
							<col>
						</colgroup>
						<thead>
							<tr>
								<th class="no"><spring:message code="label.security.usergroup.sequence.text" /></th>
								<th><spring:message code="label.security.usergroup.package.text" /></th>
								<th><spring:message code="label.security.usergroup.description.text" /></th>
								<th class="ico"></th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${!empty userGroupPkgList}">
								<c:forEach items="${userGroupPkgList}" var="list" varStatus="status">
									<tr>
										<td class="no">${list.rownum}</td>
										<td>
											<div class="select_single">
												<select class="single" id="pkg_name" name="pkg_name">
							                    	<c:forEach items="${packageList}" var="Package" varStatus="status">
							                    		<option value="${Package.ID}" <c:if test="${Package.NAME eq list.pkg_name}">selected="selected"</c:if>>${Package.NAME}</option>
							                    	</c:forEach>
												</select>
											</div>
										</td>
										<td><input type="text" id="userGroupPkgDesc" name="userGroupPkgDesc" maxlength="128" placeholder="<spring:message code="label.security.usergroup.description.text" />" value="${list.description}" /></td>
										<td><button type="button" class="btn_row del" onClick="fnRmvPackage(this)"><span><spring:message code="label.common.delete.text" /></span></button></td>						
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
                <button id="btn_save" type="button" class="major"><spring:message code="label.common.save.text" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 