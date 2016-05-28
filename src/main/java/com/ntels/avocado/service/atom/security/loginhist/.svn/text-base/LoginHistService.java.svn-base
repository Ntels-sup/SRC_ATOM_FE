package com.ntels.avocado.service.atom.security.loginhist;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.security.loginhist.LoginHistMapper;
import com.ntels.avocado.domain.atom.security.loginhist.Condition;
import com.ntels.avocado.domain.atom.security.loginhist.LoginHistDomain;

@Service
public class LoginHistService {

	@Autowired
	private LoginHistMapper loginHistMapper;
	
	public List<Map<String, String>> listUserGroup(){
		return loginHistMapper.listUserGroup();
	}
	
	public List<Map<String, String>> listUserLevel(String userLevelId){
		return loginHistMapper.listUserLevel(userLevelId);
	}
	
	public int count(Condition condition){
		return loginHistMapper.count(condition);
	}
	
	public List<LoginHistDomain> list(Condition condition, int page, int perPage){
		int start = ((page - 1) * perPage);
		int end = perPage;
		
		return loginHistMapper.list(condition, start, end);
	}
	
    public List<LinkedHashMap<String, String>> listExcel(Condition condition) {
    	return loginHistMapper.listExcel(condition);
    }
}
