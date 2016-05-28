package com.ntels.avocado.controller.atom.fault.alarmcontrol;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ntels.avocado.domain.atom.fault.alarmcontrol.AlarmCtrDomain;
import com.ntels.avocado.service.atom.fault.alarmcontrol.AlarmCtrService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;

@Controller
@RequestMapping(value = "/atom/fault/alarmcontrol")
public class AlarmCtrController {
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private AlarmCtrService alarmCtrService;
	private String thisUrl = "atom/fault/alarmcontrol";
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	//operation history insert를 위한 서비스
	@Autowired
	private CommonService commonService;
	
	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : AlarmCtrController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 24. 오전 9:55:04
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "list")
	public String list(Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("1");
		
		List<AlarmCtrDomain> listAlarmCtr = alarmCtrService.listAlarmCtr();
		List<AlarmCtrDomain> listAlarmCtrLevel = alarmCtrService.listAlarmCtrLevel();
		List<AlarmCtrDomain> listAlarmCtrCode = alarmCtrService.listAlarmCtrCode();
		
		model.addAttribute("listAlarmCtr", listAlarmCtr);
		model.addAttribute("listAlarmCtrLevel", listAlarmCtrLevel);
		model.addAttribute("listAlarmCtrCode", listAlarmCtrCode);
		model.addAttribute("listAlarmCodeDef", alarmCtrService.listAlarmCodeDef());
		model.addAttribute("listAlaramServrity", commonCodeService.listAlarmSeverity());
		return thisUrl + "/list";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: modify
	 * 2. ClassName : AlarmCtrController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 24. 오전 9:55:09
	 * </PRE>
	 *   @return String
	 *   @param alarmCtrDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "modify")
	public String modify(AlarmCtrDomain alarmCtrDomain, Model model) throws Exception {
		List<AlarmCtrDomain> listAlarmCtr = alarmCtrService.listAlarmCtr();
		List<AlarmCtrDomain> listAlarmCtrLevel = alarmCtrService.listAlarmCtrLevel();
		List<AlarmCtrDomain> listAlarmCtrCode = alarmCtrService.listAlarmCtrCode();

		model.addAttribute("listAlarmCtr", listAlarmCtr);
		model.addAttribute("listAlarmCtrLevel", listAlarmCtrLevel);
		model.addAttribute("listAlarmCtrCode", listAlarmCtrCode);
		model.addAttribute("listAlarmCodeDef", alarmCtrService.listAlarmCodeDef());
		model.addAttribute("listAlaramServrity", commonCodeService.listAlarmSeverity());
		return thisUrl +"/modify";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: modifyAction
	 * 2. ClassName : AlarmCtrController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 24. 오후 2:25:38
	 * </PRE>
	 *   @return void
	 *   @param alarmCtrDomain
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value = "modifyAction", method = RequestMethod.POST)
	public void modifyAction(AlarmCtrDomain alarmCtrDomain, Model model) throws Exception {		
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("6");
		
		alarmCtrService.modifyAction(alarmCtrDomain);
	}
}
