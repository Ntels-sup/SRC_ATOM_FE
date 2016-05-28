package com.ntels.avocado.dao.atom.general.schedulerhist;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.general.schedulerhist.Condition;
import com.ntels.avocado.domain.atom.general.schedulerhist.SchedulerHistDomain;

@Component
public interface SchedulerHistMapper {
	
	List<SchedulerHistDomain> listPackageName(
			@Param(value = "condition") Condition condition);
	
	List<SchedulerHistDomain> listGroupName(
			@Param(value = "condition") Condition condition);
	
	List<SchedulerHistDomain> listJobName(
			@Param(value = "condition") Condition condition);
	
	List<SchedulerHistDomain> list(
			@Param(value = "condition") Condition condition,
			@Param(value = "start") int start,
			@Param(value = "end") int end);
	
	int count(@Param(value = "condition") Condition condition);

	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") Condition condition);

}