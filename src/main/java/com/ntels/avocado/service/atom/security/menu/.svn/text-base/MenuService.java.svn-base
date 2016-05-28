package com.ntels.avocado.service.atom.security.menu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.dao.atom.security.menu.MenuMapper;
import com.ntels.avocado.domain.atom.security.menu.Menu;

@Service
public class MenuService {
	@Autowired
	private MenuMapper menuMapper;
	
	public List<Map<String, Object>> listAuthorizationMenu(String userLevel) {
		return menuMapper.listAuthorizationMenu(userLevel);
	}
	
	public List<Map<String, Object>> listPackageMenu(String userId, String userLevel) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> list = menuMapper.listAuthorizatioPackage(userId);
		if (list.size() > 0) {
			Map<String, Object> map = null;
			Map<String, Object> pkgMap = null;
			String pkgName = "";
			List<Map<String, Object>> pkglist;
			for (int i=0; i < list.size(); i++) {
				map = list.get(i);				
				//result.add(map);
				pkgName = (String)map.get("PKG_NAME");
				pkglist = menuMapper.listPackageMenu(pkgName, userLevel);
				
				for (int j=0; j < pkglist.size(); j++) {
					pkgMap = pkglist.get(j);
					result.add(pkgMap);
				}				
			}
		}
		//System.err.println(result);
		return result;
	}

	public List<Map<String, Object>> getMenuTree(String package_id) {
		
		List<Map<String, Object>> listTree = new ArrayList<Map<String, Object>>();
        listTree = menuMapper.findMenu(package_id);
       
        for (int i = 0; i < listTree.size(); i++) {
        	Map<String, Object> state = new HashMap<String, Object>();
        	if("#".equals(listTree.get(i).get("parent"))){
            	state.put("opened", true);
            	state.put("selected  ", true);
            	state.put("disabled  ", false);
        	}else{
        		state.put("opened", false);
        		state.put("selected  ", false);
        		state.put("disabled  ", true);
        	}
        	state.put("is_folder", listTree.get(i).get("is_folder"));
        	state.put("DEPTH", listTree.get(i).get("DEPTH"));
        	state.put("PKG_NAME", listTree.get(i).get("PKG_NAME"));
        	state.put("DB_NAME", listTree.get(i).get("DB_NAME"));
        	listTree.get(i).put("state", state);
		}
   
		return listTree;
	}
	
	public List<Map<String, Object>> getMenuDynaTree(String package_id) {
		
		List<Map<String, Object>> listTree = new ArrayList<Map<String, Object>>();
        listTree = menuMapper.findMenu(package_id);
       
        for (int i = 0; i < listTree.size(); i++) {
        	Map<String, Object> state = new HashMap<String, Object>();
        	if("#".equals(listTree.get(i).get("parent"))){
            	state.put("opened", true);
            	state.put("selected  ", true);
            	state.put("disabled  ", false);
        	}else{
        		state.put("opened", false);
        		state.put("selected  ", false);
        		state.put("disabled  ", true);
        	}
        	state.put("is_folder", listTree.get(i).get("is_folder"));
        	state.put("DEPTH", listTree.get(i).get("DEPTH"));
        	state.put("PKG_NAME", listTree.get(i).get("PKG_NAME"));
        	state.put("DB_NAME", listTree.get(i).get("DB_NAME"));
        	listTree.get(i).put("state", state);
		}
   
		return listTree;
	}
	
	
	
	public Menu getMenu(Integer menu_id) {
		return menuMapper.getMenu(menu_id);
	}

	
	public int getNewMenuId(Menu menu) {
		return menuMapper.getNewMenuId(menu);
	}
	
	@Transactional
	public boolean insert(Menu menu) {
		return (menuMapper.insert(menu) > 0);
	}
	
	@Transactional
	public boolean update(Menu menu) {
		return (menuMapper.update(menu) > 0);
	}

	
	@Transactional
	public boolean delete(Integer menu_id) {
		menuMapper.deleteUserAuth(menu_id); // 메뉴삭제 전 권한부터 삭제.
		return (menuMapper.delete(menu_id) > 0);
	}
	
	public List<Menu> list(String package_id) {
		return menuMapper.list(package_id);
	}
	
	
	
}
