<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>





<script type="text/javascript">
    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
    	$('#alarm_total').text('${alarm.total}');
        fnPushChart();
    });
    
    


function fnPushChart() {
Alarm_chart.dataProvider = ${alarmChart};
Alarm_chart.validateData();
var contact = JSON.parse('${alarmChart}');

for(var ii = 0 ; ii  < contact.length  ; ii++ ){
	contact[ii].test = "color:"+ii;
}





}	

</script>
	<div class="count1">
		<span>${alarm.critical}</span>
		<p>Critical</p>
	</div>
	<div class="count2">
		<span>${alarm.major}</span>
		<p>Major</p>
	</div>
	<div class="count3">
		<span>${alarm.minor}</span>
		<p>Minor</p>
	</div>
	<div class="count4">
		<span>${alarm.fault}</span>
		<p>Fault</p>
	</div>




