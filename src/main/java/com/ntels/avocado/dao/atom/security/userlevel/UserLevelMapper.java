package com.ntels.avocado.dao.atom.security.userlevel;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.security.menu.Menu;
import com.ntels.avocado.domain.atom.security.userlevel.AuthMenuDomain;
import com.ntels.avocado.domain.atom.security.userlevel.UserLevelDomain;

@Component
public interface UserLevelMapper {

	List<Map<String, String>> listUserLevel(@Param(value = "userLevelId") String userLevelId);
	
	List<Menu> getMenu(@Param(value="pkgName")String pkgName);
	
	List<Menu> getAuthMenu(@Param(value="pkgName")String pkgName
			             , @Param(value="levelId")String levelId);
	
	int count(@Param(value = "condition") UserLevelDomain userLevelDomain);
	
	List<UserLevelDomain> list(@Param("condition") UserLevelDomain userLevelDomain
	                         , @Param("start") int start
	                         , @Param("end") int end);
	
	UserLevelDomain detail(@Param(value="condition") UserLevelDomain userLevelDomain);
	
	int modifyAction(@Param(value="condition") UserLevelDomain userLevelDomain);
	
	int removeAuthMenu(@Param(value="condition") UserLevelDomain userLevelDomain);
	
	int addAuthMenu(@Param(value="condition") AuthMenuDomain authMenuDomain);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") UserLevelDomain userLevelDomain);
}
