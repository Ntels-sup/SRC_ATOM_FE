package com.ntels.avocado.service.atom.performance.perfomstatistics;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.performance.perfomstatistics.PerfomStatisticsMapper;
import com.ntels.avocado.dao.vofcs.performance.perfomstatistics.VofcsPerfomStatisticsMapper;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.performance.perfomstatistics.PerfomStatisticsDomain;
import com.ntels.avocado.domain.atom.performance.resourcestatistics.ResourceStatisticsDomain;
import com.ntels.ncf.utils.ParamUtil;

@Service
public class PerfomStatisticsService {

	@Autowired
	private PerfomStatisticsMapper aTomPerfomStatisticsMapper;
	
	@Autowired
	private VofcsPerfomStatisticsMapper vofcsPerfomStatisticsMapper ;
	
	
	public Paging listAction(PerfomStatisticsDomain condition) {
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}
		condition.setStart(((condition.getPage()-1)*condition.getPerPage()));
		condition.setEnd(condition.getPerPage());
		
		String dbName = condition.getDb_name();
		List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String,Object>>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(dbName.equals("ATOM")){ // => ATOM
			list = aTomPerfomStatisticsMapper.list(condition, condition.getStart(), condition.getEnd());
			map = aTomPerfomStatisticsMapper.count(condition);
		}else if(dbName.equals("VOFCS")){ //  => VOFCS
			list = vofcsPerfomStatisticsMapper.list(condition, condition.getStart(), condition.getEnd());
			map = vofcsPerfomStatisticsMapper.count(condition);
		}
		
		//paging을 위한 DTO를 생성
		Paging paging = new Paging();
		paging.setLists(list);
		paging.setTotalCount(Integer.parseInt(map.get("TOTAL_COUNT").toString()));
		paging.setMap(map);	
		paging.setPage(condition.getPage());
		paging.setPerPage(condition.getPerPage());	
		
		return paging;
	}
	
	public String topSystemArray(PerfomStatisticsDomain condition) {
		String dbName = condition.getDb_name();
		String topSystemName = "";
		if(dbName.equals("ATOM")){ //  => ATOM
			topSystemName = aTomPerfomStatisticsMapper.topSystemArray(condition);
		}else if(dbName.equals("VOFCS")){ //  => VOFCS
			topSystemName = vofcsPerfomStatisticsMapper.topSystemArray(condition);
		}
		return topSystemName;
	}
	
	public List<HashMap<String,String>> getChartList(PerfomStatisticsDomain condition) {
		String dbName = condition.getDb_name();
		List<HashMap<String,String>> resultChart = new ArrayList<HashMap<String,String>>();
		
		if(dbName.equals("ATOM")){ // 1 => ATOM
			resultChart = aTomPerfomStatisticsMapper.getChartList(condition);
		}else if(dbName.equals("VOFCS")){ // 2 => VOFCS
			resultChart = vofcsPerfomStatisticsMapper.getChartList(condition);
		}
		return resultChart;
	}
	
	
	public List<LinkedHashMap<String, String>> listExcel(PerfomStatisticsDomain condition){
		String dbName = condition.getDb_name();
		List<LinkedHashMap<String,String>> resultExcel = new ArrayList<LinkedHashMap<String,String>>();
		
		if(dbName.equals("ATOM")){ //  => ATOM
			resultExcel = aTomPerfomStatisticsMapper.listExcel(condition);
		}else if(dbName.equals("VOFCS")){ //  => VOFCS
			resultExcel = vofcsPerfomStatisticsMapper.listExcel(condition);
		}
	  return resultExcel;
	}
	
}
