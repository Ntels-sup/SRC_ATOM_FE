package com.ntels.avocado.controller.atom.fault.nbiconfig;

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

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.atom.fault.nbiconfig.NbiConfigDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.fault.nbiconfig.SnmpTrapConfigService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;

@Controller
@RequestMapping(value = "/atom/fault/nbiconfig")
public class SnmpTrapConfigController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String language = DateUtil.getDateRepresentation();

	@Autowired
	private SnmpTrapConfigService snmpTrapConfigService;
	private String thisUrl = "atom/fault/nbiconfig";

	@Autowired
	private CommonCodeService commonCodeService;
	
	//operation history insert를 위한 서비스
	@Autowired
	private CommonService commonService;
	
	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : SnmpTrapConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 18. 오전 9:25:09
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "list")
	public String list(Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("1");
		
		List<NbiConfigDomain> trapIpList = null;
		
		NbiConfigDomain trapConfig = snmpTrapConfigService.trapConfig();
		if (trapConfig != null) {
			trapIpList = snmpTrapConfigService.trapIpList();
		}

		model.addAttribute("trapConfig", trapConfig);
		model.addAttribute("trapIpList", trapIpList);
		return thisUrl + "/list";
	}

	/**
	 * <PRE>
	 * 1. MethodName: update
	 * 2. ClassName : SnmpTrapConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 18. 오전 9:25:13
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "modify")
	public String update(Model model) throws Exception {	
		List<NbiConfigDomain> trapIpList = null;
		int trapIpCount = 0;

		NbiConfigDomain trapConfig = snmpTrapConfigService.trapConfig();
		if (trapConfig != null) {
			trapIpList = snmpTrapConfigService.trapIpList();
			trapIpCount = snmpTrapConfigService.trapIpCount();
		}

		model.addAttribute("trapConfig", trapConfig);
		model.addAttribute("trapIpCount", trapIpCount);
		model.addAttribute("trapIpList", trapIpList);

		return thisUrl + "/modify";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: saveAction
	 * 2. ClassName : SnmpTrapConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 26. 오후 2:35:35
	 * </PRE>
	 *   @return void
	 *   @param trapConfig
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value = "modifyAction", method = RequestMethod.POST)
	public void saveAction(NbiConfigDomain nbiConfigDomain, Model model) throws Exception {	
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("6");
		
		snmpTrapConfigService.modifyAction(nbiConfigDomain);
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: exportAction
	 * 2. ClassName : SnmpTrapConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 18. 오전 9:25:24
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "exportAction", method = RequestMethod.POST)
	public String exportAction(NbiConfigDomain nbiConfigDomain
			                 , HttpSession session
			                 , Model model) throws Exception {
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		
        //디코딩
        String filename = URLDecoder.decode(nbiConfigDomain.getTitleName());
        
        List<List<LinkedHashMap<String, String>>> lists = new ArrayList<List<LinkedHashMap<String, String>>>();
        List<List<String>> titles = new ArrayList<List<String>>();
        List<String> sheetNames = new ArrayList<String>();
        
        List<LinkedHashMap<String, String>> trapConfigList = snmpTrapConfigService.listExcelTrapConfig();
        sheetNames.add("Configuration");
        
		List<String> title1 = new ArrayList<String>() ;
		/** (title) header setting */
		for(String mapKey : trapConfigList.get(0).keySet()){
			title1.add(mapKey);
		}
		titles.add(title1);
        lists.add(trapConfigList);
        
        List<LinkedHashMap<String, String>> trapIpList = snmpTrapConfigService.listExcelTrapIp();
        sheetNames.add("Destination IP");
        
		List<String> title2 = new ArrayList<String>() ;
		/** (title) header setting */
		for(String mapKey : trapIpList.get(0).keySet()){
			title2.add(mapKey);
		}
		titles.add(title2);
        lists.add(trapIpList);
        
		/**  dataType : 모든항목 String 일경우 dataType 생략해도 됨 */
		/*List<String> dataType = Arrays.asList("S", "S", "S", "S", "S");  
		model.addAttribute("dataType", dataType);	*/	                 
		/** dataType */
		
		/** 파일중복다운시 파일명+날짜(년월일시분초[언어별]) 표시 */
		model.addAttribute("lists", lists);
		model.addAttribute("sheetNames", sheetNames);
		model.addAttribute("titles", titles);
	 	model.addAttribute("NowdateTime", commonCodeService.getNowDateTime(language));
	 	model.addAttribute("filename", filename);
        return "excelViewer";
	}
}
