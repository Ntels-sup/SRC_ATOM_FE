<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>

<script src="/scripts/locales/bootstrap-datepicker.${language}.min.js" charset="UTF-8"></script>
<script src="/scripts/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

<script type="text/javascript">
var language = '${language}';
	$(document).ready(function() {
	    
	  //package select 
		$("#pkg_name").multipleSelect({
			 filter: false
			,width: "162px"
	        ,single: true
	        ,selectAll: false
	        ,multiple: false
	        ,onClick: function(view) {
	        	//statistics combo list 검색
	        	fn_tableName(view.value);
	        	var tableName=$("table_name").multipleSelect('getSelects')[0];
	        	goSearchList(view.value, tableName);
	        }  
	    });
	  
	  	//statistics select
		$("#table_name").multipleSelect({
			 filter: false
			,width: "162px"
	        ,single: true
	        ,selectAll: false
	        ,multiple: false 
	        ,onClick: function(view){
            	var pkgName = $("#pkg_name").multipleSelect('getSelects')[0];
            	
            	//List 조회 (param -> 1 : package, 2 : statistics)
            	goSearchList(pkgName, view.value);
            }
	   });
	    
		fn_tableName($("#pkg_name").val());
		
		fnInit();
	});

	
	function fn_tableName(pkgNm){
		var param = null;
		param  = "&"+"pkgNm="+pkgNm;
		$("#table_name").empty();
		$("#table_name").multipleSelect('refresh');
		$.ajax({
	        url : "tableNameCombo",
	        data : param,
	        type : 'POST',
	        async: false,
	        dataType : 'json',
	        success : function(data) {
	    		var array = data;
	    		var optionTag;
	    		 $("#table_name").html('<option value="all">All</option>');
	    		$.each(array,function(index,appObj) {
	    			optionTag = $('<option value="'+appObj.TABLE_NAME+'">'+appObj.TABLE_NAME+'</option>');
	    			$("#table_name").append(optionTag).multipleSelect('refresh');
	    		});
	        },
	        error: function(e){
	            openAlertModal(e.reponseText);
	        },
	        complete : function() {

	        }
		});
	}
	
    function goSearchList(pkgNm, tableNm){
    	fnShowLoading();
    	
		var param = new Object();
		param.pkg_name = pkgNm;
		param.table_name = tableNm;
		
		$.ajax({
            url : "listAction",
            data : param,
            type : 'POST',
            success : function(data) {
            	 $("#historyTable").html(data);
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {
				
            }
		});
    }
	
    function fnInit(){
    	goSearchList();
    }

	/**
	 * 조회시 로딩.. 이미지
	 */
    function fnShowLoading() {
        var loadImage =  '<div class="scroll" id="loading"><div class="loading"><span class="loading-inner"></span></div></div>';;
        $('#historyTable').children().remove();
        $('#historyTable').append(loadImage);   
    }
</script>

<body>
	 <form id="myForm" name="myForm" method="post">
			<!-- sort시 필요 -->
  			<input type="hidden" id="orderBy" name="orderBy" >
  			<input type="hidden" id="sortClass" name="sortClass">
			<input type="hidden" id="titleName"  name="titleName"    value="${titleName}" />
			<input type="hidden" id="dateformat" name="dateformat" value="${dateformat}" />
			
				<div class="content">
					<div class="cont_body">
			            <header>
			            	<p><spring:message code="label.performance.statisticsconfig.explain.text"/></p>
							<div class="cont_top_right">
				                <div class="select_multi type3">
				                    <label><spring:message code="label.performance.statisticsconfig.package.text"/></label>
				                    <select class="single" id="pkg_name" name="pkg_name">
										 <option value="all">All</option> 
										<c:forEach items="${listPackage}" var="Package" varStatus="status">
											<option value="${Package.ID}">${Package.NAME}</option>
										</c:forEach>
									</select>
				                </div>
								<div class="select_single type3">
									<label><spring:message code="label.performance.statisticsconfig.statistics.text"/></label>
									<select id="table_name" name="table_name" class="single">

									</select>
								</div>
							</div>
			            </header>
					<div id="historyTable"></div> <!-- 데이터는 다른 화면에서 미리 만들고 ajax로 호출함 -->
	  			</div>
			</div>
	</form>
</body>