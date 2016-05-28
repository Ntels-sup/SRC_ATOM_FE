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

<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/selectBox.js"></script>
<style>
.cont_top_right button{width:30px !important;padding:0 !important;min-width:25px !important;}
.cont_top_right .dropdown{display:inline-block;}
.cont_top_right .dropdown_content{display:none;width:70px;position:absolute;z-index:100;margin-left:-17px;background-color:#f9f9f9;box-shadow:2px 4px 9px -1px rgba(0,0,0,0.2);border:1px solid #aaaeb3;border-radius:5px;overflow:hidden;}
.cont_top_right .dropdown_content a{color:black;padding:12px 16px;text-decoration:none;display:block;text-align:center;}
.cont_top_right .dropdown_content a:hover{background-color:#f1f1f1}
.cont_top_right .dropdown:hover .dropdown_content{display:block;}
.cont_top_right .dropdown_content li{border-top:1px solid #e0e3e6;}
.cont_top_right .dropdown_content li:first-child{border-top:none;}
</style>
<script type="text/javascript">
var language = '${language}';
$(document).ready(function() {
	$('#system_id').find('option:first').attr('selected', 'selected');   
	$("select.group").multipleSelect({
			filter: true,
			single: true,  
         multiple: true,
         multipleWidth: 150,
         width: "602px"
       , onClick: function(view) {
    	   $("#system_id").val(view.value);
    	   goSearch();
     	}
     });
	goSearch();
});


	function goSearch(){
		fnShowLoading();
		var param = $("#myForm").serialize();
	        $.post('listAction.ajax', param, function(data) {
	            $('#dataTable').html(data);
	        });
    }
    
    /**
     * Loading image
     */
    function fnShowLoading() {
        var loadImage =  '<div class="scroll" id="loading"><div class="loading"><span class="loading-inner"></span></div></div>';;
        $('.data').children().remove();
        $('.data').append(loadImage);   
    }

    function fnExcel(){
    	if($("tbody > tr > td").html() == '<spring:message code="label.empty.list" />') {
        	openAlertModal('<spring:message code="msg.common.excel.download.alarm" />');
            return;
        }

    	var param = $("#myForm").serialize();
        $.download('exportAction.xls',param,'post');
    }   
    
    
</script>

    </head>
<body>
<form id="myForm" name="myForm" method="post">
			<!-- sort시 필요 -->
	<input type="hidden" id="orderBy" name="orderBy" value="" />
	<input type="hidden" id="sortClass" name="sortClass" value="" />
	<input type="hidden" id="titleName"  name="titleName"    value="${titleName}" />
  	<input type="hidden" id="dateformat" name="dateformat" value="${dateformat}" />
  	
  	<input type="hidden" id="pkg_name" name="pkg_name" />
  	<input type="hidden" id="table_name" name="table_name"/>
  	<input type="hidden" id="node_no" name="node_no"/>
  	<input type="hidden" id="column_name" name="column_name"/>


	<!-- content -->
    <div class="content">
        <div class="cont_body">
            <header>
                <p><spring:message code="label.fault.tca.exp" /></p>
            </header>
            <div class="cont_top_right">
				<div class="select_group type3">
					<label><spring:message code="label.common.package/node" /></label>
                         <select id="system_id" name="system_id" class="group" multiple="multiple" value="checkAll">
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
				</div>
				<div class="dropdown">
					<button type="button" class="btn_icon download dropbtn" title="<spring:message code="label.common.downlaod"/>"><span><spring:message code="label.common.downlaod"/></span></button>
					<ul class="dropdown_content">
						<li><a href="javascript:fnExcel();">Excel</a></li>
					</ul>
				</div>
			</div>
            
            <!-- listAction inner Html -->
			<div id="dataTable"></div>
        </div>
   </div>        
		
		
		
		
		
		
		
		
		
		
		

</form>

</body>
</html>
