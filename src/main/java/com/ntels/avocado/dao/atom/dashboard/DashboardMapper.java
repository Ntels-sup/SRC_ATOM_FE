package com.ntels.avocado.dao.atom.dashboard;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.dashboard.AlarmChart;
import com.ntels.avocado.domain.atom.dashboard.AlarmTotal;
import com.ntels.avocado.domain.atom.dashboard.ReleaseLog;


@Component
public interface DashboardMapper {

	
	AlarmTotal getTotalAlarm();
	
	List<AlarmChart> getAlarmChart();
	
	List<ReleaseLog> getReleaseLog(@Param(value = "language") String language);
	
}
