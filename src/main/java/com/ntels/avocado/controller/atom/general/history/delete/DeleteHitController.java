package com.ntels.avocado.controller.atom.general.history.delete;


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
import com.ntels.avocado.domain.atom.general.history.delete.DeleteHitDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.general.history.delete.DeleteHitService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;
import com.ntels.ncf.utils.StringUtils;


@Controller
@RequestMapping(value = "/atom/general/history/delete")
public class DeleteHitController{

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private DeleteHitService deleteHitService;

	private String thisUrl = "atom/general/history/delete";
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private CommonService commonService;

	@RequestMapping(value = "list")
	public String list( Model model, HttpSession  session) throws Exception {
		commonService.insertOperationHist("2");
		//session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		//data format
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
		model.addAttribute("System" ,commonCodeService.listSystemId());
		model.addAttribute("Package",commonCodeService.listPackageId());
		model.addAttribute("Group" ,commonCodeService.listPart());
		
		return thisUrl + "/list";
	}	
	
 
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(DeleteHitDomain condition, Model model, HttpSession session) throws Exception {
		
		//session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		//dateformat
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
		
		
		Paging paging = deleteHitService.listAction(condition);
		
		model.addAttribute("deleteHitList", paging);
		model.addAttribute("dateformat", dateformat);

		return thisUrl + "/listAction";
	}
	 
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(Model model
								, HttpSession session
								, DeleteHitDomain condition) throws ParseException  {
		
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
		if(condition.getNode_id() != null){
			String[] SystemArray = condition.getNode_id().split(",");
			condition.setNodeArray(SystemArray);	
		}
		//그룹 멀티 -> Array
		if(condition.getGroup_code() != null){
			String[] GroupArray = condition.getGroup_code().split(",");
			condition.setGroupArray(GroupArray);	
		}
        //디코딩
		condition.setOrderBy(URLDecoder.decode(condition.getOrderBy()));
        String filename = URLDecoder.decode(condition.getTitleName());
		List<LinkedHashMap<String, String>> list = deleteHitService.listExcel(condition);
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