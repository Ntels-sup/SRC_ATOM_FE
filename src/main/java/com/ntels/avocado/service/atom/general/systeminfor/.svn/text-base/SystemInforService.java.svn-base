package com.ntels.avocado.service.atom.general.systeminfor;


import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.general.systeminfor.SystemInforMapper;
import com.ntels.avocado.domain.atom.general.systeminfor.SystemInforDomain;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.ncf.utils.ParamUtil;

@Service
public class SystemInforService {
	
	@Autowired
	private SystemInforMapper systemInforMapper;
	
	
	public Paging list(SystemInforDomain condition){
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}
		condition.setStart(((condition.getPage()-1)*condition.getPerPage()));
		condition.setEnd(condition.getPerPage());
		
		List<SystemInforDomain> list = systemInforMapper.list(condition, condition.getStart(), condition.getEnd());
		int count = systemInforMapper.count(condition);
		
		Paging paging = new Paging();
		paging.setLists(list);
		paging.setTotalCount(count);		
		paging.setPage(condition.getPage());
		paging.setPerPage(condition.getPerPage());
		return paging;
	}


	public List<LinkedHashMap<String, String>> listExcel(SystemInforDomain condition) {
		return systemInforMapper.listExcel(condition);
	}

}
