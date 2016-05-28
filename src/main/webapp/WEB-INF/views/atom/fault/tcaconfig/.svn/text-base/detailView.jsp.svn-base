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

	valueSet();
	
 	$("#range0").colResizable({
		//liveDrag:false, 
		//draggingClass:"rangeDrag", 
		gripInnerHtml:"<div class='rangeGrip'></div>", 
		//onDrag:onSlide,
		//minWidth :$("#range0").width() * parseInt('${TCA_INFO.unit_value}') / (parseInt('${TCA_INFO.max_value}') - parseInt('${TCA_INFO.min_value}'))
	}); 
		
	//버튼 클릭시
	$("#cancelButton").click(function() {
		goListPage();
	});
	
	
	$("#btn_modify").click(function() {
		goUpdateView();
	});
	
	
	$("#btn_delete").click(function() {
		removeAction();
	});

});

function valueSet(){
	var sHtml = "";
	sHtml += "	<tr>";
	var width = $('#range0').width() * ( parseInt('${TCA_INFO.critical_under_right}')-parseInt('${TCA_INFO.min_value}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
	sHtml += "		<td width=\""+width+"px\" class=\"bar04\"></td>";
	width = $('#range0').width() * ( parseInt('${TCA_INFO.major_under_right}')-parseInt('${TCA_INFO.major_under_left}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
	sHtml += "		<td width=\""+width+"px\" class=\"bar03\"></td>";
	width = $('#range0').width() * ( parseInt('${TCA_INFO.minor_under_right}')-parseInt('${TCA_INFO.minor_under_left}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
	sHtml += "		<td width=\""+width+"px\" class=\"bar02\"></td>";
	width = $('#range0').width() * ( parseInt('${TCA_INFO.cleared_right}')-parseInt('${TCA_INFO.cleared_left}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
	sHtml += "		<td width=\""+width+"px\" class=\"bar05\"></td>";
	width = $('#range0').width() * ( parseInt('${TCA_INFO.minor_over_right}')-parseInt('${TCA_INFO.minor_over_left}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
	sHtml += "		<td width=\""+width+"px\" class=\"bar02\"></td>";
	width = $('#range0').width() * ( parseInt('${TCA_INFO.major_over_right}')-parseInt('${TCA_INFO.major_over_left}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
	sHtml += "		<td width=\""+width+"px\" class=\"bar03\"></td>";
	var width = $('#range0').width() * ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.critical_over_left}') ) / ( parseInt('${TCA_INFO.max_value}')-parseInt('${TCA_INFO.min_value}') )
	sHtml += "		<td width=\""+width+"px\" class=\"bar04\"></td>";
	sHtml += "	</tr>";
	$('#range0').append(sHtml);
	
}


function goListPage() {
	$("#myForm").attr("action", "list");
	$("#myForm").submit();
}

function goUpdateView(){
	$("#myForm").attr("action", "update");
	$("#myForm").submit();
}


function removeAction(){
	
	openConfirmModal("", "<spring:message code="msg.common.delete" />",	function(){
		var param = $("#myForm").serialize();
		$.ajax({
	        url : "deleteAction.ajax",
	        data : param,
	        type : 'POST',
	        dataType : 'json',
	        async: false,
	        success : function(data) {
				result = data.returnMsg;
				if (result == "SUCCESS") {
					openAlertModal( "",data.resultMsg,function(){goListPage();} ); // detail View로 다시 이동
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
		});

}


</script>

</head>
<body>
<form id="myForm" name="myForm" method="post">
    <input type="hidden" id="pkg_name" name="pkg_name" value="${TCA_INFO.pkg_name}"/>
   	<input type="hidden" id="table_name" name="table_name" value="${TCA_INFO.table_name}"/>
  	<input type="hidden" id="node_no" name="node_no" value="${TCA_INFO.node_no}"/>
  	<input type="hidden" id="column_name" name="column_name" value="${TCA_INFO.column_name}"/>

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
							<input type="text"  value="${TCA_INFO.act_yn_dc}" disabled="disabled" />
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
                        <th scope="col" class="imp"><spring:message code="label.fault.tca.value"/>  
                    </tr>
                    <tr>
                        <td>
							<input type="text"  id="minValue" name="minValue" placeholder="" class="input_xs" value="${TCA_INFO.min_value}" disabled="disabled"/>
						</td>
                        <td>
							<input type="text"  id="maxValue" name="maxValue"  placeholder="" class="input_xs" value="${TCA_INFO.max_value}" disabled="disabled"/>
						</td>
                        <td rowspan="3"  class="slidearea">
							<div class="rangeWrap" >
									<ul class="info type02">
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
								
								<table id="range0" class="rangeslide">
								</table>
								
								<ul class="unitNumber">
									<li class="unit01" id="" name="">${TCA_INFO.min_value}</li>
									<li class="unit02" id="" name="">${TCA_INFO.middle_value}</li>
									<li class="unit03" id="" name="">${TCA_INFO.max_value}</li>
								</ul>
							
							</div>
                        </td>
                    </tr>
					<tr>
                        <th scope="col" class="imp" colspan="2">Unit</th>
                    </tr>
					<tr>
                        <td colspan="2">
							<input type="text" id="unitValue" name="unitValue" placeholder="" class="input_xs" value="${TCA_INFO.unit_value}" disabled="disabled"/>
							
						</td>
                    </tr>        
                </table>
            </div>
        </div>
        <!-- //cont_body -->
        <div class="cont_footer">
            <div class="btn_area">
                <button id="cancelButton" type="button"><spring:message code="label.common.list.text" /></button>
            	<ntels:auth auth="${authType}">
                <button id="btn_delete" type="button"><spring:message code="label.common.delete.text" /></button>
                <button id="btn_modify" type="button"><spring:message code="label.common.update.text" /></button>
                </ntels:auth>
            
            
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content -->
    
</form>

</body>    