package com.ntels.avocado.controller.atom.general.backup.dailypolicy;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.atom.general.backup.dailypolicy.Daily;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.general.backup.dailypolicy.DailyService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.MessageUtil;

@Controller
@RequestMapping(value = "/atom/general/backup/dailypolicy/daily")
public class DailyController{

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommonCodeService commonCodeService;
	@Autowired
	private DailyService dailyService;
	
	@Autowired
	private CommonService commonService;

	private String thisUrl = "atom/general/backup/dailypolicy/daily";	
	
	/**
	 * List.
	 */
	@RequestMapping(value = "list")
	public String list(@RequestParam(required=false) String node_id, Model model)  throws Exception {
			

			commonService.insertOperationHist("2");
			model.addAttribute("node_id" ,node_id);
			model.addAttribute("System" ,commonCodeService.listNodeType());
			model.addAttribute("Package",commonCodeService.listPackageId());
		
		return thisUrl + "/list";
	}	
	
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(@RequestParam(required=false) String node_id, Model model) throws Exception {
		model.addAttribute("backupInformation", dailyService.backupInfomation(node_id));
		model.addAttribute("deleteInformation", dailyService.deleteInfomation(node_id));
		
		
		return thisUrl + "/listAction";
	}
	
	
	@RequestMapping(value = "update")
	public String update(@RequestParam(required=false) String node_id,Model model) throws Exception {
		
		model.addAttribute("node_id",node_id);
		model.addAttribute("backupInformation", dailyService.backupInfomation(node_id));
		model.addAttribute("deleteInformation", dailyService.deleteInfomation(node_id));
		model.addAttribute("defaultInformation", commonCodeService.dailyPolicyDefault());
		return thisUrl + "/update";
	}
	
	 
	/**
	 * Save action.
	 */
	@RequestMapping(value = "saveAction", method = RequestMethod.POST)
	public void saveAction(Daily daily, HttpServletRequest request, Model model) {
				
		commonService.insertOperationHist("6");
		try {
			HttpSession session = request.getSession(false);

			if (session == null) {
				model.addAttribute("result", "false");
				model.addAttribute("resultMsg", "Session is lost!");
			} 
			else {
				SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
				
				dailyService.saveAction(daily, sessionUser.getUserId());

				model.addAttribute("result", "true");
				model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.save.result"));
			}
		} 
		catch(Exception e) {
            model.addAttribute("result", "false");
            model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
		} 
	}	
}
