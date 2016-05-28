<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title><spring:message code="label.title"/></title>
<link rel="stylesheet" href="<c:url value="/styles/basic.css" />" type="text/css" />
<link rel="stylesheet" href="<c:url value="/styles/jquery-ui-1.8.11.custom.css" />" type="text/css" />

<script type="text/javascript" src="<c:url value="/scripts/jquery/jquery-1.6.2.js" />"></script>		
<script type="text/javascript" src="<c:url value="/scripts/jquery/jquery-ui-1.8.11.custom.min.js" />"></script>
<script type="text/javascript" charset="utf-8" src="<c:url value="/scripts/jquery/calendar/jquery.ui.datepicker-ko.js" />"></script>

<script type="text/javascript">
<!--

	var end_date = "9999-12-31";
	var id = "00";

	$(document).ready(function() {

		window.resizeTo(925,494);			
		
		initialize(id);
		
		$.datepicker.setDefaults($.datepicker.regional['en']);
		$( ".date" ).datepicker();
		
		var applyOption;
		var i = 0;

		for(i = 0; i < 24; i++) {
			applyOption =  $('<option value="' + ((i < 10) ? '0' + i : i) + '">' + ((i < 10) ? '0' + i : i) + '</option>');
			$("#applyHour").append(applyOption);
		}
		
		for(i = 0; i < 60; i++) {
			applyOption =  $('<option value="' + ((i < 10) ? '0' + i : i) + '">' + ((i < 10) ? '0' + i : i) + '</option>');
			$("#applyMin").append(applyOption);
		}
		
		$("#cycle_type input[name=cycle_type]").click(function() {
			
			id = $(this).val();
			
			initialize(id);
			
			$("#cycle_type #t" + id).show();
		});
		
		// 수행 기간 [없음] 선택시
		$("#expire_n").click(function() {
			
			$("#expireDate").val(end_date);
		});
		
		// 수행 기간 [만료 날짜] 선택시
		$("#expire_y").click(function() {
			
			$("#expireDate").val(expire_date.substring(0,4) + "_" + expire_date.substring(4,6) + "_" + expire_date.substring(6,8));
		});			
	});
	
	// 화면 로드시 초기화
	function initialize(id) {
		
		for(var i=0; i<5; i++) {
			
			$("#cycle_type #t0" + i).hide();
		}
		
		if(id) {
			
			$("#cycle_type #t" + id).show();
		}	
	}	

	// 저장
	function insertBatchGroup() {
	
		if($("#batch_group_name").val() == "") {
			alert('<spring:message code="msg.pfnm.batch.batch_group_name.text"/>');
			$("#batch_group_name").focus();
			return;
		}
		
		// 수행 주기
		var cycle = "";

		if(id == "00") {
			
			cycle = $("#t" + id + " input[name=cycle]").val();
		}
		else {

			$("#t" + id + " input[name=cycle_button_" + id +"]").each(function() {

				if($(this).is(":checked")) {
					
					cycle = $("#t" + id + " #cycle_" + $(this).val()).val();
					
					if($(this).val() == "06") {
						
						id = "05"; 
					}
				}
			});
		}

		$("#schedule_cycle_type").val(id);
		$("#schedule_cycle").val(cycle);			
		
		// 수행 기간
		var apply_date = $("#applyDate").val();
		var apply_hour = $("#applyHour").val();
		var apply_min = $("#applyMin").val();
		var expire_date = $("#expireDate").val(); 
		
		$("#apply_date").val(apply_date.replace(/-/g,"") + apply_hour + apply_min);
		$("#expire_date").val(expire_date.replace(/-/g,""));
		
		var formData = $("#frm").serialize();
		$.ajax({
			type: "post",
			url: "/pfnm/designer/batch/insertBatchGroupAction.json",
			data: formData,
			success: function(data) {
				console.log(data);
				var batchGroup = data.batchGroup;
				listBatchGroup();
				opener.location.href="/pfnm/designer/batch/list?system_id=${batchGroup.system_id}&batch_group_id="+batchGroup.new_batch_group_id;
			},
			error: function(data) {
				console.log(data);
			}
		});
	}
	
	// 목록
	function listBatchGroup() {
	
		frm.action = "/pfnm/designer/batch/listBatchGroup.ajax";
		frm.submit();
	}
	
	// 창 닫기
	function closeWindow() {
	
		self.close();
	}
	
//-->
</script>
</head>

<body>
	<!--s : popup layer-->
	<div id="pop_layer" style="width:900px;">
		<section>
			<header>
				<spring:message code="label.pfnm.batch.manage_batch_group.text"/><a href="javascript:closeWindow();"><spring:message code="label.pfnm.batch.close.text"/></a>
			</header>
			<article>
				<form id="frm" name="frm" method="post"
					action="/pfnm/designer/batch/insertBatchGroupAction.ajax">
				<input type="hidden" name="system_id" value="${batchGroup.system_id}"/>
				<input type="hidden" name="package_id" value="${batchGroup.package_id}"/>
				<input type="hidden" name="user_id" value="test"/>
				<input type="hidden" id="schedule_cycle_type" name="schedule_cycle_type" value=""/>	
				<input type="hidden" id="schedule_cycle" name="schedule_cycle" value=""/>				
				<table class="modif">
					<colgroup>
						<col width="20%">
						<col width="30%">
						<col width="20%">
						<col width="30%">
					</colgroup>
		            <tr>
		               <th class="capt" colspan="4"><spring:message code="label.pfnm.batch.batch_info.text"/></th>
		            </tr>					
					<tr>
						<th><label for="001"><strong>*</strong><spring:message code="label.pfnm.batch.batch_group.text"/></label>
						</th>
						<td><input type="text" id="batch_group_name" name="batch_group_name" value="">
						</td>
						<th><label for="002"><spring:message code="label.pfnm.batch.holiday_exception_yn.text"/></label>
						</th>
						<td><input type="checkbox" id="holiday_exception_yn" name="holiday_exception_yn" value="Y">
						</td>
					</tr>
					<tr>
						<th><label for="003"><spring:message code="label.pfnm.batch.remark.text"/></label>
						</th>
						<td colspan="3"><input type="text" id="remark" name="remark" class="pc100" value="">
						</td>
					</tr>
				</table>	
				<br>
				<table class="modif">
		             <tr>
		               <th class="capt" colspan="4"><spring:message code="label.pfnm.batch.schedule_cycle_type.text"/></th>
		            </tr>
					<tr id="cycle_type">
						<th width="320"><spring:message code="label.pfnm.batch.select.text"/>: 
							<input type="radio" id="r00" name="cycle_type" value="00" checked><label for="r00"><spring:message code="label.pfnm.batch.not.text"/></label>
							<input type="radio" id="r01" name="cycle_type" value="01"><label for="r01"><spring:message code="label.pfnm.batch.min.text"/></label>
							<input type="radio" id="r02" name="cycle_type" value="02"><label for="r02"><spring:message code="label.pfnm.batch.hour.text"/></label>
							<input type="radio" id="r03" name="cycle_type" value="03"><label for="r03"><spring:message code="label.pfnm.batch.day.text"/></label>
							<input type="radio" id="r04" name="cycle_type" value="04"><label for="r04"><spring:message code="label.pfnm.batch.month.text"/></label>
						</th>
						<td id="t00" style="display:none;">
							<input type="hidden" id="t00_cycle" name="cycle" value="0">
						</td>
						<td id="t01" style="display:none;">
							<input type="radio" id="button_01" name="cycle_button_01" value="01" checked><label for="t011"><spring:message code="label.pfnm.batch.per.text"/></label>
							<input type="text" id="cycle_01" name="cycle" class="px50" value="5"> 
							<label for="t012"><spring:message code="label.pfnm.batch.per_min.text"/></label>
						</td>
						<td id="t02" style="display:none;">							
							<input type="radio" id="button_02" name="cycle_button_02" value="02" checked><label for="t021"><spring:message code="label.pfnm.batch.per.text"/></label>
							<input type="text" id="cycle_02" name="cycle" class="px50" value="1">
							<label for="t022"><spring:message code="label.pfnm.batch.per_hour.text"/></label>
						</td>
						<td id="t03" style="display:none;">
							<input type="radio" id="button_03" name="cycle_button_03" value="03" checked><label for="t032"><spring:message code="label.pfnm.batch.per.text"/></label>
							<input type="text" id="cycle_03" name="cycle" class="px50" value="1"> 
							<label for="t033"><spring:message code="label.pfnm.batch.per_day.text"/></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="button_04" name="cycle_button_03" value="04"><label for="t034"><spring:message code="label.pfnm.batch.per_week.text"/> : </label> 
							<select id="cycle_04" name="cycle">
                        		<option value="7"><spring:message code="label.pfnm.batch.mon.text"/></option>
                        		<option value="7"><spring:message code="label.pfnm.batch.tue.text"/></option>
                        		<option value="7"><spring:message code="label.pfnm.batch.wed.text"/></option>
                        		<option value="7"><spring:message code="label.pfnm.batch.thu.text"/></option>
                        		<option value="7"><spring:message code="label.pfnm.batch.fri.text"/></option>
                        		<option value="7"><spring:message code="label.pfnm.batch.sat.text"/></option>
                        		<option value="7"><spring:message code="label.pfnm.batch.sun.text"/></option>
                     		</select>
						</td>
						<td id="t04" style="display:none;">
							<input type="radio" id="button_05" name="cycle_button_04" value="05" checked>
							<label for="button_04"><spring:message code="label.pfnm.batch.per.text"/></label> 
							<input type="text" id="cycle_05" name="cycle" class="px50" value="1"> 
							<label for="cycle_04"><spring:message code="label.pfnm.batch.per_mon.text"/></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="button_06" name="cycle_button_04" value="06">
							<label for="button_05"><spring:message code="label.pfnm.batch.per_mon2.text"/></label> 
							<input type="hidden" id="cycle_06" name="cycle" class="px50" value="1"> 
							<label for="cycle_05"><spring:message code="label.pfnm.batch.last_day.text"/></label>
						</td>							
					</tr>
				</table>	
				<br>
				<table class="modif">
		            <tr>
		               <th class="capt"><spring:message code="label.pfnm.batch.schedule_date.text"/></th>
		            </tr>
					<tr>
						<th><spring:message code="label.pfnm.batch.apply_date.text"/></th>
					</tr>
					<tr>
						<td>
							<input type="hidden" id="apply_date" name="apply_date">
							<input id="applyDate" name="applyDate" class="px100 date" readonly="readonly"> 
							<a href="javascript:$('#applyDate').datepicker('show');" id="btn_apply_date" class="ico_cal">
							<img src="/images/ico_cal.gif"></a>&nbsp;<select id="applyHour" name="applyHour"></select> : <select id="applyMin" name="applyMin"></select>							
						</td>
					</tr>
					<tr>
						<th><spring:message code="label.pfnm.batch.select.text"/>: <input type="radio" id="expire_n" name="expire_yn" checked>
							<label for="a01"><spring:message code="label.pfnm.batch.not.text"/></label> 
							<input type="radio" id="expire_y" name="expire_yn">
							<label for="a03"><spring:message code="label.pfnm.batch.expire_date.text"/></label>
						</th>
					</tr>
					<tr>
						<td>
							<input type="hidden" id="expire_date" name="expire_date">
							<input id="expireDate" class="px100 date" name="expireDate" value="9999-12-31">
							<a href="javascript:$('#expireDate').datepicker('show');" id="btn_expire_date" class="ico_cal">
							<img src="/images/ico_cal.gif"></a>
						</td>
					</tr>					
				</table>
				</form>
				<div class="pop_btn">
					<a href="javascript:insertBatchGroup();" class="button"><span><spring:message code="label.common.button.save.text"/></span>
					</a> 
					<a href="javascript:closeWindow();" class="button"><span><spring:message code="label.common.button.cancel.text"/></span>
					</a> 
					<a href="javascript:listBatchGroup();" class="button"><span><spring:message code="label.common.button.list.text"/></span>
					</a> 
				</div>
			</article>
		</section>
	</div>
	<!--e : popup layer-->
</body>
</html>