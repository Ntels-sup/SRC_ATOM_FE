package com.ntels.avocado.service.atom.general.schedulerhist;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.LinkedHashMap;
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

import com.ntels.avocado.domain.Paging.Paging;
import com.ntels.avocado.domain.atom.general.schedulerhist.Condition;
import com.ntels.avocado.domain.atom.general.schedulerhist.SchedulerHistDomain;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/datasource-config.xml",
        "classpath:/junit_test/root-context.xml"
})
@WebAppConfiguration
public class SchedulerHistServiceTest {

private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private SchedulerHistService schedulerHistService;
	
	private Condition condition;
	
	@Before
	public void setUp() {
		condition = new Condition();
	}
	
	@Test
	public void testDummy() {
		assertTrue(true);
	}
	
	@Test
	public void testListPackageName() {
		
		List<SchedulerHistDomain> list = schedulerHistService.listPackageName(condition);
		
		logger.debug( "pkgName list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( list.size()>0 );
	}
	
	@Test
	public void testListGroupName() {
		
		String pkg_name		= "ATOM";
		condition.setPkg_name(pkg_name);
		
		List<SchedulerHistDomain> list = schedulerHistService.listGroupName(condition);
		
		logger.debug( "groupName list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( list.size()>0 );
	}
	
	@Test
	public void testListJobName() {

		String pkg_name		= "ATOM";
		String group_name 	= "groupNm";
		
		condition.setPkg_name(pkg_name);
		condition.setGroup_name(group_name);
		
		List<SchedulerHistDomain> list = schedulerHistService.listJobName(condition);
		
		logger.debug( "jobName list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( list.size()>0 );
	}
	
	@Test
	public void testList_영문() {
		
		int page			= 2;
		int perPage			= 10;
		String startDt		= "01.04.2016";
		String endDt		= "01.01.2017";
		String startTm		= "00:00";
		String endTm		= "23:59";
		String language		= "en";
		
		String pkg_name		= "ATOM";
		String group_name	= "groupNm";
		String job_name		= "jobNm";
		String gubun		= "start";

		condition.setPage(page);
		condition.setPerPage(perPage);
		
		condition.setStartDt(startDt);
		condition.setEndDt(endDt);
		condition.setStartTm(startTm);
		condition.setEndTm(endTm);
		condition.setLanguage(language);
		
		condition.setPkg_name(pkg_name);
		condition.setGroup_name(group_name);
		condition.setJob_name(job_name);
		condition.setGubun(gubun);
		
		Paging paging = schedulerHistService.list(condition);
		
		logger.debug( "scheduler history excel list size : " + paging.getLists().size() );
		
		assertNotNull( paging.getLists() );
		assertTrue( "영문 로케일", paging.getLists().size()>0 );
	}

	@Test
	public void testCount() {
		
		String startDt		= "01.04.2016";
		String endDt		= "01.01.2017";
		String startTm		= "00:00";
		String endTm		= "23:59";
		String language		= "en";
		
		String pkg_name		= "ATOM";
		String group_name	= "groupNm";
		String job_name		= "jobNm";
		String gubun		= "start";

		condition.setStartDt(startDt);
		condition.setEndDt(endDt);
		condition.setStartTm(startTm);
		condition.setEndTm(endTm);
		condition.setLanguage(language);
		
		condition.setPkg_name(pkg_name);
		condition.setGroup_name(group_name);
		condition.setJob_name(job_name);
		condition.setGubun(gubun);
		
		int count = schedulerHistService.count(condition);
		
		logger.debug( "scheduler history count : " + count );
		
		assertNotNull( count );
		assertTrue( "영문 로케일", count>0 );
	}

	@Test
	public void testListExcel_한글_로케일() {

		String startDt		= "2016-04-01";
		String endDt		= "2017-01-01";
		String startTm		= "00:00";
		String endTm		= "23:59";
		String language		= "ko";
		
		String pkg_name		= "ATOM";
		String group_name	= "groupNm";
		String job_name		= "jobNm";
		String gubun		= "start";

		condition.setStartDt(startDt);
		condition.setEndDt(endDt);
		condition.setStartTm(startTm);
		condition.setEndTm(endTm);
		condition.setLanguage(language);
		
		condition.setPkg_name(pkg_name);
		condition.setGroup_name(group_name);
		condition.setJob_name(job_name);
		condition.setGubun(gubun);
		
		List<LinkedHashMap<String, String>> list = schedulerHistService.listExcel(condition);
		
		logger.debug( "scheduler history excel list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( "한글 로케일", list.size()>0 );
	}

	@Test
	public void testListExcel_영문_로케일() {

		String startDt		= "01.04.2016";
		String endDt		= "01.01.2017";
		String startTm		= "00:00";
		String endTm		= "23:59";
		String language		= "en";
		
		String pkg_name		= "ATOM";
		String group_name	= "groupNm";
		String job_name		= "jobNm";
		String gubun		= "start";

		condition.setStartDt(startDt);
		condition.setEndDt(endDt);
		condition.setStartTm(startTm);
		condition.setEndTm(endTm);
		condition.setLanguage(language);
		
		condition.setPkg_name(pkg_name);
		condition.setGroup_name(group_name);
		condition.setJob_name(job_name);
		condition.setGubun(gubun);
		
		List<LinkedHashMap<String, String>> list = schedulerHistService.listExcel(condition);
		
		logger.debug( "scheduler history excel list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( "영문 로케일", list.size()>0 );
	}

}
