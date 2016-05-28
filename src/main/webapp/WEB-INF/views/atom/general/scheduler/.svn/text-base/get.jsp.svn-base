<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels"%>
		<section>
			<header>
				<spring:message code="label.pfnm.batch.view.text"/><a href="javascript:closeWindow();"><spring:message code="label.pfnm.batch.close.text"/></a>
			</header>
			<article>
				<form id="pop" name="pop" method="post"
					action="/pfnm/designer/batch/updateAction.ajax">	
				<input type="hidden" name="system_id" value="${batch.system_id}"/>
				<input type="hidden" name="package_id" value="${batch.package_id}"/>
				<input type="hidden" name="batch_group_id" value="${batch.batch_group_id}"/>
				<input type="hidden" name="batch_job_id" value="${batch.batch_job_id}"/>	
				<input type="hidden" name="app_package_id" value="${batch.system_id}"/>										
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
					<tr>
						<th><label for="component_type"><strong>*</strong><spring:message code="label.pfnm.batch.component_type.text"/></label>
						</th>
						<td><select id="component_type" name="component_type">
								<c:forEach items="${listPluginProperties}" var="properties" varStatus="status">
								<option value="${properties.type_code}" <c:if test="${properties.type_code == batch.component_type}">selected="selected"</c:if>>${properties.type_name}</option>
								</c:forEach>
								</select>
						</td>
					</tr>					
					<tr>
						<th><label for="application_id"><strong>*</strong><spring:message code="label.pfnm.batch.application_id.text"/></label>
						</th>
						<td><select id="application_id" name="application_id">
								<c:forEach items="${listApplication}" var="application" varStatus="status">
								<option value="${application.application_id}" <c:if test="${application.application_id == batch.application_id}">selected="selected"</c:if>>${application.app_name}</option>
								</c:forEach>
							  </select>
						</td>
					</tr>
					<tr>
						<th><label for="abnormal_stop_yn"><spring:message code="label.pfnm.batch.abnormal_stop_yn.text"/></label>
						</th>
						<td><input type="checkbox" id="abnormal_stop_yn" name="abnormal_stop_yn" value="Y" <c:if test="${batch.abnormal_stop_yn == 'Y'}">checked="checked"</c:if>>
						</td>
					</tr>
					<tr>
						<th><label for="execute_argument"><spring:message code="label.pfnm.batch.execute_argument.text"/></label>
						</th>
						<td><input type="text" id="execute_argument" name="execute_argument" value="${batch.execute_argument}">
						</td>
					</tr>
					<tr>
						<th><label for="remark"><spring:message code="label.pfnm.batch.remark.text"/></label>
						</th>
						<td><input type="text" id="remark" name="remark" placeholder="0" value="${batch.remark}">
						</td>
					</tr>
					<tr>
						<th><label for="lms_log_yn"><spring:message code="label.pfnm.batch.lms_log_yn.text"/></label>
						</th>
						<td><input type="checkbox" id="lms_log_yn" name="lms_log_yn" value="Y" <c:if test="${batch.lms_log_yn == 'Y'}">checked="checked"</c:if>>
						</td>
					</tr>	
				</table>
				<div class="pop_btn">
					<a href="javascript:goBatch('get');" class="button"><span><spring:message code="label.common.button.modify.text"/></span>
					</a>
					<a href="javascript:closeWindow();" class="button"><span><spring:message code="label.common.button.cancel.text"/></span>
					</a>
				</div>
				</form>
			</article>
		</section>