package com.ntels.avocado.dao.atom.general.systeminfor;

import java.util.LinkedHashMap;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.general.systeminfor.SystemInforDomain;

@Component
public interface SystemInforMapper {
	int count(@Param(value = "condition") SystemInforDomain systemInforDomain);

	List<SystemInforDomain> list(@Param("condition") SystemInforDomain systemInforDomain
            , @Param("start") int start
            , @Param("end") int end);

	List<LinkedHashMap<String, String>> listExcel(@Param(value="condition") SystemInforDomain systemInforDomain);
	
}
