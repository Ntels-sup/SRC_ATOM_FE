<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:forEach items="${paging.lists}" var="i" varStatus="status">
	<fmt:parseDate var="lastDate" value="${fn:replace(i.LST_DATE,' ', '')}" pattern="yyyyMMddHHmmss" />
	<tr>
    	<td class="chk"><input type="checkbox" id="check_${status.count}" name="chk" value="${i.MSG_ID}"><label for="check_${status.count}">check</label></td>
       	<td class="<c:if test="${i.CONFIRM_YN eq 'Y'}">ok</c:if>"></td>
       	<td id="tr_node_name">${i.NODE_NAME}</td>
       	<td class="date"><fmt:formatDate value="${lastDate}" pattern="${sessionUser.patternDate} HH:mm:ss" /></td>
       	<td id="tr_code">${i.CODE}</td>
       	<td>${i.TYPE_NAME}</td>
       	<!--severity addclass: ind(회색), cr, ma, mi, wa(파랑), cl(녹색), nor(보라)-->
       	<td id="tr_severity_name" class="sev 
       		<c:if test="${i.SEVERITY_CCD eq 0}">ind</c:if>
       		<c:if test="${i.SEVERITY_CCD eq 1}">cr</c:if>
       		<c:if test="${i.SEVERITY_CCD eq 2}">ma</c:if>
       		<c:if test="${i.SEVERITY_CCD eq 3}">mi</c:if>
       		<c:if test="${i.SEVERITY_CCD eq 4}">nor</c:if>
       		<c:if test="${i.SEVERITY_CCD eq 5}">cl</c:if>
       		<c:if test="${i.SEVERITY_CCD eq 6}">wa</c:if>
       		<c:if test="${i.SEVERITY_CCD eq 7}">ind</c:if>
       		">${i.SEVERITY_NAME}</td>

       	<td>${i.PROBABLE_CAUSE}</td>
       	<td>${i.TARGET}</td>
       	<td><span class="per">${i.VALUE} ${i.COMPLEMENT}</span>
       		<%-- <div class="graph_bar"><p style="width:${i.VALUE}%"><span class="bar bar_ani"></span></p></div> --%>
       	</td>
       	<td style="display:none;">${i.MSG_ID}</td>
       	<td style="display:none;">${i.SEVERITY_CCD}</td>     	    
        <td class="ico"><button type="button" id="btn_alarm_detail" title="Detail" class="more" value="${i.MSG_ID}"></button></td>   
                                     
	</tr>
	
</c:forEach>
 
<input type="hidden" name="listSize" value="${fn:length(paging.lists)}" />
<input type="hidden" name="lastPage" value="${lastPage}" />
<input type="hidden" name="realPage" value="${paging.page}" />
<input type="hidden" name="alarm_totalcount" value="<fmt:formatNumber value="${paging.totalCount}" pattern="#,###"/>" />

<c:forEach items="${severityCount}" var="i" varStatus="status">
	<input type="hidden" name="${i.SEVERITY_NAME}_count" value="${i.CNT}" />
</c:forEach>
	
	
<script type="text/javascript">
<!--
	$(document).ready(function() {
		var tbl = $('.table.hover_event');
		var tbl_tr = tbl.find('tbody tr');
		
		for (var i = 0; i < tbl_tr.length; i++) {
		    tbl_tr.eq(i).hover(function(){
		      $(this).addClass('hover');
		      if($(this).filter('.sev')){
		        $get_lv_class = $(this).find('.sev').attr('class');
		        $(this).addClass($get_lv_class).removeClass('sev');
		      }
		    },function(){
		      $(this).removeClass();
		    });
		  }
	});
	
//-->
</script>