package com.ntels.avocado.controller.atom.config.resourceconfig;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ntels.avocado.domain.atom.config.resourceconfig.ResourceConfigDomain;
import com.ntels.avocado.service.atom.config.resourceconfig.ResourceConfigService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;

@Controller
@RequestMapping(value = "/atom/config/resourceconfig")
public class ResourceConfigController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private ResourceConfigService resourceConfigService;
	private String thisUrl = "atom/config/resourceconfig";

	@Autowired
	private CommonCodeService commonCodeService;
	
	//operation history insert를 위한 서비스
	@Autowired
	private CommonService commonService;
	
	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : ResourceConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 5. 3. 오후 4:47:09
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("1");
		
		model.addAttribute("listResourceGrp", resourceConfigService.listResourceGrp());
		model.addAttribute("listPackage", commonCodeService.listPackageId());
		model.addAttribute("listStatPeriod", resourceConfigService.listStatPeriod());
		return thisUrl + "/list";
	}

	/**
	 * <PRE>
	 * 1. MethodName: goSearchRscGrp
	 * 2. ClassName : ResourceConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 5. 4. 오후 1:05:47
	 * </PRE>
	 *   @return void
	 *   @param resourceConfigDomain
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="goSearchRscGrp", method=RequestMethod.POST)
	public void goSearchRscGrp(ResourceConfigDomain resourceConfigDomain, Model model) throws Exception {
		model.addAttribute("rscGrpConfig", resourceConfigService.rscGrpConfig(resourceConfigDomain));
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: goSearchRscList
	 * 2. ClassName : ResourceConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 5. 4. 오후 4:08:36
	 * </PRE>
	 *   @return String
	 *   @param resourceConfigDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="goSearchRscList", method=RequestMethod.POST)
	public String goSearchRscList(ResourceConfigDomain resourceConfigDomain, Model model) throws Exception {
		List<ResourceConfigDomain> rscConfigList = null;
		rscConfigList = resourceConfigService.rscConifg(resourceConfigDomain);
		
		model.addAttribute("searchVal", resourceConfigDomain);
		model.addAttribute("rscConfigList", rscConfigList);
		return thisUrl + "/listAction";
	}
		
	/**
	 * <PRE>
	 * 1. MethodName: getListNodeType
	 * 2. ClassName : ResourceConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 5. 4. 오후 1:05:50
	 * </PRE>
	 *   @return void
	 *   @param pkgName
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value = "getListNodeType")
	public void getListNodeType(@RequestParam("pkgName") String pkgName, Model model) throws Exception {
		model.addAttribute("listNodeType", resourceConfigService.listNodeType(pkgName));
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: modifyAction
	 * 2. ClassName : ResourceConfigController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 5. 3. 오후 4:47:03
	 * </PRE>
	 *   @return void
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="modifyAction", method=RequestMethod.POST)
	public void modifyAction(ResourceConfigDomain resourceConfigDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("6");
		
		 resourceConfigService.modifyAction(resourceConfigDomain);
	}
}
