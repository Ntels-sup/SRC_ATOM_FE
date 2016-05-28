package com.ntels.avocado.dao.atom.fault.alarmlevel;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.fault.alarmlevel.AlmCodeDef;
import com.ntels.avocado.domain.atom.fault.alarmlevel.AlmLevel;
import com.ntels.avocado.domain.atom.fault.alarmlevel.AlmMonitor;
import com.ntels.avocado.domain.atom.fault.alarmlevel.AlmMonitorDef;

@Component
public interface AlarmLevelMapper {

	List<AlmCodeDef> listAlmCodeDef(@Param(value = "condition") AlmCodeDef condition, @Param(value = "start") int start, @Param(value = "end") int end);
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") AlmCodeDef condition);
	int countAlmCodeDef(@Param(value = "condition") AlmCodeDef condition);
	AlmCodeDef getAlmCodeDef(AlmCodeDef almCodeDef);
	List<AlmMonitorDef> listAlmMonitorDef(AlmCodeDef almCodeDef);
	List<AlmMonitorDef> listAlmMonitorTarget(AlmMonitorDef almMonitorDef);
	int saveAlmCodeDef(AlmCodeDef almCodeDef);
	AlmMonitor getAlmMonitor(AlmMonitor almMonitor);
	List<AlmLevel> listAlmLevel(AlmMonitorDef almMonitorDef);
	int insertAlmMonitor(AlmMonitor almMonitor);
	int deleteAlmLevel(AlmMonitor almMonitor);
	int insertAlmLevel(AlmLevel almLevel);
}
