package com.ntels.avocado.controller.atom.performance.calltrace;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ntels.avocado.domain.atom.performance.calltrace.TrcHist;
import com.ntels.avocado.service.atom.performance.calltrace.CallTraceService;
import com.ntels.avocado.service.common.CommonCodeService;

@Controller
@RequestMapping(value = "/atom/performance/calltrace")
public class CallTraceController {
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private CallTraceService callTraceService;
	
	private String thisUrl = "atom/performance/calltrace";
	
	@RequestMapping(value = "list")
	public String list(Model model) {
		model.addAttribute("trcHist", callTraceService.getTraceHist());
		model.addAttribute("System" ,commonCodeService.listSystemId());
		model.addAttribute("Package",commonCodeService.listPackageId());
		model.addAttribute("keywords",commonCodeService.listTraceKeyword());
		model.addAttribute("traceModes",commonCodeService.listTraceMode());
		return thisUrl + "/list";
	}
	
	@RequestMapping(value = "insertHist")
	public void insertHist(Model model, TrcHist trcHist) {
		model.addAttribute("result", callTraceService.insertHist(trcHist));
	}

	@RequestMapping(value = "updateHist")
	public void updateHist(Model model, TrcHist trcHist) {
		model.addAttribute("result", callTraceService.updateHist(trcHist));
	}
}
