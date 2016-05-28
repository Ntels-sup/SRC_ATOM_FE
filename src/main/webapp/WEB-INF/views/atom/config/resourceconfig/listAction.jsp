<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {    	
	
  		$("#btn_cancel").click(function(){
  			fnCancel();
    	});

  		$("#btn_save").click(function(){
  			fnSave();
    	});
		
  		fnInit();
    });
    
  	//init function
    function fnInit(){
		
    }
  	
 	// resource config fnCancel
    function fnCancel(){
 		//resource group search
    	goSearchRscGrp("${searchVal.rscGrpId}");
 		//resource list search
    	goSearchRscList("${searchVal.rscGrpId}", "${searchVal.pkgName}", "${searchVal.nodeType}");
    }
    
  	//resource config fnSave
    function fnSave(){
    	var param = new Object();
    	
    	param.rsc_grp_id = $("#src_grp_id").val();
    	param.rsc_grp_use_yn = (($("#rsc_grp_use_yn").is(":checked") == true) ? "Y" : "N");
    	param.period = $("#period").val();
    	param.stat_period = $("#stat_period").val();
    	param.vnfm_send_yn = (($("#vnfm_send_yn").is(":checked") == true) ? "Y" : "N");
    	param.stat_yn = (($("#stat_yn").is(":checked") == true) ? "Y" : "N");
		param.rscConfigArr = fnRscVal();
		console.log(param);

 		$.ajax({
            url : "modifyAction",
            data : param,
            type : 'POST',
            dataType : 'json',
            success : function(data) {
            	openAlertModal("","<spring:message code="msg.common.saved" />",function(){
             		//resource group search
                	goSearchRscGrp("${searchVal.rscGrpId}");
             		//resource list search
                	goSearchRscList("${searchVal.rscGrpId}", "${searchVal.pkgName}", "${searchVal.nodeType}");
            	});
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {

            }
		});
    }

  	//resource config fnRscVal (저장할 resrouce config 데이터 값 셋팅)
  	function fnRscVal(){
  		var rscList = new Array();
  		
  		var rscTrObj = $("table.tbl_update tbody tr");
  		var rscLength = $("table.tbl_update tbody tr").length;

    	if($("table.tbl_update tbody > tr > td").html() == '<spring:message code="label.empty.list" />') {
    		rscLength = 0;
        }
    	
  		for(var i=0; i<rscLength; i++){
  			var resource = new Object();
  			
  			resource.pkg_name = $(rscTrObj).eq(i).find("input[name=pkg_name]").val();
  			resource.node_type = $(rscTrObj).eq(i).find("input[name=node_type]").val();
  			resource.rsc_id = $(rscTrObj).eq(i).find("input[name=prc_id]").val();
  			
  			if($(rscTrObj).eq(i).find("input[name=rsc_use_yn]").is(":checked")){
  				resource.rsc_use_yn = "Y";
  			} else {
  				resource.rsc_use_yn = "N";
  			}
  			
  			rscList.push(resource);
  		}
  		
  		return JSON.stringify(rscList);
  	}
  	
</script>  
 
	<div class="list type03">
		<table class="tbl_update">
			<colgroup>
				<col width="25%">
				<col width="25%">
				<col width="25%">
				<col width="*">
				<col width="10px">
			</colgroup>
			<thead>
				<tr>
					<th><spring:message code="label.conifg.resourcecoinfg.package.text" /></th>
					<th><spring:message code="label.conifg.resourcecoinfg.node_type.text" /></th>
					<th><spring:message code="label.conifg.resourcecoinfg.resource_name.text" /></th>
					<th><spring:message code="label.conifg.resourcecoinfg.use.text" /></th>
					<th></th>
				</tr>
			</thead>
		</table>
        
		<div class="scroll">
			<table class="tbl_update">
				<caption><spring:message code="label.conifg.resourcecoinfg.resource_list.text" /></caption>
				<colgroup>
					<col width="25%">
					<col width="25%">
					<col width="25%">
					<col width="25%">
				</colgroup>
				<tbody>
					<c:if test="${!empty rscConfigList}">
						<c:forEach items="${rscConfigList}" var="list" varStatus="status">
							<tr>
								<td><input type="hidden" id="pkg_name" name="pkg_name" value="${list.pkg_name}">${list.pkg_name}</td>
								<td><input type="hidden" id="node_type" name="node_type" value="${list.node_type}">${list.node_type}</td>
								<td>${list.rsc_name}</td>
								<td>
									<span class="switch blue">
										<input type="hidden" id="prc_id" name="prc_id" value="${list.rsc_id}">
										<input type="checkbox" class="toggle toggle-round" id="rsc_use_yn${status.count}" name="rsc_use_yn" <c:if test="${list.rsc_use_yn eq 'Y'}">checked</c:if>>
										<label for="rsc_use_yn${status.count}"></label>
									</span>
								</td>
							</tr>
						</c:forEach>
					</c:if>
							
			 		<c:if test="${empty rscConfigList}">
						<tr>
					    	<td class="t_c"colspan="4"><spring:message code="label.empty.list" /></td>
					    </tr>
			 		</c:if>
				</tbody>
			</table>
		</div>
	</div>
            
	<div class="cont_footer">
	    <div class="btn_area">
	        <button id="btn_cancel" type="button"><spring:message code="label.common.cancel.text" /></button>
	        <button id="btn_save" type="button" class="major"><spring:message code="label.common.save.text" /></button>
	    </div>
	</div>
	<!-- //cont_footer --> 