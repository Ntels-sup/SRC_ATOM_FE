package com.ntels.avocado.controller.atom.security.sessionmanage;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.security.sessionmanage.SessionManageDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.security.sessionmanage.SessionManageService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;

@Controller
@RequestMapping(value="/atom/security/sessionmanage")
public class SessionManageController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private SessionManageService sessionManageService;
	private String thisUrl = "atom/security/sessionmanage";

	@Autowired
	private CommonCodeService commonCodeService;
	
	//operation history insert를 위한 서비스
	@Autowired
	private CommonService commonService;
	
	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : SessionManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 4. 오후 1:40:40
	 * </PRE>
	 *   @return String
	 *   @param Model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("1");
		
		return thisUrl + "/list";
	}

	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : SessionManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 4. 오후 1:40:31
	 * </PRE>
	 *   @return String
	 *   @param sessionManageDomain
	 *   @param page
	 *   @param perPage
	 *   @param request
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="listAction", method = RequestMethod.POST)
	public String list(SessionManageDomain sessionManageDomain
		             , @RequestParam(required=false, defaultValue="1") int page
		             , @RequestParam(required=false, defaultValue="10") int perPage
		             , HttpServletRequest request
		             , Model model) throws Exception {
		// session
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.USER.SESSION_USER);
		// session user level
		sessionManageDomain.setUserLevelId(sessionUser.getUserLevelId());
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		sessionManageDomain.setLanguage(language);

		Paging paging = new Paging();
		List<SessionManageDomain> list = null;
		int count = 0;
		
		//Keyword 검색 처리
		String searchType = sessionManageDomain.getSearchType();  // code , probable_cause, description
		String searchText = sessionManageDomain.getSearchText();  // 검색 text
		searchText = searchText.trim();
		
		if("userId".equals(searchType)) sessionManageDomain.setUser_id(searchText);
        if("userName".equals(searchType)) sessionManageDomain.setUser_name(searchText);
        
		count = sessionManageService.count(sessionManageDomain);
		if(count > 0){list = sessionManageService.list(sessionManageDomain, page, perPage);}

		//paging을 위한 DTO를 생성
		paging.setLists(list); //결과를 DTO에 저장
		paging.setTotalCount(count); //결과 갯수를 DTO에 저장	
		paging.setPage(page); //현재 페이지를 저장
		paging.setPerPage(perPage); //페이징수
		
		model.addAttribute("sessionUserId", sessionUser.getUserId());
		model.addAttribute("remoteIp", request.getRemoteAddr());
		model.addAttribute("sessionManageList", paging);
		return thisUrl + "/listAction";
	}

	/**
	 * <PRE>
	 * 1. MethodName: updateSession
	 * 2. ClassName : SessionManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 4. 오후 1:40:53
	 * </PRE>
	 *   @return String
	 *   @param stop_user_id
	 *   @param stop_gateway_ip
	 *   @param stop_type
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "updateSessionStop", method = RequestMethod.POST)
	public void updateSession(@RequestParam("userId") String userId
							, @RequestParam("sessionId") String sessionId
							, @RequestParam("gatewayIp") String gatewayIp
							, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("5");
		
		sessionManageService.updateSessionStop(userId, sessionId, gatewayIp);
	}
	
    /**
     * <PRE>
     * 1. MethodName: exportAction
     * 2. ClassName : SessionManageController
     * 3. Comment   :
     * 4. 작성자    : hsy
     * 5. 작성일    : 2016. 4. 4. 오후 1:41:40
     * </PRE>
     *   @return String
     *   @param sessionManageDomain
     *   @param request
     *   @param model
     *   @return
     *   @throws Exception
     */
    @RequestMapping(value = "exportAction", method = RequestMethod.POST)
    public String exportAction(SessionManageDomain sessionManageDomain
    		                 , HttpServletRequest request
    		                 , Model model) throws Exception {
		// session
		SessionUser sessionUser = (SessionUser) request.getSession().getAttribute(Consts.USER.SESSION_USER);
		// session user level
		sessionManageDomain.setUserLevelId(sessionUser.getUserLevelId());
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		sessionManageDomain.setLanguage(language);
		
        //디코딩
    	sessionManageDomain.setOrderBy(URLDecoder.decode(sessionManageDomain.getOrderBy()));
        String filename = URLDecoder.decode(sessionManageDomain.getTitleName());
        
		List<LinkedHashMap<String, String>> list = sessionManageService.listExcel(sessionManageDomain);
		
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
