package com.ntels.avocado.service.atom.security.operationhist;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.security.operationhist.OperationHistMapper;
import com.ntels.avocado.domain.atom.security.operationhist.Condition;
import com.ntels.avocado.domain.atom.security.operationhist.OperationHistDomain;

@Service
public class OperationHistService {

	@Autowired
	private OperationHistMapper operationHistMapper;
	
	public List<Map<String, String>> listMenu(){
		return operationHistMapper.listMenu();
	}
	
	public List<Map<String, String>> listTarget(){
		return operationHistMapper.listTarget();
	}
	
	public List<Map<String, String>> listMessage(){
		return operationHistMapper.listMessage();
	}
	
	public int count(Condition condition){
		return operationHistMapper.count(condition);
	}
	
	public List<OperationHistDomain> list(Condition condition, int page, int perPage){
		int start = ((page - 1) * perPage);
		int end = perPage;
		
		return operationHistMapper.list(condition, start, end);
	}
	
    public List<LinkedHashMap<String, String>> listExcel(Condition condition) {
    	return operationHistMapper.listExcel(condition);
    }
}
