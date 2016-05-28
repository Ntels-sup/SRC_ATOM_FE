<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" charset="utf-8" src="/scripts/stringUtil.js"></script>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
  		$("#btn_list").click(function(){
  			goList();
  		});
  		
  		$("#btn_del").click(function(){
  			fnRemove();
  		});
  		
  		$("#btn_mod").click(function(){
  			goModify();
  		});
    });
    
    //user group Manage goList
    function goList(){
    	$("#detailForm").attr("action","/atom/security/usergroup/list");
		$("#detailForm").submit();
    }
    
    //user group Manage remove
    function fnRemove(){
    	//삭제시 해당 usergroup에 속한 user가 있으면 return
    	if("${userGroupUseCnt}" > 0){
    		openAlertModal("","<spring:message code="msg.security.usergroup.check.remove_user_group" />");
    		return;
    	}
    	
    	openConfirmModal("", "<spring:message code="msg.common.delete" />", function(){
	    	var param = new Object();
	    	param = $("#detailForm").serialize();
	
			$.ajax({
	            url : "removeAction",
	            data : param,
	            type : 'POST',
	            dataType : 'json',
	            success : function(data) {
	            	openAlertModal("","<spring:message code="msg.common.deleted" />",goList);
	            },
	            error: function(e){
	            	openAlertModal(e.responseText);
	            },
	            complete : function() {
	
	            }
			});
    	});
    }
    
    //user group Manage goModify
 	function goModify(){
		$("#detailForm").attr("action","/atom/security/usergroup/modify");
		$("#detailForm").submit();
 	}
    
</script>   

	<div class="content">
		<div class="cont_body">
		    <header><h3><spring:message code="label.security.usergroup.user_group.text" /></h3></header>
			<form id="detailForm" name="detailForm">
				<div class="detail">
	           		<!-- modify 화면이동시 필요 -->
	            	<input type="hidden" id="group_no" name="group_no" value="${userGroup.group_no}">
	            	<!-- list 화면이동시 필요 -->
	            	<input type="hidden" id="groupNo" name="groupNo" value="${searchVal.groupNo}">
					
					<table class="tb1_detail">
						<caption><spring:message code="label.security.usergroup.user_group.text" /></caption>
						<colgroup>
							<col width="30%" />
							<col width="30%" />
							<col width="30%" />
						</colgroup>
						<tr>
							<th scope="col"><spring:message code="label.security.usergroup.user_group.text" /></th>
							<th colspan="2" scope="col"><spring:message code="label.security.usergroup.description.text" /></th>
						</tr>
						<tr>
							<td>${userGroup.group_name}</td>
							<td colspan="2">${userGroup.description}</td>
						</tr>
					</table>
				</div>
				<!-- //detail -->
			
				<header><h3><spring:message code="label.security.usergroup.related_package.text" /></h3></header>
				<div class="list">
					<table>
						<caption><spring:message code="label.security.usergroup.related_package.text" /></caption>
						<colgroup>
							<col>
							<col width="25%" />
							<col width="50%" />
						</colgroup>
						<thead>
							<tr>
								<th class="no"><spring:message code="label.security.usergroup.sequence.text" /></th>
								<th><spring:message code="label.security.usergroup.package.text" /></th>
								<th><spring:message code="label.security.usergroup.description.text" /></th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${!empty userGroupPkgList}">
								<c:forEach items="${userGroupPkgList}" var="list" varStatus="status">
									<tr>
										<td class="no">${list.rownum}</td>
										<td>${list.pkg_name}</td>
										<td>${list.description}</td>							
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
            	<button id="btn_list" type="button"><spring:message code="label.common.list.text" /></button>
            	<ntels:auth auth="${authType}">
                <button id="btn_del" type="button"><spring:message code="label.common.delete.text" /></button>
                <button id="btn_mod" type="button"><spring:message code="label.common.update.text" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 