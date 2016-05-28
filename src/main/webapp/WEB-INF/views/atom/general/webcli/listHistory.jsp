<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels"%>

<c:if test="${!empty listHistory}">	
	<c:forEach items="${listHistory}" var="i" varStatus="status">
		<tr>
		   	<td align="center" style="cursor:default;">${i.COMMAND}</td>
		   	<td align="center" style="cursor:default;">${i.SYSTEM_NAME}</td>
		   	<td align="center" style="cursor:default;">${i.ARGS}</td>
		   	<td align="center" style="cursor:default;">${i.REQ_DATE}</td>
		   	<td align="center" style="cursor:default;">${i.RES_DATE}</td>
		   	<td align="center" style="cursor:default;">${i.RESULT_STR}</td>
		</tr>
	</c:forEach>
</c:if>
				
