package com.ntels.avocado.controller.atom.management.trace;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.management.trace.Condition;
import com.ntels.avocado.service.atom.management.trace.TraceDetailService;
import com.ntels.avocado.service.atom.management.trace.TraceReqService;
import com.ntels.ncf.utils.MessageUtil;

@Controller
@RequestMapping(value = "/atom/management/trace/detail")
public class TraceDetailController{

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private TraceReqService traceReqService;
	@Autowired
	private TraceDetailService traceDetailService;

	private String thisUrl = "atom/management/trace/detail";

	// go list page
	@RequestMapping(value = "traceView", method = RequestMethod.POST)
	public String traceView(
			Condition condition,
			Model model) {
		condition.setPage(1);
		condition.setPerPage(10);
		
		model.addAttribute("traceReq", traceReqService.getTraceReq(condition));
		model.addAttribute("condition", condition);
		//model.addAttribute("listTraceProcess", traceReqService.listTraceProcess());

		return thisUrl + "/traceView";
	}

	// list action
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction (
			Condition condition,
			@RequestParam String type,
			Model model) {
		//paging을 위한 DTO를 생성
		Paging paging = new Paging();
		List<Map<String, String>> list = null;
		
		if(StringUtils.isBlank(condition.getTrace_req_id())) {
			logger.debug("==>> empty trace_req_id...");
			
			condition.setPage(1);
			condition.setPerPage(Integer.parseInt(MessageUtil.getMessage("paging.per_size")));
			
			list = new ArrayList<Map<String, String>>();
			
			paging.setLists(list);
			paging.setTotalCount(-1);
		} else {
			if("UDR".equals(type)) {
				list = traceDetailService.listUDR(condition);
				paging.setLists(list);
				paging.setTotalCount(traceDetailService.countUDR(condition));
			}
			else if("CDR".equals(type)) {
				list = traceDetailService.listCDR(condition);
				paging.setLists(list);
				paging.setTotalCount(traceDetailService.countCDR(condition));
			}
			else if("RAW_UDR".equals(type)) {
				list = traceDetailService.listRawUDR(condition);
				paging.setLists(list);
				paging.setTotalCount(traceDetailService.countRawUDR(condition));
			}
			else {
				list = traceDetailService.listRawCDR(condition);
				paging.setLists(list);
				paging.setTotalCount(traceDetailService.countRawCDR(condition));
			}
		}
		
		paging.setPage(condition.getPage());
		paging.setPerPage(condition.getPerPage());
		
		//DTO를 결과 model에 저장
		model.addAttribute("listResData", paging);
		model.addAttribute("type", type);
		model.addAttribute("totalPage", (int) Math.ceil(paging.getTotalCount()/paging.getPerPage()) + 1);
		model.addAttribute("condition", condition);
		
		if("UDR".equals(type)) {
			return thisUrl + "/listUDRAction";
		}
		else if("CDR".equals(type)) {
			return thisUrl + "/listCDRAction";
		}
		else if("RAW_UDR".equals(type)) {
			return thisUrl + "/listRawUDRAction";
		}
		else {
			return thisUrl + "/listRawCDRAction";
		}
	}

	// get analysis action
	@RequestMapping(value = "getAnalysisAction", method = RequestMethod.POST)
	public void getAnalysisAction(
			Condition condition,
			@RequestParam String type,
			Model model) {
		model.addAttribute("analysisValue", traceDetailService.getAnalysis(condition, type));
	}

	// trace stop action
//	@RequestMapping(value = "stopTraceAction", method = RequestMethod.POST)
//	public void stopTraceAction(
//			String trace_req_id,
//			Model model) {
//		if(traceReqService.updateEnd_datetime(Integer.parseInt(trace_req_id))){
//			logger.info("trace update end_datetime success!!! : " + trace_req_id);
//			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.save.result"));
//		}else{ 
//			logger.info("trace update end_datetime fail!!! : " + trace_req_id);
//			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
//		}
//	}
	
	// file export action
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(
			Condition condition, 
			@RequestParam String type,
			Model model) {
		List<String> title = null;
		
		if("UDR".equals(type)) {
			title = Arrays.asList("MSID", "Framed IP", "Session ID", "Event Time", "UP Size", "DOWN Size");
		} else if("RAW_UDR".equals(type)) {
			title = Arrays.asList("UDR Type", "MSID", "Framed IP", "Session ID", "Event Time", "UP Size", "DOWN Size");
		} else {
			title = Arrays.asList("Service Type", "Destination IP", "Start Time", "End Time", "URL",
					"Total UP", "Total Down", "Real UP", "Real Down");
		}

		model.addAttribute("title", title);

		List<Map<String, String>> list = traceDetailService.listExcel(condition, type);
		model.addAttribute("list", list);

		return "excelViewer";
	}
}
