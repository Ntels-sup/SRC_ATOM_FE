package com.ntels.avocado.controller.atom.fault.alarmhistory;

import java.net.URLDecoder;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.fault.alarmhistory.AlarmHistoryDomain;
import com.ntels.avocado.domain.atom.security.operationhist.OperationHistDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.fault.alarmhistory.AlarmHistoryService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;
import com.ntels.ncf.utils.StringUtils;

/**
 * @author junwoo
 *
 */
@Controller
@RequestMapping(value = "/atom/fault/alarmhistory")
public class AlarmHistoryController {
	private Logger logger = Logger.getLogger(this.getClass());
	
	private String thisUrl = "atom/fault/alarmhistory";
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private AlarmHistoryService alarmHistoryService;
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private CommonService commonService;
	

	/**
	  * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : AlarmHistoryController
	 * 3. Comment   : 조회 페이지로 이동
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 3. 17. 오후 4:24:16
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @param request
	 *   @return
	 */
	@RequestMapping(value = "list")
	public String list(Model model, HttpServletRequest request , HttpSession session) {
		//현재시간 시 2자리 DateUtil.getNow("HH") 변경 ==>  commonCodeService.getNowHour()
		//현재시간 분 2자리 DateUtil.getNow("mm") 변경 ==>   commonCodeService.getNowMin()
		
		model.addAttribute("endHour", commonCodeService.getNowHour());
		model.addAttribute("endMin", StringUtils.lpad(commonCodeService.getNowMin(),2,'0'));
		
		/*멀티 셀렉트 박스*/ 
		model.addAttribute("System" ,commonCodeService.listSystemId());
		model.addAttribute("Package",commonCodeService.listPackageId());
		
		/*알람 그룹 멀티 콤보*/
		model.addAttribute("listAlmGroup",commonCodeService.listAlmGroup());
		/* 알람레벨 콤보*/
		model.addAttribute("listAlarmSeverity",commonCodeService.listAlarmSeverity());

		/* 클리어 플럭 콤보*/
//		model.addAttribute("listClearedFlag",commonCodeService.listClearedFlag());
		
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		model.addAttribute("language", language);
		// 날짜 표시 형식
		String dateformat = sessionUser.getPatternDate();
		model.addAttribute("dateformat", dateformat);
		// 시작 , 끝 날짜
		//현재시간 년월일 DateUtil.getNow(dateformat) 변경 ==>  commonCodeService.getNowDate(language)
		model.addAttribute("startDate", commonCodeService.getNowDate(language));
		model.addAttribute("endDate", commonCodeService.getNowDate(language));
		
		 //TAT_COMMON_CODE의 그룹코드(200003) 참고
		commonService.insertOperationHist("2"); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		
		return thisUrl + "/list";
	}
	

	/**
	  * <PRE>
	 * 1. MethodName: listAction
	 * 2. ClassName : AlarmHistoryController
	 * 3. Comment   : 조회 처리
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 3. 17. 오후 5:50:55
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @param condition
	 *   @param request
	 *   @return
	 */
	@RequestMapping(value = "listAction")	
	public String listAction(Model model
							,AlarmHistoryDomain condition
							, HttpSession session
							,HttpServletRequest request) throws ParseException  {
	
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		condition.setLanguage(language);
		// 날짜 표시 형식
		String dateformat = sessionUser.getPatternDate();
		//startDate Format 변환.
    	condition.setStartDate(DateUtil.dateFormatChangeToString(condition.getStartDate(),dateformat));
		
		condition.setStartHour(condition.getStartHour() == null ? "00" : condition.getStartHour());
		condition.setStartMin(condition.getStartMin() == null ? "00" : condition.getStartMin());
		
		//endDate Format 변환.
		condition.setEndDate(DateUtil.dateFormatChangeToString(condition.getEndDate(),dateformat));

		condition.setEndHour(condition.getEndHour() == null ? "00" : condition.getEndHour());
		condition.setEndMin(condition.getEndMin() == null ? "00" : condition.getEndMin());		
		
		// Future Time Check 2013.08.19
		condition.setStartTime(DateUtil.checkExceedTime(condition.getStartDate(), condition.getStartHour() + condition.getStartMin()));
		condition.setEndTime(DateUtil.checkExceedTime(condition.getEndDate(), condition.getEndHour() + condition.getEndMin()));
		
		//시스탬 멀티 -> Array
		if(condition.getSystem_id() != null){
			String[] SystemArray = condition.getSystem_id().split(",");
			condition.setSystemArray(SystemArray);	
		}
		
		//그룹 멀티 -> Array
		if(condition.getGroup_id() != null){
			String[] GroupArray = condition.getGroup_id().split(",");
			condition.setGroupArray(GroupArray);	
		}
		
		//Severity 멀티 -> Array
		if(condition.getSeverity_id() != null){
			String[] SeverityArray = condition.getSeverity_id().split(",");
			condition.setSeverityArray(SeverityArray);	
		}
		
		
		
		//Keyword 검색 처리
		String keyWord = condition.getKeyWord();  // code , location , probableCause
		String KeyText = condition.getKeyTextBox();  // 검색 text
		KeyText =KeyText.trim();
		
		if("code".equals(keyWord)) condition.setCode(KeyText);
        if("location".equals(keyWord)) condition.setLocation(KeyText);
        if("probableCause".equals(keyWord)) condition.setProbableCause(KeyText);
		
		

		//결과 요청
		Paging paging = alarmHistoryService.listAction(condition);
		
		
		model.addAttribute("resultList", paging);

		model.addAttribute("dateformat", dateformat);

        
		return thisUrl + "/listAction";
	}	
	
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(Model model
								, HttpSession session
								, AlarmHistoryDomain condition) throws ParseException  {
		
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		condition.setLanguage(language);
		// 날짜 표시 형식
		String dateformat = sessionUser.getPatternDate();
		//startDate Format 변환.
    	condition.setStartDate(DateUtil.dateFormatChangeToString(condition.getStartDate(),dateformat));
		condition.setStartHour(condition.getStartHour() == null ? "00" : condition.getStartHour());
		condition.setStartMin(condition.getStartMin() == null ? "00" : condition.getStartMin());
		
		//endDate Format 변환.
		condition.setEndDate(DateUtil.dateFormatChangeToString(condition.getEndDate(),dateformat));
		condition.setEndHour(condition.getEndHour() == null ? "00" : condition.getEndHour());
		condition.setEndMin(condition.getEndMin() == null ? "00" : condition.getEndMin());		
		// Future Time Check 2013.08.19
		condition.setStartTime(DateUtil.checkExceedTime(condition.getStartDate(), condition.getStartHour() + condition.getStartMin()));
		condition.setEndTime(DateUtil.checkExceedTime(condition.getEndDate(), condition.getEndHour() + condition.getEndMin()));
		//시스탬 멀티 -> Array
		if(condition.getSystem_id() != null){
			String[] SystemArray = condition.getSystem_id().split(",");
			condition.setSystemArray(SystemArray);	
		}
		//그룹 멀티 -> Array
		if(condition.getGroup_id() != null){
			String[] GroupArray = condition.getGroup_id().split(",");
			condition.setGroupArray(GroupArray);	
		}
		//Severity 멀티 -> Array
		if(condition.getSeverity_id() != null){
			String[] SeverityArray = condition.getSeverity_id().split(",");
			condition.setSeverityArray(SeverityArray);	
		}
		
		//Keyword 검색 처리
		String keyWord = condition.getKeyWord();  // code , location , probableCause
		String KeyText = condition.getKeyTextBox();  // 검색 text
		KeyText =KeyText.trim();
		if("code".equals(keyWord)) condition.setCode(KeyText);
        if("location".equals(keyWord)) condition.setLocation(KeyText);
        if("probableCause".equals(keyWord)) condition.setProbableCause(KeyText);
        
        //디코딩
        condition.setOrderBy(URLDecoder.decode(condition.getOrderBy()));
        String filename = URLDecoder.decode(condition.getTitleName());
        
		List<LinkedHashMap<String, String>> list = alarmHistoryService.listExcel(condition);
		model.addAttribute("list", list);
		
		List<String> title = new ArrayList<String>() ;
		/** (title) header setting */
		for(String mapKey : list.get(0).keySet()){
			title.add(mapKey);
			}
		model.addAttribute("title", title);
		
		/**  dataType : 모든항목 String 일경우 dataType 생략해도 됨 */
//		List<String> dataType = Arrays.asList("S", "S", "S", "S", "N");  
//		model.addAttribute("dataType", dataType);		                 
		/** dataType */
		
		/** 파일중복다운시 파일명+날짜(년월일시분초[언어별]) 표시 */
	 	model.addAttribute("NowdateTime", commonCodeService.getNowDateTime(language));
	 	model.addAttribute("filename", filename);
		
		return "excelViewer";
	}
	
}
