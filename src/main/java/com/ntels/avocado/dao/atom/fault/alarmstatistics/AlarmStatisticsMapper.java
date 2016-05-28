package com.ntels.avocado.dao.atom.fault.alarmstatistics;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;


import com.ntels.avocado.domain.atom.fault.alarmstatistics.AlarmStatistics;
import com.ntels.avocado.domain.atom.fault.alarmstatistics.AlarmStatisticsDomain;

@Component
public interface AlarmStatisticsMapper {
	
	List<AlarmStatistics> list(@Param(value = "condition") AlarmStatisticsDomain condition, @Param(value = "start") int start, @Param(value = "end") int end );
	
	Map<String, Object> count(@Param(value = "condition") AlarmStatisticsDomain condition);

	List<LinkedHashMap<String,String>> topSystemList(@Param(value = "condition") AlarmStatisticsDomain condition);
	
	String topSystemArray(@Param(value = "condition") AlarmStatisticsDomain condition);
	
	List<HashMap<String,String>> getChartList(@Param(value = "condition") AlarmStatisticsDomain condition);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") AlarmStatisticsDomain condition);
}
