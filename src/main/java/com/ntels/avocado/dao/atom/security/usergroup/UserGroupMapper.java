package com.ntels.avocado.dao.atom.security.usergroup;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.security.usergroup.UserGroupDomain;

@Component
public interface UserGroupMapper {

	List<Map<String, String>> listUserGroup();
	
	int userGroupUseCnt(@Param(value = "condition") UserGroupDomain userGroupDomain);
	
	int duplChkGrpName(@Param(value = "groupName") String groupName
			         , @Param(value = "groupNo") String groupNo);
	
	String getAddGroupId(@Param(value="condition") UserGroupDomain userGroupDomain);
	
	int count(@Param(value = "condition") UserGroupDomain userGroupDomain);
	
	List<UserGroupDomain> list(@Param("condition") UserGroupDomain userGroupDomain
	                         , @Param("start") int start
	                         , @Param("end") int end);
	
	UserGroupDomain detailUserGroup(@Param(value="condition") UserGroupDomain userGroupDomain);
	
	List<UserGroupDomain> detailUserGroupPkg(@Param(value="condition") UserGroupDomain userGroupDomain);
	
	int addUserGroup(@Param(value="condition") UserGroupDomain userGroupDomain);
	
	int addUserGroupPkg(@Param(value="condition") UserGroupDomain userGroupDomain);
	
	int modifyUserGroup(@Param(value="condition") UserGroupDomain userGroupDomain);
	
	int removeUserGroup(@Param(value="condition") UserGroupDomain userGroupDomain);
	
	int removeUserGroupPkg(@Param(value="condition") UserGroupDomain userGroupDomain);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") UserGroupDomain userGroupDomain);
}
