package com.ntels.avocado.dao.atom.config.nodemanagement;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.config.nodemanagement.NodeManagementDomain;

@Component
public interface NodeManagementMapper {
	List<Map<String, String>> listNodeGrp();
	
	List<Map<String, String>> listNodeType(@Param(value = "pkg_name") String pkg_name);
	
	int duplChkNodeName(@Param(value="nodeName") String nodeName
			          , @Param(value="nodeNo") String nodeNo);
	
	int count(@Param(value = "condition") NodeManagementDomain nodeManagementDomain);
	
	List<NodeManagementDomain> list(@Param("condition") NodeManagementDomain nodeManagementDomain
				                  , @Param("start") int start
				                  , @Param("end") int end);
	
	NodeManagementDomain detail(@Param("condition") NodeManagementDomain nodeManagementDomain);

	int addAction(@Param("condition") NodeManagementDomain nodeManagementDomain);
	
	int modifyAction(@Param("condition") NodeManagementDomain nodeManagementDomain);
	
	int removeAction(@Param("condition") NodeManagementDomain nodeManagementDomain);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") NodeManagementDomain nodeManagementDomain);
}
