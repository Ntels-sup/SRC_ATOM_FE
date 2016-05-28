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
    
    //ip Manage goList
    function goList(){
    	$("#detailForm").attr("action","/atom/security/ipmanage/list");
		$("#detailForm").submit();
    }
    
    //ip Manage remove
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
	            	openAlertModal(e.responseText);
	            },
	            complete : function() {
	
	            }
			});
    	});
    }
    	
    //ip Manage goModify
 	function goModify(){
		$("#detailForm").attr("action","/atom/security/ipmanage/modify");
		$("#detailForm").submit();
 	}
	
</script>   

    <div class="content">
		<!-- cont_body -->
		<div class="cont_body">
			<div class="detail">
            	<form id="detailForm" name="detailForm">
            		<!-- modify 화면이동시 필요 -->
	            	<input type="hidden" id="ip_manager_no" name="ip_manager_no" value="${ipManage.ip_manager_no}">
	            	<!-- list 화면이동시 필요 -->
	            	<input type="hidden" id="searchAllowYn" name="searchAllowYn" value="${searchVal.searchAllowYn}">
	            	<input type="hidden" id="searchIp" name="searchIp" value="${searchVal.searchIp}">

	                <table class="tbl_detail">
	                	<caption><spring:message code="label.conifg.nodemanagement.title.text" /></caption>
	                    <colgroup>
		                    <col width="25%"/>
		                    <col width="25%"/>
		                    <col width="25%"/>
	                    </colgroup>
	                    <tr>
	                        <th scope="col"><spring:message code="label.security.ipmanage.ip_address.text" /></th>
	                        <th scope="col"><spring:message code="label.security.ipmanage.login_allowance.text" /></th>
	                        <th scope="col"><spring:message code="label.security.ipmanage.sessions.text" /></th>
	                    </tr>
	                    <tr>
	                        <td>${ipManage.ip}</td>
	                        <td>${ipManage.allow_name}</td>
	                        <td>${ipManage.max_simult}</td>
	                    </tr>
	                    <tr>
	                        <th scope="col" colspan="3"><spring:message code="label.security.ipmanage.description.text" /></th>
	                    </tr>
	                    <tr>
	                        <td colspan="3">${ipManage.description}</td>
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