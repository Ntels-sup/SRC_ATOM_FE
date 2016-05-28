package com.ntels.avocado.service.atom.general.scheduler;

import static org.junit.Assert.assertEquals;
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
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.domain.atom.general.scheduler.Scheduler;
import com.ntels.avocado.domain.atom.general.scheduler.SchedulerFlow;
import com.ntels.avocado.domain.atom.general.scheduler.SchedulerGroup;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/datasource-config.xml",
        "classpath:/junit_test/root-context.xml"
})
@WebAppConfiguration
public class SchedulerServiceTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	private SchedulerGroup schedulerGroup 	= null;
	private Scheduler scheduler 			= null;
	private SchedulerFlow schedulerFlow		= null;
//	private Application application			= null;
//	private Package package_				= null;
//	private PluginProperties pp				= null;
	
	@Autowired
	private SchedulerService schedulerService;
	
	@Before
	public void setUp() {
		schedulerGroup 	= new SchedulerGroup();
		scheduler 		= new Scheduler();
		schedulerFlow	= new SchedulerFlow();
//		application		= new Application();
//		package_		= new Package();
//		pp				= new PluginProperties();
	}
	
	@Test
	public void testDummy() {
		assertTrue(true);
	}
	
	@Test
	public void testListPkg() {
		List<SchedulerGroup> list = schedulerService.listPkg();
		logger.debug( "[mirinae.maru] package list size : " + list.size() );
		assertNotNull( list );
	}

	@Ignore
	public void testListSchedulerGroup() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListScheduler() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListSchedulerFlow() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListApplication() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListPluginProperties() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetSchedulerGroup() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetScheduler() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetSchedulerFlow() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testInsertSchedulerGroup() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testInsertScheduler() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testInsertSchedulerFlow() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testUpdateSchedulerGroup() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testUpdateScheduler() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testUpdateSchedulerName() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testUpdateSchedulerPosition() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testUpdateSchedulerFlow() {
		fail("Not yet implemented");
	}

	@Test
	@Transactional
	public void testDeleteSchedulerGroup() {

		String pkg_name		= "ATOM";
		String group_name	= "groupNm"; 
				
		schedulerGroup.setPkg_name(pkg_name);
		schedulerGroup.setGroup_name(group_name);
		
		int result = schedulerService.deleteSchedulerGroup(schedulerGroup);
		
		assertTrue( result>0 );
	}

	@Test
	@Transactional
	public void testDeleteSchedulerGroup_조건을_만족_못해서_삭제_안됨() {

		String pkg_name		= "";
		String group_name	= ""; 
				
		schedulerGroup.setPkg_name(pkg_name);
		schedulerGroup.setGroup_name(group_name);
		
		int result = schedulerService.deleteSchedulerGroup(schedulerGroup);
		

		assertEquals( 0, result);	
	}

	@Ignore
	public void testDeleteScheduler() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testDeleteSchedulerFlow() {
		fail("Not yet implemented");
	}

}
