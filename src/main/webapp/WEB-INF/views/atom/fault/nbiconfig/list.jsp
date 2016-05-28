<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
    	$("#btn_mod").click(function() {
            goModify();
        });
    });
        
    //nbi config goModify
    function goModify(){
    	$("#myForm").attr("action", "/atom/fault/nbiconfig/modify");
        $("#myForm").submit();	
    }
    
    //exportAtion
    function fnExcel(){
    	//param value is null(값이 없음)
		var param = new Object();
		param = $("#myForm").serialize();
		
        $.download('exportAction.xls',param,'post');
    }  

</script>   

	<div class="content">
		<div class="cont_body">
			<header><h3><spring:message code="label.snmptrap.config.list.title.text" /></h3></header>
			<form id="myForm" name="myForm">
				<!-- excelDownload시 필요 -->
				<input type="hidden" id="titleName"  name="titleName" value="${titleName}" />
				
				<div class="detail">
					<table class="tb1_detail">
						<caption><spring:message code="label.snmptrap.config.list.title.text" /></caption>
						<colgroup>
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
						</colgroup>
						<tr>
							<th colspan="2" scope="col"><spring:message code="label.snmptrap.config.list.enterprise_oid.text" /></th>
							<th scope="col"><spring:message code="label.snmptrap.config.list.trap_version.text" /></th>
						</tr>
						<tr>
							<td colspan="2">${trapConfig.enterprise_oid}</td>
							<td>${trapConfig.trap_version}</td>
						</tr>
						<tr>
				            <th scope="col"><spring:message code="label.snmptrap.config.list.agent_host_name.text" /></th>
				            <th scope="col"><spring:message code="label.snmptrap.config.list.agent_ip.text" /></th>
				            <th scope="col"><spring:message code="label.snmptrap.config.list.trap_process.text" /></th>
						</tr>
						<tr>
							<td>${trapConfig.agent_hostname}</td>
							<td>${trapConfig.agent_ip}</td>
							<td>${trapConfig.trap_proc}</td>
						</tr>
					</table>
				</div>
				
				<header><h3><spring:message code="label.snmptrap.config.list.trap_ip_title.text" /></h3></header>
				<div class="list">
					<table>
						<caption><spring:message code="label.snmptrap.config.list.trap_ip_title.text" /></caption>
						<colgroup>
							<col width="*" />
							<col width="150px" />
							<col width="*" />
							<col width="*" />
							<col width="*" />
						</colgroup>
						<thead>
							<tr>
								<th><spring:message code="label.snmptrap.config.list.ip.text" /></th>
								<th><spring:message code="label.snmptrap.config.list.port.text" /></th>
								<th><spring:message code="label.snmptrap.config.list.community.text" /></th>
								<th><spring:message code="label.snmptrap.config.list.host_name.text" /></th>
								<th><spring:message code="label.snmptrap.config.list.description.text" /></th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${!empty trapIpList}">
							<c:forEach items="${trapIpList}" var="trapIp" varStatus="status">
								<tr>
									<td>${trapIp.ip}</td>
									<td>${trapIp.port}</td>
									<td>${trapIp.community}</td>
									<td>${trapIp.host_name}</td>
									<td>${trapIp.description}</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty trapIpList}">
							<tr>
						    	<td class="t_c" colspan="5"><spring:message code="label.empty.list" /></td>
						    </tr>
						</c:if>
						</tbody>
					</table>
				</div>
			</form>
		</div>
		<!-- //cont_body -->
		
        <div class="cont_footer">
            <div class="btn_area">
                <ntels:auth auth="${authType}">
                <button id="btn_mod" type="button"><spring:message code="label.common.update.text" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 