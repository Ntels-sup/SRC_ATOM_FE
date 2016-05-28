package com.ntels.avocado.controller.atom.fault.alarmlevel;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.atom.fault.alarmlevel.AlmCodeDef;
import com.ntels.avocado.domain.atom.fault.alarmlevel.AlmMonitor;
import com.ntels.avocado.domain.atom.fault.alarmlevel.AlmMonitorDef;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.config.networkmanager.NetworkManagerService;
import com.ntels.avocado.service.atom.fault.alarmlevel.AlarmLevelService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;

@Controller
@RequestMapping(value = "/atom/fault/alarmlevel")
public class AlarmLevelController {
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private NetworkManagerService networkManagerService;
	
	@Autowired
	private AlarmLevelService alarmLevelService;
	
	@Autowired
	private CommonService commonService;

	private String thisUrl = "atom/fault/alarmlevel";
	
	private String language = DateUtil.getDateRepresentation();
	
	@RequestMapping(value = "list")
	public String list(Model model) {
		commonService.insertOperationHist("2");
		model.addAttribute("System" ,commonCodeService.listSystemId());
		model.addAttribute("Package",commonCodeService.listPackageId());
		return thisUrl + "/list";
	}
	
	@RequestMapping(value = "listAlmCodeDef")
	public String listAction(Model model, AlmCodeDef almCodeDef) {
		model.addAttribute("resultList", alarmLevelService.listAlmCodeDef(almCodeDef));
		return thisUrl + "/listAlmCodeDef";
	}
	
	@RequestMapping(value = "listAlmMonitorDef")
	public String listAlmMonitorDef(Model model, AlmCodeDef almCodeDef) {
		List<AlmMonitorDef> almMonitorDefList = alarmLevelService.listAlmMonitorDef(almCodeDef);
		if (almMonitorDefList.size() > 0) {
			// TAT_ALM_MONITOR_DEF 테이블에 데이터가 있으면 Level Setting 화면으로 이동한다.
			model.addAttribute("nodeTypeList", networkManagerService.listNodeType());
			model.addAttribute("almMonitorDefList", almMonitorDefList);
			model.addAttribute("defaultAlarmLevelList", commonCodeService.listDefaultAlarmLevel());
			return thisUrl + "/listAlmMonitorDef";
		} else {
			// TAT_ALM_MONITOR_DEF 테이블에 데이터가 없으면 Severity Setting 화면으로 이동한다.
			model.addAttribute("almCodeDef", alarmLevelService.getAlmCodeDef(almCodeDef));
			return thisUrl + "/detailAlmCodeDef";
		}
	}
	
	@RequestMapping(value = "saveAlmCodeDef")
	public void saveAlmCodeDef(Model model, AlmCodeDef almCodeDef) {
		commonService.insertOperationHist("6");
		model.addAttribute("result", alarmLevelService.saveAlmCodeDef(almCodeDef));
	}
	
	@RequestMapping(value = "saveAlmLevel")
	public void saveAlmLevel(Model model, String jsonStr) {
		commonService.insertOperationHist("6");
		model.addAttribute("result", alarmLevelService.saveAlmLevel(jsonStr));
	}
	
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(Model model, HttpSession session, AlmCodeDef condition) {
		List<LinkedHashMap<String, String>> list = alarmLevelService.listExcel(condition);
		model.addAttribute("list", list);
		List<String> title = new ArrayList<String>();
		if(list.size()>0){
			for(String mapKey : list.get(0).keySet()){
				title.add(mapKey);
			}
		}
		model.addAttribute("title", title);
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		model.addAttribute("NowdateTime", commonCodeService.getNowDateTime(language));
		model.addAttribute("filename", condition.getTitleName());
		return "excelViewer";
	}		
}
