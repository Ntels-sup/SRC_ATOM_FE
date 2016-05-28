<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript" charset="utf-8" src="/scripts/jquery.alphanumeric.js"></script>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
    	
    	$("#btn_save").hide();
    	$("#btn_cancel").hide();
    	
    	$(".edit").click(function() {
    		fnRowEdit(this);
        });
        
        $("#btn_save").click(function() {
            fnSave();
        });
    	
        $("#btn_cancel").click(function() {
            fnCancel();
        });
        
    }); 
    
    function fnRowEdit(btn){
		var td=$(btn).parent().parent().children();
		var collect_period=$(td[3]).text();
		var sHtml = "";
		var bHtml="";

		sHtml += "<input type=\"text\" style=\"width:100%;\" value=\""+collect_period+"\"  maxlength=\"9\"/>";
		$(td[3]).html(sHtml);
		
		//bHtml += "		<button type=\"button\" class=\"btn_row save\" onClick=\"javascript:updateNodeGrp(this);\"><span><spring:message code="label.common.save"/></span></button>";
		$(td[4]).html(bHtml);
		
		var collect_yn_id=$(td[2]).find("input")[0].id;
		$("#"+collect_yn_id).prop("disabled",false);
    	
    	
    	$("input[type=text]").numeric();
    	$("#btn_save").show();
    	$("#btn_cancel").show();
    	
    	
   }
    
	function fnCancel(){
		goSearchList("${searchVal.pkg_name}", "${searchVal.table_name}");
	}
	
	function fnSave(){
		var text=$("input[type=text]");
		for(var i=0; i<$(text).length; i++){
		 	if (!$.isNumeric($(text[i]).val() )) {
	        	openAlertModal("","<spring:message code="msg.performance.statisticsconfig.collect_period.invalid" />", function(){
	    			$(text[i]).focus();
	        	});
				return;
			}			
		}
	 	
		var array=new Array();
		var tr=$("table.tbl_update tbody > tr ");
		 
		for(var i=0; i<tr.length; i++){
			  var obj=new Object();
	 		 	
			  var pkg_name = $(tr[i]).children("td").eq(0).text();
		   	  var table_name = $(tr[i]).children("td").eq(1).text();
	  
	 		  if($(tr[i]).children("td").eq(2).find("input[name=collect_yn]").is(":checked")){
	  			var collect_yn = "Y";
	  		  } else {
	  			var collect_yn = "N";
	  		  }
	  		
		     if( $(tr[i]).children("td").eq(4).children("button").length == 0){
		   		var collect_period= $(tr[i]).children("td").eq(3).find("input[type=text]").val();
		   	 }else{
		 	    var collect_period = $(tr[i]).children("td").eq(3).text();
			 }
				
	  		 obj.pkg_name=pkg_name;
		  	 obj.table_name=table_name;
		  	 obj.collect_period=collect_period;
	  	     obj.collect_yn=collect_yn;
	  	    		 
			 array.push(obj);
		}
		 
		var param=new Object();
		param.jsonArr=JSON.stringify(array);
		
		openConfirmModal("", "<spring:message code="msg.common.save" />", function(){
			$.ajax({
	            url : "modifyAction",
	            data : param,
	            type : 'POST',
	            dataType : 'json',
	            success : function(data) {
	            	var result=data.result;
	            	if(result=="succ"){
		            	openAlertModal("","<spring:message code="msg.common.saved" />",function(){
		             		//list search
		                	goSearchList("${searchVal.pkg_name}", "${searchVal.table_name}");
		            	});
	            	} else{
	            		 openAlertModal("",result);
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
	
//-->
</script>
<!-- 리스트 start -->                    
            <div class="list type03">
                 <table class="tbl_update">
                    <colgroup>
                      	<col width="25%"/>
						<col width="25%"/>
						<col width="20%"/>
						<col width="*"/>
						<col>
						<col width="10px"/>
                    </colgroup>
                    <thead>
                        <tr>
                           	<th><spring:message code="label.performance.statisticsconfig.package.text"/></th>
							<th><spring:message code="label.performance.statisticsconfig.statistics.text"/></th>
							<th><spring:message code="label.performance.statisticsconfig.collect.text"/></th>
							<th class="t_c"><spring:message code="label.performance.statisticsconfig.collect_period.text"/></th>
							<th class="ico"></th>
							<th></th>
                        </tr>
                    </thead>
                 </table>
				 <div class="scroll">
	                <table class="tbl_update">
						<colgroup>
							<col width="25%">
							<col width="25%">
							<col width="20%">
							<col width="*">
							<col>
						</colgroup>
                      	<tbody>
                          <c:forEach items="${statisticsConfig.lists}" var="statisticsConfig" varStatus="status">
						    <tr>
						      <td>${statisticsConfig.pkg_name}</td>
						      <td>${statisticsConfig.table_name}</td>
						      <td>
								<span class="switch blue">
									<input id="collect_yn${status.count}" class="toggle toggle-round" type="checkbox" name="collect_yn" disabled="true"
									<c:if test="${statisticsConfig.collect_yn eq 'Y'}">checked</c:if>>
									<label for="collect_yn${status.count}"></label>
								</span>
				      		  </td>
						      <td class="t_c">${statisticsConfig.collect_period}</td>
						      <td class="ico"><button type="button" class="btn_row edit"  id="rowEditBtn"><span>수정</span></button></td>
						    </tr>
						  </c:forEach>
 						  <c:if test="${empty statisticsConfig.lists}">
						    <tr class="odd" style="cursor:default;">
						      <td align="center" colspan="9"><spring:message code="label.empty.list" /></td>
						    </tr>
						  </c:if>
                      	</tbody>
                     </table>
                 </div>
           </div>
<!-- 리스트 end -->

<!-- 페이징 start -->
		 	<div class="cont_footer">
        		<div class="util"><span><em>${statisticsConfig.totalCount}</em>rows(s)</span></div>
           		 <div class="btn_area">
                	<button type="button"  id="btn_cancel"><spring:message code="label.common.cancel.text" /></button>
               		 <button type="button" id="btn_save" class="major"><spring:message code="label.common.save.text" /></button>
           		 </div>
       		 </div>
<!-- 페이징 end -->



