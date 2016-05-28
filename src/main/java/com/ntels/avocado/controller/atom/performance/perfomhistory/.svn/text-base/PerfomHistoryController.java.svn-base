package com.ntels.avocado.controller.atom.performance.perfomhistory;

import java.net.URLDecoder;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.performance.perfomhistory.PerfomHistoryDomain;
import com.ntels.avocado.domain.atom.security.operationhist.OperationHistDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.performance.perfomhistory.PerfomHistoryService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;
import com.ntels.ncf.utils.StringUtils;

@Controller
@RequestMapping(value = "/atom/performance/perfomhistory")
public class PerfomHistoryController {
	private String thisUrl = "atom/performance/perfomhistory";
	
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private PerfomHistoryService perfomHistoryService;
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private CommonService commonService;
	
	/**
	  * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : PerfomHistoryController
	 * 3. Comment   : 조회화면으로 이동
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 11. 오후 12:55:23
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
		
		/*PerForm History Single 콤보*/
		model.addAttribute("rcdTableInfo",commonCodeService.listRcdTable());
		
		/*멀티 셀렉트 박스*/ 
		model.addAttribute("System" ,commonCodeService.listSystemName());
		model.addAttribute("Package",commonCodeService.listPackageId());
		
		/*Table 당 콤보 그룹 조회*/
		model.addAttribute("ComboGroup",commonCodeService.listRcdComboGroup());
		List<Map<String, String>> ComboGroupSet = commonCodeService.listRcdComboGroup();
		for(int i=0 ; i < ComboGroupSet.size() ; i++ ){
			ComboGroupSet.get(i).put("tbCl", ComboGroupSet.get(i).get("TABLE_NAME")+":"+ComboGroupSet.get(i).get("COLUMN_NAME"));
		}
		model.addAttribute("ComboGroupSet",ComboGroupSet);
		
		/*Table 콤보 조회*/
		model.addAttribute("ComboValue",commonCodeService.listRcdComboValue());
		
		
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

		 //TAT_COMMON_CODE의 그룹코드(200003) 참고
		commonService.insertOperationHist("2"); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		
		return thisUrl + "/list";
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: listAction
	 * 2. ClassName : PerfomHistoryController
	 * 3. Comment   : 조회 시작~
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 11. 오후 1:31:05
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
			 ,PerfomHistoryDomain condition
			 ,HttpServletRequest request) throws ParseException {
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);

		String tableNmae  =  condition.getTableName();
		Enumeration enums = request.getParameterNames();
        
		StringBuffer whereClause = new StringBuffer();
        
		while(enums.hasMoreElements()){
        	String Nm = (String) enums.nextElement();
        	String value = request.getParameter(Nm);
            String[] usArray = Nm.split(":");
            if(usArray.length > 1){
	            if(tableNmae.equals(usArray[0])){
	            	StringBuffer whereClm = new StringBuffer();
	            	//검색항목 타입 조회. commonCodeService.typeOfColumn(TABLE_NAME,COLUMN_NAME);
	            	String cltype = commonCodeService.typeOfColumn(tableNmae , usArray[1]);
	            	if(cltype.equals("INT") || cltype.equals("BIGINT")){
	            		whereClm.append("\n AND ").append(usArray[1]).append("=").append(value);
	            	}else{
	            		whereClm.append("\n AND ").append(usArray[1]).append("=").append('"').append(value).append('"');
	            	}
	            	whereClause.append(whereClm);
	            }
            }
        }

		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		condition.setLanguage(language);
		// 날짜 데이터 포멧 맞추기위해 DB날짜 페턴을 입력.
		condition.setLocale(commonCodeService.DbdatePattern(language));
		
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
		if(condition.getSystem_name() != null){
			String[] SystemArray = condition.getSystem_name().split(",");
			condition.setSystemArray(SystemArray);	
		}
		 List<String> header = new ArrayList<String>();
		//테이블 컬럼조회-검색(view)필드
		String[] viewColumns = commonCodeService.getViewColList(tableNmae,"Y").split(",");
		condition.setViewColumns(viewColumns);
        for(String col : viewColumns){
        	if(!col.equals("")) header.add(col);
        }
		//테이블 일반 컬럼조회 view
		String[] sumColumns = commonCodeService.getViewColList(tableNmae,"N").split(",");
        condition.setSumColumns(sumColumns);
        for(String col : sumColumns){
        	header.add(col);
        }
        
        //whereClause
        condition.setWhereClause(whereClause.toString());
        //table space 조회 : PKG_ID 가 테이블스페이스 구분자
        condition.setDb_name(commonCodeService.getDbName(tableNmae));	
		//결과 요청
		Paging paging = perfomHistoryService.listAction(condition);
		model.addAttribute("resultList", paging);
		model.addAttribute("HEADCOL", header);
		
		model.addAttribute("language", language);
		model.addAttribute("patternTime", sessionUser.getPatternTime());
		// 리스트 날짜포멧
		model.addAttribute("dateformat", sessionUser.getPatternDate());
		model.addAttribute("typeId", condition.getTypeId());
		
		return thisUrl + "/listAction";
	}

	@RequestMapping(value = "exportAction")
	public String exportAction(Model model
            , HttpSession session
			 ,PerfomHistoryDomain condition
			 ,HttpServletRequest request) throws ParseException {
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);

		String tableNmae  =  URLDecoder.decode(condition.getTableName());
		condition.setTableName(tableNmae);
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
	            if(tableNmae.equals(usArray[0])){
	            	StringBuffer whereClm = new StringBuffer();
	            	StringBuffer tUnion = new StringBuffer();
	            	//검색항목 타입 조회. commonCodeService.typeOfColumn(TABLE_NAME,COLUMN_NAME);
	            	String cltype = commonCodeService.typeOfColumn(tableNmae , usArray[1]);
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
		condition.setLanguage(language);
		// 날짜 데이터 포멧 맞추기위해 DB날짜 페턴을 입력.
		condition.setLocale(commonCodeService.DbdatePattern(language));
		
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
		if(condition.getSystem_name() != null){
			String[] SystemArray = URLDecoder.decode(condition.getSystem_name()).split(",");
			condition.setSystemArray(SystemArray);	
		}
		
		//테이블 컬럼조회-검색(view)필드
		String[] viewColumns = commonCodeService.getViewColList(tableNmae,"Y").split(",");
		condition.setViewColumns(viewColumns);
		//테이블 컬럼조회-통계(SUM(view))vlfem
		String[] sumColumns = commonCodeService.getViewColList(tableNmae,"N").split(",");
        condition.setSumColumns(sumColumns);
        //whereClause
        condition.setWhereClause(whereClause.toString());
        //timeUnionClause
        condition.setTimeUnionClause(timeUnionClause.toString());
        //table space 조회 : PKG_ID 가 테이블스페이스 구분자
        condition.setDb_name(commonCodeService.getDbName(tableNmae));		
		
        //디코딩
        condition.setOrderBy(URLDecoder.decode(condition.getOrderBy()));
        String filename = URLDecoder.decode(tableNmae);
		List<LinkedHashMap<String, String>> list = perfomHistoryService.listExcel(condition);
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
