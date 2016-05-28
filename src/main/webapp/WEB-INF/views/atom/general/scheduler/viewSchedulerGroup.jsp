<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
  		$("#btn_list").click(function(){
  			goList();
  		});
  		
  		$("#btn_del").click(function(){
  			openConfirmModal("<spring:message code='label.confirm.delete'/>", "", function() {
  				fnRemove();
			});
  		});
  		
  		$("#btn_mod").click(function(){
  			goModify();
  		});
  		
  		fnInit();
    });
    
  	//value setting
  	function fnInit(){
  		//login type 셋팅
//   		if(parseInt("${userManage.login_type}") > 1){
//   			$("input[name=loginType][id=multi]").prop("checked",true);
//   			$("#login_type_count").show();
//   		} else {
//   			$("input[name=loginType][id=single]").prop("checked",true);
// 	  		$("#login_type_count").hide();
//   		}
  		
  		//radio 버튼 체크 (status) 
  		$("input[name=status][value=${schedulerGroup.schedule_cycle_type}]").prop("checked",true);
  	}
    
    //user manage goList
    function goList(){
    	$("#detailForm").attr("action","/atom/general/scheduler/list");
		$("#detailForm").submit();
    }
    
    //user manage remove
    function fnRemove(){
    	
    	var param = new Object();
    	param = $("#detailForm").serialize();

		$.ajax({
            url : "deleteSchedulerGroupAction",
            data : param,
            type : 'POST',
            dataType : 'json',
            success : function(data) {
            	goList();
            },
            error: function(e){
            	openAlertModal(e.responseText);
            },
            complete : function() {

            }
		});
    }
    
    //user manage goModify
 	function goModify(){
		$("#detailForm").attr("action","/atom/general/scheduler/updateSchedulerGroup");
		$("#detailForm").submit();
 	}
	
</script>   

    <div class="content">
		<!-- cont_body -->
		<div class="cont_body">
			<div class="detail">
            	<form id="detailForm" name="detailForm">
            		<!-- modify 화면이동시 필요 -->
	            	<input type="hidden" id="pkg_name" name="pkg_name" value="${schedulerGroup.pkg_name}">
	            	<!-- list 화면이동시 필요 -->
	            	<input type="hidden" id="group_name" name="group_name" value="${schedulerGroup.group_name}">

	                <table class="tbl_detail">
	                	<caption>Batch Group</caption>
	                    <colgroup>
		                    <col width="20%"/>
		                    <col width="20%"/>
		                    <col width="20%"/>
		                    <col width="20%"/>
	                    </colgroup>
	                    <tr>
	                        <th scope="col"><spring:message code="label.general.systeminformation.package.text" /></th>
	                        <th scope="col"><spring:message code="label.pfnm.batch.batch_group.text" /></th>
	                        <th scope="col">Start Date</th>
	                        <th scope="col">End Date</th>
	                    </tr>
	                    <tr>
	                        <td>${schedulerGroup.pkg_name}</td>
	                        <td>${schedulerGroup.group_name}</td>
	                        <td>${schedulerGroup.start_date}</td>
	                        <td>${schedulerGroup.expire_date}</td>
	                    </tr>
	                    <tr>
	                    	<th scope="col" colspan="2">
	                        	<spring:message code="label.resource.statistics.cycle.text" />
	                        	<spring:message code="label.configuration.networkmanager.type.text" /> 
	                        </th>
	                        <th scope="col"><spring:message code="label.resource.statistics.cycle.text" /></th>
	                        <th scope="col"><spring:message code="label.configuration.networkmanager.use.text" /></th>
	                    </tr>
	                    <tr>
	                    	<td colspan="2">
								<c:forEach items="${cycleType}" var="cycleModel" varStatus="status">
		                            <input type="radio" id="${cycleModel.NAME}" name="status" value="${cycleModel.ID}" disabled/>
		                            <label for="enalbe">${cycleModel.NAME}</label>
	                            </c:forEach>
							</td>
	                        <td>
	                        	<c:if test="${schedulerGroup.schedule_cycle_type != '01'}">${schedulerGroup.schedule_cycle}</c:if>
	                        	<c:forEach items="${cycleType}" var="cycleModel" varStatus="status">
		                            <c:if test="${cycleModel.ID eq schedulerGroup.schedule_cycle_type}">${cycleModel.NAME}</c:if>
	                            </c:forEach>
	                        </td>
	                        <td>${schedulerGroup.use_yn_nm}</td>
	                    </tr>
	                    <tr>
	                    	<th scope="col" colspan="4">Description</th>
	                    </tr>
	                    <tr>
	                    	<td colspan="4">${schedulerGroup.description}</td>
	                    </tr>
	                </table>
				</form>
            </div>
        </div>
		<!-- //cont_body -->
		
        <div class="cont_footer">
            <div class="btn_area">
            	<button id="btn_list" type="button"><spring:message code="label.common.list.text" /></button>
            	<ntels:auth auth="${authType}">
                <button id="btn_mod" type="button"><spring:message code="label.common.update.text" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 