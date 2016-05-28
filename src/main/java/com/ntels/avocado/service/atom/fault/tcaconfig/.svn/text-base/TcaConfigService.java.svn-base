package com.ntels.avocado.service.atom.fault.tcaconfig;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.dao.atom.fault.tcaconfig.TcaConfigMapper;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.fault.alarmlevel.AlmCodeDef;
import com.ntels.avocado.domain.atom.fault.tcaconfig.TcaConfig;
import com.ntels.avocado.domain.atom.fault.tcaconfig.TcaConfigDomain;
import com.ntels.ncf.utils.ParamUtil;

@Service
public class TcaConfigService {
	@Autowired
	private TcaConfigMapper tcaConfigMapper;
	
	public Paging listAction(TcaConfigDomain condition){
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}
		condition.setStart(((condition.getPage()-1)*condition.getPerPage()));
		condition.setEnd(condition.getPerPage());
		
		List<TcaConfig> list = tcaConfigMapper.list(condition  , condition.getStart(), condition.getEnd());
		
		Map<String, Object> map = tcaConfigMapper.count(condition); 
		
		//paging을 위한 DTO를 생성
		Paging paging = new Paging();
		paging.setLists(list);
		paging.setTotalCount(Integer.parseInt(map.get("TOTAL_COUNT").toString()));
		paging.setMap(map);	
		paging.setPage(condition.getPage());
		paging.setPerPage(condition.getPerPage());
		
		return paging;
	}
	
	
	public List<LinkedHashMap<String, String>> listExcel(TcaConfigDomain condition) {
		return tcaConfigMapper.listExcel(condition);
	}
	
	public List<Map<String, String>> StatisticsTable(String node_no){
		return tcaConfigMapper.StatisticsTable(node_no);
	}
	
	public List<Map<String, String>> StatisticsColumn(String node_no,String table_name){
		return tcaConfigMapper.StatisticsColumn(node_no,table_name);
	}
	
	
	@Transactional
	public boolean insert(TcaConfigDomain condition){
		int resultcnt = 0;
		resultcnt = resultcnt + tcaConfigMapper.insertTca(condition); // TAT_STS_TCA 등록.
		//TAT_STS_TCA_RULE 등록 (case 7 : OVER CRITICAL	, OVER MAJOR , OVER MINOR , CLEARED , UNDER CRITICAL , UNDER MAJOR , UNDER MINOR )
		condition.setSEVERITY_CCD("OVER CRITICAL");
		resultcnt = resultcnt + tcaConfigMapper.insertTcaRule(condition);
		
		condition.setSEVERITY_CCD("OVER MAJOR");
		resultcnt = resultcnt + tcaConfigMapper.insertTcaRule(condition);
		
		condition.setSEVERITY_CCD("OVER MINOR");
		resultcnt = resultcnt + tcaConfigMapper.insertTcaRule(condition);
		
		condition.setSEVERITY_CCD("CLEARED");
		resultcnt = resultcnt + tcaConfigMapper.insertTcaRule(condition);
		
		condition.setSEVERITY_CCD("UNDER CRITICAL");
		resultcnt = resultcnt + tcaConfigMapper.insertTcaRule(condition);
		
		condition.setSEVERITY_CCD("UNDER MAJOR");
		resultcnt = resultcnt + tcaConfigMapper.insertTcaRule(condition);
		
		condition.setSEVERITY_CCD("UNDER MINOR");
		resultcnt = resultcnt + tcaConfigMapper.insertTcaRule(condition);
		
		System.err.println("isnert total count :" + resultcnt);
		return (resultcnt > 7);
	}
	
	
	@Transactional
	public boolean update(TcaConfigDomain condition){
		int resultcnt = 0;
		resultcnt = resultcnt + tcaConfigMapper.updateTca(condition); // TAT_STS_TCA 수정.
		//TAT_STS_TCA_RULE 등록 (case 7 : OVER CRITICAL	, OVER MAJOR , OVER MINOR , CLEARED , UNDER CRITICAL , UNDER MAJOR , UNDER MINOR )
		condition.setSEVERITY_CCD("OVER CRITICAL");
		resultcnt = resultcnt + tcaConfigMapper.updateTcaRule(condition);
		
		condition.setSEVERITY_CCD("OVER MAJOR");
		resultcnt = resultcnt + tcaConfigMapper.updateTcaRule(condition);
		
		condition.setSEVERITY_CCD("OVER MINOR");
		resultcnt = resultcnt + tcaConfigMapper.updateTcaRule(condition);
		
		condition.setSEVERITY_CCD("CLEARED");
		resultcnt = resultcnt + tcaConfigMapper.updateTcaRule(condition);
		
		condition.setSEVERITY_CCD("UNDER CRITICAL");
		resultcnt = resultcnt + tcaConfigMapper.updateTcaRule(condition);
		
		condition.setSEVERITY_CCD("UNDER MAJOR");
		resultcnt = resultcnt + tcaConfigMapper.updateTcaRule(condition);
		
		condition.setSEVERITY_CCD("UNDER MINOR");
		resultcnt = resultcnt + tcaConfigMapper.updateTcaRule(condition);
		
		return (resultcnt > 7);
	}
	
	
	@Transactional
	public boolean delete(TcaConfigDomain condition){
		int resultcnt = 0;
		resultcnt = resultcnt + tcaConfigMapper.deleteTca(condition);
		resultcnt = resultcnt + tcaConfigMapper.deleteTcaRule(condition);
		return (resultcnt > 0);
	}
	
	
	
	public TcaConfig getTcaInfo(TcaConfigDomain condition){
		return tcaConfigMapper.getTcaInfo(condition);
	}
	
}
