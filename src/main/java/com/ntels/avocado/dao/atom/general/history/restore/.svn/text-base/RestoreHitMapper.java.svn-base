package com.ntels.avocado.dao.atom.general.history.restore;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.general.history.backup.BackupHitDomain;
import com.ntels.avocado.domain.atom.general.history.restore.RestoreHitDomain;

@Component
public interface RestoreHitMapper {

	int count(@Param(value = "condition") RestoreHitDomain restoreHitDomain);
	
	List<RestoreHitDomain> list(@Param("condition") RestoreHitDomain restoreHitDomain
	                           , @Param("start") int start
	                           , @Param("end") int end);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") RestoreHitDomain condition);

	void saveAction(RestoreHitDomain condition);

	int getCountRestore(@Param(value = "condition") RestoreHitDomain condition);
}

