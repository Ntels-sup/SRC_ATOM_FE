package com.ntels.avocado.dao.atom.general.webcli;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

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

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/root-context.xml",
        "classpath:/junit_test/datasource-config.xml"
})
@WebAppConfiguration
public class WebCliMapperTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private WebCliMapper webCliMapper;

//	SchedulerGroup schedulerGroup 	= null;
//	Scheduler scheduler 			= null;
	
	@Before
	public void setUp() {
//		schedulerGroup 	= new SchedulerGroup();
//		scheduler 		= new Scheduler();
	}
	
	@Test
	public void testDummy() {
		assertTrue( true );
	}
	
	@Ignore
	public void testTableSel() {
		List<Map<String, String>> list = webCliMapper.tableSel();
		logger.debug( "[mirinae.maru] list.size : " + list.size() );
		
		assertNotNull( list );
	}

	@Ignore
	public void testXmlTable() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testXmlComponent() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetServiceName() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetProcessName() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetComponentName() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetQueueName() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetKeywords() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListCommands() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListInputFormat() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetCommand() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testSystemCount() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListHistory() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListTrace() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testDistXml() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testInsert() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testUpdate() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testSearchSystemID() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testDistSysGroup() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetAuth() {
		fail("Not yet implemented");
	}

}
