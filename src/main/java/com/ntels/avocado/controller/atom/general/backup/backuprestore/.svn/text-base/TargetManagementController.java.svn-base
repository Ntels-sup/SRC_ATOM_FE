/*****************************************************************************************
 * Copyright (c) 2012 nTels, All rights reserved.
 *
 * com.ntels.avocado.controller.ofcs.general.target.TargetManagementController.java 
 * Service 클래스
 * 
 * 사용 방법:
 * <pre>
 *    사용 방법을 넣어 주세요.
 *    여러줄이라도 상관 없습니다.
 * </pre>
 *
 * @저자  : ejoh
 * @버전  :
 * @작성일 : 2013.3.25
 ******************************************************************************************/
package com.ntels.avocado.controller.atom.general.backup.backuprestore;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.general.backup.backuprestore.TargetCondition;
import com.ntels.avocado.domain.atom.general.backup.backuprestore.TargetDomain;
import com.ntels.avocado.service.atom.general.backup.backuprestore.TargetManagementService;
import com.ntels.ncf.utils.MessageUtil;
import com.ntels.ncf.utils.PasingUtil;

@Controller
@RequestMapping(value = "/ofcs/general/target")
public class TargetManagementController{

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private TargetManagementService targetManagementService;
	private String thisUrl = "ofcs/general/target";	
	
	@RequestMapping(value = "listTargCd")
	public @ResponseBody Object listTargCd(HttpServletRequest request) {
		Object result = null;
		// return object
		List<Map<String, String>> list = targetManagementService.listTargCd();
		result=list;
		return result;
	}	
	
	@RequestMapping(value = "list", method = RequestMethod.POST)
	public String list(Model model){
		this.logger.debug("list call...");
		return thisUrl+"/list";
	}
	
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(
			TargetCondition condition
			  //, @RequestParam(required=false, defaultValue="1") int page
			  //, @RequestParam(required=false, defaultValue="10") int perPage			
              , Model model ) {
		
		List<TargetDomain> selectTargetList = null;
		int totalCount = targetManagementService.selectListTotalCount(condition);
		
		Paging paging = new Paging(); 
		
		//페이지 재정의
		//마지막레코드 삭제될때 6페이지의 1레코드 삭제시 5페이지로 바뀌어야 한다.
		int page = PasingUtil.getPage(condition.getPage(), condition.getPerPage(), totalCount);
		
		if (totalCount > 0) selectTargetList = targetManagementService.selectTargetList(condition, page, condition.getPerPage());
		
		//paging을 위한 DTO를 생성
		paging.setLists(selectTargetList); //결과를 DTO에 저장
		paging.setTotalCount(totalCount); //결과 갯수를 DTO에 저장	
		paging.setPage(page); //현재 페이지를 저장
		paging.setPerPage(condition.getPerPage()); //페이징수	
				
		//DTO를 결과 model에 저장
		model.addAttribute("resultList", paging);
		model.addAttribute("condition", condition);
		
		return thisUrl+"/listAction";
	}
	
	@RequestMapping(value = "updateForm", method = RequestMethod.POST)
	public String updateForm(
			TargetCondition condition
			, Model model) {
		
		TargetDomain info = targetManagementService.selectTargetInfo(condition);
		
		model.addAttribute("info", info);
		model.addAttribute("condition", condition);
		
		return thisUrl+"/updateForm";
	}
	
	@RequestMapping(value = "insertAction", method = RequestMethod.POST)
	public void insertAction(
			TargetDomain targetInfo, Model model){
		
		// 조회조건 설정 
		TargetCondition condition = new TargetCondition();
		condition.setCode(targetInfo.getCode());
		condition.setType_code(targetInfo.getType_code());
		
		if(targetManagementService.selectTargetCount(condition)){
			model.addAttribute("result", "false");
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.duplicated.result"));
		}else{
			
			boolean rst = targetManagementService.insertTargetInfo(targetInfo);
			if(rst == true){
				model.addAttribute("result", "true");
				model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.save.result"));
			} else {
				model.addAttribute("result", "false");
				model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
			}
		}	
	}
	
	@RequestMapping(value = "updateAction", method = RequestMethod.POST)
	public void updateAction(TargetDomain targetInfo, Model model){
		
		boolean rst = targetManagementService.updateTargetInfo(targetInfo);
		
		if(rst == true){
			model.addAttribute("result", "true");
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.save.result"));
		} else {
			model.addAttribute("result", "false");
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
		}
	}

	@RequestMapping(value = "deleteAction", method = RequestMethod.POST)
	public void deleteAction(TargetCondition condition, Model model){
		
		boolean rst = targetManagementService.deleteTargetInfo(condition);
		
		if(rst == true){
			model.addAttribute("result", "true");
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.delete.result"));
		} else {
			model.addAttribute("result", "false");
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
		}
	}
	
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(Model model) {
		
		model.addAttribute("sheetNames", "T_MDF_REC_TARGET_CODE");
		
		List<String> title = Arrays.asList("Target Type", "Target Code", "Target Name", "Code Format");
		model.addAttribute("title", title);

		List<Map<String, String>> list = targetManagementService.selectExcelTarget();
		model.addAttribute("list", list);

		return "excelViewer";
	}	
	
	

}