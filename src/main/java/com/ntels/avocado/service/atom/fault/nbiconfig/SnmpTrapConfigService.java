package com.ntels.avocado.service.atom.fault.nbiconfig;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.dao.atom.fault.nbiconfig.SnmpTrapConfigMapper;
import com.ntels.avocado.domain.atom.fault.nbiconfig.NbiConfigDomain;

@Service
public class SnmpTrapConfigService {
	@Autowired
	private SnmpTrapConfigMapper snmpTrapConfigMapper;
	
	public NbiConfigDomain trapConfig() {
		return snmpTrapConfigMapper.trapConfig();
	}
	
	public int trapIpCount() {
		return snmpTrapConfigMapper.trapIpCount();
	}

	public List<NbiConfigDomain> trapIpList() {
		return snmpTrapConfigMapper.trapIpList();
	}
	
	@Transactional
	public void modifyAction(NbiConfigDomain nbiConfigDomain) {
		List<NbiConfigDomain> trapIpList = new ArrayList<NbiConfigDomain>();
		
		snmpTrapConfigMapper.modifyTrapConfig(nbiConfigDomain);
		snmpTrapConfigMapper.removeTrapIp();
		
		//trapIp data parse
		if(nbiConfigDomain.getIp() != null){
			String ip[] = nbiConfigDomain.getIp().split(",");
			String port[] = nbiConfigDomain.getPort().split(",");
			String host_name[]= nbiConfigDomain.getHost_name().split(",");
			String community[] = nbiConfigDomain.getCommunity().split(",");
			
			//description null exception 처리 
			String description[] = new String[ip.length];
			String descriptionTmp[] = nbiConfigDomain.getDescription().split(",");
			for(int j=0; j<descriptionTmp.length; j++){
				description[j] = descriptionTmp[j];
			}
			
			for(int i=0; i<ip.length; i++){
				NbiConfigDomain trapIp = new NbiConfigDomain();
				trapIp.setIp(ip[i]);
				trapIp.setPort(port[i]);
				trapIp.setHost_name(host_name[i]);
				trapIp.setCommunity(community[i]);
				trapIp.setDescription(description[i]);
				trapIpList.add(trapIp);
			}
		}
		
		//trapIp data insert
		if(trapIpList.size() > 0){
			for(int j=0; j<trapIpList.size(); j++){
				snmpTrapConfigMapper.addTrapIp(trapIpList.get(j));
			}
		}
	}

	public List<LinkedHashMap<String, String>> listExcelTrapConfig() {
    	return snmpTrapConfigMapper.listExcelTrapConfig();
    }
	
	public List<LinkedHashMap<String, String>> listExcelTrapIp() {
		return snmpTrapConfigMapper.listExcelTrapIp();
	}
}
