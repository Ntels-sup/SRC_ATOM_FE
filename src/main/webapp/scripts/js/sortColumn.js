/**
 * 화면 구성
 * @param orderBy_clause
 */
function fnOrderBy(orderBy_clause) {
	var array_orderBy_clause = orderBy_clause.split(",");
	var orderByLen = array_orderBy_clause.length;
	var sortColName = array_orderBy_clause[0].split(" ")[0];
	
	if (sortColName == "ORDER_DATE") sortColName = "DATE";
	if (sortColName == "DISPLAY_ORDER") sortColName = array_orderBy_clause[1].split(" ")[0];

	var colName;
	var sortGubun;
	
	for(var i = 0; i < orderByLen; i++) {
		colName = array_orderBy_clause[i].split(" ")[0];
		sortGubun = array_orderBy_clause[i].split(" ")[1];
		
		if (colName == "ORDER_DATE") colName = "DATE";
		
    	if(sortGubun == 'ASC') {
    		$("span[" + "id='" + colName + " DESC'" + "]").hide();
    		$("span[" + "id='" + colName + " ASC'" + "]").show();
    		if(colName == sortColName) $("span[" + "id='" + colName + " ASC'" + "]").children("span").css("color", "yellow");
    		if(colName != sortColName) $("span[" + "id='" + colName + " ASC'" + "]").children("span").css("color", "");
    	} else {
    		$("span[" + "id='" + colName + " ASC'" + "]").hide();
    		$("span[" + "id='" + colName + " DESC'" + "]").show();
    		if(colName == sortColName) $("span[" + "id='" + colName + " DESC'" + "]").children("span").css("color", "yellow");
    		if(colName != sortColName) $("span[" + "id='" + colName + " DESC'" + "]").children("span").css("color", "");
    	}
	}
}

/**
 * 모니터링 ordering 구성
 * @param sortColName
 * @param sortGubun
 */
function fnChangeOrderBy(sort, order) {
	//console.log(sort + " " + order);			
	var defaultOrderByClause = $("#default_orderBy_clause").val();
	
	var removeOrder = "ASC";
	if (order == "ASC") removeOrder = "DESC";
	
	var changeOrderByClause;
	var removeOrderByClause;
	
	if (sort == "SEVERITY") {
		changeOrderByClause = "DISPLAY_ORDER " + order + "," + sort + " " + order;
		removeOrderByClause = "DISPLAY_ORDER " + removeOrder + "," + sort + " " + removeOrder + ",";
	} else {
		changeOrderByClause = sort + " " + order;	
		removeOrderByClause = sort + " " + removeOrder + ",";
	}
	//console.log(changeOrderByClause);
	//console.log(removeOrderByClause);
	
	if(defaultOrderByClause.length > 1) {
		changeOrderByClause = changeOrderByClause + "," + defaultOrderByClause.replace(removeOrderByClause, "");
	}
	//console.log(changeOrderByClause);
	fnOrderBy(changeOrderByClause);
	$("#orderBy_clause").val(changeOrderByClause);
	$("#page").val("1");
	
	goSearch();
}


function fnChgOrderBy(sortColName, sortGubun) {
	var array_default_orderBy_clause = $("#default_orderBy_clause").val().split(",");
	var orderByLen = array_default_orderBy_clause.length;
	var orderBy_clause = sortColName + " " + sortGubun;

	if(orderByLen > 1) {
		for(var i = 0; i < orderByLen; i++) {
			if(array_default_orderBy_clause[i].indexOf(sortColName) != -1) {
				orderBy_clause = orderBy_clause + "," +  array_default_orderBy_clause.slice(0, i).concat(array_default_orderBy_clause.slice(i+1, array_default_orderBy_clause.length));
				break;
			}
		}
	}
	//alert(orderBy_clause);

	$("#orderBy_clause").val(orderBy_clause);
	$("#page").val("1");

	goSearch();
}


function fnCheckHistPeriod(start_date_obj, start_hour_obj, start_min_obj, end_date_obj, end_hour_obj, end_min_obj, format ){
    var o_start_date = $(start_date_obj).val();
    var start_hour = $(start_hour_obj).val();
    var start_min = $(start_min_obj).val();
    var o_end_date = $(end_date_obj).val();
    var end_hour = $(end_hour_obj).val();
    var end_min = $(end_min_obj).val();

    var param = new Object();
    param.start_date = o_start_date;
    param.end_date = o_end_date;
    
    var start_date ="";
    var end_date   ="";
		$.ajax({
            url : "/atom/commonCode/histDateValue",
            data : param,
            type : 'POST',
            async: false,
            dataType : 'json',
            success : function(data) {
            	start_date = data.start_date;
            	end_date = data.end_date;
            	},
            error: function(e){
                alert(e.reponseText);
            },
            complete : function() {

            }
		});
    

    var arr_start_date = start_date.split("-");
    var arr_end_date = end_date.split("-");
    var start_date_time = "";
    var end_date_time = "";
    var check_date_time = "";
    var check_date = new Date();

    	check_date.setFullYear(parseInt(arr_start_date[0]), parseInt(arr_start_date[1])-1, parseInt(arr_start_date[2]));
    	check_date.setHours(parseInt(start_hour), parseInt(start_min), 0, 0);
    	start_date_time = arr_start_date[0] + arr_start_date[1] + arr_start_date[2] + start_hour + start_min;
    	end_date_time = arr_end_date[0] + arr_end_date[1] + arr_end_date[2] + end_hour + end_min;
    if(end_date_time < start_date_time) {
    	 //$(end_date_obj).focus();
         return "wrong_period";
    }

    return "";
}











function fnCheckPeriod(start_date_obj, start_hour_obj, start_min_obj, end_date_obj, end_hour_obj, end_min_obj, search_type_obj){
    var o_start_date = $(start_date_obj).val();
    var start_hour = $(start_hour_obj).val();
    var start_min = $(start_min_obj).val();
    var o_end_date = $(end_date_obj).val();
    var end_hour = $(end_hour_obj).val();
    var end_min = $(end_min_obj).val();
    var search_type = $(search_type_obj).val();
    
  
    var holyCheck_dat = 5 ; // 기본 5일
    var dailyCheck_dat = 10 ; // 기본 10일

    var param = new Object();
    param.start_date = o_start_date;
    param.end_date = o_end_date;
    
    var start_date ="";
    var end_date   ="";
		$.ajax({
            url : "/atom/commonCode/atomDateValue",
            data : param,
            type : 'POST',
            async: false,
            dataType : 'json',
            success : function(data) {
            	start_date = data.start_date;
            	end_date = data.end_date;
            	holyCheck_dat = data.holyCheck_dat;
            	dailyCheck_dat = data.dailyCheck_dat;
            },
            error: function(e){
                alert(e.reponseText);
            },
            complete : function() {

            }
		});
    

    var arr_start_date = start_date.split("-");
    var arr_end_date = end_date.split("-");
    var start_date_time = "";
    var end_date_time = "";
    var check_date_time = "";
    var check_date = new Date();
    


    	check_date.setFullYear(parseInt(arr_start_date[0]), parseInt(arr_start_date[1])-1, parseInt(arr_start_date[2]));

    	if(search_type == "1" || search_type == "5" || search_type == "6") {
    		check_date.setHours(parseInt(start_hour), parseInt(start_min), 0, 0);
    		start_date_time = arr_start_date[0] + arr_start_date[1] + arr_start_date[2] + start_hour + start_min;
    		end_date_time = arr_end_date[0] + arr_end_date[1] + arr_end_date[2] + end_hour + end_min;
    	} else if(search_type == "2") {
        	check_date.setHours(parseInt(start_hour), 0, 0, 0);
    		start_date_time = arr_start_date[0] + arr_start_date[1] + arr_start_date[2] + start_hour + "00";
    		end_date_time = arr_end_date[0] + arr_end_date[1] + arr_end_date[2] + end_hour + "00";
    	}
    
    	
    	
    if((search_type == "1" || search_type == "5" || search_type == "6" || search_type == "2") && (end_date_time < start_date_time)) {
    	 //$(end_date_obj).focus();
         return "wrong_period";
    }

    if(search_type == "1" || search_type == "5" || search_type == "6") {
    	// 5/10/30분 주기인 경우 한달30일 이전 조회 제한.
    	console.log("holyCheck_dat :"+holyCheck_dat);
    	check_date.setDate(check_date.getDate()+holyCheck_dat);   // 한달
    	check_date_time = check_date.getFullYear()
    	                + ("00" + (check_date.getMonth() + 1)).slice(-2)
    	                + ("00" + check_date.getDate()).slice(-2)
    	                + ("00" + check_date.getHours()).slice(-2)
    	                + ("00" + check_date.getMinutes()).slice(-2);
    	if(check_date_time < end_date_time){
    		if(search_type == "1") {
    			return "is5minutePerDay";
    		}else if(search_type == "5") {
				return "is10minutePerDay";
        	} else {
        		return "is30minutePerDay";
        	}
    	}
    	
    	
    } else if(search_type == "2") {
    	// 시간 주기인 경우 1년 기간 설정 체크
    	console.log("dailyCheck_dat :"+dailyCheck_dat);
		check_date.setDate(check_date.getDate()+dailyCheck_dat);   
		//check_date.setFullYear(check_date.getFullYear()+1);
    	check_date_time = check_date.getFullYear()
        				+ ("00" + (check_date.getMonth() + 1)).slice(-2)
        				+ ("00" + check_date.getDate()).slice(-2)
        				+ ("00" + check_date.getHours()).slice(-2)
        				+ ("00" + check_date.getMinutes()).slice(-2);

    	check_date_time
    	if(check_date_time < end_date_time) {
			//$(end_date_obj).focus();
			return "ishourPerYear";
       }
    }

    return "";
}


function fnPerFomCheckPeriod(start_date_obj, start_hour_obj, start_min_obj, end_date_obj, end_hour_obj, end_min_obj, search_type_obj,tableName){
    var o_start_date = $(start_date_obj).val();
    var start_hour = $(start_hour_obj).val();
    var start_min = $(start_min_obj).val();
    var o_end_date = $(end_date_obj).val();
    var end_hour = $(end_hour_obj).val();
    var end_min = $(end_min_obj).val();
    var search_type = $(search_type_obj).val();
    var o_tableName = $(tableName).val();
    
  
    var holyCheck_dat = 5 ; // 기본 5일
    var dailyCheck_dat = 10 ; // 기본 10일

    var param = new Object();
    param.start_date = o_start_date;
    param.end_date = o_end_date;
    param.tableName = o_tableName;
    
    var start_date ="";
    var end_date   ="";
		$.ajax({
            url : "/atom/commonCode/PerFomdateValue",
            data : param,
            type : 'POST',
            async: false,
            dataType : 'json',
            success : function(data) {
            	start_date = data.start_date;
            	end_date = data.end_date;
            	holyCheck_dat = data.holyCheck_dat;
            	dailyCheck_dat = data.dailyCheck_dat;
            },
            error: function(e){
                alert(e.reponseText);
            },
            complete : function() {

            }
		});
    

    var arr_start_date = start_date.split("-");
    var arr_end_date = end_date.split("-");
    var start_date_time = "";
    var end_date_time = "";
    var check_date_time = "";
    var check_date = new Date();
    


    	check_date.setFullYear(parseInt(arr_start_date[0]), parseInt(arr_start_date[1])-1, parseInt(arr_start_date[2]));

    	if(search_type == "1" || search_type == "5" || search_type == "6") {
    		check_date.setHours(parseInt(start_hour), parseInt(start_min), 0, 0);
    		start_date_time = arr_start_date[0] + arr_start_date[1] + arr_start_date[2] + start_hour + start_min;
    		end_date_time = arr_end_date[0] + arr_end_date[1] + arr_end_date[2] + end_hour + end_min;
    	} else if(search_type == "2") {
        	check_date.setHours(parseInt(start_hour), 0, 0, 0);
    		start_date_time = arr_start_date[0] + arr_start_date[1] + arr_start_date[2] + start_hour + "00";
    		end_date_time = arr_end_date[0] + arr_end_date[1] + arr_end_date[2] + end_hour + "00";
    	}
    
    	
    	
    if((search_type == "1" || search_type == "5" || search_type == "6" || search_type == "2") && (end_date_time < start_date_time)) {
    	 //$(end_date_obj).focus();
         return "wrong_period";
    }

    if(search_type == "1" || search_type == "5" || search_type == "6") {
    	// 5/10/30분 주기인 경우 한달30일 이전 조회 제한.
    	console.log("holyCheck_dat :"+holyCheck_dat);
    	check_date.setDate(check_date.getDate()+holyCheck_dat);   // 한달
    	check_date_time = check_date.getFullYear()
    	                + ("00" + (check_date.getMonth() + 1)).slice(-2)
    	                + ("00" + check_date.getDate()).slice(-2)
    	                + ("00" + check_date.getHours()).slice(-2)
    	                + ("00" + check_date.getMinutes()).slice(-2);
    	if(check_date_time < end_date_time){
    		if(search_type == "1") {
    			return "is5minutePerDay";
    		}else if(search_type == "5") {
				return "is10minutePerDay";
        	} else {
        		return "is30minutePerDay";
        	}
    	}
    	
    	
    } else if(search_type == "2") {
    	// 시간 주기인 경우 1년 기간 설정 체크
    	console.log("dailyCheck_dat :"+dailyCheck_dat);
		check_date.setDate(check_date.getDate()+dailyCheck_dat);   
		//check_date.setFullYear(check_date.getFullYear()+1);
    	check_date_time = check_date.getFullYear()
        				+ ("00" + (check_date.getMonth() + 1)).slice(-2)
        				+ ("00" + check_date.getDate()).slice(-2)
        				+ ("00" + check_date.getHours()).slice(-2)
        				+ ("00" + check_date.getMinutes()).slice(-2);

    	check_date_time
    	if(check_date_time < end_date_time) {
			//$(end_date_obj).focus();
			return "ishourPerYear";
       }
    }

    return "";
}


//Atom Sort==========================================================================

function listSort(target){
	var orderBy = "";
	var thClass = "";
	
	if($(target).attr("class") == "sort up"){
		$(target).attr("class", "sort down");
	} else if($(target).attr("class") == "sort down"){
		$(target).attr("class", "sort up");
	} 
	
	if($(target).attr("class") == "date sort up"){
		$(target).attr("class", "date sort down");
	} else if($(target).attr("class") == "date sort down"){
		$(target).attr("class", "date sort up");
	}
	
	
	
	$(target).parent().children("date.sort.up, date.sort.down, .sort.up, .sort.down").each(function(index){
		if(orderBy == ""){
			orderBy = $(this).attr("id");
			if($(this).attr("class") == "sort up"){
				orderBy += " ASC";
			}else if($(this).attr("class") == "date sort up"){
				orderBy += " ASC";
			}else {
				orderBy += " DESC";
			}
		} else {
			orderBy += ", " + $(this).attr("id");
			if($(this).attr("class") == "sort up"){
				orderBy += " ASC";
			}else if($(this).attr("class") == "date sort up"){
				orderBy += " ASC";
			}else {
				orderBy += " DESC";
			}
		}
	});
	
	$(target).parent().children("date.sort.up, date.sort.down, .sort.up, .sort.down").each(function(index){
		if(thClass == ""){
			thClass = $(this).attr("id")+":"+$(this).attr("class");
		} else {
			thClass += ","+$(this).attr("id")+":"+$(this).attr("class");
		}
	});
	
	$("#orderBy").val(orderBy);
	$("#sortClass").val(thClass);
	
	goSearch();
}


function sortClass(sortTag){
	var thTags = sortTag.split(",");
	
	for(var i=0; i<thTags.length; i++){
		var thId = thTags[i].split(":")[0];
		var thClass = thTags[i].split(":")[1];
		
		$(".sort").each(function(index){
			if($(this).attr("id") == thId){
				$(this).attr("class",thClass);
			}
		});
	}
}

function fnCheckStr(obj) {
	var oldStr = $(obj).val();
	var newStr = oldStr.replace(/[^\w\s\{\}\[\]\/?.,:;|\(\)*~`!^\-_+<>@\#$%&\\\=\'\"]/gi, "");
	$(obj).val(newStr);
}
