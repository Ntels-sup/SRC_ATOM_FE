package com.ntels.avocado.dao.atom.security.usermanage;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.security.usermanage.UserManageDomain;

@Component
public interface UserManageMapper {

	List<Map<String, String>> listUserGroup();
	
	List<Map<String, String>> listUserLevel(@Param(value = "userLevelId") String userLevelId);
	
	String getPasswd(@Param(value="userId") String userId);
	
	int getPasswdLifeCycle(@Param(value="userLevelId") String userLevelId);
	
	int duplChkUserId(@Param(value="userId") String userId);
	
	int count(@Param(value = "condition") UserManageDomain userManageDomain);
	
	List<UserManageDomain> list(@Param("condition") UserManageDomain userManageDomain
	                          , @Param("start") int start
	                          , @Param("end") int end);

	UserManageDomain detail(@Param(value="condition") UserManageDomain userManageDomain);
	
	int addAction(@Param(value="condition") UserManageDomain userManageDomain);
	
	int modifyAction(@Param(value="condition") UserManageDomain userManageDomain);
	
	int removeAction(@Param(value="condition") UserManageDomain userManageDomain);
		
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") UserManageDomain userManageDomain);
}
