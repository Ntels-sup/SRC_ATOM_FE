package com.ntels.avocado.service.atom.fault.alarmstatistics;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.dao.atom.fault.alarmstatistics.AlarmStatisticsMapper;
import com.ntels.avocado.domain.atom.fault.alarmstatistics.AlarmStatistics;
import com.ntels.avocado.domain.atom.fault.alarmstatistics.AlarmStatisticsDomain;
import com.ntels.ncf.utils.ParamUtil;


@Service
public class AlarmStatisticsService {
	@Autowired
	private AlarmStatisticsMapper alarmStatisticsMapper;
	
/*	public List<AlarmStatistics> listAction(AlarmStatisticsCondition condition){		
		List<AlarmStatistics> list = alarmStatisticsMapper.list(condition);
		return list;
	}*/
	
	
	public Paging listAction(AlarmStatisticsDomain condition) {
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}
		condition.setStart(((condition.getPage()-1)*condition.getPerPage()));
		condition.setEnd(condition.getPerPage());
		
		List<AlarmStatistics> list = alarmStatisticsMapper.list(condition, condition.getStart(), condition.getEnd());
		
		Map<String, Object> map = alarmStatisticsMapper.count(condition);
		
		//paging을 위한 DTO를 생성
		Paging paging = new Paging();
		paging.setLists(list);
		paging.setTotalCount(Integer.parseInt(map.get("TOTAL_COUNT").toString()));
		paging.setMap(map);	
		paging.setPage(condition.getPage());
		paging.setPerPage(condition.getPerPage());	
		
		return paging;
	}
	
	public List<HashMap<String,String>> getChartList(AlarmStatisticsDomain condition) {
		return alarmStatisticsMapper.getChartList(condition);
	}
	
	
	public List<LinkedHashMap<String, String>> topSystemList(AlarmStatisticsDomain condition) {
		return alarmStatisticsMapper.topSystemList(condition);
	}
	
	public String topSystemArray(AlarmStatisticsDomain condition) {
		return alarmStatisticsMapper.topSystemArray(condition);
	}
	
	public List<LinkedHashMap<String, String>> listExcel(AlarmStatisticsDomain condition){
		return alarmStatisticsMapper.listExcel(condition);
	}
	
	
}
