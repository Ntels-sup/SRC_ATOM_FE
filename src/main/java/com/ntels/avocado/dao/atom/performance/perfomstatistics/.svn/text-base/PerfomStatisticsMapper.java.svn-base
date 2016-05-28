package com.ntels.avocado.dao.atom.performance.perfomstatistics;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.performance.perfomstatistics.PerfomStatisticsDomain;


@Component
public interface PerfomStatisticsMapper {

	List<LinkedHashMap<String, Object>> list(@Param(value = "condition") PerfomStatisticsDomain condition , @Param(value = "start") int start, @Param(value = "end") int end );
	
	Map<String, Object> count(@Param(value = "condition") PerfomStatisticsDomain condition);
	
	String topSystemArray(@Param(value = "condition") PerfomStatisticsDomain condition);
	
	List<HashMap<String,String>> getChartList(@Param(value = "condition") PerfomStatisticsDomain condition);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") PerfomStatisticsDomain condition);
	
	
}
