package com.ntels.avocado.service.atom.monitor;

import static org.junit.Assert.fail;

import org.apache.log4j.Logger;
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
public class MonitorServiceTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private MonitorService monitorService;
	
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
	public void testSeverityCount() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testLastSound() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testAudioSeveritySound() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testCheckAlarmConfirm() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testClearAlarmConfirm() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListNodeStatus() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListTreeDetail() {
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
		
		int result = monitorService.getProcNo(nodeType, procName);
		logger.debug( "[mirinae.marru] nodeType, procName, procNo : " + nodeType +", "+ procName +", "+ result  );
	}

}
