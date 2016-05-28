<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>

<script type="text/javascript">
 
    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {    	

		$("#btn_mod").click(function() {
            listUpdate();
        });
		
    });
    
    function listUpdate(){
		$("#daily").attr("action", "/atom/general/backup/dailypolicy/daily/update");
        $("#daily").submit();
    }
</script>
<div class="content">
	<div class="cont_body">
		<header>
			<h3><spring:message code="label.general.backup.dailypolicy.backup_title.text" /></h3>
			<p><spring:message code="label.general.backup.dailypolicy.backup_explan.text" /></p>
		</header>
		<div class="detail">
			<table class="tb1_detail">
				<colgroup>
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="17.5%" />
				</colgroup> 
				<tr>
					<th><spring:message code="label.general.backup.dailypolicy.input_data.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.history.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.output_data.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.statistics.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.log.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.pm.text" /></th>
				</tr>
				<tr>
   					<td>${backupInformation.BACKUP_INPUT_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${backupInformation.BACKUP_HIST_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${backupInformation.BACKUP_OUTPUT_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${backupInformation.BACKUP_STAT_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${backupInformation.BACKUP_LOG_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${backupInformation.BACKUP_PM_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
      			</tr>		
			</table>
		</div>
		
		<header>
			<h3><spring:message code="label.general.backup.dailypolicy.delete_title.text" /></h3>
			<p><spring:message code="label.general.backup.dailypolicy.delete_explan.text" /></p>
		</header>
		<div class="detail">
			<table class="tb1_detail">
				<colgroup>
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="17.5%" />
				</colgroup> 
				<tr>
					<th><spring:message code="label.general.backup.dailypolicy.input_data.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.history.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.output_data.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.statistics.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.log.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.pm.text" /></th>
				</tr>
				<tr>
   					<td>${deleteInformation.DELETE_INPUT_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${deleteInformation.DELETE_HIST_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${deleteInformation.DELETE_OUTPUT_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${deleteInformation.DELETE_STAT_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${deleteInformation.DELETE_LOG_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${deleteInformation.DELETE_PM_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   				</tr>		
			</table>
		</div>
		<header>
			<h3><spring:message code="label.general.backup.dailypolicy.comp_title.text" /></h3>
			<p><spring:message code="label.general.backup.dailypolicy.comp_explan.text" /></p>
		</header>
		<div class="detail">
			<table class="tb1_detail">
				<colgroup>
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="16.5%" />
					<col width="17.5%" />
				</colgroup> 
				<tr>
					<th><spring:message code="label.general.backup.dailypolicy.input_data.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.history.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.output_data.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.statistics.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.log.text" /></th>
   					<th><spring:message code="label.general.backup.dailypolicy.pm.text" /></th>
				</tr>
				<tr>
   					<td>${deleteInformation.COMP_INPUT_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${deleteInformation.COMP_HIST_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${deleteInformation.COMP_OUTPUT_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${deleteInformation.COMP_STAT_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${deleteInformation.COMP_LOG_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   					<td>${deleteInformation.COMP_PM_DATA} <spring:message code="label.general.backup.dailypolicy.day.text" /></td>
   				</tr>		
			</table>
		</div>
	</div>
	<div class="cont_footer">
		<div class="btn_area">
			<button id="btn_mod" type="button"><spring:message code="label.common.update.text" /></button>
		</div>
	</div>
</div>