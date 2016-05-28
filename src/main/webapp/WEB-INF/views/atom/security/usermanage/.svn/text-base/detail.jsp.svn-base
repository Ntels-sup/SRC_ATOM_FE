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
  		
  		fnInit();
    });
    
  	//value setting
  	function fnInit(){
  		//login type 셋팅
  		if(parseInt("${userManage.login_type}") > 1){
  			$("input[name=loginType][id=multi]").prop("checked",true);
  			$("#login_type_count").show();
  		} else {
  			$("input[name=loginType][id=single]").prop("checked",true);
	  		$("#login_type_count").hide();
  		}
  		
  		//radio 버튼 체크 (status) 
  		$("input[name=status][value=${userManage.status}]").prop("checked",true);
  	}
    
    //user manage goList
    function goList(){
    	$("#detailForm").attr("action","/atom/security/usermanage/list");
		$("#detailForm").submit();
    }
    
    //user manage remove
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
    
    //user manage goModify
 	function goModify(){
		$("#detailForm").attr("action","/atom/security/usermanage/modify");
		$("#detailForm").submit();
 	}
	
</script>   

    <div class="content">
		<!-- cont_body -->
		<div class="cont_body">
			<div class="detail">
            	<form id="detailForm" name="detailForm">
            		<!-- modify 화면이동시 필요 -->
	            	<input type="hidden" id="user_id" name="user_id" value="${userManage.user_id}">
	            	<!-- list 화면이동시 필요 -->
	            	<input type="hidden" id="groupNo" name="groupNo" value="${searchVal.groupNo}">

	                <table class="tbl_detail">
	                	<caption>User Manager</caption>
	                    <colgroup>
		                    <col width="20%"/>
		                    <col width="20%"/>
		                    <col width="20%"/>
		                    <col width="20%"/>
	                    </colgroup>
	                    <tr>
	                        <th scope="col"><spring:message code="label.security.usermanage.user_id.text" /></th>
	                        <th scope="col"><spring:message code="label.security.usermanage.user_group.text" /></th>
	                        <th scope="col"><spring:message code="label.security.usermanage.user_level.text" /></th>
	                        <th scope="col"></th>
	                    </tr>
	                    <tr>
	                        <td>${userManage.user_id}</td>
	                        <td>${userManage.group_name}</td>
	                        <td>${userManage.level_name}</td>
	                        <td></td>
	                    </tr>
	                    <tr>
	                    	<th scope="col"><spring:message code="label.security.usermanage.user_name.text" /></th>
	                        <th scope="col"><spring:message code="label.security.usermanage.employee_no.text" /></th>
	                        <th scope="col"><spring:message code="label.security.usermanage.phone_number.text" /></th>
	                        <th scope="col"><spring:message code="label.security.usermanage.email.text" /></th>
	                    </tr>
	                    <tr>
	                    	<td>${userManage.user_name}</td>
	                        <td>${userManage.emp_no}</td>
	                        <td>${userManage.user_phone}</td>
	                        <td>${userManage.user_email}</td>
	                    </tr>
	                    <!-- userLevel = 1 인 유저만 view  -->
	                    <c:if test="${userLevelId eq 1}">
		                    <tr>
		                        <th colspan="2" scope="col"><spring:message code="label.security.usermanage.login_type.text" /></th>
		                        <th scope="col"><spring:message code="label.security.usermanage.user_account_expiration.text" /></th>
		                        <th scope="col"><spring:message code="label.security.usermanage.password_expiration.text" /></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2">
		                            <input type="radio" id="single" name="loginType" disabled/>
		                            <label for="single"><spring:message code="label.security.usermanage.single.text" /></label>
		                            <input type="radio" id="multi" name="loginType" disabled/>
		                            <label for="multi"><spring:message code="label.security.usermanage.multiple.text" /></label>
		                            <span id="login_type_count"><spring:message code="label.security.usermanage.count.text" />${userManage.login_type}</span>
		                        </td>
		                        <td>${userManage.account_exfire}</td>
		                        <td>${userManage.passwd_exfire}</td>
		                    </tr>
		                    <tr>
		                        <th colspan="2" scope="col"><spring:message code="label.security.usermanage.login_status.text" /></th>
		                        <th colspan="2" scope="col"><spring:message code="label.security.usermanage.status_reason.text" /></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2">
		                            <input type="radio" id="enalbe" name="status" value="Y" disabled/>
		                            <label for="enalbe"><spring:message code="label.security.usermanage.enable.text" /></label>
		                            <input type="radio" id="disable" name="status" value="N" disabled/>
		                            <label for="disable"><spring:message code="label.security.usermanage.disable.text" /></label>
		                            <input type="radio" id="locked" name="status" value="L" disabled/>
		                            <label for="locked"><spring:message code="label.security.usermanage.locked.text" /></label>
		                        </td>
		                        <td colspan="2">${userManage.status_reason}</td>
		                    </tr>
	                    </c:if>
	                    <!-- //userLevel = 1 인 유저만 view -->
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