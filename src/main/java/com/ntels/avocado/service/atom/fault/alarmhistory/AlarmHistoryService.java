package com.ntels.avocado.service.atom.fault.alarmhistory;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.fault.alarmhistory.AlarmHistoryMapper;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.fault.alarmhistory.AlarmHistory;
import com.ntels.avocado.domain.atom.fault.alarmhistory.AlarmHistoryDomain;
import com.ntels.avocado.domain.atom.fault.alarmstatistics.AlarmStatisticsDomain;
import com.ntels.ncf.utils.ParamUtil;

@Service
public class AlarmHistoryService {
	@Autowired
	private AlarmHistoryMapper alarmHistoryMapper;
	
	public Paging listAction(AlarmHistoryDomain condition){
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}

		condition.setStart(((condition.getPage()-1)*condition.getPerPage()));
		condition.setEnd(condition.getPerPage());

		if(condition.getSystem_id() != null){
			String[] SystemArray = condition.getSystem_id().split(",");
			condition.setSystemArray(SystemArray);	
		}
		
		
		List<AlarmHistory> list = alarmHistoryMapper.list(condition, condition.getStart(), condition.getEnd());
		int count = alarmHistoryMapper.count(condition);
		
		//결과를 DTO에 저장
		Paging paging = new Paging();
		paging.setLists(list);
		paging.setTotalCount(count);		
		paging.setPage(condition.getPage());
		paging.setPerPage(condition.getPerPage());
		
		return paging;
	
	}
	
	
	public List<LinkedHashMap<String, String>> listExcel(AlarmHistoryDomain condition){
		return alarmHistoryMapper.listExcel(condition);
	}
	
	
	
}
