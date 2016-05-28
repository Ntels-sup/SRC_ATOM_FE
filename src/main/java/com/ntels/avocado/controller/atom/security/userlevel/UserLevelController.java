package com.ntels.avocado.controller.atom.security.userlevel;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.security.menu.Menu;
import com.ntels.avocado.domain.atom.security.userlevel.UserLevelDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.service.atom.security.userlevel.UserLevelService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.DateUtil;

@Controller
@RequestMapping(value="/atom/security/userlevel")
public class UserLevelController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String language = DateUtil.getDateRepresentation();
	
	//menuList
	private List<Menu> listMenu = null;
	//menuAuthList
	private List<Menu> listAuthMenu = null;
	
	@Autowired
	private UserLevelService userLevelService;
	private String thisUrl = "atom/security/userlevel";
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	//operationHist 처리를 위한 autowired
	@Autowired 
	private CommonService commonService;
	
	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 25. 오후 7:51:38
	 * </PRE>
	 *   @return String
	 *   @param userLevelDomain
	 *   @param session
	 *   @param model
	 *   @return
	 */
	@RequestMapping(value="list")
	public String list(UserLevelDomain userLevelDomain
			         , HttpSession session
			         , Model model){
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("1");
		
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		userLevelDomain.setUserLevelId(sessionUser.getUserLevelId());
		
		model.addAttribute("searchVal", userLevelDomain);
		model.addAttribute("listUserLevel", userLevelService.listUserLevel(userLevelDomain.getUserLevelId()));
		return thisUrl + "/list";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: listAction
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 25. 오후 8:08:48
	 * </PRE>
	 *   @return String
	 *   @param userLevelDomain
	 *   @param page
	 *   @param perPage
	 *   @param session
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="listAction", method=RequestMethod.POST)
	public String listAction(UserLevelDomain userLevelDomain
            			   , @RequestParam(required=false, defaultValue="1") int page
                           , @RequestParam(required=false, defaultValue="10") int perPage
                           , HttpSession session
                           , Model model) throws Exception {
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		userLevelDomain.setUserLevelId(sessionUser.getUserLevelId());
		
		//paging
		Paging paging = new Paging();
		List<UserLevelDomain> list = null;
		int count = 0;
		
		count = userLevelService.count(userLevelDomain);
		if(count > 0){list = userLevelService.list(userLevelDomain, page, perPage);}

		//paging을 위한 DTO를 생성
		paging.setLists(list); //결과를 DTO에 저장
		paging.setTotalCount(count); //결과 갯수를 DTO에 저장	
		paging.setPage(page); //현재 페이지를 저장
		paging.setPerPage(perPage); //페이징수
		
		model.addAttribute("userLevelList", paging);
		return thisUrl + "/listAction";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: detail
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 27. 오전 11:47:40
	 * </PRE>
	 *   @return String
	 *   @param userLevelDomain
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="detail")
	public String detail(UserLevelDomain userLevelDomain
			           , HttpSession session
			           , Model model) throws Exception {
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		userLevelDomain.setUserLevelId(sessionUser.getUserLevelId());
		
		UserLevelDomain userLevel = new UserLevelDomain();
		userLevel = userLevelService.detail(userLevelDomain);
				
		model.addAttribute("searchVal", userLevelDomain);
		model.addAttribute("userLevel", userLevel);
		model.addAttribute("listPackage", commonCodeService.listPackageId());
		return thisUrl + "/detail";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: modify
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 28. 오전 10:24:17
	 * </PRE>
	 *   @return String
	 *   @param userLevelDomain
	 *   @param session
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="modify")
	public String modify(UserLevelDomain userLevelDomain
			           , HttpSession session
			           , Model model) throws Exception {
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		userLevelDomain.setUserLevelId(sessionUser.getUserLevelId());
		
		UserLevelDomain userLevel = new UserLevelDomain();
		userLevel = userLevelService.detail(userLevelDomain);
				
		model.addAttribute("searchVal", userLevelDomain);
		model.addAttribute("userLevel", userLevel);
		model.addAttribute("listPackage", commonCodeService.listPackageId());
		return thisUrl + "/modify";
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: modifyAction
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 5. 2. 오후 1:01:05
	 * </PRE>
	 *   @return void
	 *   @param userLevelDomain
	 *   @param userAuthDomain
	 *   @param model
	 *   @throws Exception
	 */
	@RequestMapping(value="modifyAction", method=RequestMethod.POST)
	public void modifyAction(UserLevelDomain userLevelDomain, Model model) throws Exception {
		// 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		commonService.insertOperationHist("6");
		
		userLevelService.modifyAction(userLevelDomain);
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: getTree
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 28. 오후 5:42:12
	 * </PRE>
	 *   @return Object
	 *   @param pkgName
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="getMenuTree", method=RequestMethod.POST)
	public @ResponseBody Object getTree(@RequestParam(value="pkgName") String pkgName
			                          , Model model) throws Exception {
		listMenu = userLevelService.getMenu(pkgName); // db data
		
		ArrayList<Object> root = new ArrayList<Object>(); // json data
		Map<String, Object> rootNode = new HashMap<String, Object>();
		Map<Integer, Boolean> removeNode = new HashMap<Integer, Boolean>();
		
		rootNode.put("title", pkgName);
		rootNode.put("isFolder", "true");
		rootNode.put("key", "0");
		rootNode.put("depth", "0");
		rootNode.put("children", makeMenuJson(null, 0, removeNode, "M"));
		root.add(rootNode);
		
		return root;
	}

	/**
	 * <PRE>
	 * 1. MethodName: getAuthMenuTree
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 28. 오후 6:09:34
	 * </PRE>
	 *   @return Object
	 *   @param pkgName
	 *   @param levelId
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="getAuthMenuTree", method=RequestMethod.POST)
	public @ResponseBody Object getAuthMenuTree(@RequestParam(value="pkgName") String pkgName
			                                  , @RequestParam(value="levelId") String levelId
			                                  , Model model) throws Exception {
		listAuthMenu = userLevelService.getAuthMenu(pkgName,levelId); // db data
		
		ArrayList<Object> root = new ArrayList<Object>(); // json data
		Map<String, Object> rootNode = new HashMap<String, Object>();
		Map<Integer, Boolean> removeNode = new HashMap<Integer, Boolean>();
		
		rootNode.put("title", pkgName);
		rootNode.put("isFolder", "true");
		rootNode.put("key", "0");
		rootNode.put("depth", "0");
		rootNode.put("children", makeMenuJson(null, 0, removeNode, "AM"));
		root.add(rootNode);
		
		return root;
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: makeMenuJson
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 28. 오후 2:36:21
	 * </PRE>
	 *   @return ArrayList<Object>
	 *   @param parent
	 *   @param index
	 *   @param removeNode
	 *   @return
	 */
	private ArrayList<Object> makeMenuJson(Map<String, Object> parent, int index, Map<Integer, Boolean> removeNode, String makeType) {
		Menu menu = null;
		ArrayList<Object> folder = new ArrayList<Object>();
		Integer parent_menu_id = 0; 
		List<Menu> menuType = null;
		
		if(makeType == "AM"){
			menuType = listAuthMenu; 
		} else {
			menuType = listMenu;
		}
		
		if(index > 0) {
			parent_menu_id = Integer.parseInt(parent.get("key").toString());
		}
		
		for(int i = index; i < menuType.size(); i++) {
			menu = menuType.get(i);
			
			if(index > 0 && !menu.getUp_menu_id().equals(parent_menu_id)) {
				continue;
			}
			
			if((Boolean) removeNode.get(menu.getMenu_id()) != null) {
				continue;
			}
			
			if("Y".equals(menu.getIs_folder())) {
				Map<String, Object> node = new HashMap<String, Object>();
				if(makeType == "AM"){
					node.put("title", menu.getMenu_name()+"<em>:"+ menu.getAuth_type() +"</em>");
				} else {
					node.put("title", menu.getMenu_name());
				}
				node.put("isFolder","true");   // menu.getIs_folder());
				node.put("key", menu.getMenu_id());
				node.put("depth", menu.getDepth());
				node.put("expand", "true");
				
				ArrayList<Object> tmpList = makeMenuJson(node, index + 1, removeNode, makeType);
				if(tmpList.size() > 0) {
					node.put("children", tmpList);
				}
				folder.add(node);
				removeNode.put(menu.getMenu_id(), Boolean.TRUE);
			} else {
				Map<String, Object> leaf = new HashMap<String, Object>();
				if(makeType == "AM"){
					leaf.put("title", menu.getMenu_name()+"<em>:"+ menu.getAuth_type() +"</em>");
				} else {
					leaf.put("title", menu.getMenu_name());
				}
				leaf.put("key", menu.getMenu_id());
				leaf.put("depth", menu.getDepth());
				folder.add(leaf);
				removeNode.put(menu.getMenu_id(), Boolean.TRUE);
			}
		}
		
		return folder;
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: exportAction
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    : hsy
	 * 5. 작성일    : 2016. 4. 27. 오전 11:38:03
	 * </PRE>
	 *   @return String
	 *   @param userLevelDomain
	 *   @param session
	 *   @param model
	 *   @return
	 *   @throws Exception
	 */
	@RequestMapping(value="exportAction", method=RequestMethod.POST)
	public String exportAction(UserLevelDomain userLevelDomain
			                 , HttpSession session
			                 , Model model) throws Exception {
		// session
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		// session user level
		userLevelDomain.setUserLevelId(sessionUser.getUserLevelId());
		// language
		if( !"".equals(sessionUser.getLanguage()) && sessionUser.getLanguage() != null ){
			language = sessionUser.getLanguage();
		}
		userLevelDomain.setLanguage(language);
		
        //디코딩
		userLevelDomain.setOrderBy(URLDecoder.decode(userLevelDomain.getOrderBy()));
        String filename = URLDecoder.decode(userLevelDomain.getTitleName());
        
		List<LinkedHashMap<String, String>> list = userLevelService.listExcel(userLevelDomain);
		
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
