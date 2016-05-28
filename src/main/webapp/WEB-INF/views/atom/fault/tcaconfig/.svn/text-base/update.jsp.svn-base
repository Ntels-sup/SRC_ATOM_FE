<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="/styles/colResizable.css">
<script src="/scripts/slider.js"></script>



 <head>
 	<meta charset="UTF-8">
 	<meta http-equiv="X-UA-Compatible" content="IE=edge">
 	<title>ATOM</title>
 	
<script type="text/javascript">
$(document).ready(function() {

	$("#actYn").multipleSelect({
        single: true
       ,selectAll: false
       ,multiple: false
  	   ,onClick: function(view) {

          }
	 });
		
	//버튼 클릭시
	$("#cancelButton").click(function() {
		goDetailView();
	});
	
	
	$("#btn_save").click(function() {
		fn_SaveAction();
	});
	
	//버튼 클릭시
	$("#btn_stroke").click(function() {
		fn_ValueSetBar();
	});

    valuBarLode(); 
});

//Tca 등록할 value값 셋팅을 위한 action
function fn_ValueSetBar(){
	
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

function valuBarLode(){
    // valueRangeWrap
    var param = new Object();
	param.pkg_name    = '${TCA_INFO.pkg_name}';
	param.table_name  = '${TCA_INFO.table_name}';
	param.node_no     = '${TCA_INFO.node_no}';
	param.column_name = '${TCA_INFO.column_name}';
	param.tableIdx = tableIdx++;
	$.post('valueRangeWrapMod.ajax', param, function(data) {
    	$('#valueRangeWrap').empty();
    	$('#valueRangeWrap').html(data);
    });
	
}

function fn_SaveAction(){
    
    
	
	//Alarm Level :저장할  max min unit 값셋팅
	$("#minValue").val($("#minValue_Rw").text());
	$("#maxValue").val($("#maxValue_Rw").text());
	$("#unitValue").val($("#unitValue_Rw").val());
	
	var param = $("#myForm").serialize();
	$.ajax({
        url : "updateAction.ajax",
        data : param,
        type : 'POST',
        dataType : 'json',
        async: false,
        success : function(data) {
			result = data.returnMsg;
			if (result == "SUCCESS") {
				openAlertModal( "",data.resultMsg,function(){goDetailView();} ); // detail View로 다시 이동
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



function goDetailView() {
	$("#myForm").attr("action", "detailView");
	$("#myForm").submit();
}

function goUpdateView(){
	$("#myForm").attr("action", "update");
	$("#myForm").submit();
}


</script>

</head>
<body>
<form id="myForm" name="myForm" method="post">
    <input type="hidden" id="pkg_name" name="pkg_name" value="${TCA_INFO.pkg_name}"/>
   	<input type="hidden" id="table_name" name="table_name" value="${TCA_INFO.table_name}"/>
  	<input type="hidden" id="node_no" name="node_no" value="${TCA_INFO.node_no}"/>
  	<input type="hidden" id="column_name" name="column_name" value="${TCA_INFO.column_name}"/>
  	
  	<input type="hidden" id="Critical_Over_left"   name="Critical_Over_left"   value="${TCA_INFO.critical_over_left}"/>
	<input type="hidden" id="Critical_Over_right"  name="Critical_Over_right"  value="0" />
	<input type="hidden" id="Major_Over_left"      name="Major_Over_left"      value="${TCA_INFO.major_over_left}"/>
	<input type="hidden" id="Major_Over_right"     name="Major_Over_right"     value="${TCA_INFO.major_over_right}"/>
	<input type="hidden" id="Minor_Over_left"      name="Minor_Over_left"      value="${TCA_INFO.minor_over_left}"/>
	<input type="hidden" id="Minor_Over_right"     name="Minor_Over_right"     value="${TCA_INFO.minor_over_right}"/>
	<input type="hidden" id="Cleared_left"         name="Cleared_left"         value="${TCA_INFO.cleared_left}"/>
	<input type="hidden" id="Cleared_right"        name="Cleared_right"        value="${TCA_INFO.cleared_right}"/>
	<input type="hidden" id="Minor_Under_left"     name="Minor_Under_left"     value="${TCA_INFO.minor_under_left}"/>
	<input type="hidden" id="Minor_Under_right"    name="Minor_Under_right"    value="${TCA_INFO.minor_under_right}"/>
	<input type="hidden" id="Major_Under_left"     name="Major_Under_left"     value="${TCA_INFO.major_under_left}"/>
	<input type="hidden" id="Major_Under_right"    name="Major_Under_right"    value="${TCA_INFO.major_under_right}"/>	
	<input type="hidden" id="Critical_Under_left"  name="Critical_Under_left"  value="0" />
	<input type="hidden" id="Critical_Under_right" name="Critical_Under_right" value="${TCA_INFO.critical_under_right}" />
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
							<input type="text"  value="${TCA_INFO.node_name}" disabled="disabled" />
						</td>
                        <td>
							<input type="text"  value="${TCA_INFO.table_name}" disabled="disabled" />
						</td>
                        <td>
							<input type="text"  value="${TCA_INFO.column_name}" disabled="disabled" />
                        </td>
                        <td>
							<select class="single" id="actYn" name="actYn">
							    <c:forEach items="${actYn}" var="actYnlist" varStatus="status">
                                	<option value="${actYnlist.ID}" <c:if test="${TCA_INFO.act_yn eq actYnlist.ID}">Selected</c:if>>${actYnlist.NAME}</option>
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
							<input type="text"  id="minValue_temp" name="minValue_temp" placeholder="" class="input_xs" value="${TCA_INFO.min_value}" />
						</td>
                        <td>
							<input type="text"  id="maxValue_temp" name="maxValue_temp"  placeholder="" class="input_xs" value="${TCA_INFO.max_value}" />
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
							<input type="text" id="unitValue_temp" name="unitValue_temp" placeholder="" class="input_xs" value="${TCA_INFO.unit_value}" />
							<button type="button" class="btn_stroke" id="btn_stroke" ><spring:message code="label.common.edit" /></button>
							
						</td>
                    </tr>
                </table>
            </div>
        </div>
        <!-- //cont_body -->
        <div class="cont_footer">
            <div class="btn_area">
                <button id="cancelButton" type="button"><spring:message code="label.common.cancel.text" /></button>
                <button id="btn_save" class="major" type="button"><spring:message code="label.common.save" /></button>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content -->
    
</form>

</body>    