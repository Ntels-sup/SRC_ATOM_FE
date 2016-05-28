package com.ntels.avocado.service.atom.performance.resourcestatistics;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.performance.resourcestatistics.ResourceStatisticsMapper;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.fault.alarmstatistics.AlarmStatisticsDomain;
import com.ntels.avocado.domain.atom.performance.resourcestatistics.ResourceStatisticsDomain;
import com.ntels.avocado.domain.atom.performance.resourcestatistics.ResourceStatistics;
import com.ntels.ncf.utils.ParamUtil;

@Service
public class ResourceStatisticsService {
	@Autowired
	private ResourceStatisticsMapper resourceStatisticsMapper;
	
	public Paging listAction(ResourceStatisticsDomain condition){
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}

		condition.setStart(((condition.getPage()-1)*condition.getPerPage()));
		condition.setEnd(condition.getPerPage());
		
		List<LinkedHashMap<String, Object>> list = resourceStatisticsMapper.list(condition  , condition.getStart(), condition.getEnd());
		
		Map<String, Object> map = resourceStatisticsMapper.count(condition); 
		
		//paging을 위한 DTO를 생성
		Paging paging = new Paging();
		paging.setLists(list);
		paging.setTotalCount(Integer.parseInt(map.get("TOTAL_COUNT").toString()));
		paging.setMap(map);	
		paging.setPage(condition.getPage());
		paging.setPerPage(condition.getPerPage());
		
		return paging;
	}
	
	
	public List<LinkedHashMap<String, Object>> listRscIdCase(ResourceStatisticsDomain condition) {
		return resourceStatisticsMapper.listRscIdCase(condition);
	}
	
	
	public String topSystemArray(ResourceStatisticsDomain condition) {
		return resourceStatisticsMapper.topSystemArray(condition);
	}
	
	public List<LinkedHashMap<String, String>> topSystemList(ResourceStatisticsDomain condition) {
		return resourceStatisticsMapper.topSystemList(condition);
	}
	
	public List<HashMap<String,String>> getChartList(ResourceStatisticsDomain condition) {
		return resourceStatisticsMapper.getChartList(condition);
	}
	
	
	public List<LinkedHashMap<String, String>> listExcel(ResourceStatisticsDomain condition){
		return resourceStatisticsMapper.listExcel(condition);
	}
	
}
