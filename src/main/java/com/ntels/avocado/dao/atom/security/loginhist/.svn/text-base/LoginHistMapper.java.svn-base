package com.ntels.avocado.dao.atom.security.loginhist;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.security.loginhist.Condition;
import com.ntels.avocado.domain.atom.security.loginhist.LoginHistDomain;

@Component
public interface LoginHistMapper {

	List<Map<String, String>> listUserGroup();
	
	List<Map<String, String>> listUserLevel(@Param(value = "userLevelId") String userLevelId);
	
	int count(@Param(value = "condition") Condition condition);
	
	List<LoginHistDomain> list(@Param(value = "condition") Condition condition
			                 , @Param(value = "start") int start
			                 , @Param(value = "end") int end);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") Condition condition);
}
