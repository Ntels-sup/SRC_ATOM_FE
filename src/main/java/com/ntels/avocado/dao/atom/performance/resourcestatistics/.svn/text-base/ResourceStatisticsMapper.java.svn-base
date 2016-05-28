package com.ntels.avocado.dao.atom.performance.resourcestatistics;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.fault.alarmstatistics.AlarmStatisticsDomain;
import com.ntels.avocado.domain.atom.performance.resourcestatistics.ResourceStatisticsDomain;

@Component
public interface ResourceStatisticsMapper {

	List<LinkedHashMap<String, Object>> list(@Param(value = "condition") ResourceStatisticsDomain condition , @Param(value = "start") int start, @Param(value = "end") int end );
	List<LinkedHashMap<String, Object>> cTempList(@Param(value = "condition") ResourceStatisticsDomain condition , @Param(value = "start") int start, @Param(value = "end") int end );
	
	Map<String, Object> count(@Param(value = "condition") ResourceStatisticsDomain condition);
	Map<String, Object> cTempCount(@Param(value = "condition") ResourceStatisticsDomain condition);
	
	
	List<LinkedHashMap<String, Object>> listRscIdCase(@Param(value = "condition") ResourceStatisticsDomain condition);
	
	String topSystemArray(@Param(value = "condition") ResourceStatisticsDomain condition);
	
	List<LinkedHashMap<String,String>> topSystemList(@Param(value = "condition") ResourceStatisticsDomain condition);
	
	List<HashMap<String,String>> getChartList(@Param(value = "condition") ResourceStatisticsDomain condition);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") ResourceStatisticsDomain condition);
	
}
