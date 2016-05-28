package com.ntels.avocado.dao.atom.config.resourceconfig;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.config.resourceconfig.ResourceConfigDomain;

@Component
public interface ResourceConfigMapper {

	List<Map<String, String>> listNodeType(@Param(value = "pkgName") String pkgName);
	
	List<Map<String, String>> listResourceGrp();
	
	List<Map<String, String>> listStatPeriod();
	
	ResourceConfigDomain rscGrpConfig(@Param(value="condition") ResourceConfigDomain resourceConfigDomain);
	
	List<ResourceConfigDomain> rscConifg(@Param(value="condition") ResourceConfigDomain resourceConfigDomain);
	
	int modifyRscGrpConifg(@Param(value="condition") ResourceConfigDomain resourceConfigDomain);
	
	int modifyRscConifg(@Param(value="condition") ResourceConfigDomain resourceConfigDomain);
}
