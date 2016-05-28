<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

test : ${paging.lists}<br>

<c:forEach items="${paging.lists}" var="i" varStatus="status">
	<fmt:parseDate var="prcDate" value="${fn:replace(i.PRC_DATE,' ', '')}" pattern="yyyyMMddHHmmss" />
 	${i.PRC_DATE}///<fmt:formatDate value="${prcDate}" pattern="${sessionUser.patternDate} HH:mm:ss" />
	
</c:forEach>