package com.ntels.avocado.dao.atom.general.history.backup;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.ntels.avocado.domain.atom.general.history.backup.BackupHitDomain;
// import com.ntels.avocado.domain.atom.general.history.backup.Condition;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/root-context.xml",
        "classpath:/junit_test/datasource-config.xml"
})
@WebAppConfiguration
public class BackupHitMapperTest {

private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private BackupHitMapper backupHitMapper;
	
	// private Condition condition;
	
	@Before
	public void setUp() {
		// condition = new Condition();
	}
	
	@Test
	public void testDummy() {
		assertTrue(true);
	}
	
	@Ignore
	public void testListBackupHistory() {

		int start 	= 0;
		int end		= 10;
		
		// List<BackupHitDomain> list = backupHitMapper.listBackupHistory(condition, start, end);
		
		// logger.debug( "list size : " + list.size() );

		// assertNotNull( list );		
		// assertTrue( list.size()>-1 );		
	}

	@Ignore
	public void testCount() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testSelectBackupHistory() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListExcel() {
		fail("Not yet implemented");
	}

}
