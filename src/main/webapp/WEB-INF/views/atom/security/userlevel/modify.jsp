<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<link href="/styles/tree/ui.dynatree.css" rel="stylesheet" type="text/css">

<script type="text/javascript" charset="utf-8" src="/scripts/dynaTree/jquery.dynatree.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/stringUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/jquery.alphanumeric.js"></script>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
    	// multiple select start // 
		$("select.single").multipleSelect({
	        single: true,
	        selectAll: false,
            multiple: false,
            onClick: function(view){
            	//tree reload
            	$('#defMenuTree').empty();
				$('#authMenuTree').empty();
				getMenuTree(view.label);
            }
		});
		
    	//radio(lock type) change 이벤트
		$("input[type=radio][name=lock_type]").change(function(){
			if($(this).attr("id") == "manual"){
				$("#lock_time").val("");
				$("#lockTime").hide();
			} else {
				$("#lock_time").val("${userLevel.lock_time}");
				$("#lockTime").show();
			}
		});
		$("#defExpandAll").click(function(){
			$("#defMenuTree").dynatree("getRoot").visit(function(node){
				node.expand(true);
			});
			return false;
		});
		
		$("#authExpandAll").click(function(){
			$("#authMenuTree").dynatree("getRoot").visit(function(node){
				node.expand(true);
			});
			return false;
		});
		
		$("#defCollapseAll").click(function(){
			$("#defMenuTree").dynatree("getRoot").visit(function(node){
				node.expand(false);
			});
			return false;
		});
		
		$("#authCollapseAll").click(function(){
			$("#authMenuTree").dynatree("getRoot").visit(function(node){
				node.expand(false);
			});
			return false;
		});
		
		$("#authMenuTypeA").click(function(){
			var node = $("#authMenuTree").dynatree("getActiveNode");
			console.log(node);
			var depth1 = getChild(node);
			var depth2;
			var depth3;
			
			var tmpTitle1;
			var tmpTitle2;
			var tmpTitle3;
			var tmpTitle4;
			
			if(!node) {
	    		openAlertModal("","<spring:message code="msg.security.userlevel.check.close.text" />");  
	    		return;
			}
			
			if (node.data.key == "0") return;
				
			if (depth1 != null) {			
				for(var i = 0; i < depth1.length; i++) {
					depth2 = getChild(depth1[i]);
					if (depth2 != null) {
						for(var j = 0; j < depth2.length; j++) {
							depth3 = getChild(depth2[j]);
							if (depth3 != null) {
								for(var k = 0; k < depth3.length; k++) {
									//depth4 = getChild(depth3[k]);
									tmpTitle4 = depth3[k].data.title.split(":");
									depth3[k].data.title = tmpTitle4[0] + ":A</em>";
								}							
							}
							tmpTitle3 = depth2[j].data.title.split(":");
							depth2[j].setTitle(tmpTitle3[0] + ":A</em>");
						}
					}
					tmpTitle2 = depth1[i].data.title.split(":");
					depth1[i].setTitle(tmpTitle2[0] + ":A</em>");
				}			
			}
			tmpTitle1 = node.data.title.split(":");
			node.setTitle(tmpTitle1[0] + ":A</em>");
		});
		
		$("#authMenuTypeR").click(function(){
			var node = $("#authMenuTree").dynatree("getActiveNode");
			var depth1 = getChild(node);
			var depth2;
			var depth3;
					
			var tmpTitle1;
			var tmpTitle2;
			var tmpTitle3;
			var tmpTitle4;
			
			if(!node) {
	    		openAlertModal("","<spring:message code="msg.security.userlevel.check.close.text" />");  
	    		return;
			}
			
			if (node.data.key == "0") return;
			
			if (depth1 != null) {			
				for(var i = 0; i < depth1.length; i++) {
					depth2 = getChild(depth1[i]);
					if (depth2 != null) {
						for(var j = 0; j < depth2.length; j++) {
							depth3 = getChild(depth2[j]);
							if (depth3 != null) {
								for(var k = 0; k < depth3.length; k++) {
									//depth4 = getChild(depth3[k]);
									tmpTitle4 = depth3[k].data.title.split(":");
									//depth3[k].setTitle(tmpTitle4[0] + ":R"); //setTitle 안된다?
									depth3[k].data.title = tmpTitle4[0] + ":R</em>";
								}							
							}
							tmpTitle3 = depth2[j].data.title.split(":");
							depth2[j].setTitle(tmpTitle3[0] + ":R</em>");
						}
					}
					tmpTitle2 = depth1[i].data.title.split(":");
					depth1[i].setTitle(tmpTitle2[0] + ":R</em>");
				}			
			} 
			tmpTitle1 = node.data.title.split(":");
			node.setTitle(tmpTitle1[0] + ":R</em>");
		});
		
		$("#authDelNode").click(function(){
			var node = $("#authMenuTree").dynatree("getActiveNode");

			if(!node) {
	    		openAlertModal("","<spring:message code="msg.security.userlevel.check.close.text" />");  
	    		return;
			}
			
			// 상위 메뉴 삭제 금지...
			if(node.data.key == "0") {
				return;
			}
			node.remove();
		});
		
		$("#btn_cancel").click(function(){
			fnCancel();
		});
		
		$("#btn_save").click(function(){
			fnModify();
		});
		
    	fnInit();
    });
    
    //value setting
    function fnInit(){
    	//radio 버튼 체크 (lock_type) 
  		if("${userLevel.lock_type}" == "M"){
  			$("input[name=lock_type][value=${userLevel.lock_type}]").prop("checked",true);
  			$("#lockTime").hide();
  			$("#lock_time").val("");
  		} else if("${userLevel.lock_type}" == "T"){
  			$("input[name=loginType][id=single]").prop("checked",true);
	  		$("#lockTime").show();
  			$("#lock_time").val("${userLevel.lock_time}");
  		}
    	
    	//숫자만 입력하도록 셋팅
    	$("#passwd_life_cycle").numeric();
    	$("#passwd_noti_day").numeric();
    	$("#max_wrong_passwd").numeric();
    	$("#passwd_dup_count").numeric();
    	$("#lock_time").numeric();
    	$("#account_life_cycle").numeric();
    	$("#account_noti_day").numeric();
    	$("#absent_lock_day").numeric();
    	
    	//최초 tree load
    	var pkgName = $("#pkgName").multipleSelect('getSelects');
  		getMenuTree(pkgName[0]);
    }

    //user Level Manage getMenuTree  
    function getMenuTree(pkgName){
    	var param = new Object();
    	param.pkgName = pkgName;
    	param.levelId = "${userLevel.level_id}";
    	
    	//def menu tree
    	$("#defMenuTree").dynatree({
     		initAjax: {
     			type : "post",
     			data : param,
     			dataType : "json",
     			async: false,
     			url: "getMenuTree"
     		},
     		clickFolderMode: 1, //1:활성화 , 2:확장, 3:활성화 및 확장
    		minExpandLevel: 2, //루트가 축소되지 암음 value=1
    		debugLevel: 0, // 0:quiet, 1:normal, 2:debug
    		onDblClick: function(node) {  //더블 클릭시 이벤트
    			if(node.data.isFolder) {
    				if(node.isExpanded()) {
    	 	 			node.expand(false);
    				} else {
    		 			node.expand(true);
    				}
    			}
    		},
    		dnd: { //드래그앤 드랍 이벤트
    			onDragStart: function(node) {
    				if (node.data.key == "0"){
    					return false; //root는 그래그 제외				
    				}
    				return true;
    			},
    			onDragStop: function(node) {
    				//logMsg("tree.onDragStop(%o)", node);
    			}
    		}
    	});
    	
    	//menu auth tree
    	$("#authMenuTree").dynatree({
     		initAjax: {
     			type : "post",
     			data : param,
     			dataType : "json",
     			async: false,
     			url: "getAuthMenuTree"
     		},
     		clickFolderMode: 1, //1:활성화 , 2:확장, 3:활성화 및 확장
    		minExpandLevel: 2, //루트가 축소되지 암음 value=1
    		debugLevel: 0, // 0:quiet, 1:normal, 2:debug
    		onDblClick: function(node) {
    			if(node.data.isFolder) {
    				if(node.isExpanded()) {
    	 	 			node.expand(false);
    				} else {
    		 			node.expand(true);
    				}
    			}
    		},
            dnd: {
    			autoExpandMS: 1000, //폴더 확장 
    			preventVoidMoves: true, // Prevent dropping nodes 'before self', etc.
    			onDragStart: function(node) {
    				/** This function MUST be defined to enable dragging for the tree.
    				 *  Return false to cancel dragging of node.
    				 */
    				//logMsg("tree.onDragStart(%o)", node);
    				//if(node.data.isFolder)
    				//	return false;
    				return false;
    			},
    			onDragStop: function(node) {
    				//logMsg("tree.onDragStop(%o)", node);
    			},
    			onDragEnter: function(node, sourceNode) {
    				/** sourceNode may be null for non-dynatree droppables.
    				 *  Return false to disallow dropping on node. In this case
    				 *  onDragOver and onDragLeave are not called.
    				 *  Return 'over', 'before, or 'after' to force a hitMode.
    				 *  Any other return value will calc the hitMode from the cursor position.
    				 */
    				//logMsg("tree.onDragEnter(%o, %o)", node, sourceNode);
//    				if(node.data.isFolder)
//    					return false;
                    
                    if(node.data.key == "0") {
                        return "over";
                    }
                    
                    return true;
    			},
    			onDragOver: function(node, sourceNode, hitMode) {
//     				console.log("drag over");
    				/** Return false to disallow dropping this node.
    				 *
    				 */
//    				 if(node.data.isFolder){
//    					 var dd = $.ui.ddmanager.current;
//    					 dd.cancel();
//    					 alert("folder");
//    				 }
    				//logMsg("tree.onDragOver(%o, %o, %o)", node, sourceNode, hitMode);
    			},
    			onDrop: function(node, sourceNode, hitMode, ui, draggable) {
    				// 다른 트리메뉴에서 드레그&그롭이면 생성
    				/**This function MUST be defined to enable dropping of items on the tree.
    				 * sourceNode may be null, if it is a non-Dynatree droppable.
    				 */
    				//logMsg("tree.onDrop(%o, %o)", node, sourceNode);
    				//console.log(node);
    				//console.log(sourceNode);
    				//console.log(hitMode);
    				//console.log(ui);
    				//console.log(draggable);
    				
    				var sourceNodeTitle = sourceNode.data.title;				
    				var sourceNodeKey = sourceNode.data.key;
    				var sourceNodeDeth = sourceNode.data.depth;
    				
    				var upMenuName = node.data.title;
    				var upMenuKey = node.data.key;

					/* console.log(upMenuName);
    				console.log(upMenuKey); */
    				
    				var copynode;
    				if(sourceNode) {
    					copynode = sourceNode.toDict(true, function(dict){
    						dict.title = dict.title + "<em>:R</em>";
    						dict.key = dict.key;
    						//delete dict.key; // Remove key, so a new one will be created
    					});
    				}else{
    					copynode = {title: "This node was dropped here (" + ui.helper + ")."};
    				}
    				
    				/* console.log(hitMode);
    				console.log(node);
    				console.log(sourceNodeKey);
    				console.log(sourceNodeDeth); */
    				
    				//상위 메뉴가 하위 메뉴로 들어갈수 없다.
    				//var nodeArrayKey;
    				//var nodeKey;
    				var nodeDeth = "";
    				var isDeth = true;
    				
    				if (hitMode == "over") {
    					//console.log(node.data.isFolder);
    					if (node.data.isFolder) {
    						if (node.getChildren() != null) {
    							$.each(node.getChildren(), function(index, row) {
    								//console.log("depth === " + row.data.depth);
    								//nodeArrayKey = row.data.key.split("_");
    								nodeDeth =  row.data.depth;
    								if (parseInt(sourceNodeDeth) < parseInt(nodeDeth)) {
    									isDeth = false;
    								}
    								return false; //child 다 읽을 필요 없다..
    							});			
    						}
    					} else {
    						//폴더가 아닌곳에 등록할수 없다.
    			    		openAlertModal("","<spring:message code="msg.security.userlevel.check.is_forder.text" />");  
    			    		return;
    					}
    				} else if ((hitMode == "before") || (hitMode == "after")) {
    					//console.log(hitMode);
    					//console.log("sourceNodeDeth == " + sourceNodeDeth);
    					//console.log("nodeDeth == " + nodeDeth);
    					nodeDeth = node.data.depth;	
    					if (parseInt(sourceNodeDeth) < parseInt(nodeDeth)) {
    						isDeth = false;
    					}
    				}				
    				//console.log("sourceNodeDeth:"+sourceNodeDeth);
    				//console.log("nodeDeth:"+nodeDeth);
    				if (upMenuKey == 0) {
    					if (sourceNodeDeth != 1) {
    			    		openAlertModal("","<spring:message code="msg.security.userlevel.check.root.text" />");  
			    			return;
    					}
    				}
    				
    				if (!isDeth) {
			    		openAlertModal("","<spring:message code="msg.security.userlevel.check.depth.text" />");  
	    				return;
    				}
    				
    				if (parseInt(sourceNodeDeth) > parseInt(nodeDeth)) {
			    		openAlertModal("","<spring:message code="msg.security.userlevel.check.depth2.text" />");  
    					return;
    				}
    				
    				//중복 체크해야함
    				var isBoolean = true;
    				var tree = $("#authMenuTree").dynatree("getTree").getRoot();
    				//console.log(tree);
    				var root = tree.getChildren();
    				if (root != null) {
    					var title;
    					var last;
    					var key;
    										
    					$.each(root, function(index, row) {
    						if (row.getChildren() != null) {						
    							$.each(row.getChildren(), function(index, row) {
    								title = row.data.title;
    								last = title.lastIndexOf("<em>:");
    								title = title.substr(0,last);
    								key = row.data.key;
    								
    								if (($.trim(title) == $.trim(sourceNodeTitle)) && ($.trim(key) == $.trim(sourceNodeKey))) {
    									isBoolean = false;
    									return false;
    								}
    								if (row.childList != null) {
    									$.each(row.getChildren(), function(index, row) {
    										title = row.data.title;
    										last = title.lastIndexOf("<em>:");
    										title = title.substr(0,last);
    										key = row.data.key;
    										
    										if (($.trim(title) == $.trim(sourceNodeTitle)) && ($.trim(key) == $.trim(sourceNodeKey))) {
    											isBoolean = false;
    											return false;
    										}
    										if (row.childList != null) {
    											$.each(row.getChildren(), function(index, row) {
    												title = row.data.title;
    												last = title.lastIndexOf("<em>:");
    												title = title.substr(0,last);
    												key = row.data.key;
    								
    												if (($.trim(title) == $.trim(sourceNodeTitle)) && ($.trim(key) == $.trim(sourceNodeKey))) {
    													isBoolean = false;
    													return false;
    												}
    											});
    											
    											if (row.childList != null) {
    												$.each(row.getChildren(), function(index, row) {
    													title = row.data.title;
    													last = title.lastIndexOf("<em>:");
    													title = title.substr(0,last);
    													key = row.data.key;
    													
    													if (($.trim(title) == $.trim(sourceNodeTitle)) && ($.trim(key) == $.trim(sourceNodeKey))) {
    														isBoolean = false;
    														return false;
    													}
    												});
    											}	
    										}	
    									});
    								}							
    							});
    						}
    					});
    				}
    				
    				//중복 체크				
    				if (!isBoolean) {
			    		openAlertModal("","<spring:message code="msg.security.userlevel.check.duplicate.text" />");  
						return;
    				}
    				
    				if(hitMode == "over") {
    					if ((isBoolean) && (isDeth)) {
    						node.addChild(copynode); // Append as child node
    						node.expand(true);
    					} 
    										
    				}else if(hitMode == "before"){
    					// Add before this, i.e. as child of current parent
    					if ((isBoolean) && (isDeth)) node.parent.addChild(copynode, node);
    				}else if(hitMode == "after"){
    					// Add after this, i.e. as child of current parent
    					if ((isBoolean) && (isDeth)) node.parent.addChild(copynode, node.getNextSibling());
    				}else{
    					if ((isBoolean) && (isDeth)) node.addChild(copynode);
    				}
    			},
    			onDragLeave: function(node, sourceNode) {
    				
    			}
    		}
    	});
    	
    	$("#defMenuTree").dynatree("getTree").reload();
    	$("#authMenuTree").dynatree("getTree").reload();
    }
    
    //user Level Manage cancel
    function fnCancel(){
		$("#modifyForm").attr("action","/atom/security/userlevel/detail");
		$("#modifyForm").submit();
    }

    //user Level Manage update
 	function fnModify(){
    	if($("#passwd_life_cycle").val() == "" || $("#passwd_life_cycle").val() == null){
    		openAlertModal("","<spring:message code="msg.security.userlevel.check.password_expiration" />",function(){$("#passwd_life_cycle").focus();});  
    		return;
    	} else if(parseInt($("#passwd_life_cycle").val()) > 365){
    		openAlertModal("","<spring:message code="msg.security.userlevel.check.password_expiration_day" />",function(){$("#passwd_life_cycle").focus();});  
    		return;
    	}
    	if($("#passwd_noti_day").val() == "" || $("#passwd_noti_day").val() == null){
    		openAlertModal("","<spring:message code="msg.security.userlevel.check.password_report" />",function(){$("#passwd_noti_day").focus();});  
    		return;
    	} else if(parseInt($("#passwd_noti_day").val()) > 365){
    		openAlertModal("","<spring:message code="msg.security.userlevel.check.password_report_day" />",function(){$("#passwd_noti_day").focus();});  
    		return;
    	}
    	if($("#max_wrong_passwd").val() == "" || $("#max_wrong_passwd").val() == null){
    		openAlertModal("","<spring:message code="msg.security.userlevel.check.password_wrong_allow_count" />",function(){$("#max_wrong_passwd").focus();});  
    		return;
    	}
    	if($("#passwd_dup_count").val() == "" || $("#passwd_dup_count").val() == null){
    		openAlertModal("","<spring:message code="msg.security.userlevel.check.password_duplicate_allow_count" />",function(){$("#passwd_dup_count").focus();});  
    		return;
    	}
    	if($("#lock_type").val() == "T"){
	    	if($("#lock_time").val() == "" || $("#lock_time").val() == null){
	    		openAlertModal("","<spring:message code="msg.security.userlevel.check.lock_time" />",function(){$("#lock_time").focus();});  
	    		return;
	    	}
    	}
    	if($("#account_life_cycle").val() == "" || $("#account_life_cycle").val() == null){
    		openAlertModal("","<spring:message code="msg.security.userlevel.check.account_expiration" />",function(){$("#account_life_cycle").focus();});  
    		return;
    	} else if(parseInt($("#account_life_cycle").val()) > 365){
    		openAlertModal("","<spring:message code="msg.security.userlevel.check.account_expiration_day" />",function(){$("#account_life_cycle").focus();});  
    		return;
    	}
    	if($("#account_noti_day").val() == "" || $("#account_noti_day").val() == null){
    		openAlertModal("","<spring:message code="msg.security.userlevel.check.account_expiration" />",function(){$("#account_noti_day").focus();});  
    		return;
    	} else if(parseInt($("#account_noti_day").val()) > 365){
    		openAlertModal("","<spring:message code="msg.security.userlevel.check.account_report_day" />",function(){$("#account_noti_day").focus();});  
    		return;
    	}
    	if($("#absent_lock_day").val() == "" || $("#absent_lock_day").val() == null){
    		openAlertModal("","<spring:message code="msg.security.userlevel.check.account_absent_lock" />",function(){$("#absent_lock_day").focus();});  
    		return;
    	} else if(parseInt($("#absent_lock_day").val()) > 365){
    		openAlertModal("","<spring:message code="msg.security.userlevel.check.account_absent_lock_day" />",function(){$("#absent_lock_day").focus();});  
    		return;
    	}
    		
		if(!existchildren()){
			openAlertModal("","<spring:message code="msg.security.userlevel.check.select.text" />");
			return;
		}
		
		openConfirmModal("", "<spring:message code="msg.common.save" />", function(){
			var param = new Object();
	    	param.authMenuArr=execMenuData();
	    	param.pkg_name = $("#pkgName").val();
	    	param.level_id = $("#level_id").val();
	    	param.levelId = $("#levelId").val(); // searchVal
			param.passwd_life_cycle = $("#passwd_life_cycle").val();
			param.passwd_noti_day = $("#passwd_noti_day").val();
			param.max_wrong_passwd = $("#max_wrong_passwd").val();
			param.passwd_dup_count = $("#passwd_dup_count").val();
			param.lock_type = $("input[name=lock_type]:checked").val();
			param.lock_time = $("#lock_time").val();
			param.account_life_cycle = $("#account_life_cycle").val();
			param.account_noti_day = $("#account_noti_day").val();
			param.absent_lock_day = $("#absent_lock_day").val();
			param.description = $("#description").val();
			console.log("authMenuArr====" + param.authMenuArr);
			
			$.ajax({
	            url : "modifyAction",
	            data : param,
	            type : 'POST',
	            dataType : 'json',
	            success : function(data) {
	            	openAlertModal("","<spring:message code="msg.common.saved" />",function(){
	            		$("#modifyForm").attr("action","/atom/security/userlevel/list");
	            		$("#modifyForm").submit();
	            	});
	            },
	            error: function(e){
	                openAlertModal("",e.responseText);
	            },
	            complete : function() {

	            }
			});
		});
 	}
    
	//선ㄷ택 노드의 자식노드를 return
    function getChild(node) {
    	var array = new Object();
    	if ((node != null) && (node.hasChildren())) {
    		array = node.getChildren();
    	} else {
    		array = null;
    	}
    	return array;
    }
    
    //저장시 menu auth tree null check     
    function existchildren() {
    	var rootNode = $("#authMenuTree").dynatree("getRoot"); 
    	var numChildren = rootNode.countChildren();
    	
    	if(numChildren > 1) {
    		return true;
    	}
    	return false;	
    }

	// 실행 함수
    function execMenuData() {
    	var menuArr = new Array();
        var root = $("#authMenuTree").dynatree("getRoot");
        makeMenuData(root, null, 0, menuArr, 1);

        return JSON.stringify(menuArr);
    }

    // 메뉴구조 
    function makeMenuData(node, nodeParent, depth, menuArr, display_order) {
        if(node.parent == null) {           
            makeMenuData(node.childList[0], node, depth, menuArr, display_order);
        } else {
            var up_menu_id = nodeParent.data.key;
            
            if(node.childList == null) {
				menuArr.push(makeTreeData(node, depth, up_menu_id, display_order));
                return;
            } else {
            	if(node.data.key != "0"){
	                menuArr.push(makeTreeData(node, depth, up_menu_id, display_order));
            	}
            }
            
            var childList = node.childList;
            
            for(var i = 0; i < childList.length; i++) {
                makeMenuData(childList[i], node, depth+1, menuArr, i+1);
            }
            
            return;
        }
    }

    // 문자열로 만듦.
    function makeTreeData(node, depth, up_menu_id, display_order) {
		var menu = new Object();
        var tmpTitle = node.data.title;
        var last = node.data.title.lastIndexOf(":");
        var titleAuth = tmpTitle.substr(last+1,1);
        
        if(node.data.key != "0") {
            menu.level_id = $("#level_id").val();
            menu.menu_id = node.data.key
            menu.auth_type = titleAuth;
            menu.display_order = display_order;
            menu.up_menu_id = up_menu_id
            menu.depth = depth
        }
        return menu;
    }
    
</script>   

    <div class="content">
        <div class="cont_body">
        	<form id="modifyForm" name="modifyForm">
	        	<div class="cont_left_half">
		            <header><h3><spring:message code="label.security.userlevel.user_level_configuration.text" /></h3></header>
		            <div class="detail">
		           		<!-- modify 화면이동시 필요 -->
		            	<input type="hidden" id="level_id" name="level_id" value="${userLevel.level_id}">
		            	<!-- list 화면이동시 필요 -->
		            	<input type="hidden" id="levelId" name="levelId" value="${searchVal.levelId}">
		            	
		                <table class="tbl_detail register">
		                    <caption><spring:message code="label.security.userlevel.user_level_configuration.text" /></caption>
		                    <colgroup>
			                    <col width="50%"/>
			                    <col width="50%"/>
		                    </colgroup>
		                    <tr>
		                        <th colspan="2" scopt="col" class="imp"><spring:message code="label.security.userlevel.user_level.text" /></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2">${userLevel.level_title}</td>
		                    </tr>
		                    <tr>
		                        <th scopt="col" class="imp"><spring:message code="label.security.userlevel.password_expiration.text" /></th>
		                        <th scopt="col" class="imp"><spring:message code="label.security.userlevel.password_report.text" /></th>
		                    </tr>
		                    <tr>
		                        <td><input type="text" id="passwd_life_cycle" name="passwd_life_cycle" class="input_xs t_r" value="${userLevel.passwd_life_cycle}" maxlength="5"/><spring:message code="label.security.userlevel.day.text" /></td>
		                        <td><input type="text" id="passwd_noti_day" name="passwd_noti_day" class="input_xs t_r" value="${userLevel.passwd_noti_day}" maxlength="5"/><spring:message code="label.security.userlevel.day.text" /></td>
		                    </tr>
		                    <tr>
		                        <th scopt="col" class="imp"><spring:message code="label.security.userlevel.password_wrong_allow_count.text" /></th>
		                        <th scopt="col" class="imp"><spring:message code="label.security.userlevel.password_duplicate_allow_count.text" /></th>
		                    </tr>
		                    <tr>
		                        <td><input type="text" id="max_wrong_passwd" name="max_wrong_passwd" class="input_xs t_r" value="${userLevel.max_wrong_passwd}" maxlength="5"/><spring:message code="label.security.userlevel.number.text" /></td>
		                        <td><input type="text" id="passwd_dup_count" name="passwd_dup_count" class="input_xs t_r" value="${userLevel.passwd_dup_count}" maxlength="5"/><spring:message code="label.security.userlevel.number.text" /></td>
		                    </tr>
		                    <tr>
		                        <th colspan="2" scopt="col" class="imp"><spring:message code="label.security.userlevel.lock_type.text" /></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2">
		                            <input type="radio" id="manual" name="lock_type" value="M">
		                            <label for="manual"><spring:message code="label.security.userlevel.manual_lock.text" /></label>
		                            <input type="radio" id="time" name="lock_type" value="T">
		                            <label for="time"><spring:message code="label.security.userlevel.time_lock.text" /></label>
		                            <span id="lockTime">
		                            	<spring:message code="label.security.userlevel.lock_time.text" />
		                                <input type="text" id="lock_time" name="lock_time" class="input_xs t_r" value=""/> 
		                                <spring:message code="label.security.userlevel.secs.text" />
		                            </span>
		                        </td>
		                    </tr>
		                    <tr>
		                        <th scopt="col" class="imp"><spring:message code="label.security.userlevel.account_expiration.text" /></th>
		                        <th scopt="col" class="imp"><spring:message code="label.security.userlevel.account_report.text" /></th>
		                    </tr>
		                    <tr>
		                        <td><input type="text" id="account_life_cycle" name="account_life_cycle" class="input_xs t_r" value="${userLevel.account_life_cycle}" maxlength="5"/><spring:message code="label.security.userlevel.day.text" /></td>
		                        <td><input type="text" id="account_noti_day" name="account_noti_day" class="input_xs t_r" value="${userLevel.account_noti_day}" maxlength="5"/><spring:message code="label.security.userlevel.day.text" /></td>
		                    </tr>
		                    <tr>
		                        <th colspan="2" scopt="col" class="imp"><spring:message code="label.security.userlevel.account_absent_lock.text" /></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2"><input type="text" id="absent_lock_day" name="absent_lock_day" class="input_xs t_r" value="${userLevel.absent_lock_day}" maxlength="5"/><spring:message code="label.security.userlevel.day.text" /></td>
		                    </tr>
		                    
		                    <tr>
		                        <th colspan="2" scopt="col"><spring:message code="label.security.userlevel.description.text" /></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2">
		                        	<input type="text" id="description" name="description"  value="${userLevel.description}" />
		                        </td>
		                    </tr>
		                </table>
		            </div>
		        </div>
		        <!-- //cont_left_half -->
		        
		        <div class="cont_right_half">
		            <header>
		                <h3><spring:message code="label.security.userlevel.menu_authority.text" /></h3>
		                <select class="single type3" id="pkgName" name="pkgName" >
							<c:forEach items="${listPackage}" var="Package" varStatus="status">
								<option value="${Package.ID}">${Package.NAME}</option>
							</c:forEach>
		                </select>
		                <p>Package선택하고 메뉴를 오른쪽으로 Drag하여 설정합니다.</p>
	            	</header>
	            	
					<!-- 메뉴 구조도 -->
					<article class="box_2cols">
						<div id="groupAuthView">
							<div class="boxOne"><!--boxRight와 동일하게-->
								<header><spring:message code="label.security.userlevel.default_menu.text" /></header>
								<ul class="treeCon">
									<li><a id="defExpandAll" class="full" href="#" title="<spring:message code="label.security.userlevel.open.text" />"></a></li>
									<li><a id="defCollapseAll" class="close" href="#" title="<spring:message code="label.security.userlevel.close.text" />"></a></li>
								</ul>
								<div class="boxContent">
									<div class="menuTree" id="defMenuTree">
										
									</div>
								</div>
							</div>
							
							<div class="boxMid">
								<span class="arrow"></span>
							</div>
							
							<div class="boxOne"><!--boxRight와 동일하게-->
								<header><spring:message code="label.security.userlevel.accessible_menu.text" /></header>
								<ul class="treeCon">
									<li><a id="authExpandAll" class="full" href="#" title="<spring:message code="label.security.userlevel.open.text" />"></a></li>
									<li><a id="authCollapseAll" class="close" href="#" title="<spring:message code="label.security.userlevel.close.text" />"></a></li>
									<li><a id="authMenuTypeA" class="all" href="#" title="전체권한"></a></li>
									<li><a id="authMenuTypeR" class="read" href="#" title="읽기권한"></a></li>
									<li><a id="authDelNode" class="del" href="#" title="삭제"></a></li>
								</ul>
								<div class="boxContent">
									<div class="menuTree" id="authMenuTree">
										
									</div>
								</div>
							</div>
						</div>
					</article>
					<!--// 메뉴 구조도 -->
		        </div>
		        <!-- //cont_right_half -->
	        </form>
		</div>
		<!-- //cont_body -->
		
        <div class="cont_footer">
            <div class="btn_area">
                <button id="btn_cancel" type="button"><spring:message code="label.common.cancel.text" /></button>
                <ntels:auth auth="${authType}">
                <button id="btn_save" type="button" class="major"><spring:message code="label.common.save.text" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 