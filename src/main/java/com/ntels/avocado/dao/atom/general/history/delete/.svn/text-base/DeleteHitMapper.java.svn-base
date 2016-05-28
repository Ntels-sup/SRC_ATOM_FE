package com.ntels.avocado.dao.atom.general.history.delete;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.general.history.delete.DeleteHitDomain;

@Component
public interface DeleteHitMapper {

	int count(@Param(value = "condition") DeleteHitDomain deleteHitDomain);
	
	List<DeleteHitDomain> list(@Param("condition") DeleteHitDomain deleteHitDomain
	                           , @Param("start") int start
	                           , @Param("end") int end);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value = "condition") DeleteHitDomain condition);
}

