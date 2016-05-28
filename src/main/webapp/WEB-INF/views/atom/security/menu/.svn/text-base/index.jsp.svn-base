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

<link rel="stylesheet" href="/styles/tree/ui.dynatree.css"> 
<script type="text/javascript" charset="utf-8" src="/scripts/dynaTree/jquery.dynatree.js"></script>


    
<script type="text/javascript">
var language = '${language}';

$(document).ready(function() {
   // package 에 해당하는 트리만 그린다.
	$("select[id='package_id']").multipleSelect({
        single: true
       ,selectAll: false
       ,multiple: false
		,multipleWidth: 150
       ,width: "100px"
       ,onClick: function(view) {
    	   $('#menuAttribute').empty();
    	   reloadMenuTree(view.value);
         }
   });
	
   loadMenuTree();
	
});

//트리 타이틀 클릭시 이벤트 처리
$(document).on("click", ".dynatree-title", function(){
	var node = $("#dynatree").dynatree("getActiveNode");
 	if(node.data.key != $("#treeKey").val()) {
		// data 갱신시 페이지를 다시 로딩하지 않고 tree를 핸들링하기 위한 셋팅
		$("#treeKey").val(node.data.key);
		getViewMenuPage(node.data.key);
	}
	
});




function loadMenuTree(){
	var param = new Object();
	param.package_id = $('#package_id').val();
	
	// Initialize the tree inside the <div>element.
	// The tree structure is read from the contained <ul> tag.
	$("#dynatree").dynatree({
 		initAjax: {
 			type : "post",
 			data : param,
 			dataType : "json",
 			async: false,
 			url: "/atom/security/menu/getMenuDynaTree.json"
 		},
 		debugLevel: 0,
 		autoFocus: false,
		clickFolderMode: 1,
		minExpandLevel: 2,
/*  	    onClick: function(node) {
				getViewMenuPage(node.data.key);
 	    },  */
		onDblClick: function(node) {
			if(node.data.isFolder) {
				node.toggleExpand();
			}
		}
	});
	
	if('${menu_id}' != ''){
	$("#dynatree").dynatree("getTree").activateKey('${menu_id}');
	var node = $("#dynatree").dynatree("getActiveNode");
	node.expand(true);
	getViewMenuPage('${menu_id}');
	}
   
}

function reloadMenuTree(value){
	var param = new Object();
	param.package_id = value;

	// Initialize the tree inside the <div>element.
	// The tree structure is read from the contained <ul> tag.
	$("#dynatree").dynatree({
 		initAjax: {
 			type : "post",
 			data : param,
 			dataType : "json",
 			async: false,
 			url: "getMenuDynaTree.json"
 		},
 		debugLevel: 0,
 		autoFocus: false,
		clickFolderMode: 1,
		minExpandLevel: 2,
/*  	    onClick: function(node) {
				getViewMenuPage(node.data.key);
 	    },  */
		onDblClick: function(node) {
			if(node.data.isFolder) {
				node.toggleExpand();
			}
		}
	});
	$("#dynatree").dynatree("getTree").reload();
	
	
	
}





//메뉴 그룹 등록
function fnAddMenuGroup(){
	 
	var node = $('#dynatree').dynatree("getActiveNode");
	if(!node) {
		 openAlertModal('<spring:message code="msg.need.select.menu.text"/>');
		return;
	}

    if(!node.data.isFolder) {
    	openAlertModal('<spring:message code="msg.not.menu_group.text"/>');
        return;
    }
    
    //ATOM 그룹 2deth까지 등록가능. 그외 그룹 1depth까지 등록가능.
	   if($('#package_id').val() =="ATOM"){
		   	if(node.data.depth  < 2 ){
		    	goInsertMenuPage("Y", node.data.key , $('#package_id').val());
		    }else{
	    		openAlertModal('<spring:message code="msg.limit.two.depth.menu_group.text"/>');
				return;
		    }
	    }else{ 
	    	if(node.data.depth  < 1 ){
	    		goInsertMenuPage("Y", node.data.key , $('#package_id').val());
		    }else{
		    	openAlertModal('<spring:message code="msg.limit.one.depth.menu_group.text"/>');
		    	return;
		    }
	    }

    node.expand(true);
}

//메뉴 등록
function fnAddMenu(){
	var node = $('#dynatree').dynatree("getActiveNode");
	if(!node) {
		 openAlertModal('<spring:message code="msg.need.select.menu.text"/>');
		return;
	}
	if(!node.data.isFolder) {
		openAlertModal('<spring:message code="msg.not.menu.text"/>');
		return;
	}
	goInsertMenuPage("N", node.data.key , $('#package_id').val());
    node.expand(true);
}

function goInsertMenuPage(is_folder, menu_id , pkg_name) {
	var param = new Object();
	param.is_folder =  is_folder;
	param.menu_id   =  menu_id;
	param.pkg_name  = pkg_name; 
	
    $.post('insert.ajax', param, function(data) {
		$('#menuAttribute').html(data);
    });
}

function getViewMenuPage(node_id) {
	if(node_id == "0") {
		$('#menuAttribute').empty();
        return;
    }

	var param = new Object();
	param.menu_id =  node_id;
	$.post('detailMenuAction.ajax', param, function(data) {
		$('#menuAttribute').empty();
		$('#menuAttribute').html(data);
	});
	$('#dynatree').dynatree("getTree").activateKey(node_id);
	
}



/**
 * 트리 열기
 */
function expandAll() {
	$('#dynatree').dynatree("getRoot").visit(function(node){
		node.expand(true);
	});
}

/**
 * 트리 닫기
 */
function collapseAll() {
	$('#dynatree').dynatree("getRoot").visit(function(node){
		node.expand(false);
	});
}



</script>

</head>
<body>
<form id="myForm" name="myForm" method="post">
<input type="hidden" id="packageId"  name="packageId"    value="" />
<input type="hidden" id="childCnt"  name="childCnt"    value="" />

<!-- content -->

<div class="content">
	<div class="cont_body">
    <header>
    <label>Package</label>
    <select id="package_id" name="package_id" class="single type3">
     <c:forEach items="${Package}" var="Packagelist" varStatus="status">
     	<option value="${Packagelist.ID}" <c:if test="${Packagelist.ID eq pkg_name}"> selected="selected"</c:if> > ${Packagelist.NAME}</option>
     </c:forEach>    
    </select>
    <p><spring:message code="label.security.menu.explanation.text"/></p>
    </header>
    <article class="box_2cols">
		<div class="boxLeft">
			<header><spring:message code="label.security.menu.menu_structure.text"/></header>
			<ul class="treeCon">
				<li><a id="btnExpandAll" class="full" href="javascript:expandAll();" title="<spring:message code="label.security.menu.tree_open.text"/>"></a></li>
				<li><a id="btnCollapseAll" class="close" href="javascript:collapseAll();" title="<spring:message code="label.security.menu.tree_close.text"/>"></a></li>
                <ntels:auth auth="${menuAuth}">
                <li><a id="btnAddMenuGroup" class="group" href="javascript:fnAddMenuGroup();" title="<spring:message code="label.security.menu.group_insert.text"/>"></a></li>
				</ntels:auth>
				<ntels:auth auth="${menuAuth}">
				<li><a id="btnAddMenu" class="menu" href="javascript:fnAddMenu();" title="<spring:message code="label.security.menu.insert.text"/>"></a></li>
			    </ntels:auth>
			</ul>
			<div class="boxContent">
				<div class="menuTree" id="dynatree"></div>
			</div>
        </div><!-- // boxLeft -->    
            
        <div class="boxRight" id="menuAttribute">
        </div><!-- // boxRight -->        
	</article>
	</div><!-- //cont_body --> 
	
</div><!--// content -->
</form>



</body>
<input type="hidden" id="treeKey" name="treeKey">
</html>
