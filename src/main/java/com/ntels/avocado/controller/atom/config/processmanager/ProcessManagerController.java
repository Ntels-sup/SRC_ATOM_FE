package com.ntels.avocado.controller.atom.config.processmanager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ntels.avocado.domain.atom.config.networkmanager.Line;
import com.ntels.avocado.domain.atom.config.processmanager.Proc;
import com.ntels.avocado.domain.atom.config.processmanager.Svc;
import com.ntels.avocado.domain.common.definitions.CodeDefinitions;
import com.ntels.avocado.service.atom.config.processmanager.ProcessManagerService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.StringUtils;

@Controller
@RequestMapping(value = "/atom/config/processmanager")
public class ProcessManagerController {

private String thisUrl = "atom/config/processmanager";
	
	@Autowired
	private ProcessManagerService processManagerService;
	
	@Autowired
	private CommonService commonService;
	
	@RequestMapping(value = "list")
	public String list() {
		commonService.insertOperationHist("2");
		return thisUrl + "/list";
	}
	
	@RequestMapping(value = "listSvc")
	public String listSvc() {
		return thisUrl + "/listSvc";
	}
	
	@RequestMapping(value = "detailProc")
	public String detailProc(Model model, Proc proc) {
		model.addAttribute("proc", proc);
		return thisUrl + "/detailProc";
	}
	
	@RequestMapping(value = "detailLine")
	public String detailLine(Model model, Line line) {
		model.addAttribute("line", line);
		return thisUrl + "/detailLine";
	}
	
	@RequestMapping(value = "searchFlowDesign")
	public void searchFlowDesign(Model model, Svc svc) {
		model.addAttribute("type", CodeDefinitions.LINE_TYPE_PROCESS);
		model.addAttribute("readonly", false);
		model.addAttribute("pkgList", processManagerService.listPkg());
		model.addAttribute("nodeTypeList", processManagerService.listNodeType());
		model.addAttribute("svcList", processManagerService.listSvc());
		
		if (StringUtils.isNotEmpty(svc.getNode_type()) && StringUtils.isNotEmpty(svc.getSvc_no())) {
			model.addAttribute("procBaseList", processManagerService.listProcBase());
			model.addAttribute("procList", processManagerService.listProc(svc));
			model.addAttribute("lineList", processManagerService.listLine(svc));
		}
	}

	@RequestMapping(value = "saveFlowDesign")
	public void saveFlowDesign(Model model, String jsonStr) {
		commonService.insertOperationHist("6");
		model.addAttribute("result", processManagerService.saveFlowDesign(jsonStr));
	}
	
	@RequestMapping(value = "insertSvc")
	public void insertSvc(Model model, Svc svc) {
		commonService.insertOperationHist("3");
		model.addAttribute("result", processManagerService.insertSvc(svc));
	}

	@RequestMapping(value = "updateSvc")
	public void updateSvc(Model model, Svc svc) {
		commonService.insertOperationHist("5");
		model.addAttribute("result", processManagerService.updateSvc(svc));
	}

	@RequestMapping(value = "deleteSvc")
	public void deleteSvc(Model model, Svc svc) {
		commonService.insertOperationHist("4");
		model.addAttribute("result", processManagerService.deleteSvc(svc));
	}
}
