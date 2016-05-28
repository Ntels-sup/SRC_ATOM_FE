package com.ntels.avocado.service.atom.performance.statisticsconfig;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ntels.avocado.dao.atom.performance.statisticsconfig.StatisticsConfigMapper;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.config.networkmanager.Pkg;
import com.ntels.avocado.domain.atom.performance.statisticsconfig.StatisticsConfigDomain;
import com.ntels.ncf.utils.ParamUtil;

@Service
public class StatisticsConfigService {

	@Autowired
	private StatisticsConfigMapper statisticsConfigMapper;
	
	public Paging listAction(StatisticsConfigDomain condition){
		
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}
		condition.setStart(((condition.getPage()-1)*condition.getPerPage()));
		condition.setEnd(condition.getPerPage());
		
		List<StatisticsConfigDomain> list = statisticsConfigMapper.list(condition, condition.getStart(), condition.getEnd());
		int count = statisticsConfigMapper.count(condition);
		
		Paging paging = new Paging();
		paging.setLists(list);
		paging.setTotalCount(count);		
		//paging.setPage(condition.getPage());
		//paging.setPerPage(condition.getPerPage());
		return paging;
	}
	
	@Transactional
	public String modifyAction(String jsonArr) {
		try {
			Gson gson=new Gson();
			JsonParser parser=new JsonParser();
			
			JsonArray json=(JsonArray) parser.parse(jsonArr);
			for (int i=0;i<json.size();i++) {
				JsonObject object= (JsonObject) json.get(i);
				StatisticsConfigDomain condition=gson.fromJson(object, StatisticsConfigDomain.class);
				statisticsConfigMapper.modifyAction(condition);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return ex.getMessage();
		}
		return "succ";
	}
}
