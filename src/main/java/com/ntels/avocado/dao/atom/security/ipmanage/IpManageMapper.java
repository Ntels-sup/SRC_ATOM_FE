package com.ntels.avocado.dao.atom.security.ipmanage;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.security.ipmanage.IpManageDomain;

@Component
public interface IpManageMapper {
	
	List<Map<String, String>> listAllowYn();
	
	List<IpManageDomain> duplChkIpBandWidth();
	
	int count(@Param(value = "condition") IpManageDomain ipManageDomain);
	
	List<IpManageDomain> list(@Param("condition") IpManageDomain ipManageDomain
                            , @Param("start") int start
                            , @Param("end") int end);
	
	IpManageDomain detail(@Param(value="condition") IpManageDomain ipManageDomain);
	
	int addAction(@Param(value="condition") IpManageDomain ipManageDomain);
	
	int modifyAction(@Param(value="condition") IpManageDomain ipManageDomain);
	
	int removeAction(@Param(value="condition") IpManageDomain ipManageDomain);
	
	List<LinkedHashMap<String, String>> listExcel(@Param(value="condition") IpManageDomain ipManageDomain);
	
	String getMaxIpNo();
}
