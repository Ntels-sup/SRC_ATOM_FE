package com.ntels.avocado.service.atom.general.history.backup;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.general.history.backup.BackupHitMapper;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.fault.alarmconfig.AlarmConfigDomain;
import com.ntels.avocado.domain.atom.fault.alarmhistory.AlarmHistory;
import com.ntels.avocado.domain.atom.fault.alarmhistory.AlarmHistoryDomain;
import com.ntels.avocado.domain.atom.general.history.backup.BackupHitDomain;
import com.ntels.ncf.utils.ParamUtil;

@Service
public class BackupHitService {

	@Autowired
	private BackupHitMapper backupHitMapper;
	
	public Paging listAction(BackupHitDomain condition){
		
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}
		
		condition.setStart(((condition.getPage()-1)*condition.getPerPage()));
		condition.setEnd(condition.getPerPage());
		

		List<BackupHitDomain> list = backupHitMapper.list(condition, condition.getStart(), condition.getEnd());
		int count = backupHitMapper.count(condition);
		
		
		Paging paging = new Paging();
		paging.setLists(list);
		paging.setTotalCount(count);		
		paging.setPage(condition.getPage());
		paging.setPerPage(condition.getPerPage());
		return paging;
	}
	
	public List<LinkedHashMap<String, String>> listExcel(BackupHitDomain condition){
		return backupHitMapper.listExcel(condition);
	}

	public BackupHitDomain detail(BackupHitDomain condition) {
		return backupHitMapper.detail(condition);
	}
	
	
}
