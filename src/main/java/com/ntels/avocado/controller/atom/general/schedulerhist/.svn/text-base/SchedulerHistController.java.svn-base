package com.ntels.avocado.controller.atom.general.schedulerhist;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.general.schedulerhist.Condition;
import com.ntels.avocado.domain.atom.general.schedulerhist.SchedulerHistDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.general.schedulerhist.SchedulerHistService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.ncf.utils.PropertiesUtil;
import com.ntels.ncf.utils.StringUtils;

@Controller
@RequestMapping(value = "/atom/general/schedulerhist/")
public class SchedulerHistController{

	private Logger logger = Logger.getLogger(this.getClass());
	
	/** The history service. */
	@Autowired
	private SchedulerHistService schedulerHistService;
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	/** The this url. */
	private String thisUrl = "/atom/general/schedulerhist";


	/**
	 * List.
	 *
	 * @param model the model
	 * @param request the request
	 * @return the string
	 * 
	 * 설명 : 조회 페이지로 이동
	 */
	@RequestMapping(value = "list")
	public String list(Model model, HttpServletRequest request, Condition condition) {
		
		HttpSession session = request.getSession(false);
		SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
		
		String start_dt = commonCodeService.getNowDate(sessionUser.getLanguage());
		String start_tm	= commonCodeService.getNowHour()+":"+StringUtils.lpad(commonCodeService.getNowMin(),2,'0');

		logger.debug( "[mirinae.maru] start_dt : " + start_dt );
		logger.debug( "[mirinae.maru] start_tm : " + start_tm );
		logger.debug( "[mirinae.maru] URL : " + thisUrl + "/list" );
		
		condition.setStartDt(start_dt);
		condition.setStartTm("00:00");
		condition.setEndDt(start_dt);
		condition.setEndTm(start_tm);
		
//		model.addAttribute("Package"	, schedulerHistService.listPackageName(condition));
		/*멀티 셀렉트 박스*/ 
		model.addAttribute("System" ,commonCodeService.listSystemId());		// TAT_NODE 조회
		model.addAttribute("Package",commonCodeService.listPackageId());	// TAT_PKG 조회
		
		model.addAttribute("condition"	, condition);
		
		return "atom/general/schedulerhist/list";
	}
	
	/**
	 * List action.
	 *
	 * @param condition the condition
	 * @param result the result
	 * @param model the model
	 * @param request the request
	 * @return the string
	 * 
	 * 설명 : 조회 처리
	 */
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(
			@Valid Condition condition, 
			BindingResult result, 
			Model model, 
			HttpServletRequest request) {
		
		HttpSession session = request.getSession(false);
		SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
		
		logger.debug( "[mirinae.maru] sessionUser : " + sessionUser.toString() );
	
	
		//시스탬 멀티 -> Array
		if(condition.getSystem_id() != null){
			String[] systemArray = condition.getSystem_id().split(",");
			condition.setSystemArray(systemArray);	
		}
		
		String[] x = condition.getSystemArray();
		for( int i=0; i<x.length; i++ ) {
			logger.debug( "[mirinae.maru] systemId["+i+"] : " + x[i] );
		}
		
		
		condition.setLanguage(sessionUser.getLanguage());
		
		Paging paging = schedulerHistService.list(condition);		
		
		model.addAttribute("condition", condition);
		model.addAttribute("resultList", paging);
		
		return thisUrl + "/listAction";
	}
	
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(
			Model model,
			HttpSession session,
			@Valid Condition condition) throws ParseException  {
		
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		condition.setLanguage(sessionUser.getLanguage());
		
		//시스탬 멀티 -> Array
		if(condition.getSystem_id() != null){
			String[] systemArray = condition.getSystem_id().split(",");
			condition.setSystemArray(systemArray);	
		}
		
		List<LinkedHashMap<String, String>> list = schedulerHistService.listExcel(condition);
		model.addAttribute("list", list);
		
		List<String> title = new ArrayList<String>() ;
		/** (title) header setting */
		for(String mapKey : list.get(0).keySet()){
			title.add(mapKey);
		}
		model.addAttribute("title", title);
		
		/** 파일중복다운시 파일명+날짜(년월일시분초[언어별]) 표시 */
	 	model.addAttribute("NowdateTime", commonCodeService.getNowDateTime(sessionUser.getLanguage()));
	 	model.addAttribute("filename", condition.getTitleName());
	 	
		return "excelViewer";
	}
	
	/* select box용 group list */
	@RequestMapping(value = "listGroupName")
	public @ResponseBody Object listGroupName(
			Condition condition,
			HttpServletRequest request,
			Model model) {
		
		//시스탬 멀티 -> Array
		if(condition.getSystem_id() != null){
			String[] systemArray = condition.getSystem_id().split(",");
			condition.setSystemArray(systemArray);	
		}
		
		return schedulerHistService.listGroupName(condition);
	}
	
	/* select box용 job list */
	@RequestMapping(value = "listJobName")
	public @ResponseBody Object listJobName(
			Condition condition,
			HttpServletRequest request,
			Model model) {
		
		//시스탬 멀티 -> Array
		if(condition.getSystem_id() != null){
			String[] systemArray = condition.getSystem_id().split(",");
			condition.setSystemArray(systemArray);	
		}
		
		return schedulerHistService.listJobName(condition);
	}
}