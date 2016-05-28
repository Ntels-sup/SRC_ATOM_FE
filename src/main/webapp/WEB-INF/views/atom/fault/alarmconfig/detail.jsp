<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
  		$("#btn_list").click(function(){
  			goList();
  		});
  		
  		$("#btn_mod").click(function(){
  			goModify();
  		});
    });
      	
    //alarm Config goList
    function goList(){
    	$("#detailForm").attr("action","/atom/fault/alarmconfig/list");
		$("#detailForm").submit();
    }
        
    //alarm Config goModify
 	function goModify(){
		$("#detailForm").attr("action","/atom/fault/alarmconfig/modify");
		$("#detailForm").submit();
 	}
	
</script>   

    <div class="content">
		<!-- cont_body -->
		<div class="cont_body">
			<div class="detail">
            	<form id="detailForm" name="detailForm">
            		<!-- modify 화면이동시 필요 -->
	            	<input type="hidden" id="code" name="code" value="${alarmConfig.code}">
	            	<input type="hidden" id="pkg_name" name="pkg_name" value="${alarmConfig.pkg_name}">
	            	<!-- list 화면이동시 필요 -->
	            	<input type="hidden" id="alarmType" name="alarmType" value="${searchVal.alarmType}">
	            	<input type="hidden" id="alarmGroup" name="alarmGroup" value="${searchVal.alarmGroup}">
	            	<input type="hidden" id="pkgName" name="pkgName" value="${searchVal.pkgName}">
	            	<input type="hidden" id="search_type" name="searchType" value="${searchVal.searchType}">
	            	<input type="hidden" id="search_type" name="searchText" value="${searchVal.searchText}">
	            	
	                <table class="tbl_detail">
	                	<caption><spring:message code="label.fault.alarmconfig.title.text" /></caption>
	                    <colgroup>
		                    <col width="20%"/>
		                    <col width="20%"/>
		                    <col width="20%"/>
		                    <col width="20%"/>
	                    </colgroup>
	                    <tr>
	                        <th scope="col"><spring:message code="label.fault.alarmconfig.alarm_code.text" /></th>
	                        <th scope="col"><spring:message code="label.fault.alarmconfig.probable_cause.text" /></th>
	                        <th scope="col"><spring:message code="label.fault.alarmconfig.alarm_group.text" /></th>
	                        <th scope="col"><spring:message code="label.fault.alarmconfig.defalut_severity.text" /></th>
	                    </tr>
	                    <tr>
	                        <td>${alarmConfig.code}</td>
	                        <td>${alarmConfig.probable_cause}</td>
	                        <td>${alarmConfig.group_ccd_name}</td>
	                        <td>${alarmConfig.severity_ccd_name}</td>
	                    </tr>
	                    <tr>
	                        <th scope="col"><spring:message code="label.fault.alarmconfig.alarm_type.text" /></th>
	                        <th scope="col"><spring:message code="label.fault.alarmconfig.snmp.text" /></th>
	                        <th scope="col"><spring:message code="label.fault.alarmconfig.sms.text" /></th>
	                        <th scope="col"><spring:message code="label.fault.alarmconfig.email.text" /></th>
	                    </tr>
	                    <tr>
	                        <td>${alarmConfig.type_ccd_name}</td>
	                        <td>${alarmConfig.snmp_yn_name}</td>
	                        <td>${alarmConfig.sms_yn_name}</td>
	                        <td>${alarmConfig.email_yn_name}</td>
	                    </tr>
	                    <tr>
	                        <th scope="col" colspan="4"><spring:message code="label.fault.alarmconfig.description.text" /></th>
	                    </tr>
	                    <tr>
	                        <td colspan="4">${alarmConfig.description}</td>
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
                <button id="btn_mod" type="button"><spring:message code="label.common.edit.text" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 