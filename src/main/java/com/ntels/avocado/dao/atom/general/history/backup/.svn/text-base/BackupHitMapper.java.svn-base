package com.ntels.avocado.dao.atom.general.history.backup;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.fault.alarmhistory.AlarmHistoryDomain;
import com.ntels.avocado.domain.atom.general.history.backup.BackupHitDomain;

@Component
public interface BackupHitMapper {

	int count(@Param(value = "condition") BackupHitDomain backupHitDomain);
	
	List<BackupHitDomain> list(@Param("condition") BackupHitDomain backupHitDomain
	                           , @Param("start") int start
	                           , @Param("end") int end);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") BackupHitDomain condition);

	BackupHitDomain detail(@Param(value="condition") BackupHitDomain condition);
}

