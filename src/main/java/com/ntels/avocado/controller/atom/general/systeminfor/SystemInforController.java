package com.ntels.avocado.controller.atom.general.systeminfor;

import java.net.URLDecoder;
import java.text.ParseException;
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

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.general.systeminfor.SystemInforDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.general.systeminfor.SystemInforService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.ncf.utils.DateUtil;
import com.ntels.avocado.service.common.CommonService;


@Controller
@RequestMapping(value = "/atom/general/systeminfor")
public class SystemInforController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private SystemInforService systemInforService;
	private String thisUrl = "atom/general/systeminfor";
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	//operationHist 처리를 위한 autowired
	@Autowired 
	private CommonService commonService;
	
	
	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : SystemInforController
	 * 3. Comment   :
	 * 4. 작성자    : jikime
	 * 5. 작성일    : 2016. 4. 12. 오후 2:40:46
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @param session
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(Model model, HttpSession session) throws Exception {
		
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("1");
		
		SessionUser SessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		
		/*멀티 셀렉트 박스*/ 
		model.addAttribute("System" ,commonCodeService.listSystemId());
		model.addAttribute("Package",commonCodeService.listPackageId());
		
		//Date Format
		String dateformat = SessionUser.getPatternDate();
		
		//Language
		if( !"".equals(SessionUser.getLanguage()) && SessionUser.getLanguage() != null ){
			language = SessionUser.getLanguage();
		}
		model.addAttribute("language", language);
		model.addAttribute("dateformat", dateformat);
		
		return thisUrl + "/list";		
	}
	
	
	/**
	 * <PRE>
	 * 1. MethodName: listAction
	 * 2. ClassName : SystemInforController
	 * 3. Comment   :
	 * 4. 작성자    : jikime
	 * 5. 작성일    : 2016. 4. 12. 오후 2:53:43
	 * </PRE>
	 *   @return String
	 *   @param systemInforDomain
	 *   @param page
	 *   @param perPage
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(SystemInforDomain condition
			               , HttpSession session
			               , Model model) throws Exception {
	
		// session
		SessionUser SessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		
		// session user level
		condition.setUserLevelId(SessionUser.getUserLevelId());
		
		//Date Format
		String dateformat = SessionUser.getPatternDate();
		
		// Language
		if( !"".equals(SessionUser.getLanguage()) && SessionUser.getLanguage() != null ){
			language = SessionUser.getLanguage();
		}
		condition.setLanguage(language);
		Paging paging = systemInforService.list(condition);
		model.addAttribute("systemInforList", paging);
		model.addAttribute("dateformat", dateformat);
		
		return thisUrl + "/listAction";
	}
	
	
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(Model model
								, HttpSession session
								, SystemInforDomain condition) throws ParseException  {
		
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		condition.setLanguage(language);
        //디코딩
		condition.setOrderBy(URLDecoder.decode(condition.getOrderBy()));
        String filename = URLDecoder.decode(condition.getTitleName());
		List<LinkedHashMap<String, String>> list = systemInforService.listExcel(condition);
		
		model.addAttribute("list", list);
		
		List<String> title = new ArrayList<String>();
		//** (title) header setting *//*
		
		if(list.size()>0){
			for(String mapKey : list.get(0).keySet()){
				title.add(mapKey);
			}
		} 
		model.addAttribute("title", title);
		
		//**  dataType : 모든항목 String 일경우 dataType 생략해도 됨 *//*
//		List<String> dataType = Arrays.asList("S", "S", "S", "S", "N");  
//		model.addAttribute("dataType", dataType);		                 
		//** dataType *//*
		
		//** 파일중복다운시 파일명+날짜(년월일시분초[언어별]) 표시 *//*
	 	model.addAttribute("NowdateTime", commonCodeService.getNowDateTime(language));
	 	model.addAttribute("filename", filename);
		
		return "excelViewer";
	}
	
}



