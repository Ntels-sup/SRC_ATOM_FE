package com.ntels.avocado.controller.common;

import java.text.ParseException;

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

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.ncf.utils.DateUtil;


@Controller
@RequestMapping(value = "/atom/commonCode")
public class CommonCodeController {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	/* 시스템콤보( 패키지/시스템 멀티셀렉트 콤보 변경예정) */
	@RequestMapping(value = "listSystemId")
	public @ResponseBody Object systemIdCombo() {
		return commonCodeService.listSystemId();
	}
	
	/* 패키지콤보  */
	@RequestMapping(value = "listPackageId")
	public @ResponseBody Object listPackageId(Model model) {
		return commonCodeService.listPackageId();
	}
	
	/* alarm type 콤보  */
	@RequestMapping(value = "listAlarmType")
	public @ResponseBody Object listAlarmType(Model model) {
		return commonCodeService.listAlarmType();
	}
	
	/* alarm group 콤보  */
	@RequestMapping(value = "listAlarmGroup")
	public @ResponseBody Object listAlarmGroup(Model model) {
		return commonCodeService.listAlarmGroup();
	}
	
	/* alarm severity 콤보  */
	@RequestMapping(value = "listAlarmSeverity")
	public @ResponseBody Object listAlarmSeverity(Model model) {
		return commonCodeService.listAlarmSeverity();
	}
	
	
	/**
	  * <PRE>
	 * 1. MethodName: histDateValue
	 * 2. ClassName : CommonCodeController
	 * 3. Comment   : history 조회 기간 유효성 체크위한 날짜format 변환.
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 3. 21. 오후 12:43:02
	 * </PRE>
	 *   @return void
	 *   @param model
	 *   @param session
	 *   @param start_date
	 *   @param end_date
	 *   @throws ParseException
	 */
	@RequestMapping(value = "histDateValue")
	public void dateValue(Model model 
						, HttpSession session
						,@RequestParam String start_date
						,@RequestParam String end_date) throws ParseException{
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		String dateformat = sessionUser.getPatternDate();
		model.addAttribute("start_date", DateUtil.dateFormaVchk(start_date,dateformat));
		model.addAttribute("end_date", DateUtil.dateFormaVchk(end_date,dateformat));
	}
	
	
	/**
	  * <PRE>
	 * 1. MethodName: atomDateValue
	 * 2. ClassName : CommonCodeController
	 * 3. Comment   :
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 5. 11. 오전 11:41:32
	 * </PRE>
	 *   @return void
	 *   @param model
	 *   @param session
	 *   @param start_date
	 *   @param end_date
	 *   @throws ParseException
	 */
	@RequestMapping(value = "atomDateValue")
	public void atomDateValue(Model model 
						, HttpSession session
						,@RequestParam String start_date
						,@RequestParam String end_date) throws ParseException{
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		String dateformat = sessionUser.getPatternDate();
		model.addAttribute("start_date", DateUtil.dateFormaVchk(start_date,dateformat));
		model.addAttribute("end_date", DateUtil.dateFormaVchk(end_date,dateformat));
		int holyCheck_dat = 5; // 기본 5 일
		int dailyCheck_dat = 10; // 기본 10 일
		holyCheck_dat = commonCodeService.getHourlyCollectTime();
		dailyCheck_dat = commonCodeService.getDailyCollectTime();
		model.addAttribute("holyCheck_dat", holyCheck_dat);
		model.addAttribute("dailyCheck_dat", dailyCheck_dat);
	}
	
	
	/**
	  * <PRE>
	 * 1. MethodName: PerFomdateValue
	 * 2. ClassName : CommonCodeController
	 * 3. Comment   :
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 5. 11. 오전 11:40:29
	 * </PRE>
	 *   @return void
	 *   @param model
	 *   @param session
	 *   @param start_date
	 *   @param end_date
	 *   @param tableName
	 *   @throws ParseException
	 */
	@RequestMapping(value = "PerFomdateValue")
	public void PerFomdateValue(Model model 
						, HttpSession session
						,@RequestParam String start_date
						,@RequestParam String end_date
						,@RequestParam String tableName) throws ParseException{
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		String dateformat = sessionUser.getPatternDate();

		model.addAttribute("start_date", DateUtil.dateFormaVchk(start_date,dateformat));
		model.addAttribute("end_date", DateUtil.dateFormaVchk(end_date,dateformat));
		int holyCheck_dat = 5; // 기본 5 일
		int dailyCheck_dat = 10; // 기본 10 일
		String pkgName = commonCodeService.getDbName(tableName);
		holyCheck_dat = commonCodeService.getPerFomHourlyCollectTime(pkgName);
		dailyCheck_dat = commonCodeService.getPerFomDailyCollectTime(pkgName);
		model.addAttribute("holyCheck_dat", holyCheck_dat);
		model.addAttribute("dailyCheck_dat", dailyCheck_dat);
	}
	
	@RequestMapping(value = "helpBody", method = RequestMethod.POST)
	public @ResponseBody String helpBody(HttpServletRequest request) {
			
			return "/help/HELP.pdf";
	}
	
}
