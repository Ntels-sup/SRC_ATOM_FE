package com.ntels.avocado.dao.atom.fault.nbiconfig;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.fault.nbiconfig.NbiConfigDomain;

@Component
public interface SnmpTrapConfigMapper {

	NbiConfigDomain trapConfig();
	
	int trapIpCount();

	List<NbiConfigDomain> trapIpList();

	int modifyTrapConfig(NbiConfigDomain nbiConfigDomain);
	
	int addTrapIp(NbiConfigDomain nbiConfigDomain);

	int removeTrapIp();

	List<LinkedHashMap<String, String>> listExcelTrapConfig();
	
	List<LinkedHashMap<String, String>> listExcelTrapIp();

}
