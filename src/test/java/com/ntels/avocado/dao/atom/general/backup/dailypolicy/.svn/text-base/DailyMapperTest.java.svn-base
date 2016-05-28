package com.ntels.avocado.dao.atom.general.backup.dailypolicy;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Map;

import org.apache.log4j.Logger;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.dao.atom.general.backup.dailypolicy.DailyMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/root-context.xml",
        "classpath:/junit_test/datasource-config.xml"
})
@WebAppConfiguration
public class DailyMapperTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private DailyMapper dailyMapper;
	
	@Ignore
	public void testBackupInfomation_백업정보_확인() {
		
		String node_id = "123";
		Map<String,Object> backupInfomation = dailyMapper.backupInfomation(node_id);
		
		logger.debug( "node_id : " + node_id );
		logger.debug( "HOUR : " + backupInfomation.get("HOUR") );
		logger.debug( "BACKUP_INPUT_DATA : " + backupInfomation.get("BACKUP_INPUT_DATA") );
				
		assertNotNull( backupInfomation );
	}

	@Ignore
	public void testDeleteInfomation_삭제정보_확인() {
		
		String node_id = "124";
		Map<String,Object> deleteInfomation = dailyMapper.deleteInfomation(node_id);
		
		logger.debug( "node_id : " + node_id );
		logger.debug( "HOUR : " + deleteInfomation.get("HOUR") );
		logger.debug( "DELETE_INPUT_DATA : " + deleteInfomation.get("DELETE_INPUT_DATA") );
		logger.debug( "DELETE_OUTPUT_DATA : " + deleteInfomation.get("DELETE_OUTPUT_DATA") );
				
		assertNotNull( deleteInfomation );
	}

	@Ignore
	@Transactional
	public void testUpdateBackup() {
		
		int node_id				= 123;
		String backup_hour		= "12";
		String backup_minute	= "59";
		String store_data		= "";
		String backup_setting	= "Y";
		String user_id			= "admin";
		String group_code		= "110000";
		
		int updateBackupRslt = -1;
		
//		updateBackupRslt = dailyMapper.updateBackup(
//					backup_hour, 
//					backup_minute, 
//					store_data, 
//					backup_setting, 
//					node_id, 
//					user_id, 
//					group_code
//		);
		
		logger.debug( "updateBackupRslt : " + updateBackupRslt );
		
		assertTrue( updateBackupRslt>-1 );
	}

	@Ignore
	@Transactional
	public void testUpdateDelete() {
		
		int node_id				= 124;
		String delete_hour		= "09";
		String delete_minute	= "24";
		String store_data		= "";
		String delete_setting	= "D";
		String user_id			= "admin";	
		String group_code		= "110000";
		
		int updateDeleteRslt = -1;
		
//		updateDeleteRslt = dailyMapper.updateDelete(
//				delete_hour,
//				delete_minute,
//				store_data,
//				delete_setting,
//				node_id,
//				user_id,			
//				group_code
//		);
		
		logger.debug( "updateDeleteRslt : " + updateDeleteRslt );
		
		assertTrue( updateDeleteRslt>-1 );
	}
	
	
	
	@Test
	public void testDummy() {
		assertTrue(true);
	}

}
