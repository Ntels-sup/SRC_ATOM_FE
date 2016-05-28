/*****************************************************************************************
 * Copyright (c) 2012 nTels, All rights reserved.
 *
 * com.ntels.avocado.service.ofcs.general.target.TargetManagementService.java 
 * Service 클래스
 * 
 * 사용 방법:
 * <pre>
 *    사용 방법을 넣어 주세요.
 *    여러줄이라도 상관 없습니다.
 * </pre>
 *
 * @저자  : ejoh
 * @버전  :
 * @작성일 : 2013.3.25
 ******************************************************************************************/
package com.ntels.avocado.service.atom.general.backup.backuprestore;

import java.util.List;
import java.util.Map;

//import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.general.backup.backuprestore.TargetManagementMapper;
import com.ntels.avocado.domain.atom.general.backup.backuprestore.TargetCondition;
import com.ntels.avocado.domain.atom.general.backup.backuprestore.TargetDomain;
import com.ntels.avocado.exception.AtomException;


@Service
public class TargetManagementService {

	//private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private TargetManagementMapper targetManagementMapper;

	public List<Map<String, String>> listTargCd(){
		return this.targetManagementMapper.listTargCd();
	}
	
	public int selectListTotalCount(TargetCondition condition) throws AtomException {
		return targetManagementMapper.selectListTotalCount(condition);
	}
	
	public List<TargetDomain> selectTargetList(TargetCondition condition, int page, int perPage){
		
		int start = ((page - 1) * perPage);
		int end = perPage;
				
		return targetManagementMapper.selectTargetList(condition, start, end);		
	}

	/*public Paging selectTargetList(TargetCondition condition, int page, int perPage){
		
		int start = 0;
		int end = 0;
		
		start = (page-1)*perPage;
		end = perPage;
		
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}
		
		//paging을 위한 DTO를 생성
		List<TargetInfo> list = this.targetManagementMapper.selectTargetList(condition, start, end);
		int totalCount = this.targetManagementMapper.selectListTotalCount(condition);
		
		//결과를 DTO에 저장
		Paging paging = new Paging();
		paging.setLists(list);		
		paging.setTotalCount(totalCount);
		paging.setPage(page);
		paging.setPerPage(perPage);
		
		return paging;		
	}*/
	
	public TargetDomain selectTargetInfo(TargetCondition condition) throws AtomException {
		return this.targetManagementMapper.selectTargetInfo(condition);
	}
	
	public boolean selectTargetCount(TargetCondition condition) throws AtomException {
		return ( this.targetManagementMapper.selectTargetCount(condition) > 0 );
	}
	
	public boolean insertTargetInfo(TargetDomain targetInfo) throws AtomException {
		return ( this.targetManagementMapper.insertTargetInfo(targetInfo) > 0 );
	}
	
	public boolean updateTargetInfo(TargetDomain targetInfo) throws AtomException {
		return ( this.targetManagementMapper.updateTargetInfo(targetInfo) > 0 );
	}
	
	public boolean deleteTargetInfo(TargetCondition condition) throws AtomException {
		return ( this.targetManagementMapper.deleteTargetInfo(condition) > 0 ) ;
	}
	
	public List<Map<String, String>> selectExcelTarget() throws AtomException {
		return this.targetManagementMapper.selectExcelTarget();
	}
}