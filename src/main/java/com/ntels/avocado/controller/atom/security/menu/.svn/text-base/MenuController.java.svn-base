package com.ntels.avocado.controller.atom.security.menu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.ntels.avocado.domain.atom.security.menu.Menu;
import com.ntels.avocado.service.atom.security.menu.MenuService;
import com.ntels.avocado.service.common.CommonCodeService;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.MessageUtil;




@Controller
@RequestMapping(value = "/atom/security/menu")
public class MenuController {
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private CommonService commonService;
	
	private String thisUrl = "atom/security/menu";
	
	
	
	
	@RequestMapping(value = "index")
	public String index(Model model
			            ,@RequestParam(value="pkg_name", required=false) String pkg_name
			            ,@RequestParam(value="menu_id", required=false) Integer menu_id
			            , HttpServletRequest request
			            , HttpSession session) {
		model.addAttribute("Package",commonCodeService.listPackageId());		
		if(pkg_name != null ){
			model.addAttribute("pkg_name",pkg_name);
		}
		if(menu_id != null ){
			model.addAttribute("menu_id",menu_id);
		}
	    //TAT_COMMON_CODE의 그룹코드(200003) 참고
		commonService.insertOperationHist("2"); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		
		return thisUrl + "/index" ;
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: getMenuTree
	 * 2. ClassName : MenuController
	 * 3. Comment   : 페키지 별 메뉴 트리 조회.
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 12. 오후 9:03:43
	 * </PRE>
	 *   @return Object
	 *   @return
	 */
	@RequestMapping(value = "getMenuTree", method = RequestMethod.POST)
	public @ResponseBody Object getMenuTree(@RequestParam String package_id) {
		Gson gson = new Gson();
		return gson.toJson(menuService.getMenuTree(package_id));
	}

	
	List<Menu> listMenu;
	@RequestMapping(value = "getMenuDynaTree", method = RequestMethod.POST)
	public @ResponseBody Object getMenuDynaTree(@RequestParam String package_id) {
		listMenu = menuService.list(package_id); // db data
		
		ArrayList<Object> root = new ArrayList<Object>(); // json data
		Map<String, Object> rootNode = new HashMap<String, Object>();
		Map<Integer, Boolean> removeNode = new HashMap<Integer, Boolean>();
		
		rootNode.put("title", "Menu");
		rootNode.put("isFolder", "true");
		rootNode.put("key", "0");
		rootNode.put("depth", "0");
		rootNode.put("children", makeMenu2Json(null, 0, removeNode));
		
		root.add(rootNode);
		
		return root;
	}

	private ArrayList<Object> makeMenu2Json(Map<String, Object> parent, int index, Map<Integer, Boolean> removeNode) {
		Menu menu = null;
		ArrayList<Object> folder = new ArrayList<Object>();
		Integer parent_menu_id = 0; 
		
		if(index > 0) {
			parent_menu_id = Integer.parseInt(parent.get("key").toString());
		}
		
		for(int i = index; i < listMenu.size(); i++) {
			menu = listMenu.get(i);
			
			if(index > 0 && !menu.getUp_menu_id().equals(parent_menu_id)) {
				continue;
			}
			
			if((Boolean) removeNode.get(menu.getMenu_id()) != null) {
				continue;
			}
			
			if("Y".equals(menu.getIs_folder())) {
				Map<String, Object> node = new HashMap<String, Object>();
				node.put("title", menu.getMenu_name());
				node.put("isFolder","true");   // menu.getIs_folder());
				node.put("key", menu.getMenu_id());
				node.put("depth", menu.getDepth());
				node.put("expand", "true");
				
				ArrayList<Object> tmpList = makeMenu2Json(node, index + 1, removeNode);
				if(tmpList.size() > 0) {
					node.put("children", tmpList);
				}
				folder.add(node);
				removeNode.put(menu.getMenu_id(), Boolean.TRUE);
			} else {
				Map<String, Object> leaf = new HashMap<String, Object>();
				leaf.put("title", menu.getMenu_name());
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
	 * 1. MethodName: insert
	 * 2. ClassName : MenuController
	 * 3. Comment   : 등록 화면 호출
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 15. 오후 5:31:01
	 * </PRE>
	 *   @return String
	 *   @param is_folder
	 *   @param menu_id
	 *   @param model
	 *   @return
	 */
	@RequestMapping(value = "insert")
	public String insert(@RequestParam String is_folder
			           , @RequestParam Integer menu_id
			           , @RequestParam String pkg_name
			           , HttpServletRequest request
			           , HttpSession session
			           , Model model) {
		if(menu_id == 0) {
			model.addAttribute("up_menu_id", "0");
			model.addAttribute("depth", "1");
		} else {
			Menu menu = menuService.getMenu(menu_id);
			model.addAttribute("up_menu_id", menu_id);
			model.addAttribute("depth", menu.getDepth() + 1);
		}
		model.addAttribute("pkg_name", pkg_name);
		model.addAttribute("is_folder", is_folder);
		return thisUrl + "/insert";
	}
	
	@RequestMapping(value = "insertAction", method = RequestMethod.POST)
	public void insertAction(@Valid Menu menu, BindingResult result
							, HttpServletRequest request
							, HttpSession session
							, Model model) {
		if(result.hasErrors()) {
			logger.debug("result.hasErrors()=>"+result.getFieldError());
			model.addAttribute("menu", menu);
		}
		if(menuService.insert(menu)){
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.save.result"));
			model.addAttribute("returnMsg", "SUCCESS");
	        
			int newMenuId = menuService.getNewMenuId(menu);
	        model.addAttribute("menu_id", newMenuId);
		}else { 
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
			model.addAttribute("returnMsg", "FAIL");
		}
		
		//TAT_COMMON_CODE의 그룹코드(200003) 참고
		commonService.insertOperationHist("3"); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
	}
	
	/**
	  * <PRE>
	 * 1. MethodName: getMenuAction
	 * 2. ClassName : MenuController
	 * 3. Comment   : 선택한 메뉴의 정보조회.
	 * 4. 작성자    : junwoo
	 * 5. 작성일    : 2016. 4. 18. 오후 3:19:56
	 * </PRE>
	 *   @return String
	 *   @param menu_id
	 *   @param model
	 *   @return
	 */
	@RequestMapping(value = "getMenuAction")
	public String getMenuAction(@RequestParam Integer menu_id
					            , HttpServletRequest request
					            , HttpSession session                  
								, Model model) {
		
		Menu menu = menuService.getMenu(menu_id);  
		model.addAttribute("menu", menu);
		return thisUrl + "/update";
	}

	@RequestMapping(value = "detailMenuAction")
	public String detailMenuAction(@RequestParam Integer menu_id
					            , HttpServletRequest request
					            , HttpSession session                  
								, Model model) {
		
		Menu menu = menuService.getMenu(menu_id);  
		model.addAttribute("menu", menu);
		return thisUrl + "/detail";
	}
	
	
	
	@RequestMapping(value = "updateAction", method = RequestMethod.POST)
	public void updateAction(@Valid Menu menu
							, BindingResult result
				            , HttpServletRequest request
				            , HttpSession session     
							, Model model) {
		if(result.hasErrors()) {
			logger.debug("result.hasErrors()=>"+result.getFieldError());
			model.addAttribute("menu", menu);
		}
		if(menuService.update(menu)){
			model.addAttribute("menu", menu);
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.save.result"));
			model.addAttribute("returnMsg", "SUCCESS");
		}else{ 
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
			model.addAttribute("returnMsg", "FAIL");
		}
		 //TAT_COMMON_CODE의 그룹코드(200003) 참고
		commonService.insertOperationHist("5"); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		
	}
	
	@RequestMapping(value = "deleteAction", method = RequestMethod.POST)
	public void deleteAction(@RequestParam Integer menu_id
				            , HttpServletRequest request
				            , HttpSession session                
							, Model model) {
		if(menuService.delete(menu_id)) {
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.delete.result"));
			model.addAttribute("returnMsg", "SUCCESS");
		} else {
			model.addAttribute("resultMsg", MessageUtil.getMessage("msg.common.error.result"));
			model.addAttribute("returnMsg", "FAIL");
		}
		 //TAT_COMMON_CODE의 그룹코드(200003) 참고
		commonService.insertOperationHist("4"); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		
	}

/*	@RequestMapping(value = "list")
	public String list(Model model
			            ,@RequestParam(value="pkg_name", required=false) String pkg_name
			            ,@RequestParam(value="menu_id", required=false) Integer menu_id
			            ,@RequestParam(value="actionKey", required=false) String actionKey
			            , HttpServletRequest request
			            , HttpSession session) {
		model.addAttribute("Package",commonCodeService.listPackageId());		
		if(pkg_name != null ){
			model.addAttribute("pkg_name",pkg_name);
		}
		if(menu_id != null ){
			model.addAttribute("menu_id",menu_id);
		}
		 //TAT_COMMON_CODE의 그룹코드(200003) 참고
		commonService.insertOperationHist("2"); // 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
		
		return thisUrl + "/list" ;
	}*/
	
	
}
