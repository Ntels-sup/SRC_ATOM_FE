package com.ntels.avocado.dao.atom.security.operationhist;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.security.operationhist.Condition;
import com.ntels.avocado.domain.atom.security.operationhist.OperationHistDomain;

@Component
public interface OperationHistMapper {

	List<Map<String, String>> listMenu();
	
	List<Map<String, String>> listTarget();
	
	List<Map<String, String>> listMessage();
	
	int count(@Param(value = "condition") Condition condition);
	
	List<OperationHistDomain> list(@Param("condition") Condition condition
	                             , @Param("start") int start
	                             , @Param("end") int end);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") Condition condition);
}
