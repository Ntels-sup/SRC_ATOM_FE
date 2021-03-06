package com.ntels.avocado.controller.atom.security.loginHist;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.security.loginhist.Condition;
import com.ntels.avocado.domain.atom.security.loginhist.LoginHistDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.security.loginhist.LoginHistService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;
import com.ntels.ncf.utils.StringUtils;

@Controller
@RequestMapping(value="/atom/security/loginhist")
public class LoginHistController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private LoginHistService loginHistService;
	private String thisUrl = "atom/security/loginhist";
	
	@Autowired
	private CommonCodeService commonCodeService;

	//operation history insert를 위한 서비스
	@Autowired
	private CommonService commonService;
	
	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : LoginHistController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 7. 오후 7:56:09
	 * </PRE>
	 *   @return String
	 *   @param session
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(HttpSession session
			         , Model model) throws Exception{
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("1");
		
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// data format
		String dateformat = sessionUser.getPatternDate();
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		
		model.addAttribute("language", language);
		model.addAttribute("dateformat", dateformat);
		model.addAttribute("startDate", commonCodeService.getNowDate(language));
		model.addAttribute("endDate", commonCodeService.getNowDate(language));
		model.addAttribute("endHour", commonCodeService.getNowHour());
		model.addAttribute("endMin", StringUtils.lpad(commonCodeService.getNowMin(),2,'0'));
		model.addAttribute("listUserGroup", loginHistService.listUserGroup());
		model.addAttribute("listUserLevel", loginHistService.listUserLevel(sessionUser.getUserLevelId()));
		return thisUrl + "/list";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: listAction
	 * 2. ClassName : LoginHistController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 7. 오후 7:56:06
	 * </PRE>
	 *   @return String
	 *   @param condition
	 *   @param page
	 *   @param perPage
	 *   @param session
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="listAction", method=RequestMethod.POST)
	public String listAction(Condition condition
			               , @RequestParam(required=false, defaultValue="1") int page
			               , @RequestParam(required=false, defaultValue="10") int perPage
			               , HttpSession session
			               , Model model) throws Exception {
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		condition.setUserLevelId(sessionUser.getUserLevelId());
		// data format
		String dateformat = sessionUser.getPatternDate();
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		condition.setLanguage(language);
		
		//startDate Format 변환.
    	condition.setStartDate(DateUtil.dateFormatChangeToString(condition.getStartDate(),dateformat));
		condition.setStartHour(condition.getStartHour() == null ? "00" : condition.getStartHour());
		condition.setStartMin(condition.getStartMin() == null ? "00" : condition.getStartMin());
		condition.setStartTime(condition.getStartHour()+condition.getStartMin());
		//endDate Format 변환.
		condition.setEndDate(DateUtil.dateFormatChangeToString(condition.getEndDate(),dateformat));
		condition.setEndHour(condition.getEndHour() == null ? "00" : condition.getEndHour());
		condition.setEndMin(condition.getEndMin() == null ? "00" : condition.getEndMin());	
		condition.setEndTime(condition.getEndHour()+condition.getEndMin());
				
		//Keyword 검색 처리
		String searchType = condition.getSearchType();  // code , probable_cause, description
		String searchText = condition.getSearchText();  // 검색 text
		searchText = searchText.trim();
		if("userId".equals(searchType)) condition.setUserId(searchText);
        if("userName".equals(searchType)) condition.setUserName(searchText);
        
        //paging
		Paging paging = new Paging();
		List<LoginHistDomain> list = null;
		int count = 0;
		
		count = loginHistService.count(condition);
		if(count > 0){list = loginHistService.list(condition, page, perPage);}

		//paging을 위한 DTO를 생성
		paging.setLists(list); //결과를 DTO에 저장
		paging.setTotalCount(count); //결과 갯수를 DTO에 저장	
		paging.setPage(page); //현재 페이지를 저장
		paging.setPerPage(perPage); //페이징수
		
		model.addAttribute("loginHistList", paging);
		return thisUrl + "/listAction";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: exportAction
	 * 2. ClassName : LoginHistController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 7. 오후 7:56:29
	 * </PRE>
	 *   @return String
	 *   @param condition
	 *   @param session
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="exportAction", method=RequestMethod.POST)
    public String exportAction(Condition condition
							 , HttpSession session
				             , Model model) throws Exception {
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		condition.setUserLevelId(sessionUser.getUserLevelId());
		// data format
		String dateformat = sessionUser.getPatternDate();
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		condition.setLanguage(language);
		
		//startDate Format 변환.
    	condition.setStartDate(DateUtil.dateFormatChangeToString(condition.getStartDate(),dateformat));
		condition.setStartHour(condition.getStartHour() == null ? "00" : condition.getStartHour());
		condition.setStartMin(condition.getStartMin() == null ? "00" : condition.getStartMin());
		condition.setStartTime(condition.getStartHour()+condition.getStartMin());
		//endDate Format 변환.
		condition.setEndDate(DateUtil.dateFormatChangeToString(condition.getEndDate(),dateformat));
		condition.setEndHour(condition.getEndHour() == null ? "00" : condition.getEndHour());
		condition.setEndMin(condition.getEndMin() == null ? "00" : condition.getEndMin());	
		condition.setEndTime(condition.getEndHour()+condition.getEndMin());
				
		//Keyword 검색 처리
		String searchType = condition.getSearchType();  // code , probable_cause, description
		String searchText = condition.getSearchText();  // 검색 text
		searchText = searchText.trim();
		if("userId".equals(searchType)) condition.setUserId(searchText);
        if("userName".equals(searchType)) condition.setUserName(searchText);
        
        //디코딩
    	condition.setOrderBy(URLDecoder.decode(condition.getOrderBy()));
        String filename = URLDecoder.decode(condition.getTitleName());
        
		List<LinkedHashMap<String, String>> list = loginHistService.listExcel(condition);
		List<String> title = new ArrayList<String>() ;
		/** (title) header setting */
		for(String mapKey : list.get(0).keySet()){
			title.add(mapKey);
		}
		
		/**  dataType : 모든항목 String 일경우 dataType 생략해도 됨 */
		/*List<String> dataType = Arrays.asList("S", "S", "S", "S", "S");  
		model.addAttribute("dataType", dataType);	*/	                 
		/** dataType */
		
		/** 파일중복다운시 파일명+날짜(년월일시분초[언어별]) 표시 */
		model.addAttribute("list", list);
		model.addAttribute("title", title);
	 	model.addAttribute("NowdateTime", commonCodeService.getNowDateTime(language));
	 	model.addAttribute("filename", filename);
		return "excelViewer";
	}
}
