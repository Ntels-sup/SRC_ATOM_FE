/*****************************************************************************************
 * Copyright (c) 2011 nTels, All rights reserved.
 *
 * com.ntels.avocado.service.atom.history.system.schedulerlog.SchedulerLogHistoryService.java 
 * xxx 하기 위한 클래스
 * 
 * 사용 방법:
 * <pre>
 *    사용 방법을 넣어 주세요.
 *    여러줄이라도 상관 없습니다.
 * </pre>
 *
 * @저자  :
 * @버전  :
 * @작성일 : 2011. 10. 26
 *   
 * @작업 완료
 *    일자 : 내역을 적으세요
 * @작업중
 *    일자 : 내역을 적으세요
 ******************************************************************************************/
package com.ntels.avocado.service.atom.general.schedulerhist;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.general.schedulerhist.SchedulerHistMapper;
import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.general.scheduler.SchedulerGroup;
import com.ntels.avocado.domain.atom.general.schedulerhist.Condition;
import com.ntels.avocado.domain.atom.general.schedulerhist.SchedulerHistDomain;
import com.ntels.avocado.exception.AtomException;
import com.ntels.ncf.utils.ParamUtil;

/**
 * The Class SchedulerLogHistoryService.
 */
@Service
public class SchedulerHistService {

//	@Autowired
//	private SchedulerHistDAO historyDAO;
	
	@Autowired
	private SchedulerHistMapper schedulerHistMapper;
	
	/**
	 * Package List.
	 *
	 * @param condition the condition
	 * @return the list
	 * 
	 * 설명 : 이력 조회
	 * @throws AtomException the pfnm exception
	 */
	public List<SchedulerHistDomain> listPackageName(
			@Param(value = "condition") Condition condition) throws AtomException {
		
		return schedulerHistMapper.listPackageName(condition);
	}
	
	/**
	 * Group List.
	 *
	 * @param condition the condition
	 * @return the list
	 * 
	 * 설명 : 이력 조회
	 * @throws AtomException the pfnm exception
	 */
	public List<SchedulerHistDomain> listGroupName(
			@Param(value = "condition") Condition condition) throws AtomException {
		
		return schedulerHistMapper.listGroupName(condition);
	}
	
	/**
	 * Group List.
	 *
	 * @param condition the condition
	 * @return the list
	 * 
	 * 설명 : 이력 조회
	 * @throws AtomException the pfnm exception
	 */
	public List<SchedulerHistDomain> listJobName(
			@Param(value = "condition") Condition condition) throws AtomException {
		
		return schedulerHistMapper.listJobName(condition);
	}
	
	/**
	 * List.
	 *
	 * @param condition the condition
	 * @return the list
	 * 
	 * 설명 : 이력 조회
	 * @throws AtomException the pfnm exception
	 */
	public Paging list(
			@Param(value = "condition") Condition condition) throws AtomException {
		
		if(ParamUtil.nullToInteger(condition.getPage()) == 0){
			condition.setPage(1);
		}
		
		condition.setStart( ((condition.getPage() - 1) * condition.getPerPage()) );
		condition.setEnd(condition.getPerPage());
		
		condition.setStartDate(condition.getStartDt() +" "+ condition.getStartTm()+":00" );
		condition.setEndDate(condition.getEndDt() +" "+ condition.getEndTm()+":59" );

		List<SchedulerHistDomain> list = schedulerHistMapper.list(condition,condition.getStart(), condition.getEnd());
		int count = schedulerHistMapper.count(condition);
		
		//결과를 DTO에 저장
		Paging paging = new Paging();
		paging.setLists(list);
		paging.setTotalCount(count);		
		paging.setPage(condition.getPage());
		paging.setPerPage(condition.getPerPage());
		
		return paging;
	}
	
	/**
	 * Count.
	 *
	 * @param condition the condition
	 * @return the int
	 * 
	 * 설명 : 조건에 맞는 이력 갯수
	 * @throws AtomException the pfnm exception
	 */
	public int count(Condition condition) throws AtomException {
		
		condition.setStartDate(condition.getStartDt() +" "+ condition.getStartTm()+":00" );
		condition.setEndDate(condition.getEndDt() +" "+ condition.getEndTm()+":59" );
		
		return schedulerHistMapper.count(condition);
	}


	public List<LinkedHashMap<String, String>> listExcel(Condition condition) throws AtomException {
		
		try {
			condition.setStartDate(condition.getStartDt() +" "+  URLDecoder.decode(condition.getStartTm(), "UTF-8")+":00" );
			condition.setEndDate(condition.getEndDt() +" "+ URLDecoder.decode(condition.getEndTm(), "UTF-8")+":59" );
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		return schedulerHistMapper.listExcel(condition);
	}

}