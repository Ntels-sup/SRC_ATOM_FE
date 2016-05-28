package com.ntels.avocado.controller.atom.fault.alarmconfig;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.fault.alarmconfig.AlarmConfigDomain;
import com.ntels.avocado.service.atom.fault.alarmconfig.AlarmConfigService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;

@Controller
@RequestMapping(value = "/atom/fault/alarmconfig")
public class AlarmConfigController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private AlarmConfigService alarmConfigService;
	private String thisUrl = "atom/fault/alarmconfig";
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	//operation history insert를 위한 서비스
	@Autowired
	private CommonService commonService;
	
	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : AlarmConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 16. 오후 8:52:05
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "list")
	public String list(AlarmConfigDomain alarmConfigDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("1");
		
		model.addAttribute("searchVal", alarmConfigDomain);
		model.addAttribute("listAlarmType", commonCodeService.listAlarmType());
		model.addAttribute("listAlarmGroup", commonCodeService.listAlarmGroup());
		model.addAttribute("listPackage", commonCodeService.listPackageId());
		return thisUrl + "/list"; 
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: listAction
	 * 2. ClassName : AlarmConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 16. 오후 8:51:57
	 * </PRE>
	 *   @return String
	 *   @param alarmConfigDomain
	 *   @param page
	 *   @param perPage
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(AlarmConfigDomain alarmConfigDomain
			               , @RequestParam(required=false, defaultValue="1") int page
			               , @RequestParam(required=false, defaultValue="10") int perPage
			               , Model model) throws Exception {
		Paging paging = new Paging();
		List<AlarmConfigDomain> list = null;
		int count = 0;
		
		//pkgNameArr 처리
		alarmConfigDomain.setPkgNameArr(alarmConfigDomain.getPkgName().split(","));
		//Keyword 검색 처리
		String searchType = alarmConfigDomain.getSearchType();  // code , probable_cause, description
		String searchText = alarmConfigDomain.getSearchText();  // 검색 text
		searchText = searchText.trim();
		
		if("code".equals(searchType)) alarmConfigDomain.setCode(searchText);
        if("probable_cause".equals(searchType)) alarmConfigDomain.setProbable_cause(searchText);
        if("description".equals(searchType)) alarmConfigDomain.setDescription(searchText);
        
		count = alarmConfigService.count(alarmConfigDomain);
		if(count > 0){list = alarmConfigService.list(alarmConfigDomain, page, perPage);}

		//paging을 위한 DTO를 생성
		paging.setLists(list); //결과를 DTO에 저장
		paging.setTotalCount(count); //결과 갯수를 DTO에 저장	
		paging.setPage(page); //현재 페이지를 저장
		paging.setPerPage(perPage); //페이징수	
		
		model.addAttribute("alarmConfigList", paging);
		return thisUrl + "/listAction";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: detail
	 * 2. ClassName : AlarmConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 16. 오후 8:51:46
	 * </PRE>
	 *   @return String
	 *   @param alarmConfigDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "detail")
	public String detail(AlarmConfigDomain alarmConfigDomain, Model model) throws Exception {
		AlarmConfigDomain alarmConfig = new AlarmConfigDomain();
		alarmConfig = alarmConfigService.detail(alarmConfigDomain);
		
		model.addAttribute("searchVal", alarmConfigDomain);
		model.addAttribute("alarmConfig", alarmConfig);
		return thisUrl + "/detail";
	}
		
	/**
	 * <PRE>
	 * 1. MethodName: modify
	 * 2. ClassName : AlarmConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 16. 오후 8:51:37
	 * </PRE>
	 *   @return String
	 *   @param alarmConfigDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "modify")
	public String modify(AlarmConfigDomain alarmConfigDomain, Model model) throws Exception {
		AlarmConfigDomain alarmConfig = new AlarmConfigDomain();
		alarmConfig = alarmConfigService.detail(alarmConfigDomain);
		
		model.addAttribute("listAlarmGroup", commonCodeService.listAlarmGroup());
		model.addAttribute("listAlaramServrity", commonCodeService.listAlarmSeverity());
		model.addAttribute("listYn", commonCodeService.listAlphaYn());
		model.addAttribute("searchVal", alarmConfigDomain);
		model.addAttribute("alarmConfig", alarmConfig);
		return thisUrl + "/modify";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: modifyAction
	 * 2. ClassName : AlarmConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 16. 오후 8:51:29
	 * </PRE>
	 *   @return void
	 *   @param alarmConfigDomain
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value = "modifyAction", method = RequestMethod.POST)
	public void modifyAction(AlarmConfigDomain alarmConfigDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("5");
		
		alarmConfigService.modifyAction(alarmConfigDomain);
	}
	
    /**
     * <PRE>
     * 1. MethodName: exportAction
     * 2. ClassName : AlarmConfigController
     * 3. Comment   :
     * 4. 작성자    : hsy
     * 5. 작성일    : 2016. 3. 30. 오후 2:37:31
     * </PRE>
     *   @return String
     *   @param nodeManagementDomain
     *   @param model
     *   @return
     *   @throws Exception
     */
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
    public String exportAction(AlarmConfigDomain alarmConfigDomain, Model model) throws Exception {
		//pkgNameArr 처리
		alarmConfigDomain.setPkgNameArr(alarmConfigDomain.getPkgName().split(","));
		//Keyword 검색 처리
		String searchType = alarmConfigDomain.getSearchType();  // code , probable_cause, description
		String searchText = alarmConfigDomain.getSearchText();  // 검색 text
		searchText = searchText.trim();
		
		if("code".equals(searchType)) alarmConfigDomain.setCode(searchText);
        if("probable_cause".equals(searchType)) alarmConfigDomain.setProbable_cause(searchText);
        if("description".equals(searchType)) alarmConfigDomain.setDescription(searchText);
        
        //디코딩
        alarmConfigDomain.setOrderBy(URLDecoder.decode(alarmConfigDomain.getOrderBy()));
        String filename = URLDecoder.decode(alarmConfigDomain.getTitleName());
        
		List<LinkedHashMap<String, String>> list = alarmConfigService.listExcel(alarmConfigDomain);
		
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
