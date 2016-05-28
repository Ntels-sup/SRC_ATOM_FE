<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels"%>
		<section>
			<header>
				<spring:message code="label.pfnm.batch.copy.text"/><a href="javascript:closeWindow();"><spring:message code="label.pfnm.batch.close.text"/></a>
			</header>
			<article>
				<form id="pop" name="pop" method="post"
					action="/pfnm/designer/batch/insertByCopyAction.ajax">		
				<input type="hidden" name="system_id" value="${batch.system_id}"/>
				<input type="hidden" name="package_id" value="${batch.package_id}"/>
				<input type="hidden" name="batch_group_id" value="${batch.batch_group_id}"/>
				<input type="hidden" name="copy_batch_job_id" value="${batch.batch_job_id}" />				
				<input type="hidden" name="app_package_id" value="${batch.system_id}"/>
				<input type="hidden" name="image_x" value="${batch.image_x + 40}"/>
				<input type="hidden" name="image_y" value="${batch.image_y + 40}"/>					
				<input type="hidden" name="user_id" value="test"/>												
				<table class="modif">
					<colgroup>
						<col width="40%">
						<col width="60%">
					</colgroup>
					<tr>
						<th><label for="batch_job_name"><strong>*</strong><spring:message code="label.pfnm.batch.batch_job_name.text"/></label>
						</th>
						<td><input type="text" id="batch_job_name" name="batch_job_name" value="${batch.batch_job_name}">
						</td>
					</tr>
				</table>
				</form>
				<div class="pop_btn">
					<a href="javascript:goBatch('copy');" class="button"><span><spring:message code="label.common.button.ok.text"/></span>
					</a> <a href="javascript:closeWindow();" class="button"><span><spring:message code="label.common.button.cancel.text"/></span>
					</a>
				</div>
			</article>
		</section>