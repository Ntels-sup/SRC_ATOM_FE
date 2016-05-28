package com.ntels.avocado.controller.atom.fault.alarmstatistics;

import java.net.URLDecoder;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.google.gson.Gson;
import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.fault.alarmstatistics.AlarmStatisticsDomain;
import com.ntels.avocado.domain.atom.security.operationhist.OperationHistDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.fault.alarmstatistics.AlarmStatisticsService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;
import com.ntels.ncf.utils.StringUtils;

@Controller
@RequestMapping(value = "/atom/fault/alarmstatistics")
public class AlarmStatisticsController {

	private Logger logger = Logger.getLogger(this.getClass());
	
	private String thisUrl = "atom/fault/alarmstatistics";
	
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private AlarmStatisticsService alarmStatisticsService;
	
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private CommonService commonService;
	
	
	/**조회 화면으로 이동
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "list")
	public String list(Model model, HttpServletRequest request , HttpSession session) {

		//현재시간 시 2자리 DateUtil.getNow("HH") 변경 ==>  commonCodeService.getNowHour()
		//현재시간 분 2자리 DateUtil.getNow("mm") 변경 ==>   commonCodeService.getNowMin()
		
		model.addAttribute("endHour", commonCodeService.getNowHour());
		int mm = (Integer.parseInt(commonCodeService.getNowMin()) / 5) * 5;
		model.addAttribute("endMin", StringUtils.lpad(Integer.toString(mm),2,'0'));

		
		/*멀티 셀렉트 박스*/ 
		model.addAttribute("System" ,commonCodeService.listSystemId());
		model.addAttribute("Package",commonCodeService.listPackageId());
		
		/* 알람레벨 콤보*/
		model.addAttribute("listAlarmSeverity",commonCodeService.listAlarmSeverity());
		/* 클리어 플럭 콤보*/
//		model.addAttribute("listClearedFlag",commonCodeService.listClearedFlag());
		
		/* 서치타입(분,시,일,월 주기) 콤보*/
		model.addAttribute("listSearchType",commonCodeService.listSearchType());
		;
		
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		model.addAttribute("language", language);
		// 날짜 표시 형식
		String dateformat = sessionUser.getPatternDate();
		model.addAttribute("dateformat", dateformat);
		
		//현재시간 년월일 DateUtil.getNow(dateformat) 변경 ==>  commonCodeService.getNowDate(language)
		model.addAttribute("startDate", commonCodeService.getNowDate(language));
		model.addAttribute("endDate", commonCodeService.getNowDate(language));
		
		// 조회기간 알림.
		int holyCheck_dat = 5; // 기본 5 일
		int dailyCheck_dat = 10; // 기본 10 일
		holyCheck_dat = commonCodeService.getHourlyCollectTime();
		dailyCheck_dat = commonCodeService.getDailyCollectTime();
		model.addAttribute("holyCheck_dat", holyCheck_dat);
		model.addAttribute("dailyCheck_dat", dailyCheck_dat);
		
		 //TAT_COMMON_CODE의 그룹코드(200003) 참고
		commonService.insertOperationHist("2"); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		
		
		return thisUrl + "/list";
	}
	
	
	/**조회 처리
	 * @param model
	 * @param request
	 * @param SYSTEM_ID 
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value = "listAction")
	public String listAction(Model model
			                 , HttpSession session
							 ,AlarmStatisticsDomain condition
							 ,HttpServletRequest request) throws ParseException {

		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		
		if(StringUtils.isEmpty(condition.getTypeId())) condition.setTypeId("1");

		// chart 날짜 데이터 포멧 맞추기위해 DB날짜 페턴을 입력.
		if(!(condition.getTypeId()).equals("4")){ // 10,30,한시간,일별
		condition.setLocale(commonCodeService.DbdatePattern(language));
		}else{ // 월별
			condition.setLocale(commonCodeService.DbdatePatternMonth(language));	
		}
		//startDate Format 변환.
    	condition.setStartDate(DateUtil.dateFormatChangeToString(condition.getStartDate(),condition.getDateformat()));
		
		condition.setStartHour(condition.getStartHour() == null ? "00" : condition.getStartHour());
		condition.setStartMin(condition.getStartMin() == null ? "00" : condition.getStartMin());
		
		//endDate Format 변환.
		condition.setEndDate(DateUtil.dateFormatChangeToString(condition.getEndDate(),condition.getDateformat()));

		condition.setEndHour(condition.getEndHour() == null ? "00" : condition.getEndHour());
		condition.setEndMin(condition.getEndMin() == null ? "00" : condition.getEndMin());		
		
		// Future Time Check 2013.08.19
		condition.setStartTime(DateUtil.checkExceedTime(condition.getStartDate(), condition.getStartHour() + condition.getStartMin()));
		condition.setEndTime(DateUtil.checkExceedTime(condition.getEndDate(), condition.getEndHour() + condition.getEndMin()));
		
		//시스탬 멀티 -> Array
		String[] SystemArray = condition.getSystem_id().split(",");
		if(condition.getSystem_id() != null){
			if(SystemArray.length == commonCodeService.getSystemCount()){
			String[] Systemall = {"all"};	
				condition.setSystemArray(Systemall);
				condition.setSystem_id("all");
			}else{
				condition.setSystemArray(SystemArray);	
			}
		}
		
		
		//Keyword 검색 처리--> 삭제
/*		String keyWord = condition.getKeyWord();  // code , location , probableCause
		String KeyText = condition.getKeyTextBox();  // 검색 text
		KeyText =KeyText.trim();
		
		if("code".equals(keyWord)) condition.setCode(KeyText);
        if("location".equals(keyWord)) condition.setLocation(KeyText);
        if("probableCause".equals(keyWord)) condition.setProbableCause(KeyText);*/
		
		
		//결과 요청
		Paging paging = alarmStatisticsService.listAction(condition);
		model.addAttribute("resultList", paging);
		
		//차트 조회를 위해 systemId array 처리.
		condition.setSystemArray(SystemArray);
		condition.setSystem_id("");
		//시스템 Top10 을 먼저 구한다.
		String[] topArray = alarmStatisticsService.topSystemArray(condition).split(",");
		List<LinkedHashMap<String, String>> topSystem = new ArrayList<LinkedHashMap<String,String>>(); 
		for (int i = 0; i < topArray.length; i++) {
			LinkedHashMap<String, String> NODE_NAME = new LinkedHashMap<String, String>();	
			NODE_NAME.put("NODE_NAME", commonCodeService.getNodeName(topArray[i]));
			topSystem.add(i, NODE_NAME);
		}
		//top 10 시스템으로 chart 조회.
        condition.setSystemArray(topArray);
		List<HashMap<String,String>> alarmChart = alarmStatisticsService.getChartList(condition);

		String SYSCNT = "";
		HashMap<String,String> mapChart =  new HashMap<String, String>();
		for (int i = 0; i < alarmChart.size(); i++) {
			SYSCNT = alarmChart.get(i).get("SYSTM_BY_CNT");
			String prc_date = alarmChart.get(i).get("PRC_DATE");
			mapChart.put("PRC_DATE", prc_date);
			String[] scArray = SYSCNT.split(",");
		   for (int j = 0; j < scArray.length; j++) {
			   String[] o_S_C = scArray[j].split("~");
			   mapChart.put(o_S_C[0], o_S_C[1]);
		   }
		   alarmChart.get(i).clear();
		   alarmChart.get(i).putAll(mapChart);
		}
		Gson gson = new Gson();
		model.addAttribute("topSystem", topSystem);
		model.addAttribute("alarmChart", gson.toJson(alarmChart));
		model.addAttribute("severityCase",condition.getSeverity());


		model.addAttribute("language", language);
		// 날짜 표시 형식
		if(!(condition.getTypeId()).equals("4")){
			model.addAttribute("patternDate", sessionUser.getPatternDate());
		}else{
			model.addAttribute("patternDate", sessionUser.getPatternMonth());
		}
		model.addAttribute("patternTime", sessionUser.getPatternTime());
		// 리스트 날짜포멧
		model.addAttribute("dateformat", sessionUser.getPatternDate());
		model.addAttribute("typeId", condition.getTypeId());
		
		
		
		return thisUrl + "/listAction";
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: exportAction
	 * 2. ClassName : AlarmStatisticsController
	 * 3. Comment   : 엑셀 다운
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 3. 23. 오후 3:01:55
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @param session
	 *   @param condition
	 *   @param request
	 *   @return
	 *   @throws ParseException
	 */
	@RequestMapping(value = "exportAction")
	public String exportAction(Model model
            , HttpSession session
			 ,AlarmStatisticsDomain condition
			 ,HttpServletRequest request) throws ParseException {


		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		
		if(StringUtils.isEmpty(condition.getTypeId())) condition.setTypeId("1");
		// chart 날짜 데이터 포멧 맞추기위해 DB날짜 페턴을 입력.
		if(!(condition.getTypeId()).equals("4")){ // 10,30,한시간,일별
		condition.setLocale(commonCodeService.DbdatePattern(language));
		}else{ // 월별
			condition.setLocale(commonCodeService.DbdatePatternMonth(language));	
		}
		//startDate Format 변환.
    	condition.setStartDate(DateUtil.dateFormatChangeToString(condition.getStartDate(),condition.getDateformat()));
		
		condition.setStartHour(condition.getStartHour() == null ? "00" : condition.getStartHour());
		condition.setStartMin(condition.getStartMin() == null ? "00" : condition.getStartMin());
		
		//endDate Format 변환.
		condition.setEndDate(DateUtil.dateFormatChangeToString(condition.getEndDate(),condition.getDateformat()));

		condition.setEndHour(condition.getEndHour() == null ? "00" : condition.getEndHour());
		condition.setEndMin(condition.getEndMin() == null ? "00" : condition.getEndMin());		
		
		// Future Time Check 2013.08.19
		condition.setStartTime(DateUtil.checkExceedTime(condition.getStartDate(), condition.getStartHour() + condition.getStartMin()));
		condition.setEndTime(DateUtil.checkExceedTime(condition.getEndDate(), condition.getEndHour() + condition.getEndMin()));
		
		//시스탬 멀티 -> Array
		String[] SystemArray = condition.getSystem_id().split(",");
		if(condition.getSystem_id() != null){
			if(SystemArray.length == commonCodeService.getSystemCount()){
			String[] Systemall = {"all"};	
				condition.setSystemArray(Systemall);
				condition.setSystem_id("all");
			}else{
				condition.setSystemArray(SystemArray);	
			}
		}

        //디코딩
        condition.setOrderBy(URLDecoder.decode(condition.getOrderBy()));
        String filename = URLDecoder.decode(condition.getTitleName());
		List<LinkedHashMap<String, String>> list = alarmStatisticsService.listExcel(condition);
		model.addAttribute("list", list);
		
		List<String> title = new ArrayList<String>() ;
		/** (title) header setting */
		for(String mapKey : list.get(0).keySet()){
			title.add(mapKey);
			}
		model.addAttribute("title", title);
		
		/**  dataType : 모든항목 String 일경우 dataType 생략해도 됨 */
		List<String> dataType = Arrays.asList("S", "S", "S", "S", "N");  
		model.addAttribute("dataType", dataType);		                 
		/** dataType */
		
		/** 파일중복다운시 파일명+날짜(년월일시분초[언어별]) 표시 */
	 	model.addAttribute("NowdateTime", commonCodeService.getNowDateTime(language));
	 	model.addAttribute("filename", filename);
		
		return "excelViewer";
	}
	
	
	
}
