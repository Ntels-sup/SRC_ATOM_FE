package com.ntels.avocado.service.atom.performance.perfomhistory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.performance.perfomhistory.PerfomHistoryMapper;
import com.ntels.avocado.dao.vofcs.performance.perfomhistory.VofcsPerfomHistoryMapper;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.performance.perfomhistory.PerfomHistoryDomain;
import com.ntels.ncf.utils.ParamUtil;

@Service
public class PerfomHistoryService {
	
	@Autowired
	private PerfomHistoryMapper aTomPerfomHistoryMapper;
	
	@Autowired
	private VofcsPerfomHistoryMapper vofcsPerfomHistoryMapper ;
	
	public Paging listAction(PerfomHistoryDomain condition) {
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}
		condition.setStart(((condition.getPage()-1)*condition.getPerPage()));
		condition.setEnd(condition.getPerPage());
		
		String dbName = condition.getDb_name();
		List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String,Object>>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(dbName.equals("ATOM")){ // => ATOM
			list = aTomPerfomHistoryMapper.list(condition, condition.getStart(), condition.getEnd());
			map = aTomPerfomHistoryMapper.count(condition);
		}else if(dbName.equals("VOFCS")){ //  => VOFCS
			list = vofcsPerfomHistoryMapper.list(condition, condition.getStart(), condition.getEnd());
			map = vofcsPerfomHistoryMapper.count(condition);
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
	

	
	
	public List<LinkedHashMap<String, String>> listExcel(PerfomHistoryDomain condition){
		String dbName = condition.getDb_name();
		List<LinkedHashMap<String, String>> elist = new ArrayList<LinkedHashMap<String,String>>();
		if(dbName.equals("ATOM")){ // => ATOM
			elist = aTomPerfomHistoryMapper.listExcel(condition);
		}else if(dbName.equals("VOFCS")){ //  => VOFCS
			elist = vofcsPerfomHistoryMapper.listExcel(condition);	
		}
		return elist;
	}
	
}
