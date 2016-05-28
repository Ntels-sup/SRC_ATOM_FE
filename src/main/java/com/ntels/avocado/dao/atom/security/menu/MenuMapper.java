package com.ntels.avocado.dao.atom.security.menu;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.security.menu.Menu;

@Component
public interface MenuMapper {

	List<Map<String, Object>> listAllMenu();
	
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: listAuthorizationMenu
	 * 2. ClassName : MenuMapper
	 * 3. Comment   : 권한별 메뉴 조회
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 3. 17. 오후 3:19:11
	 * </PRE>
	 *   @return List<Map<String,Object>>
	 *   @param userId
	 *   @return
	 */
	List<Map<String, Object>> listAuthorizationMenu(@Param(value="userLevel")String userLevel);
	
	List<Map<String, Object>> listAuthorizatioPackage(@Param(value="userId")String userId);
	
	List<Map<String, Object>> listPackageMenu(@Param(value="pkgName")String pkgName, @Param(value="userLevel")String userLevel);
	
	
	List<Map<String, Object>> findMenu(@Param(value="package_id")String package_id);

	Menu getMenu(Integer menu_id);
	
	int getNewMenuId(Menu menu);
	
	int insert(Menu menu);
	
	int update(Menu menu);
	
	int delete(Integer menu_id);
	
	int deleteUserAuth(Integer menu_id);
	
	List<Menu> list(@Param(value="package_id")String package_id);
	
}
