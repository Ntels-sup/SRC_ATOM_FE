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
		    	
    	$("#internal_node").change(function(){
    		if($(this).prop("checked") == true){
    			$("#internal_yn").val("Y");
    		} else {
    			$("#internal_yn").val("N");
    		}
    	});
    	
    	$("#use").change(function(){
    		if($(this).prop("checked") == true){
    			$("#use_yn").val("Y");
    		} else {
    			$("#use_yn").val("N");
    		}
    	});
    	
		$("#btn_cancel").click(function(){
			fnCancel();
		});
				
		$("#btn_save").click(function(){
			fnModify();
		});

    	fnInit();
    });
    
    //value setting
    function fnInit(){
    	var tdObj = $("select[id=pkg_name]").parent();
    	var pkgOption = "";
    	
    	//package selectbox refresh
    	pkgOption = '<select class="single" id="pkg_name" name="pkg_name">';
		<c:forEach items="${listPackage}" var="Package" varStatus="status">
			pkgOption += '<option value="${Package.ID}">${Package.NAME}</option>';
		</c:forEach>
		pkgOption += '</select>';
		
     	$(tdObj).empty();
     	$(tdObj).append(pkgOption);
    	
    	$("select[id=pkg_name]").multipleSelect({
			single: true,
	        selectAll: false,
            multiple: false,
            onClick: function(view){
            	getListNodeType(view.value);
            } 
		},"refresh");
    	
    	$("#pkg_name").multipleSelect('setSelects',["${nodeManagement.pkg_name}"]);
    	$("#node_grp_id").multipleSelect('setSelects',["${nodeManagement.node_grp_id}"]);
    	$("#node_type").multipleSelect('setSelects',["${nodeManagement.node_type}"]);
    	
    	if("${nodeManagement.internal_yn}" == "Y"){
    		$("#internal_node").prop("checked",true);
    	}     	
    	if("${nodeManagement.use_yn}" == "Y"){
    		$("#use").prop("checked",true);
    	} 
    }
    
    //node Management cancel
    function fnCancel(){
		$("#modifyForm").attr("action","/atom/config/nodemanagement/detail");
		$("#modifyForm").submit();
    }
    
    //node Management update
 	function fnModify(){
    	if($.trim($("#node_name").val()) == "" || $("#node_name").val() == null){
    		openAlertModal("","<spring:message code="msg.config.nodemanagement.need.node_name" />",function(){$("#node_name").focus();});
    		return;
    	} else if(!fnDuplChkNodeName()){
    		openAlertModal("","<spring:message code="msg.config.nodemanagement.check.duplicate_node_name" />",function(){$("#node_name").focus();});
    		return;
    	}
    	if($.trim($("#ip").val()) == "" || $("#ip").val() == null){
    		openAlertModal("","<spring:message code="msg.config.nodemanagement.need.ip" />",function(){$("#ip").focus();});
    		return;
    	} else if(!isValidIpAddress($("#ip").val())){
    		openAlertModal("","<spring:message code="msg.config.nodemanagement.check.ip" />",function(){$("#ip").focus();});
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
	        		$("#modifyForm").attr("action","/atom/config/nodemanagement/list");
	        		$("#modifyForm").submit();
            	});
            },
            error: function(e){
                alert(e.reponseText);
                openAlertModal("",e.responseText);
            },
            complete : function() {

            }
		});
 	}

    //node Management getListNodeType (package 셀렉트박스 변경시 변경된  package의 node type들 가져온다) 
    function getListNodeType(pkgName){
    	var param = new Object();
    	param.pkg_name = pkgName;
    	
    	$.ajax({
            url : "getListNodeType",
            data : param,
            type : 'POST',
            dataType : 'json',
            success : function(data) {
            	var array = data.getListNodeType;
        		var optionTag;
        		
            	$("#node_type").empty();
            	$("#node_type").multipleSelect('refresh');
            	
        		$.each(array,function(index,appObj) {
        			optionTag = $('<option value="'+appObj.ID+'">'+appObj.NAME+'</option>');
        			$("#node_type").append(optionTag).multipleSelect('refresh');
        		});
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {

            }
		});
    }

 	//node name duplicate check
    function fnDuplChkNodeName(){
       	var returnVal = true;
       	
       	var param = new Object();
       	param.nodeName = $("#node_name").val();
       	param.nodeNo = $("#node_no").val();
       	
 		$.ajax({
            url : "duplChkNodeName",
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
 	
</script>   

    <div class="content">
		<!-- cont_body -->
		<div class="cont_body">
			<div class="detail">
				<form id="modifyForm" name="modifyForm">
					<!-- 수정시, detail 화면이동시 필요 -->
					<input type="hidden" id="node_no" name="node_no" value="${nodeManagement.node_no}">
	            	<!-- list 화면이동시 필요 -->
	            	<input type="hidden" id="pkgName" name="pkgName" value="${searchVal.pkgName}">
	            	<input type="hidden" id="searchType" name="searchType" value="${searchVal.searchType}">
	            	<input type="hidden" id="searchText" name="searchText" value="${searchVal.searchText}">
	
	                <table class="tbl_detail register">
						<caption><spring:message code="label.conifg.nodemanagement.title.text" /></caption>
	                    <colgroup>
		                    <col width="25%"/>
		                    <col width="25%"/>
		                    <col width="25%"/>
		                    <col width="25%"/>
	                    </colgroup>
	                    <tr>
	                        <th scope="col" class="imp"><spring:message code="label.conifg.nodemanagement.node_name.text" /></th>
	                        <th scope="col" class="imp"><spring:message code="label.conifg.nodemanagement.package.text" /></th>
	                        <th scope="col" colspan="2" class="imp"><spring:message code="label.conifg.nodemanagement.ip_address.text" /></th>
	                    </tr>
	                    <tr>
	                        <td><input type="text" id="node_name" name="node_name" value="${nodeManagement.node_name}" /></td>
	                        <td>
	                        	<select class="single" id="pkg_name" name="pkg_name">
									<c:forEach items="${listPackage}" var="Package" varStatus="status">
										<option value="${Package.ID}">${Package.NAME}</option>
									</c:forEach>
	                        	</select>
	                        </td>
	                        <td colspan="2"><input type="text" id="ip" name="ip" value="${nodeManagement.ip}" /></td>
	                    </tr>
                    	<tr>
	                        <th scope="col"><spring:message code="label.conifg.nodemanagement.node_group.text" /></th>
	                        <th scope="col"><spring:message code="label.conifg.nodemanagement.node_type.text" /></th>
	                        <th scope="col"><spring:message code="label.conifg.nodemanagement.internal_node.text" /></th>
	                        <th scope="col"><spring:message code="label.conifg.nodemanagement.use.text" /></th>
	                    </tr>
	                    <tr>
	                        <td>
	                        	<select class="single" id="node_grp_id" name="node_grp_id">
									<c:forEach items="${listNodeGrp}" var="nodeGrp" varStatus="status">
										<option value="${nodeGrp.ID}">${nodeGrp.NAME}</option>
									</c:forEach>
	                        	</select>
							</td>
	                        <td>
	                        	<select class="single" id="node_type" name="node_type">
									<c:forEach items="${listNodeType}" var="nodeType" varStatus="status">
										<option value="${nodeType.ID}">${nodeType.NAME}</option>
									</c:forEach>
	                        	</select>
	                        </td>
	                        <td>
								<div class="common swch">
									<span class="switch normal">
										<input type="hidden" id="internal_yn" name="internal_yn" value="${nodeManagement.internal_yn}" />
										<input type="checkbox" class="toggle toggle-round" id="internal_node" name="internal_node"  />
										<label for="internal_node"></label>
									</span>
								</div>
							</td>
	                        <td>
								<div class="common swch">
									<span class="switch normal">
										<input type="hidden" id="use_yn" name="use_yn" value="${nodeManagement.use_yn}" />
										<input type="checkbox" class="toggle toggle-round" id="use" name="use" />
										<label for="use"></label>
									</span>
								</div>
	                        </td>
	                    </tr>
	                    <tr>
	                         <th scope="col" colspan="4"><spring:message code="label.conifg.nodemanagement.description.text" /></th>
	                    </tr>
	                    <tr>
	                        <td colspan="4"><textarea id="description" name="description" rows="3">${nodeManagement.description}</textarea></td>
	                    </tr>
	                </table>
				</form>
            </div>
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