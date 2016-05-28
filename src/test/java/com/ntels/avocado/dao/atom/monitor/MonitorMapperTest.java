package com.ntels.avocado.dao.atom.monitor;

import static org.junit.Assert.*;

import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.ntels.avocado.dao.atom.login.LoginMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/root-context.xml",
        "classpath:/junit_test/datasource-config.xml"
})
@WebAppConfiguration
public class MonitorMapperTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private MonitorMapper monitorMapper;

//	private String validUserId;
//	private String inValidUserId;
	
	@Before
	public void setUp() {
//		validUserId = "h";
//		inValidUserId = "xxx";
	}
	
	@Ignore
	public void testAuthorizationAlarm() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testAlarmAll() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testAlarmTotalCount() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListAlarm() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testAlarmDetail() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testLastSound() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testSeverityCount() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testAudioSeveritySound() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testCheckAlarmAck() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testCheckAlarmUnack() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetCode() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListNodeStatus() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListTreeService() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListTreeProcess() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetProcessAlarm() {
		fail("Not yet implemented");
	}

	@Test
	public void testGetProcNo() {

		String nodeType = "EMS";
		String procName = "NM";
		
		int result = monitorMapper.getProcNo(nodeType, procName);
		logger.debug( "[mirinae.marru] nodeType, procName, procNo : " + nodeType +", "+ procName +", "+ result  );
		
		assertNotNull( result );
	}

}
