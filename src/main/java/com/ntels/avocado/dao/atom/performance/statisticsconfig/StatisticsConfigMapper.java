package com.ntels.avocado.dao.atom.performance.statisticsconfig;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.performance.statisticsconfig.StatisticsConfigDomain;

@Component
public interface StatisticsConfigMapper {

	int count(@Param(value = "condition") StatisticsConfigDomain condition);
	
	List<StatisticsConfigDomain> list(@Param("condition") StatisticsConfigDomain condition
	                           , @Param("start") int start
	                           , @Param("end") int end);
	
	int modifyAction(StatisticsConfigDomain condition);
	
}

