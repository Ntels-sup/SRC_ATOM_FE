package com.ntels.avocado.controller.atom.performance.perfomstatistics;

import java.net.URLDecoder;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.performance.perfomstatistics.PerfomStatisticsDomain;
import com.ntels.avocado.domain.atom.security.operationhist.OperationHistDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.performance.perfomstatistics.PerfomStatisticsService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;
import com.ntels.ncf.utils.StringUtils;

@Controller
@RequestMapping(value = "/atom/performance/perfomstatistics")
public class PerfomStatisticsController {

	private String thisUrl = "atom/performance/perfomstatistics";
	
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private PerfomStatisticsService perfomStatisticsService; 
	
	@Autowired
	private CommonService commonService;
	
	/**
	  * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : PerfomStatisticsController
	 * 3. Comment   : 조회 화면으로 이동
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 1. 오전 9:09:33
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @param request
	 *   @param session
	 *   @return
	 */
	@RequestMapping(value = "list")
	public String list(Model model, HttpServletRequest request , HttpSession session) {

		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);

		//현재시간 시 2자리 DateUtil.getNow("HH") 변경 ==>  commonCodeService.getNowHour()
		//현재시간 분 2자리 DateUtil.getNow("mm") 변경 ==>   commonCodeService.getNowMin()
		model.addAttribute("endHour", commonCodeService.getNowHour());
		int mm = (Integer.parseInt(commonCodeService.getNowMin()) / 5) * 5;
		model.addAttribute("endMin", StringUtils.lpad(Integer.toString(mm),2,'0'));
		
		/* 서치타입(분,시,일,월 주기) 콤보*/
		model.addAttribute("listSearchType",commonCodeService.listSearchType());
		
		/*Statistics Single 콤보*/
		model.addAttribute("stsTableInfo",commonCodeService.listStsTable());
		
		/*멀티 셀렉트 박스*/ 
		model.addAttribute("System" ,commonCodeService.listSystemName());
		model.addAttribute("Package",commonCodeService.listPackageId());
		
		/*Table 당 콤보 그룹 조회*/
		model.addAttribute("ComboGroup",commonCodeService.listStsComboGroup());
		List<Map<String, String>> ComboGroupSet = commonCodeService.listStsComboGroup();
		for(int i=0 ; i < ComboGroupSet.size() ; i++ ){
			ComboGroupSet.get(i).put("tbCl", ComboGroupSet.get(i).get("TABLE_NAME")+":"+ComboGroupSet.get(i).get("COLUMN_NAME"));
		}
		model.addAttribute("ComboGroupSet",ComboGroupSet);
		
		/*Table 콤보 조회*/
		model.addAttribute("ComboValue",commonCodeService.listStsComboValue());
		
		
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
	
	/**
	  * <PRE>
	 * 1. MethodName: listAction
	 * 2. ClassName : PerfomStatisticsController
	 * 3. Comment   : 조회 시작~
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 4. 오전 11:37:43
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @param session
	 *   @param condition
	 *   @param request
	 *   @return
	 *   @throws ParseException
	 */
	@RequestMapping(value = "listAction")
	public String listAction(Model model
            , HttpSession session
			 ,PerfomStatisticsDomain condition
			 ,HttpServletRequest request) throws ParseException {
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);

		String tableName  =  condition.getTableName();
		Enumeration enums = request.getParameterNames();
        
		StringBuffer whereClause = new StringBuffer();
		StringBuffer timeUnionClause = new StringBuffer();
        
		while(enums.hasMoreElements()){
        	String Nm = (String) enums.nextElement();
        	String value = request.getParameter(Nm);
            String[] usArray = Nm.split(":");
            if(usArray.length > 1){
	            if(tableName.equals(usArray[0])){
	            	StringBuffer whereClm = new StringBuffer();
	            	StringBuffer tUnion = new StringBuffer();
	            	//검색항목 타입 조회. commonCodeService.typeOfColumn(TABLE_NAME,COLUMN_NAME);
	            	String cltype = commonCodeService.typeOfColumn(tableName , usArray[1]);
	            	if(cltype.equals("INT") || cltype.equals("BIGINT")){
	            		whereClm.append("\n AND ").append(usArray[1]).append("=").append(value);
	            	}else{
	            		whereClm.append("\n AND ").append(usArray[1]).append("=").append('"').append(value).append('"');
	            	}
	            	whereClause.append(whereClm);
	            	tUnion.append(",(SELECT").append(" '").append(value).append("' ").append("AS ").append(usArray[1]).append(")").append(usArray[1]);
	            	timeUnionClause.append(tUnion);
	            }
            }
        }
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		if(StringUtils.isEmpty(condition.getTypeId())) condition.setTypeId("1");
		// 날짜 데이터 포멧 맞추기위해 DB날짜 페턴을 입력.
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
		
		//시스탬 멀티 -> Array :: all 일경우 all 로표시
		String[] SystemArray = condition.getSystem_name().split(",");
		if(condition.getSystem_name() != null){
			if(SystemArray.length == commonCodeService.getSystemCount()){
			String[] Systemall = {"all"};	
				condition.setSystemArray(Systemall);
				condition.setSystem_name("all");
			}else{
				condition.setSystemArray(SystemArray);	
			}
		}
		
		 List<String> header = new ArrayList<String>();
		//테이블 컬럼조회-검색(view)필드
		String[] viewColumns = commonCodeService.getViewColList(tableName,"Y").split(",");
		condition.setViewColumns(viewColumns);
        for(String col : viewColumns){
        	if(!col.equals("")) header.add(col);
        }
		//테이블 컬럼조회-통계(SUM(view))vlfem
		String[] sumColumns = commonCodeService.getViewColList(tableName,"N").split(",");
        condition.setSumColumns(sumColumns);
        for(String col : sumColumns){
        	header.add(col);
        }
        
        //whereClause
        condition.setWhereClause(whereClause.toString());
        //timeUnionClause
        condition.setTimeUnionClause(timeUnionClause.toString());
        //table space 조회 : PKG_ID 가 테이블스페이스 구분자
		condition.setDb_name(commonCodeService.getDbName(tableName));
        //결과 요청
		Paging paging = perfomStatisticsService.listAction(condition);
		
		//차트 조회를 위해 systemName array 처리.
		condition.setSystemArray(SystemArray);
		condition.setSystem_name("");
		//시스템 Top10 을 먼저 구한다.
		//top10 카운트 컬럼 조회.
		int limitCnt = 0;
		
		limitCnt = commonCodeService.getChartColumnCount(tableName);
		limitCnt = 15/limitCnt;               // legend 노드별 라인수 제한.
		condition.setLimitTable(limitCnt);
		
		condition.setTopCountColumn(commonCodeService.getTopCountColumn(tableName));
		String[] topArray = perfomStatisticsService.topSystemArray(condition).split(",");
		//top 10 시스템으로 chart 조회.
        condition.setSystemArray(topArray);
        condition.setChartColumns(commonCodeService.getChartColumn(tableName).split(","));
        List<HashMap<String,String>> perfomChart = perfomStatisticsService.getChartList(condition);

        List<LinkedHashMap<String, String>> topSystem = new ArrayList<LinkedHashMap<String,String>>(); 
        String[] chcol = commonCodeService.getChartColumn(tableName).split(",");
        int index = 0;
        for (int c = 0; c < limitCnt ; c++) {
        	for (int col = 0; col < chcol.length; col++) {
        		LinkedHashMap<String, String> LEG_NAME = new LinkedHashMap<String, String>();	
        		LEG_NAME.put("SYSTEM_NAME", topArray[c]+":"+chcol[col]);
        		topSystem.add(index++, LEG_NAME);;
        	}
		}
        String CNT = "";
		HashMap<String,String> mapChart =  new HashMap<String, String>();
		for (int i = 0; i < perfomChart.size(); i++) {
			CNT = perfomChart.get(i).get("CNT");
			String prc_date = perfomChart.get(i).get("PRC_DATE");
			mapChart.put("PRC_DATE", prc_date);
			String[] usArray = CNT.split(",");
			for (int j = 0; j < usArray.length; j++) {
			   String[] o_S_C = usArray[j].split("~");
			   mapChart.put(o_S_C[0], o_S_C[1]);
		   }
		   perfomChart.get(i).clear();
		   perfomChart.get(i).putAll(mapChart);
		}
		
		Gson gson = new Gson();
		model.addAttribute("perfomChart", gson.toJson(perfomChart));
		model.addAttribute("Legend", topSystem);
		
		model.addAttribute("resultList", paging);
		model.addAttribute("HEADCOL", header);
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
		model.addAttribute("chartNmae", tableName);
		
		
		return thisUrl + "/listAction";
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: exportAction
	 * 2. ClassName : PerfomStatisticsController
	 * 3. Comment   : 엑셀 다운
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 5. 오후 8:14:34
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
			 ,PerfomStatisticsDomain condition
			 ,HttpServletRequest request) throws ParseException {
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);

		String tableName  =  URLDecoder.decode(condition.getTableName());
		condition.setTableName(tableName);
		Enumeration enums = request.getParameterNames();
        
		StringBuffer whereClause = new StringBuffer();
		StringBuffer timeUnionClause = new StringBuffer();
        
		while(enums.hasMoreElements()){
        	String Nm = (String) enums.nextElement();
        	String value = request.getParameter(Nm);
        	Nm = URLDecoder.decode(Nm);
        	value  = URLDecoder.decode(value) ;
        	String[] usArray = Nm.split(":");
            if(usArray.length > 1){
	            if(tableName.equals(usArray[0])){
	            	StringBuffer whereClm = new StringBuffer();
	            	StringBuffer tUnion = new StringBuffer();
	            	//검색항목 타입 조회. commonCodeService.typeOfColumn(TABLE_NAME,COLUMN_NAME);
	            	String cltype = commonCodeService.typeOfColumn(tableName , usArray[1]);
	            	if(cltype.equals("INT") || cltype.equals("BIGINT")){
	            		whereClm.append("\n AND ").append(usArray[1]).append("=").append(value);
	            	}else{
	            		whereClm.append("\n AND ").append(usArray[1]).append("=").append('"').append(value).append('"');
	            	}
	            	whereClause.append(whereClm);
	            	tUnion.append(",(SELECT").append(" '").append(value).append("' ").append("AS ").append(usArray[1]).append(")").append(usArray[1]);
	            	timeUnionClause.append(tUnion);
	            }
            }
        }
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		if(StringUtils.isEmpty(condition.getTypeId())) condition.setTypeId("1");
		// 날짜 데이터 포멧 맞추기위해 DB날짜 페턴을 입력.
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
		
		//시스탬 멀티 -> Array :: all 일경우 all 로표시
		String[] SystemArray = URLDecoder.decode(condition.getSystem_name()).split(",");
		if(condition.getSystem_name() != null){
			if(SystemArray.length == commonCodeService.getSystemCount()){
			String[] Systemall = {"all"};	
				condition.setSystemArray(Systemall);
				condition.setSystem_name("all");
			}else{
				condition.setSystemArray(SystemArray);	
			}
		}
		
		//테이블 컬럼조회-검색(view)필드
		String[] viewColumns = commonCodeService.getViewColList(tableName,"Y").split(",");
		condition.setViewColumns(viewColumns);
		//테이블 컬럼조회-통계(SUM(view))vlfem
		String[] sumColumns = commonCodeService.getViewColList(tableName,"N").split(",");
        condition.setSumColumns(sumColumns);
        //whereClause
        condition.setWhereClause(whereClause.toString());
        //timeUnionClause
        condition.setTimeUnionClause(timeUnionClause.toString());
        //table space 조회 : PKG_ID 가 테이블스페이스 구분자
        condition.setDb_name(commonCodeService.getDbName(tableName));		
		
        //디코딩
        condition.setOrderBy(URLDecoder.decode(condition.getOrderBy()));
        String filename = URLDecoder.decode(tableName);
		List<LinkedHashMap<String, String>> list = perfomStatisticsService.listExcel(condition);
		model.addAttribute("list", list);
		List<String> title = new ArrayList<String>() ;
		/** (title) header setting */
		for(String mapKey : list.get(0).keySet()){
			title.add(mapKey);
			}
		model.addAttribute("title", title);
		
		/**  dataType : 모든항목 String 일경우 dataType 생략해도 됨 */
		//List<String> dataType = Arrays.asList("S", "S", "S", "S", "N");  
	                 
		
		/** 파일중복다운시 파일명+날짜(년월일시분초[언어별]) 표시 */
	 	model.addAttribute("NowdateTime", commonCodeService.getNowDateTime(language));
	 	model.addAttribute("filename", filename);
		return "excelViewer";
	}
}
