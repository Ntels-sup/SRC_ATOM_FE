package com.ntels.avocado.controller.atom.config.networkmanager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ntels.avocado.domain.atom.config.networkmanager.Line;
import com.ntels.avocado.domain.atom.config.networkmanager.Node;
import com.ntels.avocado.domain.atom.config.networkmanager.NodeGrp;
import com.ntels.avocado.domain.atom.config.networkmanager.Pkg;
import com.ntels.avocado.domain.common.definitions.CodeDefinitions;
import com.ntels.avocado.service.atom.config.networkmanager.NetworkManagerService;
import com.ntels.avocado.service.common.CommonService;

@Controller
@RequestMapping(value = "/atom/config/networkmanager")
public class NetworkManagerController {
	
	private String thisUrl = "atom/config/networkmanager";
	
	@Autowired
	private NetworkManagerService networkManagerService;
	
	@Autowired
	private CommonService commonService;
	
	@RequestMapping(value = "list")
	public String list() {
		commonService.insertOperationHist("2");
		return thisUrl + "/list";
	}
	
	@RequestMapping(value = "detailNode")
	public String detailNode(Model model, Node node) {
		model.addAttribute("node", node);
		return thisUrl + "/detailNode";
	}
	
	@RequestMapping(value = "detailPkg")
	public String detailPkg(Model model, Pkg pkg) {
		model.addAttribute("pkg", pkg);
		return thisUrl + "/detailPkg";
	}
	
	@RequestMapping(value = "detailLine")
	public String detailLine(Model model, Line line) {
		model.addAttribute("line", line);
		return thisUrl + "/detailLine";
	}
	
	@RequestMapping(value = "listPkg")
	public String listPkg(Model model) {
		return thisUrl + "/listPkg";
	}
	
	@RequestMapping(value = "listNodeGrp")
	public String listNodeGrp(Model model) {
		return thisUrl + "/listNodeGrp";
	}
	
	@RequestMapping(value = "searchFlowDesign")
	public void searchFlowDesign(Model model) {
		model.addAttribute("type", CodeDefinitions.LINE_TYPE_NETWORK);
		model.addAttribute("readonly", false);
		model.addAttribute("pkgList", networkManagerService.listPkg());
		model.addAttribute("nodeGrpList", networkManagerService.listNodeGrp());
		model.addAttribute("nodeTypeList", networkManagerService.listNodeType());
		model.addAttribute("nodeList", networkManagerService.listNode());
		model.addAttribute("lineList", networkManagerService.listLine());
	}

	@RequestMapping(value = "saveFlowDesign")
	public void saveFlowDesign(Model model, String jsonStr) {
		commonService.insertOperationHist("6");
		model.addAttribute("result", networkManagerService.saveFlowDesign(jsonStr));
	}
	
	@RequestMapping(value = "insertNodeGrp")
	public void insertNodeGrp(Model model, NodeGrp nodeGrp) {
		commonService.insertOperationHist("3");
		model.addAttribute("result", networkManagerService.insertNodeGrp(nodeGrp));
	}

	@RequestMapping(value = "updateNodeGrp")
	public void updateNodeGrp(Model model, NodeGrp nodeGrp) {
		commonService.insertOperationHist("5");
		model.addAttribute("result", networkManagerService.updateNodeGrp(nodeGrp));
	}

	@RequestMapping(value = "deleteNodeGrp")
	public void deleteNodeGrp(Model model, NodeGrp nodeGrp) {
		commonService.insertOperationHist("4");
		model.addAttribute("result", networkManagerService.deleteNodeGrp(nodeGrp));
	}
}
