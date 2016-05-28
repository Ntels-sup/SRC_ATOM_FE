package com.ntels.avocado.dao.atom.fault.alarmhistory;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.fault.alarmhistory.AlarmHistory;
import com.ntels.avocado.domain.atom.fault.alarmhistory.AlarmHistoryDomain;
import com.ntels.avocado.domain.atom.fault.alarmstatistics.AlarmStatisticsDomain;


@Component
public interface AlarmHistoryMapper {

	List<AlarmHistory> list(@Param(value = "condition") AlarmHistoryDomain condition, @Param(value = "start") int start, @Param(value = "end") int end);
	
	int count(@Param(value = "condition") AlarmHistoryDomain condition);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") AlarmHistoryDomain condition);
	
}
