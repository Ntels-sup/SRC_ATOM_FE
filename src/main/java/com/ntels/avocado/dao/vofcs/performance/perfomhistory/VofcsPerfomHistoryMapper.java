package com.ntels.avocado.dao.vofcs.performance.perfomhistory;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.performance.perfomhistory.PerfomHistoryDomain;

@Component
public interface VofcsPerfomHistoryMapper {
	List<LinkedHashMap<String, Object>> list(@Param(value = "condition") PerfomHistoryDomain condition , @Param(value = "start") int start, @Param(value = "end") int end );
	
	Map<String, Object> count(@Param(value = "condition") PerfomHistoryDomain condition);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") PerfomHistoryDomain condition);
}
