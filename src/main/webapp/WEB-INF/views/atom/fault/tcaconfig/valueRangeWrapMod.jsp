<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>
<link rel="stylesheet" href="/styles/colResizable.css">
<script src="/scripts/slider.js"></script>

<script type="text/javascript">
//Ajax로 첫 화면의 데이터 호출
//화면 먼저 보이고 데이터를 불러야 사용자가 덜 답답해 함
$(document).ready(function(){

	valueSetWidth();
	
	$("#range${param.tableIdx}").colResizable({
		liveDrag:true, 
		draggingClass:"rangeDrag", 
		gripInnerHtml:"<div class='rangeGrip'></div>", 
		onDrag:onSlide,
		minWidth :$("#range${param.tableIdx}").width() * parseInt('${TCA_INFO.unit_value}') / (parseInt('${TCA_INFO.max_value}') - parseInt('${TCA_INFO.min_value}'))
	});
	
	
});

function valueSetWidth(){
	var width = $('#range${param.tableIdx}').width() * ( parseInt('${TCA_INFO.critical_under_right}')-parseInt('${TCA_INFO.min_value}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
    $('#cru').width(width+"px");
	width = $('#range${param.tableIdx}').width() * ( parseInt('${TCA_INFO.major_under_right}')-parseInt('${TCA_INFO.major_under_left}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
	$('#mau').width(width+"px");
	width = $('#range${param.tableIdx}').width() * ( parseInt('${TCA_INFO.minor_under_right}')-parseInt('${TCA_INFO.minor_under_left}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
	$('#miu').width(width+"px");
	width = $('#range${param.tableIdx}').width() * ( parseInt('${TCA_INFO.cleared_right}')-parseInt('${TCA_INFO.cleared_left}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
    $('#clr').width(width+"px");
	width = $('#range${param.tableIdx}').width() * ( parseInt('${TCA_INFO.minor_over_right}')-parseInt('${TCA_INFO.minor_over_left}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
	$('#mio').width(width+"px");
	width = $('#range${param.tableIdx}').width() * ( parseInt('${TCA_INFO.major_over_right}')-parseInt('${TCA_INFO.major_over_left}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
	$('#mao').width(width+"px");
	var width = $('#range${param.tableIdx}').width() * ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.critical_over_left}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
	$('#cro').width(width+"px");
}

function onSlide(e) {
	var s ="Ranges: ";
	var values = new Array();
	var sum = 0;
	$("#range${param.tableIdx} tr td").each(function() {
		var width = $(this).width();
		values.push(sum+width);
		sum += width;
		console.log(sum);
	});
	var start = parseInt('${TCA_INFO.min_value}');      // min value
	$("#range${param.tableIdx} tr td input").eq(0).text(start);
	var max_value = values[values.length-1];
	var unit_value = parseInt('${TCA_INFO.unit_value}'); //  unit value
	for (var i=0;i<values.length;i++) {
		var value = values[i] * (parseInt('${TCA_INFO.max_value}') - start) / max_value;   // max Value
		$("#range${param.tableIdx} tr td input").eq(i+1).text(Math.round(value / unit_value) * unit_value + start);
	}
	s=s.slice(0,-1);
	
	// hidden 으로 표를 그린다.
	$("#range${param.tableIdx} td").each(function() {
		var index = $("#range${param.tableIdx} td").length - $(this).index();
		var index2 = $(this).index();
		if(index != 7){
			$("#hidenValue tr:eq("+(index-1)+") td:eq(1)").text($(this).text());
		}
		$("#hidenValue tr:eq("+index+") td:eq(3)").text($(this).text());
        
		// 상태바 표시
		$("#AlarmLevelValue li:eq("+(index2-1)+") span:eq(1)").text($("#hidenValue tr:eq("+index+") td:eq(1)").text()+"=<"+$("#hidenValue tr:eq("+index+") td:eq(3)").text());    
		
		if(index2 == 1 ){ // Major_Under_left Critical_Under_right
			$('#Major_Under_left' ).val($(this).text());
			$('#Critical_Under_right' ).val($(this).text());
	
	    }
		if(index2 == 2 ){ // Minor_Under_left  Major_Under_right
			$('#Minor_Under_left' ).val($(this).text());
			$('#Major_Under_right' ).val($(this).text());
	
	    }
		if(index2 == 3 ){ // Cleared
			$('#Cleared_left' ).val($(this).text());
			$('#Minor_Under_right' ).val($(this).text());
	
	    }
		if(index2 == 4 ){ // Minor Over
			$('#Minor_Over_left' ).val($(this).text());
			$('#Cleared_right').val($(this).text());
	
	    }
		if(index2 == 5 ){ // Major Over
				$('#Major_Over_left' ).val($(this).text());
				$('#Minor_Over_right').val($(this).text());
		
		    }
		if(index2 == 6){ // Critical Over
			// 상태바 표시
			$("#AlarmLevelValue li:eq("+(index2)+") span:eq(1)").text($("#hidenValue tr:eq("+index+") td:eq(3)").text()+"=<");
			$('#Critical_Over_left').val($("#hidenValue tr:eq("+index+") td:eq(3)").text());
			$('#Major_Over_right').val($("#hidenValue tr:eq("+index+") td:eq(3)").text());
		}
	});
}



</script>
<input type="hidden" id="unitValue_Rw" name="unitValue_Rw" value="${TCA_INFO.unit_value}"/>

<ul id="AlarmLevelValue" class="info type02">
		<li class="info04">
			<span class="tit">Critical Under</span>
			<span class="num"> =< ${TCA_INFO.critical_under_right}</span>
		</li>
		<li class="info03">
			<span class="tit">Major Under</span>
			<span class="num">${TCA_INFO.major_under_left} =< ${TCA_INFO.major_under_right}</span>
		</li>
		<li class="info02">
			<span class="tit">Minor Under</span>
			<span class="num">${TCA_INFO.minor_under_left} =< ${TCA_INFO.minor_under_right}</span>
		</li>
		<li class="info05">
			<span class="tit">Cleared</span>
			<span class="num">${TCA_INFO.cleared_left} =< ${TCA_INFO.cleared_right}</span>
		</li>
		<li class="info02">
			<span class="tit">Minor Over</span>
			<span class="num">${TCA_INFO.minor_over_left} =< ${TCA_INFO.minor_over_right}</span>
		</li>
		<li class="info03">
			<span class="tit">Major Over</span>
			<span class="num">${TCA_INFO.major_over_left} =< ${TCA_INFO.major_over_right}</span>
		</li>
		<li class="info04">
			<span class="tit">Critical Over</span>
			<span class="num">${TCA_INFO.critical_over_left} =< </span>
		</li>
</ul>

	<table id="range${param.tableIdx}" class="rangeslide" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td id="cru" width="14%" class="bar04"><input type="hidden"/></td>
			<td id="mau" width="14%" class="bar03"><input type="hidden"/></td>
			<td id="miu" width="14%" class="bar02"><input type="hidden"/></td>
			<td id="clr" width=""    class="bar05"><input type="hidden"/></td>
			<td id="mio" width="14%" class="bar02"><input type="hidden"/></td>
			<td id="mao" width="14%" class="bar03"><input type="hidden"/></td>
			<td id="cro" width="14%" class="bar04"><input type="hidden"/></td>
		</tr>
	</table>

	<ul class="unitNumber">
		<li class="unit01" id="minValue_Rw" name="minValue_Rw">${TCA_INFO.min_value}</li>
		<li class="unit02" >${TCA_INFO.middle_value}</li>
		<li class="unit03" id="maxValue_Rw" name="maxValue_Rw">${TCA_INFO.max_value}</li>
	</ul>
	
	
	<table id="hidenValue" hidden="hidden">
	<tr><td>Critical Over</td><td></td><td>=&lt;</td><td></td></tr>
	<tr><td>Major Over</td><td></td><td>=&lt;</td><td></td></tr>
	<tr><td>Minor Over</td><td></td><td>=&lt;</td><td></td></tr>
	<tr><td>CLEARED</td><td></td><td>=&lt;</td><td></td></tr>
	<tr><td>Minor Under</td><td></td><td>=&lt;</td><td></td></tr>
	<tr><td>Major Under</td><td></td><td>=&lt;</td><td></td></tr>
	<tr><td>Critical Under</td><td></td><td>=&lt;</td><td></td></tr>
    </table>

