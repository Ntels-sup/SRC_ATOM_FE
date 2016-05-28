/*****************************************************************************************
 * Copyright (c) 2012 nTels, All rights reserved.
 *
 * com.ntels.avocado.dao.ofcs.history.execute.CdrExecuteHistoryMapper.java 
 * Mapper 클래스
 * 
 * 사용 방법:
 * <pre>
 *    사용 방법을 넣어 주세요.
 *    여러줄이라도 상관 없습니다.
 * </pre>
 *
 * @저자  : Kidae, Kim
 * @버전  :
 * @작성일 : 2012.08.30
 *   
 * @작업 완료
 *    XXXX-XX-XX : -------
 *  
 * @작업중
 *    ---------
 ******************************************************************************************/
package com.ntels.avocado.dao.atom.general.backup.backuprestore;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.general.backup.backuprestore.Condition;
import com.ntels.avocado.domain.atom.general.backup.backuprestore.PackageDomain;

// TODO: Auto-generated Javadoc
/**
 * The Interface PackageMapper.
 */
@Component
public interface PackageMapper {
	
	List<PackageDomain> listMntGroup();
	
	List<PackageDomain> listBackupHist(@Param("pkgDomain") PackageDomain packageDomain);
	
	/**
	 * Gets the file list.
	 *
	 * @param system_id the system_id
	 * @param language the language
	 * @return the file list
	 */
	List<Map<String,Object>> getFileList(@Param("condition") Condition condition);
	
	
	

	int insertSample1( PackageDomain sample );
	int insertSample2( PackageDomain sample );
}