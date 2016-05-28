package com.ntels.avocado.dao.atom.fault.alarmconfig;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.fault.alarmconfig.AlarmConfigDomain;

@Component
public interface AlarmConfigMapper {

	int count(@Param(value = "condition") AlarmConfigDomain alarmConfigDomain);
	
	List<AlarmConfigDomain> list(@Param("condition") AlarmConfigDomain alarmConfigDoamin
	                           , @Param("start") int start
	                           , @Param("end") int end);
	
	AlarmConfigDomain detail(@Param("condition") AlarmConfigDomain alarmConfigDomain);
	
	int modifyAction(@Param("condition") AlarmConfigDomain alarmConfigDomain);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") AlarmConfigDomain alarmConfigDomain);
}
