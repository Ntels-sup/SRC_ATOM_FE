package com.ntels.avocado.controller.atom.security.ipmanage;

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

import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.security.ipmanage.IpManageDomain;
import com.ntels.avocado.service.atom.security.ipmanage.IpManageService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;

@Controller
@RequestMapping(value="/atom/security/ipmanage")
public class IpManageController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private IpManageService ipManageService;
	private String thisUrl = "atom/security/ipmanage";

	@Autowired
	private CommonCodeService commonCodeService;
	
	//operation history insert를 위한 서비스
	@Autowired
	private CommonService commonService;
	
	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : IpManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 5. 오전 10:28:41
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(IpManageDomain ipManageDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("1");
		
		model.addAttribute("searchVal", ipManageDomain);
		model.addAttribute("listAllowYn", ipManageService.listAllowYn());
		return thisUrl + "/list";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: listAction
	 * 2. ClassName : IpManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 5. 오후 2:42:28
	 * </PRE>
	 *   @return String
	 *   @param ipManageDomain
	 *   @param page
	 *   @param perPage
	 *   @param request
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="listAction", method = RequestMethod.POST)
	public String listAction(IpManageDomain ipManageDomain
			               , @RequestParam(required=false, defaultValue="1") int page
			               , @RequestParam(required=false, defaultValue="10") int perPage
			               , HttpServletRequest request
			               , Model model) throws Exception {
		Paging paging = new Paging();
		List<IpManageDomain> list = null;
		int count = 0;
        
		count = ipManageService.count(ipManageDomain);
		if(count > 0){list = ipManageService.list(ipManageDomain, page, perPage);}

		//paging을 위한 DTO를 생성
		paging.setLists(list); //결과를 DTO에 저장
		paging.setTotalCount(count); //결과 갯수를 DTO에 저장	
		paging.setPage(page); //현재 페이지를 저장
		paging.setPerPage(perPage); //페이징수
		
		model.addAttribute("ipManageList", paging);
		return thisUrl + "/listAction";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: detail
	 * 2. ClassName : IpManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 5. 오후 2:42:32
	 * </PRE>
	 *   @return String
	 *   @param ipManageDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="detail")
	public String detail(IpManageDomain ipManageDomain, Model model) throws Exception{
		IpManageDomain ipManage = new IpManageDomain();
		ipManage = ipManageService.detail(ipManageDomain);
		
		model.addAttribute("searchVal", ipManageDomain);
		model.addAttribute("ipManage", ipManage);
		return thisUrl + "/detail";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: add
	 * 2. ClassName : IpManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 5. 오후 3:08:56
	 * </PRE>
	 *   @return String
	 *   @param ipManageDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="add")
	public String add(IpManageDomain ipManageDomain, Model model) throws Exception {		
		model.addAttribute("searchVal", ipManageDomain);
		return thisUrl + "/add";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: addAction
	 * 2. ClassName : IpManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 6. 오후 1:13:02
	 * </PRE>
	 *   @return void
	 *   @param ipManageDomain
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="addAction", method = RequestMethod.POST)
	public void addAction(IpManageDomain ipManageDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("3");
		
		ipManageService.addAction(ipManageDomain);
	}

	/**
	 * <PRE>
	 * 1. MethodName: modify
	 * 2. ClassName : IpManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 5. 오후 2:57:20
	 * </PRE>
	 *   @return String
	 *   @param ipManageDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="modify")
	public String modify(IpManageDomain ipManageDomain, Model model) throws Exception{
		IpManageDomain ipManage = new IpManageDomain();
		ipManage = ipManageService.detail(ipManageDomain);
		
		model.addAttribute("searchVal", ipManageDomain);
		model.addAttribute("ipManage", ipManage);
		return thisUrl + "/modify";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: modifyAction
	 * 2. ClassName : IpManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 6. 오후 1:13:10
	 * </PRE>
	 *   @return void
	 *   @param ipManageDomain
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="modifyAction", method = RequestMethod.POST)
	public void modifyAction(IpManageDomain ipManageDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("5");
		
		ipManageService.modifyAction(ipManageDomain);
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: removeAction
	 * 2. ClassName : IpManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 5. 오후 4:43:18
	 * </PRE>
	 *   @return void
	 *   @param ipManageDomain
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value = "removeAction", method = RequestMethod.POST)
	public void removeAction(IpManageDomain ipManageDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("4");
		
		ipManageService.removeAction(ipManageDomain);
	}	
	

	/**
	 * <PRE>
	 * 1. MethodName: duplChkIpBandWidth
	 * 2. ClassName : IpManageController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 21. 오후 9:19:14
	 * </PRE>
	 *   @return void
	 *   @param ipBandWidth
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="duplChkIpBandWidth", method = RequestMethod.POST)
	public void duplChkIpBandWidth(@RequestParam("ipBandWidth") String ipBandWidth
			                   , Model model) throws Exception{
		String checkIpResult = ipManageService.duplChkIpBandWidth(ipBandWidth);
		
		model.addAttribute("checkIpResult", checkIpResult);
	}
    /**
     * <PRE>
     * 1. MethodName: exportAction
     * 2. ClassName : IpManageController
     * 3. Comment   :
     * 4. 작성자    : hsy
     * 5. 작성일    : 2016. 4. 5. 오후 5:02:01
     * </PRE>
     *   @return String
     *   @param ipManagerDomain
     *   @param request
     *   @param model
     *   @return
     *   @throws Exception
     */
    @RequestMapping(value = "exportAction", method = RequestMethod.POST)
    public String exportAction(IpManageDomain ipManagerDomain, Model model) throws Exception {
        //디코딩
    	ipManagerDomain.setOrderBy(URLDecoder.decode(ipManagerDomain.getOrderBy()));
        String filename = URLDecoder.decode(ipManagerDomain.getTitleName());
        
		List<LinkedHashMap<String, String>> list = ipManageService.listExcel(ipManagerDomain);
		
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
