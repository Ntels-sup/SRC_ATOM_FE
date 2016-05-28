package com.ntels.avocado.service.atom.fault.alarmconfig;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.fault.alarmconfig.AlarmConfigMapper;
import com.ntels.avocado.domain.atom.fault.alarmconfig.AlarmConfigDomain;

@Service
public class AlarmConfigService {

	@Autowired
	private AlarmConfigMapper alarmConfigMapper;
	
	public int count(AlarmConfigDomain alarmConfigDomain){
		return alarmConfigMapper.count(alarmConfigDomain);
	}
	
	public List<AlarmConfigDomain> list(AlarmConfigDomain alaramConfigDomain, int page, int perPage){
		int start = ((page - 1) * perPage);
		int end = perPage;
		
		return alarmConfigMapper.list(alaramConfigDomain, start, end);
	}
	
	public AlarmConfigDomain detail(AlarmConfigDomain alarmConfigDomain){
		return alarmConfigMapper.detail(alarmConfigDomain);
	}
	
	public void modifyAction(AlarmConfigDomain alarmConfigDomain){
		alarmConfigMapper.modifyAction(alarmConfigDomain);
	}

    public List<LinkedHashMap<String, String>> listExcel(AlarmConfigDomain alarmConfigDomain) {
    	return alarmConfigMapper.listExcel(alarmConfigDomain);
    }
}
