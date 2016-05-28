package com.ntels.avocado.controller.atom.general.scheduler;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.authorization.user.Package;
import com.ntels.avocado.domain.atom.config.networkmanager.Line;
import com.ntels.avocado.domain.atom.config.processmanager.Proc;
import com.ntels.avocado.domain.atom.config.processmanager.Svc;
import com.ntels.avocado.domain.atom.general.scheduler.Application;
import com.ntels.avocado.domain.atom.general.scheduler.PluginProperties;
import com.ntels.avocado.domain.atom.general.scheduler.Scheduler;
import com.ntels.avocado.domain.atom.general.scheduler.SchedulerFlow;
import com.ntels.avocado.domain.atom.general.scheduler.SchedulerGroup;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.domain.common.definitions.CodeDefinitions;
import com.ntels.avocado.service.atom.general.scheduler.SchedulerService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.StringUtils;

@Controller
@RequestMapping(value = "/atom/general/scheduler/")
public class SchedulerController{

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private SchedulerService schedulerService;
	
	@Autowired
	private CommonService commonService;
	
	/*list*/
	@RequestMapping(value = "list")
	public String list(
			SchedulerGroup schedulerGroup,
			Scheduler scheduler,
    		HttpServletRequest request,
    		HttpServletResponse response,
			Model model) {
		
		HttpSession session = request.getSession(false);
		SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
		
		logger.debug( "[mirinae.maru] /atom/general/scheduler/list" );
		logger.debug( "[mirinae.maru] language : " + sessionUser.getLanguage() );
		logger.debug( "[mirinae.maru] pkg_name : " + schedulerGroup.getPkg_name() );
		
		if(StringUtils.isNotEmpty(schedulerGroup.getPkg_name())) {
		
//			scheduler.setPkg_name(schedulerGroup.getPkg_name());
//			List<Scheduler> listScheduler = schedulerService.listScheduler(scheduler);		
//	
//			SchedulerFlow schedulerFlow = new SchedulerFlow();
//			schedulerFlow.setNode_type(scheduler.getNode_type());
//	
//			List<SchedulerFlow> listSchedulerFlow = schedulerService.listSchedulerFlow(schedulerFlow);
			
			schedulerGroup.setNode_type(scheduler.getNode_type());
			
			schedulerGroup = schedulerService.getSchedulerGroup(schedulerGroup);

//			model.addAttribute("listScheduler", listScheduler);
//			model.addAttribute("listSchedulerFlow", listSchedulerFlow);
			model.addAttribute("schedulerGroup", schedulerGroup);			
		}		

		model.addAttribute("Package"	, commonCodeService.listPackageId());
		model.addAttribute("searchVal"	, scheduler);
		
		return "atom/general/scheduler/list";
	}
	
	/*iframescheduler*/
	@Deprecated
	@RequestMapping(value = "iframescheduler")
	public String iframescheduler(
			@RequestParam(defaultValue="") String pkg_name,
			@RequestParam(defaultValue="") String scheduler_group_id,
			@RequestParam(defaultValue="flow") String viewType,
			Scheduler scheduler,
			Model model) {
		
		if(StringUtils.isNotEmpty(pkg_name)) {
		
			scheduler.setPkg_name(pkg_name);
			List<Scheduler> listScheduler = schedulerService.listScheduler(scheduler);		
	
			SchedulerFlow schedulerFlow = new SchedulerFlow();
			schedulerFlow.setNode_type(scheduler.getNode_type());
	
			List<SchedulerFlow> listSchedulerFlow = schedulerService.listSchedulerFlow(schedulerFlow);
			
			SchedulerGroup schedulerGroup = new SchedulerGroup();
			schedulerGroup.setNode_type(scheduler.getNode_type());
			
			schedulerGroup = schedulerService.getSchedulerGroup(schedulerGroup);

			model.addAttribute("listScheduler", listScheduler);
			model.addAttribute("listSchedulerFlow", listSchedulerFlow);
			model.addAttribute("schedulerGroup", schedulerGroup);			
		}
		
		model.addAttribute("viewType", viewType);
		model.addAttribute("pkg_name", pkg_name);
		
		return "atom/general/scheduler/iframescheduler";
	}	
	
	/*listSchedulerGroup*/
	@RequestMapping(value = "listSchedulerGroup")
	public String listSchedulerGroup(
			SchedulerGroup schedulerGroup,
			HttpServletRequest request,
			HttpServletResponse response,
			Model model) {

		HttpSession session = request.getSession(false);
		SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
		
		logger.debug( "[mirinae.maru] sessionUser : " + sessionUser.toString() );
		logger.debug( "[mirinae.maru] schedulerGroup : " + schedulerGroup.toString() );
		logger.debug( "[mirinae.maru] schedulerGroup : " + schedulerGroup.toString() );
		logger.debug( "[mirinae.maru] schedulerGroup : " + schedulerGroup.toString() );
		logger.debug( "[mirinae.maru] schedulerGroup : " + schedulerGroup.toString() );
		logger.debug( "[mirinae.maru] schedulerGroup : " + schedulerGroup.toString() );
		
		
		schedulerGroup.setLanguage(sessionUser.getLanguage());
		
		Paging paging = schedulerService.listSchedulerGroup(schedulerGroup);		
		
		model.addAttribute("schedulerGroup", schedulerGroup);
		model.addAttribute("resultList", paging);		
		
		commonService.insertOperationHist( Consts.OPERATION_HISTORY.SEARCH );
		
		return "atom/general/scheduler/listSchedulerGroup";
	}	
	
	/*getSchedulerGroup*/
	@Deprecated
	@RequestMapping(value = "getSchedulerGroup")
	public String getSchedulerGroup(
			SchedulerGroup schedulerGroup,
			Model model) {		
		
		schedulerGroup = schedulerService.getSchedulerGroup(schedulerGroup);		
		model.addAttribute("schedulerGroup", schedulerGroup);		
		return "atom/general/scheduler/getSchedulerGroup";
	}
	
	/*get*/
	@RequestMapping(value = "get")
	@Deprecated
	public String get(
			Scheduler scheduler,
			Model model) {

		scheduler = schedulerService.getScheduler(scheduler);
		
		Application application = new Application();
		application.setNode_type(scheduler.getNode_type());
		
		List<Application> listApplication = schedulerService.listApplication(application);
		
		Package package_ = new Package();
		package_.setNode_type(scheduler.getNode_type());
		
		PluginProperties pluginProperties = new PluginProperties();
		pluginProperties.setApp_type("B");
		
		List<PluginProperties> listPluginProperties = schedulerService.listPluginProperties(package_, pluginProperties);			
		
		model.addAttribute("scheduler",scheduler);
		model.addAttribute("listApplication",listApplication);
		model.addAttribute("listPluginProperties",listPluginProperties);
		
		return "atom/general/scheduler/get";
	}
	
	/*getFlow*/
	@Deprecated
	@RequestMapping(value = "getFlow")
	public String getFlow(
			SchedulerFlow schedulerFlow,
			Model model) {

		schedulerFlow = schedulerService.getSchedulerFlow(schedulerFlow);		
		model.addAttribute("schedulerFlow",schedulerFlow);		
		return "atom/general/scheduler/getFlow";
	}	
	
	/*insertByCopy*/
	@Deprecated
	@RequestMapping(value = "insertByCopy")
	public String insertByCopy(
			Scheduler scheduler,
			Model model) {			
		
		scheduler = schedulerService.getScheduler(scheduler);
		
		model.addAttribute("scheduler",scheduler);		
		
		return "atom/general/scheduler/insertByCopy";
	}	
	
	/*insertByCopy*/
	@Deprecated
	@RequestMapping(value = "insertByCopyAction")
	public String insertByCopyAction(
			@RequestParam(required=false) String copy_scheduler_job_id,
			Scheduler scheduler,
			Model model) {			
		
		Scheduler copyscheduler = new Scheduler();
		copyscheduler.setNode_type(scheduler.getNode_type());
		
		copyscheduler = schedulerService.getScheduler(copyscheduler);
		scheduler.setUser_id(copyscheduler.getUser_id());
				
		schedulerService.insertScheduler(scheduler);		
		return "atom/general/scheduler/close";
	}
	
	/*update*/
	@Deprecated
	@RequestMapping(value = "updateAction")
	public String updateAction(
			Scheduler scheduler,
			Model model) {					
		schedulerService.updateScheduler(scheduler);		
		return "atom/general/scheduler/close";
	}	
	
	/*updateByRename*/
	@Deprecated
	@RequestMapping(value = "updateByRename")
	public String updateByRename(
			Scheduler scheduler,
			Model model) {		
		scheduler = schedulerService.getScheduler(scheduler);		
		model.addAttribute("scheduler",scheduler);				
		return "atom/general/scheduler/updateByRename";
	}	
	
	/*updateByRename*/
	@Deprecated
	@RequestMapping(value = "updateByRenameAction")
	public String updateByRenameAction(
			Scheduler scheduler,
			Model model) {					
		schedulerService.updateSchedulerName(scheduler);		
		return "atom/general/scheduler/close";
	}
	
	/*updateByRename*/
	@Deprecated
	@RequestMapping(value = "updateByPosition")
	public void updateByPosition(
			Scheduler scheduler,
			Model model) {					
		schedulerService.updateSchedulerPosition(scheduler);
	}
	
	/*viewSchedulerGroup*/
	@RequestMapping(value = "viewSchedulerGroup")
	public String viewSchedulerGroup(
			SchedulerGroup schedulerGroup,
			HttpServletRequest request,
			HttpSession session,
			Model model) {		
		
		String language = "";
		
		SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
		
		logger.debug( "[mirinae.maru] sessionUser : " + sessionUser.toString()  );
		
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		
		schedulerGroup.setLanguage(language);
		
		schedulerGroup = schedulerService.getSchedulerGroup(schedulerGroup);
		
		model.addAttribute("schedulerGroup"	,schedulerGroup);		
		model.addAttribute("cycleType"		,commonCodeService.listScheduleCycleType());
		
		commonService.insertOperationHist( Consts.OPERATION_HISTORY.DISPLAY );
		
		return "atom/general/scheduler/viewSchedulerGroup";
	}
	
	/* updateSchedulerGroup */
	@RequestMapping(value = "updateSchedulerGroup")
	public String updateSchedulerGroup(
			SchedulerGroup schedulerGroup,
			HttpServletRequest request,
			HttpSession session,
			Model model) {		
		
		SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
		logger.debug( "[mirinae.maru] sessionUser : " + sessionUser.toString()  );
		
		schedulerGroup.setLanguage(sessionUser.getLanguage());
		schedulerGroup = schedulerService.getSchedulerGroup(schedulerGroup);
		
		model.addAttribute("schedulerGroup"	,schedulerGroup);		
		model.addAttribute("cycleType"		,commonCodeService.listScheduleCycleType());
		model.addAttribute("listYn"			, commonCodeService.listAlphaYn());
		
		return "atom/general/scheduler/updateSchedulerGroup";
	}
	
	/*updateSchedulerGroup*/
	@RequestMapping(value = "updateSchedulerGroupAction")
	public ModelAndView updateSchedulerGroupAction(
			@RequestParam(required=false) String call_flag,
			SchedulerGroup schedulerGroup,
    		HttpServletRequest request,
    		HttpServletResponse response,
			Model model) {
		
		HttpSession session = request.getSession(false);
		SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
		
		schedulerGroup.setUser_id(sessionUser.getUserId());
		schedulerGroup.setLanguage(sessionUser.getLanguage());
		
		ModelAndView mav = new ModelAndView();
		mav.addObject( "result", schedulerService.updateSchedulerGroup(schedulerGroup) );
		
		commonService.insertOperationHist( Consts.OPERATION_HISTORY.UPDATE );
		
		return mav;
	}		

	/*updateFlowAction*/
	@Deprecated
	@RequestMapping(value = "updateFlowAction")
	public String updateFlowAction(
			SchedulerFlow schedulerFlow,
			Model model) {
		
		schedulerService.updateSchedulerFlow(schedulerFlow);		
		return "atom/general/scheduler/close";
	}	
	
	
	/*delete*/
	@Deprecated
	@RequestMapping(value = "delete")
	public void delete(
			Scheduler scheduler,
			Model model) {
		
		schedulerService.deleteScheduler(scheduler);
	}
	
	/*deleteFlowAction*/
	@Deprecated
	@RequestMapping(value = "deleteFlowAction")
	public String deleteFlowAction(
			SchedulerFlow schedulerFlow,
			Model model) {
		
		schedulerService.deleteSchedulerFlow(schedulerFlow);		
		return "atom/general/scheduler/close";
	}	

	/*deleteSchedulerGroupAction*/
	@RequestMapping(value = "deleteSchedulerGroupAction")
	public ModelAndView deleteschedulerGroupAction(
			SchedulerGroup schedulerGroup,
			HttpServletRequest request,
			HttpServletResponse response,
			Model model) {

		ModelAndView mav = new ModelAndView();
		mav.addObject( "result", schedulerService.deleteSchedulerGroup(schedulerGroup) );
		
		commonService.insertOperationHist( Consts.OPERATION_HISTORY.DELETE );
		
		return mav;
	}		
	
	/*insert*/
	@Deprecated
	@RequestMapping(value = "insert")
	public String insert(
			Scheduler scheduler,
			Model model) {
		
		Application application = new Application();
		application.setNode_type(scheduler.getNode_type());
		
		List<Application> listApplication = schedulerService.listApplication(application);
		
		Package package_ = new Package();
		package_.setNode_type(scheduler.getNode_type());
		
		PluginProperties pluginProperties = new PluginProperties();
		pluginProperties.setApp_type("B");
		
		List<PluginProperties> listPluginProperties = schedulerService.listPluginProperties(package_, pluginProperties);				
		
		model.addAttribute("scheduler",scheduler);
		model.addAttribute("listApplication",listApplication);
		model.addAttribute("listPluginProperties",listPluginProperties);		
		
		return "atom/general/scheduler/insert";
	}
	
	/*insert*/
	@Deprecated
	@RequestMapping(value = "insertAction")
	public String insertAction(
			Scheduler scheduler,
			Model model) {
		
		schedulerService.insertScheduler(scheduler);		
		return "atom/general/scheduler/close";
	}	
	
	/*insertFlow*/
	@Deprecated
	@RequestMapping(value = "insertFlow")
	public String insertFlow(
			SchedulerFlow schedulerFlow,
			Model model) {
		
		model.addAttribute("schedulerFlow", schedulerFlow);		
		return "atom/general/scheduler/insertFlow";
	}	
	
	/*insertFlowAction*/
	@Deprecated
	@RequestMapping(value = "insertFlowAction")
	public String insertFlowAction(
			SchedulerFlow schedulerFlow,
			Model model) {
		
		schedulerService.insertSchedulerFlow(schedulerFlow);		
		return "atom/general/scheduler/close";
	}
	
	/*insertSchedulerGroup*/
	@RequestMapping(value = "insertSchedulerGroup")
	public String insertSchedulerGroup(
			HttpServletRequest request,
			SchedulerGroup schedulerGroup,
			Model model) {
		
		HttpSession session = request.getSession(false);
		SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
		
		String start_dt = commonCodeService.getNowDate(sessionUser.getLanguage());
		String start_tm	= commonCodeService.getNowHour()+":"+StringUtils.lpad(commonCodeService.getNowMin(),2,'0');

		logger.debug( "[mirinae.maru] start_dt : " + start_dt );
		logger.debug( "[mirinae.maru] start_tm : " + start_tm );
		
		schedulerGroup.setStart_dt(start_dt);
		schedulerGroup.setStart_tm(start_tm);
		schedulerGroup.setExpire_dt(start_dt);
		schedulerGroup.setExpire_tm(start_tm);
		
		model.addAttribute("schedulerGroup"	, schedulerGroup);
		model.addAttribute("Package"		, commonCodeService.listPackageId());	
		model.addAttribute("cycleType"		, commonCodeService.listScheduleCycleType());
		model.addAttribute("listYn"			, commonCodeService.listAlphaYn());
		
		return "atom/general/scheduler/insertSchedulerGroup";
	}
	
	/*insertSchedulerGroup*/
	@RequestMapping(value = "insertSchedulerGroupAction")
	public void insertSchedulerGroupAction(
			SchedulerGroup schedulerGroup,
			HttpServletRequest request,
			Model model) {
		
		HttpSession session = request.getSession(false);
		SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
		
		schedulerGroup.setLanguage(sessionUser.getLanguage());
		
		commonService.insertOperationHist( Consts.OPERATION_HISTORY.INSERT );
		
		model.addAttribute( "result", schedulerService.insertSchedulerGroup(schedulerGroup) );
	}	
	
	/* select box용 scheduler group list */
	@RequestMapping(value = "listSchedulerGroupAjax")
	public @ResponseBody Object listSchedulerGroupAjax(
			SchedulerGroup schedulerGroup,
			HttpServletRequest request,
			Model model) {
		
		HttpSession session = request.getSession(false);
		SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
			
		logger.debug( "[mirinae.maru] sessionUser : " + sessionUser.toString() );
			
		schedulerGroup.setLanguage(sessionUser.getLanguage());
		
		commonService.insertOperationHist( Consts.OPERATION_HISTORY.SEARCH );
		
		return schedulerService.listSchedulerGroupAjax(schedulerGroup);
	}
	
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(
			Model model,
			HttpSession session,
			SchedulerGroup schedulerGroup) throws ParseException  {
		
		String language = "";
		
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		
		schedulerGroup.setLanguage(language);
		
		List<LinkedHashMap<String, String>> list = schedulerService.listExcelSchedulerGroup(schedulerGroup);
		model.addAttribute("list", list);
		
		List<String> title = new ArrayList<String>() ;
		/** (title) header setting */
		for(String mapKey : list.get(0).keySet()){
			title.add(mapKey);
			}
		model.addAttribute("title", title);
		
		/** 파일중복다운시 파일명+날짜(년월일시분초[언어별]) 표시 */
	 	model.addAttribute("NowdateTime", commonCodeService.getNowDateTime(language));
	 	model.addAttribute("filename", schedulerGroup.getTitleName());
		
		commonService.insertOperationHist( Consts.OPERATION_HISTORY.SEARCH );
		
		return "excelViewer";
	}
	
	@RequestMapping(value = "listBatchJob")
	public String listBatchJob() {
		commonService.insertOperationHist( Consts.OPERATION_HISTORY.SEARCH );
		return "atom/general/scheduler/listBatchJob";
	}
	
	@RequestMapping(value = "detailBatchJob")
	public String detailBatchJob(Model model, Scheduler batchJob) {
		model.addAttribute("batchJob", batchJob);
		return "atom/general/scheduler/detailBatchJob";
	}
	
	@RequestMapping(value = "detailLine")
	public String detailLine(Model model, Line line) {
		model.addAttribute("line", line);
		return "atom/general/scheduler/detailLine";
	}
	
	@RequestMapping(value = "searchFlowDesign")
	public void searchFlowDesign(Model model, SchedulerGroup schedulerGroup) {
		model.addAttribute("type", CodeDefinitions.LINE_TYPE_BATCHJOB);
		model.addAttribute("readonly", false);
		model.addAttribute("pkgList", schedulerService.listPkg());
		model.addAttribute("batchGroupList", schedulerService.listBatchGroup());
		
		if (StringUtils.isNotEmpty(schedulerGroup.getPkg_name()) && StringUtils.isNotEmpty(schedulerGroup.getGroup_name())) {
			model.addAttribute("nodeTypeList", schedulerService.listNodeType(schedulerGroup));
			model.addAttribute("nodeList", schedulerService.listNode(schedulerGroup));
			model.addAttribute("procList", schedulerService.listProc(schedulerGroup));
			model.addAttribute("batchJobList", schedulerService.listBatchJob(schedulerGroup));
			model.addAttribute("lineList", schedulerService.listLine(schedulerGroup));
		}
	}
	
	@RequestMapping(value = "saveFlowDesign")
	public void saveFlowDesign(Model model, String jsonStr) {
		commonService.insertOperationHist("6");
		model.addAttribute("result", schedulerService.saveFlowDesign(jsonStr));
	}
	
	/*socketInfo*/
	@RequestMapping(value = "socketInfo")
	public void socketInfo(
			HttpServletRequest request,
			Model model) {
		model.addAttribute( "nodeInfo", schedulerService.nodeSocketInfo() );
		model.addAttribute( "processInfo", schedulerService.processSocketInfo() );
	}	
}