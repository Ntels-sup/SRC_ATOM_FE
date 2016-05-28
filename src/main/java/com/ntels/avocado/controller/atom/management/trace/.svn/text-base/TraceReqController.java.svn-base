package com.ntels.avocado.controller.atom.management.trace;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;
import java.util.List;

import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.management.trace.Condition;
import com.ntels.avocado.domain.atom.management.trace.TraceReq;
import com.ntels.avocado.service.atom.management.trace.TraceReqService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.ncf.utils.DateUtil;
import com.ntels.ncf.utils.MessageUtil;

@Controller
@RequestMapping(value = "/atom/management/trace")
public class TraceReqController{

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private TraceReqService traceReqService;
	@Autowired
	private CommonCodeService commonCodeService;

	private String thisUrl = "atom/management/trace";


	// go list page
	@RequestMapping(value = "list", method = RequestMethod.POST)
	public String list(
			Condition condition,
			Model model) {
		if(StringUtils.isBlank(condition.getSystem_id_c())) {
			// FIXME mirinae.maru 2016.04.01 db에서 현재 시간을 가져오는 것으로 변경해야됨 
			condition.setStart_date_c(DateUtil.getNow("yyyy-MM-dd"));
			condition.setStart_hour_c("00");
			condition.setStart_min_c("00");
			condition.setEnd_date_c(DateUtil.getNow("yyyy-MM-dd"));
			condition.setEnd_hour_c("23");
			condition.setEnd_min_c("59");
		}
		
		model.addAttribute("condition", condition);
		
		// Trace Start, Stop을 위한 데이터
		List<Map<String, String>> list = traceReqService.listTraceProcess();
		model.addAttribute("listTraceProcess", list);
		model.addAttribute("cntTraceProcess", list.size());
		
		return thisUrl + "/list";
	}

	// list action
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction (
			Condition condition,
			Model model) {
		//System.err.println(condition.toString());
		
		//paging을 위한 DTO를 생성
		Paging paging = new Paging();
		List<TraceReq> list = null;
		
		if(StringUtils.isBlank(condition.getSystem_id_c())) {
			logger.debug("==>> result.hasErrors...");
			
			condition.setPage(1);
			condition.setPerPage(Integer.parseInt(MessageUtil.getMessage("paging.per_size")));
			
			list = new ArrayList<TraceReq>();
			
			paging.setLists(list);
			paging.setTotalCount(-1);
		} else {
			//결과 요청
			list = traceReqService.list(condition);
	
			//결과를 DTO에 저장
			paging.setLists(list);
			paging.setTotalCount(traceReqService.count(condition));
		}
		
		paging.setPage(condition.getPage());
		paging.setPerPage(condition.getPerPage());
		
		//DTO를 결과 model에 저장
		model.addAttribute("listTraceReq", paging);
		
		return thisUrl + "/listAction";
	}
	
	// go insert page
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String insert(
			Condition condition, 
			Model model) {
		TraceReq traceReq = new TraceReq();
		
		if(!"".equals(condition.getSystem_id_c())) {
			traceReq.setSystem_id(condition.getSystem_id_c());
		}
		
		// end_datetime는 1시간 뒤로 설정
		String endDateTime = traceReqService.getEndDateTime();

		traceReq.setEnd_date(endDateTime.substring(0, 10));
		traceReq.setEnd_hour(endDateTime.substring(11, 13));
		traceReq.setEnd_min(endDateTime.substring(13, 15));
		traceReq.setEnd_sec("59");
		
		model.addAttribute("traceReq", traceReq);
		model.addAttribute("condition", condition);
		model.addAttribute("listTraceType", traceReqService.listTraceType());
		
		return thisUrl + "/insert";
	}

	// insert action
	@RequestMapping(value = "insertAction", method = RequestMethod.POST)
	public String insertAction(
			Condition condition,
			@Valid TraceReq traceReq, // 파라미터를 모델로 받아서 처리
			BindingResult result, // 파라미터 검증 결과
			Model model) {
		//System.err.println(traceReq.toString());
		//System.err.println(condition.toString());
		
		// 파라미터 검증
		if(result.hasErrors()) {
			logger.debug("==>> result.hasErrors()=>" + result.getFieldError());
			
			model.addAttribute("inputError", MessageUtil.getMessage("msg.input.error"));
			
			model.addAttribute("listFilterGrpNm", commonCodeService.listFilterGrpNm(traceReq.getSystem_id(), traceReq.getPackage_id(), traceReq.getService_id()));
			model.addAttribute("traceReq", traceReq);
			model.addAttribute("condition", condition);
			model.addAttribute("listTraceType", traceReqService.listTraceType());
			
			return thisUrl + "/insert";
		}
		
		if(traceReqService.insert(traceReq)){
			logger.info("trace insert success!!! : " + traceReq.toString());
			
			model.addAttribute("returnMsg", "INSERT_SUCCESS");
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.save.result"));
			model.addAttribute("condition", condition);
			model.addAttribute("actionType", "insert");
			// Trace Start, Stop을 위한 데이터
			List<Map<String, String>> list = traceReqService.listTraceProcess();
			model.addAttribute("listTraceProcess", list);
			model.addAttribute("cntTraceProcess", list.size());
		}else { 
			logger.info("trace insert fail!!! : " + traceReq.toString());
			
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
			
			model.addAttribute("listFilterGrpNm", commonCodeService.listFilterGrpNm(traceReq.getSystem_id(), traceReq.getPackage_id(), traceReq.getService_id()));
			model.addAttribute("traceReq", traceReq);
			model.addAttribute("condition", condition);
			model.addAttribute("listTraceType", traceReqService.listTraceType());
			
			return thisUrl + "/insert";
		}
		
		return thisUrl + "/list";
	}

	// go update page
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(
			Condition condition,
			Model model) {
		//System.err.println(condition.toString());
		
		model.addAttribute("traceReq", traceReqService.getTraceReq(condition));
		model.addAttribute("condition", condition);
		model.addAttribute("listTraceType", traceReqService.listTraceType());
		
		return thisUrl + "/update";
	}

	// update action
	@RequestMapping(value = "updateAction", method = RequestMethod.POST)
	public String updateAction(
			Condition condition,
			@Valid TraceReq traceReq, // 파라미터를 모델로 받아서 처리
			BindingResult result, // 파라미터 검증 결과
			Model model) {
		//System.err.println("condition=>"+condition.toString());
		//System.err.println(traceReq.toString());
		
		if(result.hasErrors()) {
			logger.debug("result.hasErrors()=>"+result.getFieldError());
			
			model.addAttribute("inputError", MessageUtil.getMessage("msg.input.error"));
			
			model.addAttribute("listFilterGrpNm", commonCodeService.listFilterGrpNm(traceReq.getSystem_id(), traceReq.getPackage_id(), traceReq.getService_id()));
			model.addAttribute("traceReq", traceReq);
			model.addAttribute("condition", condition);
			model.addAttribute("listTraceType", traceReqService.listTraceType());
			
			return thisUrl + "/update";
		}
		
		if(traceReqService.update(traceReq)){
			logger.info("trace update success!!! : " + traceReq.toString());

			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.save.result"));
			// Trace Start, Stop을 위한 데이터
			List<Map<String, String>> list = traceReqService.listTraceProcess();
			model.addAttribute("listTraceProcess", list);
			model.addAttribute("cntTraceProcess", list.size());
		}else{ 
			logger.info("trace update fail!!! : " + traceReq.toString());
			
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
			
			model.addAttribute("listFilterGrpNm", commonCodeService.listFilterGrpNm(traceReq.getSystem_id(), traceReq.getPackage_id(), traceReq.getService_id()));
			model.addAttribute("traceReq", traceReq);
			model.addAttribute("condition", condition);
			model.addAttribute("listTraceType", traceReqService.listTraceType());
			
			return thisUrl + "/update";
		}
		
		return thisUrl + "/list";
	}
	
	// delete action
	@RequestMapping(value = "deleteAction", method = RequestMethod.POST)
	public String deleteAction(
			Condition condition,
			@Valid TraceReq traceReq, // 파라미터를 모델로 받아서 처리
			BindingResult result, // 파라미터 검증 결과
			Model model) {
		//System.err.println("condition=>"+condition.toString());
		//System.err.println(traceReq.toString());

		if(traceReqService.delete(traceReq)) {
			logger.info("trace delete success!!! : " + traceReq.toString());

			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.delete.result"));
			// Trace Start, Stop을 위한 데이터
			List<Map<String, String>> list = traceReqService.listTraceProcess();
			model.addAttribute("listTraceProcess", list);
			model.addAttribute("cntTraceProcess", list.size());
		} else {
			logger.info("trace delete fail!!! : " + traceReq.toString());
			
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
			
			model.addAttribute("listFilterGrpNm", commonCodeService.listFilterGrpNm(traceReq.getSystem_id(), traceReq.getPackage_id(), traceReq.getService_id()));
			model.addAttribute("traceReq", traceReq);
			model.addAttribute("condition", condition);
			model.addAttribute("listTraceType", traceReqService.listTraceType());
			
			return thisUrl + "/update";
		}
		
		return thisUrl + "/list";
	}

	// trace stop action
	@RequestMapping(value = "stopTraceAction", method = RequestMethod.POST)
	public void stopTraceAction(
			String trace_req_id,
			Model model) {
		Condition condition = new Condition();
		condition.setTrace_req_id(trace_req_id);
		
		TraceReq traceReq = traceReqService.getTraceReq(condition);
		traceReq.setEnd_datetime(""); // UP_TRACE_REQ 프로시저 오류로 의해 빈 값 넣어서 처리함.(의미없는 데이터임)

		if(traceReqService.updateEnd_datetime(traceReq)){
			logger.info("trace update end_datetime success!!! : " + traceReq.getTrace_req_id());
			model.addAttribute("returnMsg", "true");
			model.addAttribute("resultMsg", "trace_stop");
		}else{ 
			logger.info("trace update end_datetime fail!!! : " + traceReq.getTrace_req_id());
			model.addAttribute("returnMsg", "false");
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
		}
	}

	// current datetime
	@RequestMapping(value = "currDateTime", method = RequestMethod.POST)
	public @ResponseBody String currDateTime() {
		return DateUtil.getNow("yyyy-MM-dd HH:mm:ss");
	}

	// file export action
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(Condition condition, Model model) {
		List<String> title = Arrays.asList("SYSTEM_ID", "PACKAGE_ID", "SERVICE_ID", "TRACE_REQ_ID", "TRACE_TYPE", "CONDITION_VALUE", "START_DATETIME", "END_DATETIME", 
				"USER_ID", "DESCRIPTION");
		model.addAttribute("title", title);
		
		List<Map<String, String>> list = traceReqService.listExcel(condition);
		model.addAttribute("list", list);

		return "excelViewer";
	}
	
}