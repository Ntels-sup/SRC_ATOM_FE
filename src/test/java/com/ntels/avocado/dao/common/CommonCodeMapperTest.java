package com.ntels.avocado.dao.common;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.util.List;
import java.util.Map;

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
public class CommonCodeMapperTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommonCodeMapper commonCodeMapper; 

	@Test
	public void testGetSysDate() {
		
		String format = "%Y%m%d";
		String sysDate = commonCodeMapper.getSysDate( format );

		logger.debug( "[mirinae.maru] sysDate : " + sysDate );
		
		assertNotNull( sysDate );
	}
	
	@Ignore
	public void testListSystemId() {
		fail("Not yet implemented");
	}

	@Test
	public void testListPackageId() {
		
		List<Map<String, String>> list = commonCodeMapper.listPackageId();

		logger.debug( "package list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( list.size()>0 );
	}

	@Ignore
	public void testListAlarmType() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListAlarmGroup() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListAlarmSeverity() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListAlmGroup() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListClearedFlag() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListSearchType() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetSystemCount() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testDbdatePattern() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testDbdatePatternMonth() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetSysDateTypeII() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListRscName() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testRscGrpId() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testRscUseYn() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetNowHour() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetNowMin() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetNowDate() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetNowDateTime() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListFilterGrpNm() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListStsTable() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testlistStsComboGroup() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testlistStsComboValue() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testTypeOfColumn() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListSystemName() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetViewColList() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetPkgId() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetTopCountColumn() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testGetChartColumn() {
		fail("Not yet implemented");
	}

}
