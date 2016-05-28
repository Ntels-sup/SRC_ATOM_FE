<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>




 <head>
 	<meta charset="UTF-8">
 	<meta http-equiv="X-UA-Compatible" content="IE=edge">
 	<title>ATOM</title>
 	
<script type="text/javascript">
$(document).ready(function() {

	 $("select.group_single").multipleSelect({
		filter: true,
		single: true,  
        multiple: true,
        multipleWidth: 150,
        width: "602px"
      , onClick: function(view) {
    	  $('#node_no').val(view.value);
    	  fn_stsTable(view.value);
    	}
    });
	 

	$("#statisticsTable").multipleSelect({
        single: true
       ,selectAll: false
       ,multiple: false
  	   ,onClick: function(view) {
  		   fn_stsColumn(view.value);
          }
	 });
	 
	
	$("#statisticsColumn").multipleSelect({
        single: true
       ,selectAll: false
       ,multiple: false
  	   ,onClick: function(view) {
  		 $("#statisticsColumn_Val").val(view.value);
          }
	 }); 
	
	$("#actYn").multipleSelect({
        single: true
       ,selectAll: false
       ,multiple: false
  	   ,onClick: function(view) {

          }
	 });
	
	
	//버튼 클릭시
	$("#btn_stroke").click(function() {
		fn_ValueSetBar();
	});
	
	
	$("#btn_save").click(function() {
		fn_SaveAction();
	});
	
	$("#btn_list").click(function() {
		goList();
	});
	
	
	$("#minValue_temp").keyup(function(){
		var first = $(this).val().substring(0, 1); 
	    var traceInt = $(this).val().replace(/[^0-9]/g,""); 	
		var traceInt_first = traceInt.substring(0, 1);
	    if(first == "-" && traceInt_first != "0"){
			$(this).val(first+traceInt);
		}else{
			$(this).val(traceInt);
		}
	});
	
	$("#maxValue_temp").keyup(function(){
		var first = $(this).val().substring(0, 1); 
	    var traceInt = $(this).val().replace(/[^0-9]/g,""); 	
		var traceInt_first = traceInt.substring(0, 1);
	    if(first == "-" && traceInt_first != "0"){
			$(this).val(first+traceInt);
		}else{
			$(this).val(traceInt);
		}
	});

	$("#unitValue_temp").keyup(function(){
		var trace = $(this).val().replace(/[^0-9]/g,"");
		if(trace != ""){
		$(this).val(parseInt(trace));
		}else{
			$(this).val("");
		}
		
	});






});




//Node(PKGName)선택에 따라 Statistics Table 콤보를 다시 그려준다.
function fn_stsTable(node_no){
	var param = null;
	param  = "&"+"node_no="+node_no;
	$("#statisticsTable").empty();
	$("#statisticsTable").multipleSelect('refresh');
	$("#statisticsColumn").empty();
	$("#statisticsColumn").multipleSelect('refresh');
	$.ajax({
        url : "StatisticsTableCombo",
        data : param,
        type : 'POST',
        async: false,
        dataType : 'json',
        success : function(data) {
    		var array = data;
    		var optionTag;
    		//$("#statisticsTable").html('<option value="">Select</option>'); 
    		$.each(array,function(index,appObj) {
    			optionTag = $('<option value="'+appObj.ID+'">'+appObj.NAME+'</option>');
    			$("#statisticsTable").append(optionTag).multipleSelect('refresh');
    		});
    		$("#statisticsTable").multipleSelect('refresh');
    		fn_stsColumn($("#statisticsTable").val());
        },
        error: function(e){
            openAlertModal(e.reponseText);
        },
        complete : function() {

        }
	});
}


//Table 선택에 따라 Column 콤보를 다시 그려준다.
function fn_stsColumn(table_name){
	var param = null;
	var node_no =$('#node_no').val() ;
	
	param  = "&"+"table_name="+table_name;
	param  = param+"&"+"node_no="+node_no
	$("#statisticsColumn").empty();
	$("#statisticsColumn").multipleSelect('refresh');
	
	$("#statisticsColumn_text").hide();
	$("#statisticsColumn_select").show();
	$.ajax({
        url : "StatisticsColumnCombo",
        data : param,
        type : 'POST',
        async: false,
        dataType : 'json',
        success : function(data) {
    		var array = data;
    		var optionTag;
    		//$("#statisticsTable").html('<option value="">Select</option>'); 
    		$.each(array,function(index,appObj) {
    			optionTag = $('<option value="'+appObj.ID+'">'+appObj.NAME+'</option>');
    			$("#statisticsColumn").append(optionTag).multipleSelect('refresh');
    		});
    		$("#statisticsColumn").multipleSelect('refresh');
    		if($("#statisticsColumn option").size() == 1){
    			$("#statisticsColumn_Val").val($("#statisticsColumn").val());
    			$("#statisticsColumn_text").show();
    			$("#statisticsColumn_select").hide();
    		}
        },
        error: function(e){
            openAlertModal(e.reponseText);
        },
        complete : function() {

        }
	});
}


// Tca 등록할 value값 셋팅을 위한 action
function fn_ValueSetBar(){
    //package  node table column 값들 선택여부 확인.	
	var pscheck = $("#node_no").val();
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="msg.common.empty.node"/>');
	    return;
	}
    
	pscheck = $("#statisticsTable").val();
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="label.fault.tca.empty.statisticstable"/>');  
	    return;
	}
	
	$("#statisticsColumn_Val").val($("#statisticsColumn").val());
	pscheck = $("#statisticsColumn_Val").val();
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="label.fault.tca.empty.statisticscolumn"/>');
	    return;
	}
	
	//Alarm Level : max min unit 값들 입력확인. 
	
	pscheck = $("#minValue_temp").val();
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="label.fault.tca.empty.minValue"/>');
	    return;
	}
	$("#minValue_temp").val(parseInt( $("#minValue_temp").val()) );
	
	pscheck = $("#maxValue_temp").val();
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="label.fault.tca.empty.maxValue"/>');
	    return;
	}
	$("#maxValue_temp").val(parseInt( $("#maxValue_temp").val()) );
	
	pscheck = $("#unitValue_temp").val();
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="label.fault.tca.empty.unitValue"/>');
	    return;
	}
	if(pscheck < 1){
		openAlertModal('<spring:message code="label.fault.tca.unit.exp"/>');
	    return;
	}
	$("#unitValue_temp").val(parseInt( $("#unitValue_temp").val()) );
	
	if(parseInt($("#minValue_temp").val()) >= parseInt($("#maxValue_temp").val())){
		openAlertModal('<spring:message code="label.fault.tca.false.minValue.maxValue"/>');
		return;
	}
    
	if(parseInt($("#unitValue_temp").val()) >= (parseInt($("#maxValue_temp").val()) - parseInt($("#minValue_temp").val())) ){
		openAlertModal('<spring:message code="label.fault.tca.false.unitValue"/>');
		return;
	}

    // valueRangeWrap
    var param = new Object();
	param.minValue =  $("#minValue_temp").val();
	param.maxValue   =  $("#maxValue_temp").val();
	param.unitValue  = $("#unitValue_temp").val();
	param.tableIdx = tableIdx++;
    $.post('valueRangeWrap.ajax', param, function(data) {
    	$('#valueRangeWrap').empty();
    	$('#valueRangeWrap').html(data);
    });

}
var tableIdx = 0;


function goList() {
	$("#myForm").attr("action", "list");
	$("#myForm").submit();
}

function fn_SaveAction(){
    
    //package  node table column 값들 선택여부 확인.	
	var pscheck = $("#node_no").val();
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="msg.common.empty.node"/>');
	    return;
	}
    
	pscheck = $("#statisticsTable").val();
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="label.fault.tca.empty.statisticstable"/>');  
	    return;
	}
	
	$("#statisticsColumn_Val").val($("#statisticsColumn").val());
	pscheck = $("#statisticsColumn_Val").val();
	if(pscheck == null || pscheck == ''){
		openAlertModal('<spring:message code="label.fault.tca.empty.statisticscolumn"/>');
	    return;
	}
	
	//Alarm Level :저장할  max min unit 값셋팅
	$("#minValue").val($("#minValue_Rw").text());
	$("#maxValue").val($("#maxValue_Rw").text());
	$("#unitValue").val($("#unitValue_Rw").val());
	
	var param = $("#myForm").serialize();
	$.ajax({
        url : "insertAction.ajax",
        data : param,
        type : 'POST',
        dataType : 'json',
        async: false,
        success : function(data) {
			result = data.returnMsg;
			if (result == "SUCCESS") {
				
				openAlertModal( "",data.resultMsg,function(){$("#myForm").submit();} ); // list로 다시 이동
			}else{
				openAlertModal(data.resultMsg);
			}
        },
        error: function(e){
        	openAlertModal("",e.responseText);
        },
        complete : function() {

        }
	}); 

}


</script>

</head>
<body>
<form id="myForm" name="myForm" method="post" action="/atom/fault/tcaconfig/list">
	<input type="hidden" id="Critical_Over_left" name="Critical_Over_left" />
	<input type="hidden" id="Critical_Over_right" name="Critical_Over_right" value="0" />
	<input type="hidden" id="Major_Over_left" name="Major_Over_left" />
	<input type="hidden" id="Major_Over_right" name="Major_Over_right" />
	<input type="hidden" id="Minor_Over_left" name="Minor_Over_left" />
	<input type="hidden" id="Minor_Over_right" name="Minor_Over_right" />
	<input type="hidden" id="Cleared_left" name="Cleared_left" />
	<input type="hidden" id="Cleared_right" name="Cleared_right" />
	<input type="hidden" id="Minor_Under_left" name="Minor_Under_left" />
	<input type="hidden" id="Minor_Under_right" name="Minor_Under_right" />
	<input type="hidden" id="Major_Under_left" name="Major_Under_left" />
	<input type="hidden" id="Major_Under_right" name="Major_Under_right" />	
	<input type="hidden" id="Critical_Under_left" name="Critical_Under_left" value="0" />
	<input type="hidden" id="Critical_Under_right" name="Critical_Under_right" />
	<input type="hidden" id="minValue" name="minValue" />
	<input type="hidden" id="maxValue" name="maxValue" />
	<input type="hidden" id="unitValue" name="unitValue" />

    <!-- content -->
    <div class="content">
        <div class="cont_body">
            <div class="detail">
                <table class="tbl_detail register">
                    <colgroup>
						<col width="25%"/>
						<col width="25%"/>
						<col width="25%"/>
						<col width="25%"/>
                    </colgroup>
                    <tr>
                        <th scope="col" class="imp"><spring:message code="label.common.package/node" /></th>
                        <th scope="col" class="imp"><spring:message code="label.fault.tca.statisticstable"/></th>
                        <th scope="col" class="imp"><spring:message code="label.fault.tca.statisticscolumn"/></th>
                        <th scope="col" class="imp"><spring:message code="label.fault.tca.useyn"/></th>
                    </tr>
                    <tr>
                        <td>
							<select class="group_single"  id="node_no" name="node_no">
                            <c:forEach items="${Package}" var="Packagelist" varStatus="status">
	                            <optgroup label="${Packagelist.NAME}">
		                            <c:forEach items="${System}" var="Systemlist" varStatus="status">
		                               <c:if test="${Packagelist.ID eq Systemlist.PACKAGEID}">
		                               		<option value="${Systemlist.ID}">${Systemlist.NAME}</option>
		                               </c:if>
		                            </c:forEach>
	                            </optgroup>
                            </c:forEach>
							</select>
						</td>
                        <td>
							<select class="single" id="statisticsTable" name="statisticsTable">
                            </select>
						</td>
                        <td id="statisticsColumn_select">
							<select class="single" id="statisticsColumn" name="statisticsColumn" >
                            </select>
                        </td>
                        <td id="statisticsColumn_text" hidden="hidden">
							<input type="text"  id="statisticsColumn_Val" name="statisticsColumn_Val" value="" disabled="disabled" />
                        </td>
                        <td>
							<select class="single" id="actYn" name="actYn">
                                <c:forEach items="${actYn}" var="actYnlist" varStatus="status">
                                	<option value="${actYnlist.ID}">${actYnlist.NAME}</option>
                                </c:forEach>
                            </select>
                       </td>
                    </tr>
                </table>
            </div>

			<header>
                <h3><spring:message code="label.fault.tca.tcaalarmlevel"/></h3>
            </header>
			<div class="detail">
                <table class="tbl_detail">
                    <colgroup>
						<col width="12.5%"/>
						<col width="12.5%"/>
						<col width="75%"/>
                    </colgroup>
                    <tr>
                        <th scope="col" class="imp"><spring:message code="label.fault.tca.minvalue"/>  </th>
                        <th scope="col" class="imp"><spring:message code="label.fault.tca.maxvalue"/>  </th>
                        <th scope="col" class="imp"><spring:message code="label.fault.tca.value"/>     </th>
                    </tr>
                    <tr>
                        <td>
							<input type="text"  id="minValue_temp" name="minValue_temp" placeholder="" class="input_xs" value="0" />
						</td>
                        <td>
							<input type="text"  id="maxValue_temp" name="maxValue_temp"  placeholder="" class="input_xs" value="200" />
						</td>
                        <td rowspan="3"  class="slidearea" id="TcaValueBar">
							<div class="rangeWrap" id="valueRangeWrap"></div>
                        </td>
                    </tr>
					<tr>
                        <th scope="col" class="imp" colspan="2"><spring:message code="label.fault.tca.unit"/></th>
                    </tr>
					<tr>
                        <td colspan="2">
							<input type="text" id="unitValue_temp" name="unitValue_temp" placeholder="" class="input_xs" value="10" />
							<button type="button" class="btn_stroke" id="btn_stroke" ><spring:message code="label.common.edit" /></button>
						</td>
                    </tr>        
                </table>
            </div>
        </div>
        <!-- //cont_body -->
        <div class="cont_footer">
            <div class="btn_area">
                <button type="button" id="btn_list"><spring:message code="label.common.cancel" /></button>
                <button type="button" class="major" id="btn_save" hidden="hidden"><spring:message code="label.common.save" /></button>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content -->
    
</form>

</body>    