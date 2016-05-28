/*****************************************************************************************
 * Copyright (c) 2012 nTels, All rights reserved.
 *
 * com.ntels.avocado.service.ofcs.history.execute.CdrExecuteHistoryService.java 
 * Service 클래스
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
 *    XXX-XX-XX : Finish
 * @작업중
 *    일자 : 내역을 적으세요
 ******************************************************************************************/
package com.ntels.avocado.service.atom.general.backup.backuprestore;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.general.backup.backuprestore.PackageMapper;
import com.ntels.avocado.domain.atom.general.backup.backuprestore.Condition;
import com.ntels.avocado.domain.atom.general.backup.backuprestore.PackageDomain;
import com.ntels.avocado.exception.AtomException;

// TODO: Auto-generated Javadoc
/**
 * The Class PackageService.
 */
@Service
public class PackageService {
	
	/** The package mapper. */
	@Autowired
	private PackageMapper packageMapper;
	
	/**
	 * asdf
	 *
	 * @param language the language
	 * @return the file list
	 * @throws PfnmException the pfnm exception
	 */
	public List<PackageDomain> listBackupHist(PackageDomain pkgDomain) throws AtomException {
		return packageMapper.listBackupHist(pkgDomain);
	}
	
	/**
	 * Gets the file list.
	 *
	 * @param language the language
	 * @return the file list
	 * @throws PfnmException the pfnm exception
	 */
	public List<Map<String,Object>> getFileList(Condition condition) throws AtomException {
		return packageMapper.getFileList(condition);
	}
	
	public List<PackageDomain> listMntGroup() {
		return packageMapper.listMntGroup();
	}
}