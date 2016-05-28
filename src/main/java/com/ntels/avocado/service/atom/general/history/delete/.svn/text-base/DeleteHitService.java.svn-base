package com.ntels.avocado.service.atom.general.history.delete;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.general.history.delete.DeleteHitMapper;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.general.history.delete.DeleteHitDomain;
import com.ntels.ncf.utils.ParamUtil;

@Service
public class DeleteHitService {

	@Autowired
	private DeleteHitMapper deleteHitMapper;
	
	public Paging listAction(DeleteHitDomain condition){
		
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}
		
		condition.setStart(((condition.getPage()-1)*condition.getPerPage()));
		condition.setEnd(condition.getPerPage());
		

		List<DeleteHitDomain> list = deleteHitMapper.list(condition, condition.getStart(), condition.getEnd());
		int count = deleteHitMapper.count(condition);
		
		
		Paging paging = new Paging();
		paging.setLists(list);
		paging.setTotalCount(count);		
		paging.setPage(condition.getPage());
		paging.setPerPage(condition.getPerPage());
		return paging;
	}
	
	public List<LinkedHashMap<String, String>> listExcel(DeleteHitDomain condition){
		return deleteHitMapper.listExcel(condition);
	}
	
	
}
