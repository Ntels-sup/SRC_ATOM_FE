package com.ntels.avocado.controller.atom.config.nodemanagement;

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
import com.ntels.avocado.domain.atom.config.nodemanagement.NodeManagementDomain;
import com.ntels.avocado.service.atom.config.nodemanagement.NodeManagementService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;

@Controller
@RequestMapping(value = "/atom/config/nodemanagement")
public class NodeManagementController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String language = DateUtil.getDateRepresentation();

	@Autowired
	private NodeManagementService nodeManagementService;
	private String thisUrl = "atom/config/nodemanagement";
	
	@Autowired
	private CommonCodeService commonCodeService;

	//operation history insert를 위한 서비스
	@Autowired
	private CommonService commonService;
	
	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : NodeManagementController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 17. 오후 7:34:28
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "list")
	public String list(NodeManagementDomain nodeManagementDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("1");
		
		model.addAttribute("searchVal", nodeManagementDomain);
		model.addAttribute("listPackage", commonCodeService.listPackageId());
		return thisUrl + "/list";
	}

	/**
	 * <PRE>
	 * 1. MethodName: listAction
	 * 2. ClassName : NodeManagementController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 17. 오후 7:34:21
	 * </PRE>
	 *   @return String
	 *   @param nodeManagementDomain
	 *   @param page
	 *   @param perPage
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "listAction", method = RequestMethod.POST)
	public String listAction(NodeManagementDomain nodeManagementDomain
						   , @RequestParam(required=false, defaultValue="1") int page
						   , @RequestParam(required=false, defaultValue="10") int perPage
						   , Model model) throws Exception {
		Paging paging = new Paging();
		List<NodeManagementDomain> list = null;
		int count = 0;

		//Keyword 검색 처리
		String searchType = nodeManagementDomain.getSearchType();  // code , probable_cause, description
		String searchText = nodeManagementDomain.getSearchText();  // 검색 text
		searchText = searchText.trim();
		
		if("node_name".equals(searchType)) nodeManagementDomain.setNode_name(searchText);
        if("ip".equals(searchType)) nodeManagementDomain.setIp(searchText);
        
		count = nodeManagementService.count(nodeManagementDomain);
		if(count > 0){list = nodeManagementService.list(nodeManagementDomain, page, perPage);}
		
		//paging을 위한 DTO를 생성
		paging.setLists(list); //결과를 DTO에 저장
		paging.setTotalCount(count); //결과 갯수를 DTO에 저장	
		paging.setPage(page); //현재 페이지를 저장
		paging.setPerPage(perPage); //페이징수	
		
		model.addAttribute("nodeManagementList", paging);
		return thisUrl + "/listAction";
	}

	/**
	 * <PRE>
	 * 1. MethodName: detail
	 * 2. ClassName : NodeManagementController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 17. 오후 7:34:14
	 * </PRE>
	 *   @return String
	 *   @param nodeManagementDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "detail")
	public String detail(NodeManagementDomain nodeManagementDomain, Model model) throws Exception {
		NodeManagementDomain nodeManagement = new NodeManagementDomain();
		nodeManagement = nodeManagementService.detail(nodeManagementDomain);
		
		model.addAttribute("searchVal", nodeManagementDomain);
		model.addAttribute("nodeManagement", nodeManagement);
		return thisUrl + "/detail";
	}

	/**
	 * <PRE>
	 * 1. MethodName: add
	 * 2. ClassName : NodeManagementController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 17. 오후 7:34:07
	 * </PRE>
	 *   @return String
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "add")
	public String add(NodeManagementDomain nodeManagementDomain, Model model) throws Exception {
		model.addAttribute("searchVal", nodeManagementDomain);
		model.addAttribute("listPackage", commonCodeService.listPackageId());
		model.addAttribute("listNodeGrp", nodeManagementService.listNodeGrp());
		model.addAttribute("listNodeType", nodeManagementService.listNodeType(nodeManagementDomain.getPkg_name()));
		return thisUrl + "/add";
	}

	/**
	 * <PRE>
	 * 1. MethodName: addAction
	 * 2. ClassName : NodeManagementController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 17. 오후 7:38:05
	 * </PRE>
	 *   @return void
	 *   @param nodeManagementDomain
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value = "addAction", method = RequestMethod.POST)
	public void addAction(NodeManagementDomain nodeManagementDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("3");
		
		nodeManagementService.addAction(nodeManagementDomain);
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: modify
	 * 2. ClassName : NodeManagementController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 17. 오후 7:34:01
	 * </PRE>
	 *   @return String
	 *   @param nodeManagementDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value = "modify")
	public String modify(NodeManagementDomain nodeManagementDomain, Model model) throws Exception {
		NodeManagementDomain nodeManagement = new NodeManagementDomain();
		nodeManagement = nodeManagementService.detail(nodeManagementDomain);
		
		model.addAttribute("searchVal", nodeManagementDomain);
		model.addAttribute("listPackage", commonCodeService.listPackageId());
		model.addAttribute("listNodeGrp", nodeManagementService.listNodeGrp());
		model.addAttribute("listNodeType", nodeManagementService.listNodeType(nodeManagementDomain.getPkg_name()));
		model.addAttribute("nodeManagement", nodeManagement);
		return thisUrl + "/modify";
	}

	/**
	 * <PRE>
	 * 1. MethodName: modifyAction
	 * 2. ClassName : NodeManagementController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 17. 오후 7:33:54
	 * </PRE>
	 *   @return void
	 *   @param nodeManagementDomain
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value = "modifyAction", method = RequestMethod.POST)
	public void modifyAction(NodeManagementDomain nodeManagementDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("5");
		
		nodeManagementService.modifyAction(nodeManagementDomain);
	}

	/**
	 * <PRE>
	 * 1. MethodName: removeAction
	 * 2. ClassName : NodeManagementController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 3. 17. 오후 7:33:50
	 * </PRE>
	 *   @return void
	 *   @param nodeManagementDomain
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value = "removeAction", method = RequestMethod.POST)
	public void removeAction(NodeManagementDomain nodeManagementDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("4");
		
		nodeManagementService.removeAction(nodeManagementDomain);
	}	

	/**
	 * <PRE>
	 * 1. MethodName: getListNodeType
	 * 2. ClassName : NodeManagementController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 25. 오전 10:43:51
	 * </PRE>
	 *   @return void
	 *   @param pkg_name
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value = "getListNodeType")
	public void getListNodeType(@RequestParam("pkg_name") String pkg_name, Model model) throws Exception {
		model.addAttribute("getListNodeType", nodeManagementService.listNodeType(pkg_name));
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: duplChkNodName
	 * 2. ClassName : NodeManagementController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 25. 오전 11:22:47
	 * </PRE>
	 *   @return void
	 *   @param node_name
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value = "duplChkNodeName")
	public void duplChkNodName(@RequestParam("nodeName") String nodeName
			                 , @RequestParam(value="nodeNo", required=false) String nodeNo
			                 , Model model) throws Exception {
		int duplCnt = nodeManagementService.duplChkNodeName(nodeName, nodeNo);
		
		model.addAttribute("duplCnt", duplCnt);
	}
	
    /**
     * <PRE>
     * 1. MethodName: exportAction
     * 2. ClassName : NodeManagementController
     * 3. Comment   :
     * 4. 작성자    : hsy
     * 5. 작성일    : 2016. 3. 30. 오후 2:32:00
     * </PRE>
     *   @return String
     *   @param nodeManagementDomain
     *   @param model
     *   @return
     *   @throws Exception
     */
    @RequestMapping(value = "exportAction", method = RequestMethod.POST)
    public String exportAction(NodeManagementDomain nodeManagementDomain, Model model) throws Exception {
		//Keyword 검색 처리
		String searchType = nodeManagementDomain.getSearchType();  // code , probable_cause, description
		String searchText = nodeManagementDomain.getSearchText();  // 검색 text
		searchText = searchText.trim();
		
		if("node_name".equals(searchType)) nodeManagementDomain.setNode_name(searchText);
        if("ip".equals(searchType)) nodeManagementDomain.setIp(searchText);
        
        //디코딩
        nodeManagementDomain.setOrderBy(URLDecoder.decode(nodeManagementDomain.getOrderBy()));
        String filename = URLDecoder.decode(nodeManagementDomain.getTitleName());
        
		List<LinkedHashMap<String, String>> list = nodeManagementService.listExcel(nodeManagementDomain);
		
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
