package com.ntels.avocado.controller.atom.security.usergroup;

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
import com.ntels.avocado.domain.atom.security.usergroup.UserGroupDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.security.usergroup.UserGroupService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;

@Controller
@RequestMapping(value="/atom/security/usergroup")
public class UserGroupController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String language = DateUtil.getDateRepresentation();
	
	@Autowired
	private UserGroupService userGroupService;
	private String thisUrl = "atom/security/usergroup";
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	//operationHist 처리를 위한 autowired
	@Autowired 
	private CommonService commonService;
	
	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : UserGroupController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 20. 오후 3:45:07
	 * </PRE>
	 *   @return String
	 *   @param userGroupDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(UserGroupDomain userGroupDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("1");
		
		model.addAttribute("searchVal", userGroupDomain);
		model.addAttribute("listUserGroup", userGroupService.listUserGroup());
		return thisUrl + "/list";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: listAction
	 * 2. ClassName : UserGroupController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 20. 오후 3:45:03
	 * </PRE>
	 *   @return String
	 *   @param userGroupDomain
	 *   @param page
	 *   @param perPage
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="listAction", method=RequestMethod.POST)
	public String listAction(UserGroupDomain userGroupDomain
            			   , @RequestParam(required=false, defaultValue="1") int page
                           , @RequestParam(required=false, defaultValue="10") int perPage
                           , Model model) throws Exception {
		//paging
		Paging paging = new Paging();
		List<UserGroupDomain> list = null;
		int count = 0;
		
		count = userGroupService.count(userGroupDomain);
		if(count > 0){list = userGroupService.list(userGroupDomain, page, perPage);}

		//paging을 위한 DTO를 생성
		paging.setLists(list); //결과를 DTO에 저장
		paging.setTotalCount(count); //결과 갯수를 DTO에 저장	
		paging.setPage(page); //현재 페이지를 저장
		paging.setPerPage(perPage); //페이징수
		
		model.addAttribute("userGroupList", paging);
		return thisUrl + "/listAction";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: detail
	 * 2. ClassName : UserGroupController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 20. 오후 3:44:56
	 * </PRE>
	 *   @return String
	 *   @param userGroupDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="detail")
	public String detail(UserGroupDomain userGroupDomain, Model model) throws Exception {
		UserGroupDomain userGroup = new UserGroupDomain();
		userGroup = userGroupService.detailUserGroup(userGroupDomain);
		
		List<UserGroupDomain> userGroupPkg = new ArrayList<UserGroupDomain>();
		userGroupPkg = userGroupService.detailUserGroupPkg(userGroupDomain);
		
		int userGroupUseCnt = userGroupService.userGroupUseCnt(userGroupDomain);
		
		model.addAttribute("searchVal", userGroupDomain);
		model.addAttribute("userGroup", userGroup);
		model.addAttribute("userGroupPkgList", userGroupPkg);
		model.addAttribute("userGroupUseCnt", userGroupUseCnt);
		return thisUrl + "/detail";
	}

	/**
	 * <PRE>
	 * 1. MethodName: add
	 * 2. ClassName : UserGroupController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 21. 오후 7:19:18
	 * </PRE>
	 *   @return String
	 *   @param userGroupDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="add")
	public String add(UserGroupDomain userGroupDomain, Model model) throws Exception {
		model.addAttribute("searchVal", userGroupDomain);
		model.addAttribute("packageList", commonCodeService.listPackageId());
		model.addAttribute("packageCnt", commonCodeService.listPackageCnt());
		return thisUrl + "/add";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: addAction
	 * 2. ClassName : UserGroupController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 21. 오후 7:31:46
	 * </PRE>
	 *   @return void
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="addAction", method=RequestMethod.POST)
	public void addAction(UserGroupDomain userGroupDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("3");
		
		userGroupService.addAction(userGroupDomain);
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: modify
	 * 2. ClassName : UserGroupController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 20. 오후 4:49:55
	 * </PRE>
	 *   @return String
	 *   @param userGroupDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="modify")
	public String modify(UserGroupDomain userGroupDomain, Model model) throws Exception {
		UserGroupDomain userGroup = new UserGroupDomain();
		userGroup = userGroupService.detailUserGroup(userGroupDomain);
		
		List<UserGroupDomain> userGroupPkg = new ArrayList<UserGroupDomain>();
		userGroupPkg = userGroupService.detailUserGroupPkg(userGroupDomain);
		
		model.addAttribute("searchVal", userGroupDomain);
		model.addAttribute("packageList", commonCodeService.listPackageId());
		model.addAttribute("packageCnt", commonCodeService.listPackageCnt());
		model.addAttribute("userGroup", userGroup);
		model.addAttribute("userGroupPkgList", userGroupPkg);
		return thisUrl + "/modify";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: modifyAction
	 * 2. ClassName : UserGroupController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 21. 오후 6:22:28
	 * </PRE>
	 *   @return void
	 *   @param userGroupDomain
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="modifyAction", method=RequestMethod.POST)
	public void modifyAction(UserGroupDomain userGroupDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("5");
		
		userGroupService.modifyAction(userGroupDomain);
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: removeAction
	 * 2. ClassName : UserGroupController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 21. 오전 11:24:03
	 * </PRE>
	 *   @return void
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="removeAction", method=RequestMethod.POST)
	public void removeAction(UserGroupDomain userGroupDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("4");
		
		userGroupService.removeAction(userGroupDomain);
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: duplChkGrpName
	 * 2. ClassName : UserGroupController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 21. 오후 6:42:02
	 * </PRE>
	 *   @return void
	 *   @param userGroupDomain
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="duplChkGrpName", method=RequestMethod.POST)
	public void duplChkGrpName(@RequestParam("groupName") String groupName
                             , @RequestParam(value="groupNo", required=false) String groupNo
                             , Model model) throws Exception {
		int duplCnt = userGroupService.duplChkGrpName(groupName, groupNo);
		
		model.addAttribute("duplCnt", duplCnt);
	}
	
	
	/**
	 * <PRE>
	 * 1. MethodName: exportAction
	 * 2. ClassName : UserGroupController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 20. 오후 3:45:22
	 * </PRE>
	 *   @return String
	 *   @param userGroupDomain
	 *   @param session
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="exportAction", method=RequestMethod.POST)
	public String exportAction(UserGroupDomain userGroupDomain
			                 , HttpSession session
			                 , Model model) throws Exception {
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		userGroupDomain.setLanguage(language);
        //디코딩
		userGroupDomain.setOrderBy(URLDecoder.decode(userGroupDomain.getOrderBy()));
        String filename = URLDecoder.decode(userGroupDomain.getTitleName());
        
		List<LinkedHashMap<String, String>> list = userGroupService.listExcel(userGroupDomain);
		
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
