<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- 가시:1, 가청:2, sms:3, email:4 array -->
<c:set var="AlarmCtr" value="<%=new int[] {1,2}%>" />
<!-- 등급, 코드별 변수 - radio -->
<c:set var="level" value="0" />
<c:set var="code" value="1" />
	
<script type="text/javascript">
	
    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
    	//가시 alarm toggle
    	$("#alarmCtr1").click(function(){
    	    $("#hide1").slideToggle(400);
    	});
    	//가청 alarm toggle
    	$("#alarmCtr2").click(function(){
    	    $("#hide2").slideToggle(400);
    	});
    	//sms alarm toggle
    	$("#alarmCtr3").click(function(){
    	    $("#hide3").slideToggle(400);
    	});
    	//email alarm toglle
    	$("#alarmCtr4").click(function(){
    	    $("#hide4").slideToggle(400);
    	});

		$("#btn_cancel").click(function(){
			fnCancel();
		});
		
		$("#btn_save").click(function(){
			fnModify();
		});
		
    	//등급별, 코드별 설정 radio change
    	$("input[type=radio]").change(function(){
    		<c:forEach items="${AlarmCtr}" var="list" varStatus="status">
    			if($(this).attr("name") == "radioSet${list}"){
    				if($("input[name=radioSet${list}]:checked").val() == "${level}"){
    					$("#levelSet${list}").attr("class", "ctrl1");
    					$("#codeSet${list}").attr("class", "ctrl2 hidden");
    				} else if($("input[name=radioSet${list}]:checked").val() == "${code}"){
    					$("#levelSet${list}").attr("class", "ctrl1 hidden");
    					$("#codeSet${list}").attr("class", "ctrl2");
    				}
    			}
    		</c:forEach>
    	});
    	
    	//코드별 설정 list allCheck
    	$("input[name=chk_list]").click(function(){
    		<c:forEach items="${AlarmCtr}" var="list" varStatus="status">
    			if($(this).attr("id") == "allChk${list}"){
    				if($(this).is(":checked")){
    					$("input[name=almCode${list}]").prop("checked", true);
    				} else {
    					$("input[name=almCode${list}]").prop("checked", false);
    				}
    			}
    		</c:forEach>
     	});
    	
    	fnInit();
    });
    
    //value setting
    function fnInit(){
    	//설정된 알람(가시,가청,sms,email)값 셋팅 
    	<c:forEach items="${listAlarmCtr}" var="list" varStatus="status">
    		//등급별, 코드별 라디오버튼 checked 셋팅
			$("input[name=radioSet${list.control_id}][value=${list.control_type}]").prop("checked",true);
    		
			//ctrl div show,hidden 셋팅  level : 0, code : 1
			if($("input[name=radioSet${list.control_id}]:checked").val() == "${level}"){
				$("#levelSet${list.control_id}").attr("class", "ctrl1");
				$("#codeSet${list.control_id}").attr("class", "ctrl2 hidden");
			} else if($("input[name=radioSet${list.control_id}]:checked").val() == "${code}"){
				$("#levelSet${list.control_id}").attr("class", "ctrl1 hidden");
				$("#codeSet${list.control_id}").attr("class", "ctrl2");
			}
			
			//등급별  value 셋팅 
			<c:forEach items="${listAlarmCtrLevel}" var="listLevel" varStatus="status">
				if("${list.control_id}" == "${listLevel.control_id}"){
					$("input[name=svr${listLevel.control_id}").each(function(index){
						if($(this).val() == "${listLevel.severity_ccd}"){
							$(this).prop("checked", true);
						}
					});
				}
			</c:forEach>
			
			//코드별 value 셋팅 
			$("input[name=almCode${list.control_id}").each(function(index){
				<c:forEach items="${listAlarmCodeDef}" var="alarmCodeDef" varStatus="status">
					if($(this).val() == "${alarmCodeDef.PKG_NAME}|${alarmCodeDef.CODE}"){
						$("select[id='codeSvr${list.control_id}|${alarmCodeDef.PKG_NAME}|${alarmCodeDef.CODE}']").val("${alarmCodeDef.SEVERITY_CCD}");
					}
					
					<c:forEach items="${listAlarmCtrCode}" var="listCode" varStatus="status">
						if("${list.control_id}" == "${listCode.control_id}"){
							if($(this).val() == "${listCode.pkg_name}|${listCode.code}"){
								fnChkAll($(this).prop("checked", true), "${list.control_id}");
								$("select[id='codeSvr${listCode.control_id}|${listCode.pkg_name}|${listCode.code}']").val("${listCode.severity_ccd}");
							}
						}
					</c:forEach>
				</c:forEach>
			});
			
			//설정된 알람(가시,가청,sms,email) toggle Down
			if("${list.use_yn}" == "Y"){
				$("#alarmCtr${list.control_id}").trigger("click");
			}
    	</c:forEach>    	
    }
    
    //alarm control cancel
    function fnCancel(){
		$("#modifyForm").attr("action","/atom/fault/alarmcontrol/list");
		$("#modifyForm").submit();
    }
    
    //alarm control modify
 	function fnModify(){
    	var param = new Object();
    	param.alarmCtrConfigList = alarmConfigVal();
    	param.alarmCtrList = paramVal();
    	
    	console.log("fnModify alarmCtrConfigList == " + param.alarmCtrConfigList);
    	console.log("fnModify alarmCtrList == " + param.alarmCtrList);

 		$.ajax({
            url : "modifyAction",
            data : param,
            type : 'POST',
            dataType : 'json',
            success : function(data) {
            	openAlertModal("","<spring:message code="msg.common.saved" />",function(){
            		$("#modifyForm").attr("action","/atom/fault/alarmcontrol/list");
            		$("#modifyForm").submit();
            	});
            },
            error: function(e){
                openAlertModal("",e.responseText);
            },
            complete : function() {

            }
		});
 	}
    
    function paramVal(){
    	var paramArr = new Array();
    	
    	<c:forEach items="${AlarmCtr}" var="list" varStatus="status">
    	//radio 버튼 (control_type - level, code) 이 선퇸된 alarm설정만 가져오기 
    	if($("input[type=radio][name=radioSet${list}]").is(":checked")){
    		var control_id = "${list}";
    		var control_type = $("input[type=radio][name=radioSet${list}]:checked").val();
    		
    		//contorl_type이 레벨별 (레벨별 설정)
    		if(control_type == "${level}"){
        		var severity_ccd ="";
        		var pkg_name = "";
        		var code = "";
        		var codeSvr = "";
        		
    			//checked된 severity_ccd 값 셋팅
    			$("input[type=checkbox][name=svr${list}]:checked").each(function(){
    				severity_ccd = $(this).val();
    				
    	    		var param = new Object();
    	    		param.control_id = control_id;
    	    		param.control_type = control_type;
    	    		param.severity_ccd = severity_ccd;
    	    		param.pkg_name = pkg_name;
    	    		param.code = code;
    	    		param.codeSvr = codeSvr;
    	    		param.levelConfig = "${level}";
    	    		param.codeConfig = "${code}";
    	    		paramArr.push(param);
    			});
    		//control type이 코드별(코드별 설정)
    		} else if(control_type == "${code}"){
    			var severity_ccd ="";
        		var pkg_name = "";
        		var code = "";
        		var codeSvr = "";
        		
    			//check된 code_def 값 셋팅
    			$("input[type=checkbox][name=almCode${list}]:checked").each(function(){   
   					pkg_name = $(this).val().split("|")[0];
   					code = $(this).val().split("|")[1];
   					codeSvr = $("select[id='codeSvr${list}|"+$(this).val()+"']").val();
   					
       	    		var param = new Object();
       	    		param.control_id = control_id;
       	    		param.control_type = control_type;
       	    		param.severity_ccd = severity_ccd;
       	    		param.pkg_name = pkg_name;
       	    		param.code = code;
       	    		param.codeSvr = codeSvr;
       	    		param.levelConfig = "${level}";
       	    		param.codeConfig = "${code}";
       	    		paramArr.push(param);
    			});
    		}
    	}
    	</c:forEach>

    	return JSON.stringify(paramArr);
    }
    
    function alarmConfigVal(){
    	var alarmCtrConfigList = "";
    	
    	<c:forEach items="${AlarmCtr}" var="list" varStatus="status">
    	if($("input[type=radio][name=radioSet${list}]").is(":checked")){
			var control_id = "${list}";
			var control_type = $("input[type=radio][name=radioSet${list}]:checked").val();
			//alarm 설정 리스트 (code,level)
			if(alarmCtrConfigList == ""){
				if($("input[type=checkbox][id=alarmCtr${list}]").is(":checked")){
					alarmCtrConfigList = control_id+":"+control_type+":"+"Y";
				} else {
					alarmCtrConfigList = control_id+":"+control_type+":"+"N";
				}
			} else {
				if($("input[type=checkbox][id=alarmCtr${list}]").is(":checked")){
					alarmCtrConfigList += ","+control_id+":"+control_type+":"+"Y";
				} else {
					alarmCtrConfigList += ","+control_id+":"+control_type+":"+"N";
				}
			}
    	}
    	</c:forEach>
    	
    	return alarmCtrConfigList;
    }

    function fnChkAll(event, seq){
    	var chkName = $(event).attr("name");
    	var allChkLeng = $("input[type=checkbox][name="+chkName+"]").length;
    	var checkLeng = $("input[type=checkbox][name="+chkName+"]:checked").length;
    	
    	if(allChkLeng == checkLeng){
    		$("input[type=checkbox][id=allChk"+seq+"]").prop("checked",true);
    	} else {
    		$("input[type=checkbox][id=allChk"+seq+"]").prop("checked",false);
    	}
    }
    
</script>

    <div class="content">
		<!-- cont_body -->
		<div class="cont_ctrl">
			<div class="control_wrap">
				<!-- left -->
				<form id="modifyForm" name="modifyForm">
				<div class="left">
					<!-- control -->
					<c:forEach items="${AlarmCtr}" var="list" varStatus="status">
					<c:if test="${list eq 1}">
					<div class="control">
						<h3><spring:message code="label.fault.alarmcontrol.popup.text" /></h3>
						<!-- ctrl_body --> 
						<div class="ctrl_body">
							<div class="ctrl_head">
								<span class="switch area">
									<input id="alarmCtr${list}" class="toggle toggle-round" type="checkbox" />
									<label for="alarmCtr${list}"></label>
									<em>모니터링 화면에 보여줄 알람을 등급별 또는 코드별로 설정합니다</em>
								</span>
							</div>
							<!-- ctrl_cont --> 
							<div id="hide${list}" class="ctrl_cont">
								<p>
									<input type="radio" id="level${list}" name="radioSet${list}" value="${level}" />
									<label for="level${list}"><spring:message code="label.fault.alarmcontrol.modify.level.text" /></label>
									<input type="radio" id="code${list}" name="radioSet${list}" value="${code}"/>
									<label for="code${list}"><spring:message code="label.fault.alarmcontrol.modify.code.text" /></label>
								</p>
								<div id="levelSet${list}" class="ctrl1 hidden">
									<div class="ctrl_check">
										<c:forEach items="${listAlaramServrity}" var="alaramServrity" varStatus="svrStatus">
											<input type="checkbox" id="svrChk${list}${svrStatus.index}" name="svr${list}" value="${alaramServrity.ID}">
											<label for="svrChk${list}${svrStatus.index}">${alaramServrity.NAME}</label>
										</c:forEach>
									</div>
								</div>
								<div id="codeSet${list}" class="ctrl2 hidden">
									<!-- ctr_list -->
									<div class="ctr_list">
										<div class="data">
											<table class="tbl_list">
												<colgroup>
													<col>
													<col width="16%" />
													<col width="20%" />
													<col width="200px" />
													<col width="*" />
													<col width="10px" />
												</colgroup>
												<thead>
													<tr>
														<th class="chk"><input type="checkbox" id="allChk${list}" name="chk_list">
														<label for="allChk${list}">check</label>	
														</th>
														<th><spring:message code="label.fault.alarmconfig.alarm_code.text" /></th>
														<th><spring:message code="label.fault.alarmconfig.probable_cause.text" /></th>
														<th><spring:message code="label.fault.alarmconfig.severity.text" /></th>
														<th><spring:message code="label.fault.alarmconfig.description.text" /></th>
														<th></th>
													</tr>
												</thead>
											</table>
											<div class="scroll sml link">
												<table class="tbl_list">
													<colgroup>
														<col>
														<col width="16%" />
														<col width="20%" />
														<col width="200px" />
														<col width="*" />
													</colgroup>
													<tbody>
	                                                    <c:forEach items="${listAlarmCodeDef}" var="alarmCodeDef" varStatus="codeStatus">
										 					<tr>
										 						<td class="chk"><input type="checkbox" id="almCodeChk${list}${codeStatus.count}" name="almCode${list}" value="${alarmCodeDef.PKG_NAME}|${alarmCodeDef.CODE}" onclick="fnChkAll(this,${list})" />
										 						<label for="almCodeChk${list}${codeStatus.count}">check</label>
										 						</td>
										 						<td>${alarmCodeDef.ALIAS_CODE}</td>
										 						<td>${alarmCodeDef.PROBABLE_CAUSE}</td>
										 						<td>
										 						<div class="select-style">
										 							<select id="codeSvr${list}|${alarmCodeDef.PKG_NAME}|${alarmCodeDef.CODE}" name="codeSvr${list}">
																		<c:forEach items="${listAlaramServrity}" var="alaramServrity" varStatus="status">
																			<option value="${alaramServrity.ID}">${alaramServrity.NAME}</option>
																		</c:forEach>
										 							</select>
										 						</div>
										 						</td>
																<td>${alarmCodeDef.DESCRIPTION}</td>
										 					</tr>
										 				</c:forEach>
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<!-- //ctr_list -->
								</div>
							</div>
							<!-- //ctrl_cont --> 
						</div>
						<!-- //ctrl_body --> 
					</div>
					<!-- //control -->
					</c:if>
					</c:forEach>
				</div>
				<!-- //left -->
				
				<!-- right -->
				<div class="right">
					<!-- control -->
					<c:forEach items="${AlarmCtr}" var="list" varStatus="status">
					<c:if test="${list eq 2}">
					<div class="control">
						<h3><spring:message code="label.fault.alarmcontrol.voice.text" /></h3>
						<!-- ctrl_body --> 
						<div class="ctrl_body">
							<div class="ctrl_head">
								<span class="switch area">
									<input id="alarmCtr${list}" class="toggle toggle-round" type="checkbox" />
									<label for="alarmCtr${list}"></label>
									<em>모니터링 화면에 보여줄 알람을 등급별 또는 코드별로 설정합니다</em>
								</span>
							</div>
							<!-- ctrl_cont --> 
							<div class="ctrl_cont" id="hide${list}">
								<p>
									<input type="radio" id="level${list}" name="radioSet${list}" value="${level}" />
									<label for="level${list}"><spring:message code="label.fault.alarmcontrol.modify.level.text" /></label>
									<input type="radio" id="code${list}" name="radioSet${list}" value="${code}"/>
									<label for="code${list}"><spring:message code="label.fault.alarmcontrol.modify.code.text" /></label>
								</p>
								<div class="ctrl1 hidden" id="levelSet${list}">
									<div class="ctrl_check">
										<c:forEach items="${listAlaramServrity}" var="alaramServrity" varStatus="svrStatus">
											<input type="checkbox" id="svrChk${list}${svrStatus.index}" name="svr${list}" value="${alaramServrity.ID}">
											<label for="svrChk${list}${svrStatus.index}">${alaramServrity.NAME}</label>
										</c:forEach>
									</div>
								</div>
								<div class="ctrl2 hidden" id="codeSet${list}">
									<!-- ctr_list -->
									<div class="ctr_list">
										<div class="data">
											<table class="tbl_list">
												<colgroup>
													<col>
													<col width="16%" />
													<col width="20%" />
													<col width="200px" />
													<col width="*" />
													<col width="10px" />
												</colgroup>
												<thead>
													<tr>
														<th class="chk"><input type="checkbox" id="allChk${list}" name="chk_list">
														<label for="allChk${list}">check</label>	
														</th>
														<th><spring:message code="label.fault.alarmconfig.alarm_code.text" /></th>
														<th><spring:message code="label.fault.alarmconfig.probable_cause.text" /></th>
														<th><spring:message code="label.fault.alarmconfig.severity.text" /></th>
														<th><spring:message code="label.fault.alarmconfig.description.text" /></th>
														<th></th>
													</tr>
												</thead>
											</table>
											<div class="scroll sml link">
												<table class="tbl_list">
													<colgroup>
														<col>
														<col width="16%" />
														<col width="20%" />
														<col width="200px" />
														<col width="*" />
													</colgroup>
													<tbody>
	                                                    <c:forEach items="${listAlarmCodeDef}" var="alarmCodeDef" varStatus="codeStatus">
										 					<tr>
										 						<td class="chk"><input type="checkbox" id="almCodeChk${list}${codeStatus.count}" name="almCode${list}" value="${alarmCodeDef.PKG_NAME}|${alarmCodeDef.CODE}" onclick="fnChkAll(this,${list})" />
										 						<label for="almCodeChk${list}${codeStatus.count}">check</label>
										 						</td>
										 						<td>${alarmCodeDef.ALIAS_CODE}</td>
										 						<td>${alarmCodeDef.PROBABLE_CAUSE}</td>
										 						<td>
										 						<div class="select-style">
										 							<select id="codeSvr${list}|${alarmCodeDef.PKG_NAME}|${alarmCodeDef.CODE}" name="codeSvr${list}">
																		<c:forEach items="${listAlaramServrity}" var="alaramServrity" varStatus="status">
																			<option value="${alaramServrity.ID}">${alaramServrity.NAME}</option>
																		</c:forEach>
										 							</select>
										 						</div>
										 						</td>
																<td>${alarmCodeDef.DESCRIPTION}</td>
										 					</tr>
										 				</c:forEach>
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<!-- //ctr_list -->
								</div>
							</div>
							<!-- //ctrl_cont --> 
						</div>
						<!-- //ctrl_body --> 
					</div>
					<!-- //control -->
					</c:if>
					</c:forEach>
				</div>
				<!-- //right -->
				</form>
			</div>
		</div>
		<!-- //cont_body -->
		
        <div class="cont_footer">
            <div class="btn_area">
                <button id="btn_cancel" type="button"><spring:message code="label.common.cancel" /></button>
                <ntels:auth auth="${authType}">
                <button id="btn_save" type="button" class="major"><spring:message code="label.common.save" /></button>
                </ntels:auth>
            </div>
        </div>
        <!-- //cont_footer --> 
    </div>
    <!--// content --> 