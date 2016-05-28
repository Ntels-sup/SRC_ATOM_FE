<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<link href="/styles/tree/ui.dynatree.css" rel="stylesheet" type="text/css">

<script type="text/javascript" charset="utf-8" src="/scripts/stringUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/dynaTree/jquery.dynatree.js"></script>
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
		
  		$("#btn_list").click(function(){
  			goList();
  		});
  		
  		$("#btn_mod").click(function(){
  			goModify();
  		});
  		
    	fnInit();
    });
    
  	//value setting
    function fnInit(){
    	//radio 버튼 체크 (lock_type) 
  		if("${userLevel.lock_type}" == "M"){
  			$("input[name=lockType][value=${userLevel.lock_type}]").prop("checked",true);
  			$("#lock_time").hide();
  		} else if("${userLevel.lock_type}" == "T"){
  			$("input[name=loginType][id=single]").prop("checked",true);
	  		$("#lock_time").show();
  		}
    	
    	//최초 tree load
    	var pkgName = $("#pkgName").multipleSelect('getSelects');
  		getMenuTree(pkgName[0]);
    }

 	//user Level Manage getMenuTree
    function getMenuTree(pkgName){
    	var param = new Object();
    	param.pkgName = pkgName;
    	param.levelId = "${userLevel.level_id}";
    	
    	// Initialize the tree inside the <div>element.
    	// The tree structure is read from the contained <ul> tag.
    	$("#defMenuTree").dynatree({
     		initAjax: {
     			type : "post",
     			data : param,
     			dataType : "json",
     			async: false,
     			url: "getMenuTree"
     		},
     		clickFolderMode: 3, //1:활성화 , 2:확장, 3:활성화 및 확장
    		minExpandLevel: 2, //루트가 축소되지 암음 value=1
    		debugLevel: 0 // 0:quiet, 1:normal, 2:debug
    	});
    	
    	// Initialize the tree inside the <div>element.
    	// The tree structure is read from the contained <ul> tag.
    	$("#authMenuTree").dynatree({
     		initAjax: {
     			type : "post",
     			data : param,
     			dataType : "json",
     			async: false,
     			url: "getAuthMenuTree"
     		},
     		clickFolderMode: 3, //1:활성화 , 2:확장, 3:활성화 및 확장
    		minExpandLevel: 2, //루트가 축소되지 암음 value=1
    		debugLevel: 0 // 0:quiet, 1:normal, 2:debug
    	});
    	
    	$("#defMenuTree").dynatree("getTree").reload();
    	$("#authMenuTree").dynatree("getTree").reload();
    }
 	
    //user group Manage goList
    function goList(){
    	$("#detailForm").attr("action","/atom/security/userlevel/list");
		$("#detailForm").submit();
    }
    
    //user group Manage goModify
 	function goModify(){
		$("#detailForm").attr("action","/atom/security/userlevel/modify");
		$("#detailForm").submit();
 	}
    
</script>   

    <div class="content">
        <div class="cont_body">
        	<form id="detailForm" name="detailForm">
	        	<div class="cont_left_half">
		            <header><h3><spring:message code="label.security.userlevel.user_level_configuration.text" /></h3></header>
		            <div class="detail">
		           		<!-- modify 화면이동시 필요 -->
		            	<input type="hidden" id="level_id" name="level_id" value="${userLevel.level_id}">
		            	<!-- list 화면이동시 필요 -->
		            	<input type="hidden" id="levelId" name="levelId" value="${searchVal.levelId}">
		            	
		                <table class="tbl_detail">
		                    <caption><spring:message code="label.security.userlevel.user_level_configuration.text" /></caption>
		                    <colgroup>
			                    <col width="50%"/>
			                    <col width="50%"/>
		                    </colgroup>
		                    <tr>
		                        <th colspan="2" scopt="col"><spring:message code="label.security.userlevel.user_level.text" /></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2">${userLevel.level_title}</td>
		                    </tr>
		                    <tr>
		                        <th scopt="col"><spring:message code="label.security.userlevel.password_expiration.text" /></th>
		                        <th scopt="col"><spring:message code="label.security.userlevel.password_report.text" /></th>
		                    </tr>
		                    <tr>
		                        <td>${userLevel.passwd_life_cycle} <spring:message code="label.security.userlevel.day.text" /></td>
		                        <td>${userLevel.passwd_noti_day} <spring:message code="label.security.userlevel.day.text" /></td>
		                    </tr>
		                    <tr>
		                        <th scopt="col"><spring:message code="label.security.userlevel.password_wrong_allow_count.text" /></th>
		                        <th scopt="col"><spring:message code="label.security.userlevel.password_duplicate_allow_count.text" /></th>
		                    </tr>
		                    <tr>
		                        <td>${userLevel.max_wrong_passwd} <spring:message code="label.security.userlevel.number.text" /></td>
		                        <td>${userLevel.passwd_dup_count} <spring:message code="label.security.userlevel.number.text" /></td>
		                    </tr>
		                    <tr>
		                        <th colspan="2" scopt="col" class="imp"><spring:message code="label.security.userlevel.lock_type.text" /></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2">
		                            <input type="radio" id="manual" name="lockType" value="M" disabled>
		                            <label for="manual"><spring:message code="label.security.userlevel.manual_lock.text" /></label>
		                            <input type="radio" id="time" name="lockType" value="T" disabled>
		                            <label for="time"><spring:message code="label.security.userlevel.time_lock.text" /></label>
		                            <span id="lock_time">
		                            	<spring:message code="label.security.userlevel.lock_time.text" />
		                                ${userLevel.lock_time}  
		                                <spring:message code="label.security.userlevel.secs.text" />
		                            </span>
		                        </td>
		                    </tr>
		                    <tr>
		                        <th scopt="col" class="imp"><spring:message code="label.security.userlevel.account_expiration.text" /></th>
		                        <th scopt="col" class="imp"><spring:message code="label.security.userlevel.account_report.text" /></th>
		                    </tr>
		                    <tr>
		                        <td>${userLevel.account_life_cycle} <spring:message code="label.security.userlevel.day.text" /></td>
		                        <td>${userLevel.account_noti_day} <spring:message code="label.security.userlevel.day.text" /></td>
		                    </tr>
		                    <tr>
		                        <th colspan="2" scopt="col" class="imp"><spring:message code="label.security.userlevel.account_absent_lock.text" /></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2">${userLevel.absent_lock_day} <spring:message code="label.security.userlevel.day.text" /></td>
		                    </tr>
		                    <tr>
		                        <th colspan="2" scopt="col"><spring:message code="label.security.userlevel.description.text" /></th>
		                    </tr>
		                    <tr>
		                        <td colspan="2">${userLevel.description}</td>
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
            	<button id="btn_list" type="button"><spring:message code="label.common.list.text" /></button>
            	<ntels:auth auth="${authType}">
                <button id="btn_mod" type="button"><spring:message code="label.common.update.text" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 