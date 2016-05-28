<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!--alarm detail popup-->
<div id="pop_alarmDetail">
  <div class="popup_sys">
    <div class="info">
      <h2>Alarm Detail</h2>
      <a class="close" href="javascript:closeModal();">&times;</a>
      <div class="alarm 
			<c:if test="${alarmDetail.SEVERITY_CCD eq 0}">ind</c:if>
       		<c:if test="${alarmDetail.SEVERITY_CCD eq 1}">cr</c:if>
       		<c:if test="${alarmDetail.SEVERITY_CCD eq 2}">ma</c:if>
       		<c:if test="${alarmDetail.SEVERITY_CCD eq 3}">mi</c:if>
       		<c:if test="${alarmDetail.SEVERITY_CCD eq 4}">nor</c:if>
       		<c:if test="${alarmDetail.SEVERITY_CCD eq 6}">wa</c:if>
       		<c:if test="${alarmDetail.SEVERITY_CCD eq 7}">cl</c:if>
		"> <!--Severity add class : cr, ma, mi, wa, cl, nor, ind -->
        <div class="cau">${alarmDetail.SEVERITY_NAME}</div>
        <div class="sys_ttl">
          <p>[${alarmDetail.PKG_NAME}]</p>
          <span>${alarmDetail.NODE_NAME}</span> 
        </div>
      </div>
      <div class="con">
        <table>
          <colgroup>
          <col width="33.5%">
          <col width="*">
          </colgroup>
          <tbody>
            <tr>
              <th><spring:message code="label.monitor.process.date"/></th>
              <td>
              	<fmt:parseDate var="lastDate" value="${fn:replace(alarmDetail.LST_DATE,' ', '')}" pattern="yyyyMMddHHmmss" />
              	<fmt:formatDate value="${lastDate}" pattern="${sessionUser.patternDate} HH:mm:ss" />
              </td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.alarm.code"/></th>
              <td>${alarmDetail.CODE}</td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.alarm.type"/></th>
              <td>${alarmDetail.TYPE_NAME}</td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.probable.cause"/></th>
              <td>${alarmDetail.PROBABLE_CAUSE}</td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.location"/></th>
              <td>${alarmDetail.LOCATION}</td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.target"/></th>
              <td>${alarmDetail.TARGET}</td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.value"/></th>
              <td><%-- <span class="per">${alarmDetail.VALUE} ${alarmDetail.COMPLEMENT}</span> --%>
                  <span>${alarmDetail.VALUE} ${alarmDetail.COMPLEMENT}</span>
                  <!-- <div class="graph_bar">
                    <p style="width:85.5%"><span class="bar bar_ani"></span></p>
                  </div> -->
              </td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.confirm.set.date"/></th>
              <td>
              	<fmt:parseDate var="confirmSetDate" value="${fn:replace(alarmDetail.CONFIRM_SET_DATE,' ', '')}" pattern="yyyyMMddHHmmss" />
              	<fmt:formatDate value="${confirmSetDate}" pattern="${sessionUser.patternDate} HH:mm:ss" />
              </td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.confirm.rel.date"/></th>
              <td>
              	<fmt:parseDate var="confirmRelDate" value="${fn:replace(alarmDetail.CONFIRM_REL_DATE,' ', '')}" pattern="yyyyMMddHHmmss" />
              	<fmt:formatDate value="${confirmRelDate}" pattern="${sessionUser.patternDate} HH:mm:ss" />
              </td>
            </tr>
            <tr>
              <th><spring:message code="label.monitor.additional.message"/></th>
              <td>${alarmDetail.ADDITIONAL_TEXT}</td>
            </tr>
          </tbody>
        </table>
      </div>
      <!-- button -->
      <div class="btn_area"> <a href="javascript:closeModal();">
        <button type="button"><spring:message code="label.common.ok"/></button>
        </a> </div>
    </div>
  </div>
</div>