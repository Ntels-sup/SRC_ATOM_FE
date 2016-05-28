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
  			fnRemove();
  		});
  		
  		$("#btn_mod").click(function(){
  			goModify();
  		});
    });
    
    //node Management goList
    function goList(){
    	$("#detailForm").attr("action","/atom/config/nodemanagement/list");
		$("#detailForm").submit();
    }
    
    //node Management remove
    function fnRemove(){
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
	            	openAlertModal("",e.responseText);
	            },
	            complete : function() {
	
	            }
			});
    	});
    }
    
    //node Management goModify
 	function goModify(){
		$("#detailForm").attr("action","/atom/config/nodemanagement/modify");
		$("#detailForm").submit();
 	}
	
</script>   

    <div class="content">
		<!-- cont_body -->
		<div class="cont_body">
			<div class="detail">
            	<form id="detailForm" name="detailForm">
            		<!-- modify 화면이동시 필요 -->
	            	<input type="hidden" id="node_no" name="node_no" value="${nodeManagement.node_no}" />
	            	<input type="hidden" id="pkg_name" name="pkg_name" value="${nodeManagement.pkg_name}" />
	            	<!-- list 화면이동시 필요 -->
	            	<input type="hidden" id="pkgName" name="pkgName" value="${searchVal.pkgName}" />
	            	<input type="hidden" id="searchType" name="searchType" value="${searchVal.searchType}" />
	            	<input type="hidden" id="searchText" name="searchText" value="${searchVal.searchText}" />

	                <table class="tbl_detail">
	                	<caption><spring:message code="label.conifg.nodemanagement.title.text" /></caption>
	                    <colgroup>
		                    <col width="25%"/>
		                    <col width="25%"/>
		                    <col width="25%"/>
		                    <col width="25%"/>
	                    </colgroup>
	                    <tr>
	                        <th scope="col"><spring:message code="label.conifg.nodemanagement.node_name.text" /></th>
	                        <th scope="col"><spring:message code="label.conifg.nodemanagement.package.text" /></th>
	                        <th scope="col" colspan="2"><spring:message code="label.conifg.nodemanagement.ip_address.text" /></th>
	                    </tr>
	                    <tr>
	                        <td>${nodeManagement.node_name}</td>
	                        <td>${nodeManagement.pkg_name}</td>
	                        <td colspan="2">${nodeManagement.ip}</td>
	                    </tr>
                    	<tr>
	                        <th scope="col"><spring:message code="label.conifg.nodemanagement.node_group.text" /></th>
	                        <th scope="col"><spring:message code="label.conifg.nodemanagement.node_type.text" /></th>
	                        <th scope="col"><spring:message code="label.conifg.nodemanagement.internal_node.text" /></th>
	                        <th scope="col"><spring:message code="label.conifg.nodemanagement.use.text" /></th>
	                    </tr>
	                    <tr>
	                        <td>${nodeManagement.node_grp_name}</td>
	                        <td>${nodeManagement.node_type}</td>
	                        <td>
								<div class="common swch">
									<span class="switch normal">
										<input id="internal_yn" name="internal_yn" class="toggle toggle-round" type="checkbox"<c:if test="${nodeManagement.internal_yn eq 'Y'}">checked</c:if> disabled>
										<label for="internal_yn"></label>
									</span>
								</div>
							</td>
	                        <td>
								<div class="common swch">
									<span class="switch normal">
										<input id="use_yn" name="use_yn" class="toggle toggle-round" type="checkbox" <c:if test="${nodeManagement.use_yn eq 'Y'}">checked</c:if> disabled>
										<label for="use_yn"></label>
									</span>
								</div>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th scope="col" colspan="4"><spring:message code="label.conifg.nodemanagement.description.text" /></th>
	                    </tr>
	                    <tr>
	                        <td colspan="4">${nodeManagement.description}</td>
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
                <button id="btn_del" type="button"><spring:message code="label.common.delete.text" /></button>
                <button id="btn_mod" type="button"><spring:message code="label.common.update.text" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 