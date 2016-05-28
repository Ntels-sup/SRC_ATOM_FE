package com.ntels.avocado.service.atom.general.backup.dailypolicy;

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

import com.ntels.avocado.domain.atom.general.backup.dailypolicy.Daily;
import com.ntels.avocado.service.atom.general.backup.dailypolicy.DailyService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/datasource-config.xml",
        "classpath:/junit_test/root-context.xml"
})
@WebAppConfiguration
public class DailyServiceTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private DailyService dailyService;
	
	@Test
	public void testDummy() {
		assertTrue(true);
	}	
	
	@Ignore
	public void testBackupInfomation() {

		String node_id = "123";
		Map<String, Object> rslt = dailyService.backupInfomation(node_id);
		
		logger.debug( "node_id : " + node_id );
		
		assertNotNull( rslt );
	}

	@Ignore
	public void testDeleteInfomation() {
		String node_id = "124";
		Map<String, Object> rslt = dailyService.deleteInfomation(node_id);
		
		logger.debug( "node_id : " + node_id );
		
		assertNotNull( rslt );
	}

	@Ignore
	@Transactional
	public void testSaveAction() {

		String user_id = "admin";
		
		Daily daily = new Daily();
		
//		daily.setNode_id(123);
		
		daily.setBackup_hour("03");
		daily.setBackup_minute("34");
		
		daily.setBackup_input_data("1");
		daily.setBackup_output_data("2");
		daily.setBackup_hist_data("3");
		daily.setBackup_stat_data("4");
		daily.setBackup_log_data("5");
		daily.setBackup_pm_data("6");
		
		daily.setBackup_setting("Y");
		
		
		daily.setDelete_hour("23");
		daily.setDelete_minute("54");
		
		daily.setDelete_input_data("1");
		daily.setDelete_output_data("2");
		daily.setDelete_hist_data("3");
		daily.setDelete_stat_data("4");
		daily.setDelete_log_data("5");
		daily.setDelete_pm_data("6");
//		daily.setDelete_backup_input_data("7");
//		daily.setDelete_backup_output_data("8");
//		daily.setDelete_backup_hist_data("9");
//		daily.setDelete_backup_stat_data("10");
//		daily.setDelete_backup_log_data("11");
//		daily.setDelete_backup_pm_data("12");
//		daily.setDelete_backup_package_data("13");
		
		daily.setDelete_setting("Y");
		
		int result = dailyService.saveAction(daily, user_id);

		logger.debug( "result : " + result );
		
		assertTrue( result>-1 );
	}

}
