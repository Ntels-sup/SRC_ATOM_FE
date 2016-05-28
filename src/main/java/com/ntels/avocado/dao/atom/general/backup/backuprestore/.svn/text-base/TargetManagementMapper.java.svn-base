/*****************************************************************************************
 * Copyright (c) 2012 nTels, All rights reserved.
 *
 * com.ntels.avocado.dao.ofcs.general.target.TargetManagementMapper.java 
 * Mapper 클래스
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
package com.ntels.avocado.dao.atom.general.backup.backuprestore;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.general.backup.backuprestore.TargetCondition;
import com.ntels.avocado.domain.atom.general.backup.backuprestore.TargetDomain;


@Component
public interface TargetManagementMapper {
	
	List<Map<String, String>> listTargCd();

	List<TargetDomain> selectTargetList(@Param(value = "condition") TargetCondition condition
			,@Param(value = "start") int start,@Param(value = "end") int end );
	
	int selectListTotalCount(@Param(value = "condition") TargetCondition condition);	
	
	TargetDomain selectTargetInfo(@Param(value = "condition") TargetCondition condition);
	
	int selectTargetCount(@Param(value = "condition") TargetCondition condition);
	
	int insertTargetInfo(TargetDomain targetInfo);
	
	int updateTargetInfo(TargetDomain targetInfo);
	
	int deleteTargetInfo(@Param(value = "condition") TargetCondition condition);
	
	List<Map<String, String>> selectExcelTarget();
	
}