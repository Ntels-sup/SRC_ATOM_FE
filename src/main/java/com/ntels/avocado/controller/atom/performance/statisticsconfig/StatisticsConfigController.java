package com.ntels.avocado.controller.atom.performance.statisticsconfig;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.atom.config.resourceconfig.ResourceConfigDomain;
import com.ntels.avocado.domain.atom.performance.statisticsconfig.StatisticsConfigDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.performance.statisticsconfig.StatisticsConfigService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;

@Controller
@RequestMapping(value = "/atom/performance/statisticsconfig")
public class StatisticsConfigController {
	private Logger logger = Logger.getLogger(this.getClass());
	
	private String thisUrl = "atom/performance/statisticsconfig";
	
	private String language = DateUtil.getDateRepresentation();

	@Autowired
	private StatisticsConfigService statisticsConfigService;

	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private CommonService commonService;
	
	@RequestMapping(value = "list")
	public String list(Model model, HttpServletRequest request , HttpSession session)  throws Exception {
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		//data format
		String dateformat = sessionUser.getPatternDate();
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		model.addAttribute("language", language);
		model.addAttribute("dateformat", dateformat);
		model.addAttribute("listPackage",commonCodeService.listPackageId());
		commonService.insertOperationHist("2");
	
		return thisUrl + "/list";
	}	
	
	@RequestMapping(value = "tableNameCombo")
	public @ResponseBody Object tableNameCombo(Model model 
						                  ,@RequestParam String pkgNm ){
		return commonCodeService.listTableName(pkgNm) ;
	}
	
	@RequestMapping(value = "listAction", method=RequestMethod.POST)
	public String  goSearchList(Model model ,StatisticsConfigDomain condition ){
		
		model.addAttribute("statisticsConfig", statisticsConfigService.listAction(condition));
		model.addAttribute("searchVal",condition);
		
		return thisUrl + "/listAction";
	}
	
	@RequestMapping(value="modifyAction", method=RequestMethod.POST)
	public void modifyAction(String jsonArr, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("5");
		model.addAttribute("result",statisticsConfigService.modifyAction(jsonArr));
	}
}

