package com.ntels.avocado.service.atom.general.history.restore;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.general.history.restore.RestoreHitMapper;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.general.history.backup.BackupHitDomain;
import com.ntels.avocado.domain.atom.general.history.restore.RestoreHitDomain;
import com.ntels.ncf.utils.ParamUtil;

@Service
public class RestoreHitService {

	@Autowired
	private RestoreHitMapper restoreHitMapper;
	
	public Paging listAction(RestoreHitDomain condition){
		
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}
		
		condition.setStart(((condition.getPage()-1)*condition.getPerPage()));
		condition.setEnd(condition.getPerPage());
		

		List<RestoreHitDomain> list = restoreHitMapper.list(condition, condition.getStart(), condition.getEnd());
		int count = restoreHitMapper.count(condition);
		
		
		Paging paging = new Paging();
		paging.setLists(list);
		paging.setTotalCount(count);		
		paging.setPage(condition.getPage());
		paging.setPerPage(condition.getPerPage());
		return paging;
	}
	
	public List<LinkedHashMap<String, String>> listExcel(RestoreHitDomain condition){
		return restoreHitMapper.listExcel(condition);
	}

	public void saveAction(RestoreHitDomain condition) {
		restoreHitMapper.saveAction(condition);
	}

	public int getCountRestore(RestoreHitDomain condition) {
		return restoreHitMapper.getCountRestore(condition);
	}
	
	
}
