<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%
	String browser = null;
	browser = request.getHeader("User-Agent");
	browser = browser.toUpperCase();
    
	if ((browser != null) && (browser.indexOf("CHROME") != -1)) {
%>
<!DOCTYPE html>
<html lang="en-US">
<tiles:insertAttribute name="body" />
</html>
<%		
	} else {
%>
<tiles:insertAttribute name="body" />
<%		
	}
%>