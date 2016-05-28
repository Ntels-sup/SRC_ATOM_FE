<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript">

$(document).ready(function() {

});




</script>
				<h2>Release Log</h2>
				<ul class="scroll-type4" >

<c:forEach items="${releaseLog}" var="release" varStatus="status">
					<li>
						<p class="name">${release.pkg_name}</p>
						<p class="ver">Version&nbsp;${release.pkg_version}</p>
						<p><span>Release Date</span>:&nbsp;${release.release_date}</p>
						<p><span>Pach Date</span>:&nbsp;${release.patch_date}</p>
					</li>
</c:forEach>

</ul>
