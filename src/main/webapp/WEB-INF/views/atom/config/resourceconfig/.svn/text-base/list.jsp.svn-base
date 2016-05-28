<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" charset="utf-8" src="/scripts/jquery.alphanumeric.js"></script>

<script type="text/javascript">
			
    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {	
    	// resource group select
		$("#stat_period").multipleSelect({
	        single: true,
	        selectAll: false,
            multiple: false
		});
    	
    	// resource group select
		$("#rscGrpId").multipleSelect({
	        single: true,
	        selectAll: false,
            multiple: false,
            onClick: function(view){
            	//resource group data 검색
            	goSearchRscGrp(view.value);
            }
		});
    	
    	//package select
		$("#pkgName").multipleSelect({
	        single: true,
	        selectAll: false,
            multiple: false,
            onClick: function(view){
            	//nodeType list 검색
            	getListNodeType(view.value);
            }
		});
    	
    	//node type select
		$("#nodeType").multipleSelect({
	        single: true,
	        selectAll: false,
            multiple: false,
            onClick: function(view){
            	var rscGrpId = $("#rscGrpId").multipleSelect('getSelects')[0];
            	var pkgName = $("#pkgName").multipleSelect('getSelects')[0];
            	
            	//Resource List 조회 (param -> 1: rscGrpId, 2: package, 3: node_type)
            	goSearchRscList(rscGrpId, pkgName, view.value);
            }
		});
    	
  		fnInit();
    });
    
    //init function
    function fnInit(){
    	//period 숫자만 입력하도록 셋팅
    	$("#period").numeric();
    	$("#stat_period").numeric();
    	
    	//최초 로드시 resource group 조회
		var rscGrpId = $("#rscGrpId").multipleSelect('getSelects');
		goSearchRscGrp(rscGrpId[0]);
		
		//최초 로드시 node type selectbox셋팅
		var pkgName = $("#pkgName").multipleSelect('getSelects');
		getListNodeType(pkgName[0]);
		
    }
        
    //resource config goSearchRscGrp (선택된 resource group 검색)
    function goSearchRscGrp(rscGrpId){
		var param = new Object();
		param.rscGrpId = rscGrpId;
		
		$.ajax({
            url : "goSearchRscGrp",
            data : param,
            type : 'POST',
            dataType : 'json',
            success : function(data) {
            	//src_grp_id 셋팅
            	$("#src_grp_id").val(data.rscGrpConfig.rsc_grp_id);
            	
				//use Resource Group 셋팅				
            	if(data.rscGrpConfig.rsc_grp_use_yn == "Y"){
            		$("#rsc_grp_use_yn").prop("checked",true);
            	}    
				
            	//monitoring period 셋잍
            	$("#period").val(data.rscGrpConfig.period);
            	
            	//statistics period 셋팅
            	$("#stat_period").multipleSelect('setSelects',[data.rscGrpConfig.stat_period]);
            	
				//send to VNFM 셋팅
            	if(data.rscGrpConfig.vnfm_send_yn == "Y"){
            		$("#vnfm_send_yn").prop("checked",true);
            	} else {
            		$("#vnfm_send_yn").prop("checked",false);
            	}
				
				//Coollect Staticstics 셋팅
            	if(data.rscGrpConfig.stat_yn == "Y"){
            		$("#stat_yn").prop("checked",true);
            	} else {
            		$("#stat_yn").prop("checked",false);
            	}
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {
            	//resource gorup selece box 변경호 최초  resourceConifg list 검색 
            	var pkgName = $("#pkgName").multipleSelect('getSelects')[0];
            	var nodeType = $("#nodeType").multipleSelect('getSelects')[0];
            	
            	goSearchRscList(rscGrpId, pkgName, nodeType);
            }
		});
    }
    
    //resource config getListNodeType (package 셀렉트박스 변경시 변경된  package의 node type들 가져온다) 
    function getListNodeType(pkgName){
    	var param = new Object();
    	param.pkgName = pkgName;
    	
    	$.ajax({
            url : "getListNodeType",
            data : param,
            type : 'POST',
            dataType : 'json',
            success : function(data) {
            	var array = data.listNodeType;
        		var optionTag;
        		
            	$("#nodeType").empty();
            	$("#nodeType").multipleSelect('refresh');
            	
        		$.each(array,function(index,appObj) {
        			optionTag = $('<option value="'+appObj.ID+'">'+appObj.NAME+'</option>');
        			$("#nodeType").append(optionTag).multipleSelect('refresh');
        		});
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {
            	//package selece box 변경호 최초 nodeType으로  resourceConifg list 검색 
            	var rscGrpId = $("#rscGrpId").multipleSelect('getSelects')[0];
            	var nodeType = $("#nodeType").multipleSelect('getSelects')[0];
            	
            	goSearchRscList(rscGrpId, pkgName, nodeType);
            }
		});
    }

    //resource config goSearchRsc (선택된 resource list 검색)
    function goSearchRscList(rscGrpId, pkgName, nodeType){
    	fnShowLoading();
    	
		var param = new Object();
		param.rscGrpId = rscGrpId;
		param.pkgName = pkgName;
		param.nodeType = nodeType;
		console.log(param);
		
		$.ajax({
            url : "goSearchRscList",
            data : param,
            type : 'POST',
            success : function(data) {
            	 $("#resourceConfigTable").html(data);
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {
				
            }
		});
    }
    
    //loading...
   	function fnShowLoading() {
		var loadImage = '<div class="scroll" id="loading"><div class="loading"><span class="loading-inner"></span></div></div>';
	
		$(".list.type03").children().remove();
		$(".list.type03").append(loadImage);
	}
        
</script>   

    <div class="content">
        <div class="cont_body">
	        <form id="myForm" name="myForm">
	        	<input type="hidden" id="src_grp_id" name="src_grp_id">
           	
				<header>
					<h3><spring:message code="label.conifg.resourcecoinfg.resource_group.text" /></h3>
					<div class="select_single">
						<select class="single type3" id="rscGrpId" name="rscGrpId">
							<c:forEach items="${listResourceGrp}" var="rscGrp" varStatus="status">
								<option value="${rscGrp.ID}">${rscGrp.NAME}</option>
							</c:forEach>
						</select>
					</div>
					<p><spring:message code="label.conifg.resourcecoinfg.resource_group_label.text" /></p>
				</header>
			
				<div class="detail">
					<table class="tbl_detail register">
						<caption><spring:message code="label.conifg.resourcecoinfg.resource_group.text" /></caption>
						<colgroup>
							<col width="20%"/>
							<col width="20%"/>
							<col width="20%"/>
							<col width="20%"/>
							<col width="20%"/>
						</colgroup>
	                    <tr>
	                        <th scope="col"><spring:message code="label.conifg.resourcecoinfg.use_resource_group.text" /></th>
							<th scope="col"><spring:message code="label.conifg.resourcecoinfg.monitoring_period.text" /></th>
	                        <th scope="col"><spring:message code="label.conifg.resourcecoinfg.statistics_period.text" /></th>
	                        <th scope="col"><spring:message code="label.conifg.resourcecoinfg.send_to_vnfm.text" /></th>
							<th scope="col"><spring:message code="label.conifg.resourcecoinfg.collect_statistics.text" /></th>
	                    </tr>
	                    <tr>
							<td>
								<span class="switch blue">
									<input type="checkbox" class="toggle toggle-round" id="rsc_grp_use_yn" name="rsc_grp_use_yn">
									<label for="rsc_grp_use_yn"></label>
								</span>
							</td>
							<td><input type="text" class="input_xs t_r" id="period" name="period" maxlength=6"><spring:message code="label.conifg.resourcecoinfg.secs.text" /></td>
							<td>
								<div class="select_single">
									<select class="single" id="stat_period" name="stat_period">
				                    	<c:forEach items="${listStatPeriod}" var="statPeriod" varStatus="status">
				                    		<option value="${statPeriod.ID}">${statPeriod.NAME}</option>
				                    	</c:forEach>
									</select>
								</div>
							</td>
							<td>
								<span class="switch blue">
									<input type="checkbox" class="toggle toggle-round" id="vnfm_send_yn" name="vnfm_send_yn">
									<label for="vnfm_send_yn"></label>
								</span>
							</td>
							<td>
								<span class="switch blue">
									<input type="checkbox" class="toggle toggle-round" id="stat_yn" name="stat_yn">
									<label for="stat_yn"></label>
								</span>
							</td>
	                    </tr>
					</table>
				</div>
			
				<header>
					 <h3><spring:message code="label.conifg.resourcecoinfg.resource_list.text" /></h3>
					 <p><spring:message code="label.conifg.resourcecoinfg.resource_list_label.text" /></p>
					 <div class="cont_top_right">
					 	<div class="select_single">
					 		<label><spring:message code="label.conifg.resourcecoinfg.package.text" /></label>
					 		<select class="single type3" id="pkgName" name="pkgName">
								<c:forEach items="${listPackage}" var="Package" varStatus="status">
									<option value="${Package.ID}">${Package.NAME}</option>
								</c:forEach>
					 		</select>
					 	</div>
					 	
					 	<div class="select_single">
					 		<label><spring:message code="label.conifg.resourcecoinfg.node_type.text" /></label>
					 		<select class="single type3" id="nodeType" name="nodeType"></select>
					 	</div>
					 </div>
				</header>
			
				<div id="resourceConfigTable">
					<div class="scroll" id="loading">
						<div class="loading"><span class="loading-inner"></span></div>
					</div>
				</div>
			</form>
		</div>
	</div>
