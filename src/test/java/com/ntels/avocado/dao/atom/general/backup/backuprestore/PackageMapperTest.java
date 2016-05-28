package com.ntels.avocado.dao.atom.general.backup.backuprestore;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.dao.atom.general.backup.backuprestore.PackageMapper;
import com.ntels.avocado.domain.atom.general.backup.backuprestore.Condition;
import com.ntels.avocado.domain.atom.general.backup.backuprestore.PackageDomain;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/root-context.xml",
        "classpath:/junit_test/datasource-config.xml"
})
@WebAppConfiguration
public class PackageMapperTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private PackageMapper backupRestoreMapper;

	private PackageDomain packageDomain;
	
	private void insertSample() {
		
		String pkg_name 	= "ATOM";
		String node_type	= "EMS";
		String node_no		= "5";
		String result_no	= "12";
		String prc_date		= "2016-03-24";
		String group_code	= "100001";
		String description 	= "description";
		String dst_flag		= "Y";
		String category		= "CAT";
		String state		= "S";
		String backup_file	= "aaaaaaaaaaa.xls";
		String process_result = "Y";
		String backup_name	= "backupNm";
		String backup_path	= "backupPath";
		String file_size	= "12.23";
		String reg_date		= "2016-03-24";
		String reg_id		= "nextman";
		
		PackageDomain sample = new PackageDomain();
		
		// mnt_group insert
		sample.setPkg_name(pkg_name);
		sample.setNode_type(node_type);
		sample.setGroup_code(group_code);
		sample.setCategory(category);
		sample.setState(state);
		sample.setBackup_file(backup_file);
		sample.setDescription(description);
		
		int result = backupRestoreMapper.insertSample1( sample );
		logger.debug( "[mirinae.maru] sample insert result count : " + result );
		
		
		// backup history insert
		sample = new PackageDomain();
		sample.setPkg_name(pkg_name);
		sample.setNode_type(node_type);
		sample.setNode_no(node_no);
		sample.setResult_no(result_no);
		sample.setPrc_date(prc_date);
		sample.setGroup_code(group_code);
		sample.setDst_flag(dst_flag);
		sample.setProcess_result(process_result);
		sample.setBackup_name(backup_name);
		sample.setBackup_path(backup_path);
		sample.setFile_size(file_size);
		sample.setReg_date(reg_date);
		sample.setReg_id(reg_id);
		sample.setDescription(description);
		
		result = backupRestoreMapper.insertSample2( sample );
		logger.debug( "[mirinae.maru] sample2 insert result count : " + result );
	}
	
	@Before
	public void setUp() {
		packageDomain = new PackageDomain();
	}
	
	@Test
	public void testDummy() {
		assertTrue(true);
	}
	
	@Test
	@Transactional
	public void testListMntGroup() {
		
		// 테스트용 데이터 입력
		this.insertSample();
		
		List<PackageDomain> list = backupRestoreMapper.listMntGroup();
		
		logger.debug( "[mirinae.maru] listMntGroup size : " + list.size() );
		
		PackageDomain pd = null;
		Iterator<PackageDomain> itor = list.iterator();
		while( itor.hasNext() ) {
			pd = itor.next();
			logger.debug( "[mirinae.maru] mnt group list : " + pd.getPkg_name() +"\t"+ pd.getCategory() +"\t"+ pd.getGroup_code() +"\t"+ pd.getState() );
		}
		
		assertNotNull(list);
		assertTrue( list.size()>0 );
	}
	
	@Test
	@Transactional
	public void testListBackupHist() {
		
		// 테스트용 데이터 입력
		this.insertSample();
		
		String language = "en";
		
		packageDomain.setLanguage(language);
		
		List<PackageDomain> list = backupRestoreMapper.listBackupHist(packageDomain);
		
		logger.debug( "[mirinae.maru] listBackupHist size : " + list.size() );
		assertNotNull(list);
		assertTrue( list.size()>0 );
	}

	@Ignore
	public void testGetFileList() {
		String node_id 	= "123";
		String language = "en";
		
		Condition condition = new Condition();
		condition.setNode_id(node_id);
		condition.setLanguage(language);
		
		List<Map<String,Object>> fileList 
			= backupRestoreMapper.getFileList(condition);
		
		logger.debug( "fileList size : " + fileList.size() );
		
		assertNotNull(fileList);
	}
}
