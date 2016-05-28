package com.ntels.avocado.controller.atom.monitor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.config.networkmanager.Node;
import com.ntels.avocado.domain.atom.config.processmanager.Svc;
import com.ntels.avocado.domain.atom.general.scheduler.SchedulerGroup;
import com.ntels.avocado.domain.atom.monitor.Monitor;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.domain.common.definitions.CodeDefinitions;
import com.ntels.avocado.service.atom.config.networkmanager.NetworkManagerService;
import com.ntels.avocado.service.atom.config.processmanager.ProcessManagerService;
import com.ntels.avocado.service.atom.general.scheduler.SchedulerService;
import com.ntels.avocado.service.atom.monitor.MonitorService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.ncf.utils.DateUtil;
import com.ntels.ncf.utils.StringUtils;

@Controller
@RequestMapping(value = "/atom/monitor")
public class MonitorController {
	
	private String language = DateUtil.getDateRepresentation();
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private MonitorService monitorService;
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private NetworkManagerService networkManagerService;
	
	@Autowired
	private ProcessManagerService processManagerService;
	
	@Autowired
	private SchedulerService schedulerService;
	
	@RequestMapping(value = "monitor", method = RequestMethod.POST)
	public String monitor(HttpSession session, Model model) {
		
		Gson gson = new Gson();
		
		SessionUser sessionUser = (SessionUser)session.getAttribute(Consts.USER.SESSION_USER);
		List<Map<String, Object>> authorizationPackage = monitorService.authorizationAlarm(sessionUser.getUserId());
		model.addAttribute("authorizationPackage", authorizationPackage); //패키지 권한 조회 
		model.addAttribute("alarmAll", gson.toJson(monitorService.alarmAll())); //알람 All 리스트
		model.addAttribute("audioSeveritySound", monitorService.audioSeveritySound()); //Level 오디오 정보(화면보여준다) 
		
		return "atom/monitor/monitor";
	}
	
	@RequestMapping(value="alarmList", method = RequestMethod.POST)
	public String alarmList(Monitor monitor
            				, HttpSession session
            				, Model model) {
		System.err.println("alarmList------------->"+monitor);
		System.err.println(monitor.getPackageName());
		System.err.println(Arrays.toString(monitor.getPackageName()));
		monitor.setPerPage(100); //개수
		
		int page = monitor.getPage();
		int perPage = monitor.getPerPage();
		//System.err.println(monitor.toString());
		int count = 0;
		count = monitorService.AlarmTotalCount(monitor);
		
		Paging paging = new Paging();
		paging.setTotalCount(count); //결과 갯수를 DTO에 저장	
		paging.setPage(page); //현재 페이지를 저장
		paging.setPerPage(perPage); //페이징수
		
		if (count > 0) paging.setLists(monitorService.listAlarm(monitor, page, perPage)); //결과를 DTO에 저장			
				
		
		
		int lastPage = (count % perPage == 0) ? count/perPage : (count/perPage + 1);
		
		model.addAttribute("paging", paging);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("severityCount", monitorService.severityCount(monitor));
		
		return "atom/monitor/alarmList";
	}
	
	@RequestMapping(value="exportAction", method = RequestMethod.POST)
	public String exportAction(Monitor monitor
            				, HttpSession session
            				, Model model) {
		
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		String dateformat = sessionUser.getPatternDate();
		System.err.println("-------------->"+dateformat);
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		System.err.println("-------------->"+language);
		monitor.setLanguage(language);
		
		List<LinkedHashMap<String, String>> list = monitorService.listExcel(monitor);
		List<String> title = new ArrayList<String>() ;
		/** (title) header setting */
		for(String mapKey : list.get(0).keySet()){
			title.add(mapKey);
		}
		model.addAttribute("list", list);
		model.addAttribute("title", title);
		model.addAttribute("NowdateTime", commonCodeService.getNowDateTime(language));
	 	model.addAttribute("filename", "Alarm Status");
		
		return "excelViewer";
	}
	
	/**
	 * Alarm sound.
	 * <PRE>
	 * 1. MethodName: lastSound
	 * 2. ClassName : MonitorController
	 * 3. Comment   :
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 4. 14. 오후 1:39:33
	 * </PRE>
	 *   @return Map<String,Object>
	 *   @return
	 */
	@RequestMapping(value="lastSound", method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> lastSound() {
		return monitorService.lastSound();
	}
	
	@RequestMapping(value = "networkDiagram")
	public String networkDiagram() {
		return "atom/monitor/networkDiagram";
	}
	
	@RequestMapping(value = "batchJobDiagram")
	public String batchJobDiagram() {
		return "atom/monitor/batchJobDiagram";
	}
	
	@RequestMapping(value = "searchFlowDesign")
	public void searchFlowDesign(Model model, Svc svc, SchedulerGroup schedulerGroup) {
		if (svc != null && svc.getSvc_no() != null) {
			// Process Diagram
			model.addAttribute("type", CodeDefinitions.LINE_TYPE_PROCESS);
			model.addAttribute("readonly", true);
			model.addAttribute("svcList", processManagerService.listSvc());
			model.addAttribute("procList", processManagerService.listMonitoringProc(svc));
			model.addAttribute("lineList", processManagerService.listLine(svc));
		} else if (schedulerGroup != null && schedulerGroup.getPkg_name() != null && schedulerGroup.getGroup_name() != null) {
			// Batch Job Diagram
			model.addAttribute("type", CodeDefinitions.LINE_TYPE_BATCHJOB);
			model.addAttribute("readonly", true);
			model.addAttribute("pkgList", schedulerService.listPkg());
			List<SchedulerGroup> batchGroupList = schedulerService.listBatchGroup();
			model.addAttribute("batchGroupList", batchGroupList);
			if (schedulerGroup != null && StringUtils.isEmpty(schedulerGroup.getPkg_name()) && StringUtils.isEmpty(schedulerGroup.getGroup_name())) {
				if (batchGroupList.size() > 0) {
					schedulerGroup = batchGroupList.get(0);
				}
			}
			model.addAttribute("batchJobList", schedulerService.listBatchJob(schedulerGroup));
			model.addAttribute("lineList", schedulerService.listLine(schedulerGroup));
			model.addAttribute("schedulerGroup",schedulerGroup);
		} else {
			// Network Diagram
			model.addAttribute("type", CodeDefinitions.LINE_TYPE_NETWORK);
			model.addAttribute("readonly", true);
			model.addAttribute("pkgList", networkManagerService.listPkg());
			model.addAttribute("allNodeList", networkManagerService.listAllNode());
			model.addAttribute("nodeList", networkManagerService.listMonitoringNode());
			model.addAttribute("lineList", networkManagerService.listLine());
			model.addAttribute("connectionList", networkManagerService.listConnection());
		}
	}
	
	@RequestMapping(value = "reloadNodeStatus")
	public void reloadNodeStatus(Model model) {
		model.addAttribute("allNodeList", networkManagerService.listAllNode());
		model.addAttribute("nodeList", networkManagerService.listMonitoringNode());
	}
	
	@RequestMapping(value = "reloadConnectionStatus")
	public void reloadConnectionStatus(Model model) {
		model.addAttribute("connectionList", networkManagerService.listConnection());
	}
	
	@RequestMapping(value="listNodeSvc", method=RequestMethod.POST)
	public void listSvc(Model model, Node node) {
		model.addAttribute("svcList", processManagerService.listNodeSvc(node));
	}
	
	@RequestMapping(value = "processDiagram")
	public String processDiagram(Svc svc) {
		return "atom/monitor/processDiagram";
	}
	
	@RequestMapping(value="ackAlarmConfirm", method=RequestMethod.POST)
	public @ResponseBody Object ackAlarmConfirm(String[] chk, HttpSession session) {
		try {
			
			monitorService.checkAlarmConfirm(chk, true, session);
			return 0;
		} catch(Exception e) {
			e.printStackTrace();
			return 1;
		}
	}
	
	
	@RequestMapping(value="unAckAlarmConfirm", method=RequestMethod.POST)
	public @ResponseBody Object unAckAlarmConfirm(String[] chk, HttpSession session) {
		try {
			monitorService.checkAlarmConfirm(chk, false, session);
			return 0;
		} catch(Exception e) {
			e.printStackTrace();
			return 1;
		}
	}
	
	@RequestMapping(value="clearAlarmConfirm", method=RequestMethod.POST)
	public @ResponseBody Object clearAlarmConfirm(String[] chk, HttpSession session, Model model) {
		
		Map<String,Object> map = null;
		
		try {
			
			SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
			// language
			if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
				language = sessionUser.getLanguage();
			}			
			
			int operNo = monitorService.clearAlarmConfirm(chk, session);
			
			map = new HashMap<String,Object>();
			map.put("operNo", operNo);
			map.put("NowDate", commonCodeService.getSysDate("%Y-%m-%d %H:%m:%s"));
			TimeZone tz = TimeZone.getTimeZone("EST");
			map.put("DST", (tz.inDaylightTime(new Date())) ? "Y" : "N");
			map.put("AlarmNo", monitorService.getProcessAlarm());
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
	
	@RequestMapping(value="alarmDetail", method=RequestMethod.POST)
	public String alarmDetail(Integer msgId, Model model) {
		model.addAttribute("alarmDetail", monitorService.alarmDetail(msgId));
		return "atom/monitor/alarmDetail";
	}
	
	@RequestMapping(value="listNodeStatus", method=RequestMethod.POST)
	public @ResponseBody List<Map<String,Object>> listNodeStatus() {
		return monitorService.listNodeStatus();
	}
	
	@RequestMapping(value = "listTreeDetail", method = RequestMethod.POST)
	public @ResponseBody Object listTreeDetail(String nodeId) {
		Gson gson = new Gson();
		System.err.println(monitorService.listTreeDetail(nodeId));
		return gson.toJson(monitorService.listTreeDetail(nodeId));
	}
	
	@RequestMapping(value = "listTreeAllProcess", method = RequestMethod.POST)
	public @ResponseBody List<Map<String,Object>> listTreeAllProcess(String nodeId) {
		return monitorService.listTreeAllProcess(nodeId);
	}
	
	@RequestMapping(value = "getProcNo", method = RequestMethod.POST)
	@ResponseBody
	public int getProcNo(
			@RequestParam(required=false) String nodeType,
            @RequestParam(required=false) String procName) {
		return monitorService.getProcNo(nodeType, procName);
	}
	
	@RequestMapping(value="listTopResource", method=RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> listTopResource() {
		return monitorService.listTopResource();
	}
	
	@RequestMapping(value = "dateTime", method = RequestMethod.POST)
	public @ResponseBody String dateTime(
			HttpSession session) {
		
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);

		logger.debug( "[mirinae.maru] patternDate : " + sessionUser.getPatternDate() );
		logger.debug( "[mirinae.maru] patternTime : " + sessionUser.getPatternTime() );
		
		return sessionUser.getPatternDate() +" "+ sessionUser.getPatternTime();
	}
}
