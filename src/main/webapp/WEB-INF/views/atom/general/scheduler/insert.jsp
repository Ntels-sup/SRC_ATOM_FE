<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels"%>
		<section>
			<header>
				<spring:message code="label.pfnm.batch.insert.text"/><a href="javascript:closeWindow();"><spring:message code="label.pfnm.batch.close.text"/></a>
			</header>
			<article>
				<form id="pop" name="pop" method="post"
					action="/pfnm/designer/batch/insertAction.ajax">
				<input type="hidden" name="system_id" value="${batch.system_id}"/>
				<input type="hidden" name="package_id" value="${batch.package_id}"/>
				<input type="hidden" name="batch_group_id" value="${batch.batch_group_id}"/>
				<input type="hidden" name="app_package_id" value="${batch.system_id}"/>			
				<input type="hidden" name="image_x" value="${batch.image_x}"/>
				<input type="hidden" name="image_y" value="${batch.image_y}"/>	
				<input type="hidden" name="user_id" value="test"/>
				<table class="modif">
					<colgroup>
						<col width="40%">
						<col width="60%">
					</colgroup>
					<tr>
						<th><label for="batch_job_name"><strong>*</strong><spring:message code="label.pfnm.batch.batch_job_name.text"/></label>
						</th>
						<td><input type="text" id="batch_job_name" name="batch_job_name"
							placeholder="<spring:message code="label.pfnm.batch.batch_job_name.desc"/>">
						</td>
					</tr>
					<tr>
						<th><label for="component_type"><strong>*</strong><spring:message code="label.pfnm.batch.component_type.text"/></label>
						</th>
						<td><select id="component_type" name="component_type">
								<c:forEach items="${listPluginProperties}" var="properties" varStatus="status">
								<option value="${properties.type_code}">${properties.type_name}</option>
								</c:forEach>
								</select>
						</td>
					</tr>					
					<tr>
						<th><label for="application_id"><strong>*</strong><spring:message code="label.pfnm.batch.application_id.text"/></label>
						</th>
						<td><select id="application_id" name="application_id">
								<c:forEach items="${listApplication}" var="application" varStatus="status">
								<option value="${application.application_id}">${application.app_name}</option>
								</c:forEach>
							  </select>
						</td>
					</tr>
					<tr>
						<th><label for="abnormal_stop_yn"><spring:message code="label.pfnm.batch.abnormal_stop_yn.text"/></label>
						</th>
						<td><input type="checkbox" id="abnormal_stop_yn" name="abnormal_stop_yn" value="Y">
						</td>
					</tr>
					<tr>
						<th><label for="execute_argument"><spring:message code="label.pfnm.batch.execute_argument.text"/></label>
						</th>
						<td><input type="text" id="execute_argument" name="execute_argument">
						</td>
					</tr>
					<tr>
						<th><label for="remark"><spring:message code="label.pfnm.batch.remark.text"/></label>
						</th>
						<td><input type="text" id="remark" name="remark" placeholder="0">
						</td>
					</tr>
					<tr>
						<th><label for="lms_log_yn"><spring:message code="label.pfnm.batch.lms_log_yn.text"/></label>
						</th>
						<td><input type="checkbox" id="lms_log_yn" name="lms_log_yn" value="Y">
						</td>
					</tr>					
				</table>
				</form>
				<div class="pop_btn">
					<a href="javascript:goBatch('insert');" class="button"><span><spring:message code="label.common.button.ok.text"/></span>
					</a> <a href="javascript:closeWindow();" class="button"><span><spring:message code="label.common.button.cancel.text"/></span>
					</a>
				</div>
			</article>
		</section>