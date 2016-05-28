package com.ntels.avocado.dao.atom.general.schedulerhist;

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

import com.ntels.avocado.domain.atom.general.schedulerhist.Condition;
import com.ntels.avocado.domain.atom.general.schedulerhist.SchedulerHistDomain;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/root-context.xml",
        "classpath:/junit_test/datasource-config.xml"
})
@WebAppConfiguration
public class SchedulerHistMapperTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private SchedulerHistMapper schedulerHistMapper;

	private Condition condition 	= null;
	
	@Before
	public void setUp() {
		condition = new Condition();
	}
	
	@Test
	public void testListPackageName() {

		List<SchedulerHistDomain> list = schedulerHistMapper.listPackageName(condition);

		logger.debug( "package list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( "package list", list.size()>0 );
	}
	
	@Test
	public void testListGroupName() {

		String pkg_name = "ATOM";
		condition.setPkg_name(pkg_name);
		
		List<SchedulerHistDomain> list = schedulerHistMapper.listGroupName(condition);

		logger.debug( "group list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( "group list", list.size()>0 );
	}
	
	@Test
	public void testListJobName() {

		String pkg_name 	= "ATOM";
		String group_name 	= "groupNm";
		
		condition.setPkg_name(pkg_name);
		condition.setGroup_name(group_name);
		
		List<SchedulerHistDomain> list = schedulerHistMapper.listJobName(condition);

		logger.debug( "job list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( "job list", list.size()>0 );
	}
	
	@Ignore
	public void testList_이력리스트_한글_시작시간() {

		int start 			= 0;
		int end 			= 20;
		
		String language		= "ko";
		String gubun		= "start";
		
		String startDate	= "2016-04-01 01:12:00";
		String endDate		= "9999-04-01 01:12:59";
		String pkg_name		= "ATOM";

		condition.setStart( start );
		condition.setEnd( end );
		condition.setStartDate(startDate);
		condition.setEndDate(endDate);
		condition.setPkg_name(pkg_name);
		condition.setLanguage(language);
		condition.setGubun(gubun);
		
		List<SchedulerHistDomain> list = schedulerHistMapper.list(condition,condition.getStart(),condition.getEnd());

		logger.debug( "scheduler history list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( "한글 로케일, 시작 시간 기준으로 검색", list.size()>0 );
	}
	
	@Ignore
	public void testList_이력리스트_한글_종료시간() {

		int start 			= 0;
		int end 			= 20;
		
		String language		= "ko";
		String gubun		= "end";

		
		String startDate	= "2016-04-30 01:12:00";
		String endDate		= "9999-04-01 01:12:59";
		
		String pkg_name		= "ATOM";

		condition.setStart( start );
		condition.setEnd( end );
		condition.setStartDate(startDate);
		condition.setEndDate(endDate);
		condition.setPkg_name(pkg_name);
		condition.setLanguage(language);
		condition.setGubun(gubun);
		
		List<SchedulerHistDomain> list = schedulerHistMapper.list(condition,condition.getStart(),condition.getEnd());

		logger.debug( "scheduler history list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( "한글 로케일, 종료시간기준으로 검색", list.size()>0 );
	}
	
	@Ignore
	public void testList_이력리스트_영문_시작시간() {

		int start 			= 0;
		int end 			= 20;
		
		String language		= "en";
		String gubun		= "start";
		
		String startDate	= "04.01.2016 01:12:00";
		String endDate		= "01.01.2017 01:12:59";
		String pkg_name		= "ATOM";

		condition.setStart( start );
		condition.setEnd( end );
		condition.setStartDate(startDate);
		condition.setEndDate(endDate);
		condition.setPkg_name(pkg_name);
		condition.setLanguage(language);
		condition.setGubun(gubun);
		
		List<SchedulerHistDomain> list = schedulerHistMapper.list(condition,condition.getStart(),condition.getEnd());

		logger.debug( "scheduler history list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( "영문 로케일, 시작시간 기준으로 검색", list.size()>0 );
	}
	
	@Ignore
	public void testList_이력리스트_영문_종료시간() {

		int start 			= 0;
		int end 			= 20;
		
		String language		= "en";
		String gubun		= "end";
		
		String startDate	= "04.01.2016 01:12:00";
		String endDate		= "01.01.2017 01:12:59";
		String pkg_name		= "ATOM";

		condition.setStart( start );
		condition.setEnd( end );
		condition.setStartDate(startDate);
		condition.setEndDate(endDate);
		condition.setPkg_name(pkg_name);
		condition.setLanguage(language);
		condition.setGubun(gubun);
		
		List<SchedulerHistDomain> list = schedulerHistMapper.list(condition,condition.getStart(),condition.getEnd());

		logger.debug( "scheduler history list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( "영문 로케일, 종료시간 기준으로 검색", list.size()>0 );
	}

	@Ignore
	public void testCount_한글_시작시간_기준으로_검색() {

		int start 			= 0;
		int end 			= 20;
		
		String language		= "ko";
		String gubun		= "start";
		
		String startDate	= "2016-04-01 01:12:00";
		String endDate		= "2017-12-30 01:12:59";
		String pkg_name		= "ATOM";

		condition.setStart( start );
		condition.setEnd( end );
		condition.setStartDate(startDate);
		condition.setEndDate(endDate);
		condition.setPkg_name(pkg_name);
		condition.setLanguage(language);
		condition.setGubun(gubun);
		
		int count = schedulerHistMapper.count(condition);

		logger.debug( "scheduler history count : " + count );
		
		assertTrue( "한글 로케일, 시작시간 기준으로 검색", count>0 );
	}

	@Ignore
	public void testCount_한글_종료시간_기준으로_검색() {

		String language		= "ko";
		String gubun		= "end";

		String startDate	= "2016-04-01 01:12:00";
		String endDate		= "2017-12-30 01:12:59";
		
		String pkg_name		= "ATOM";

		condition.setStartDate(startDate);
		condition.setEndDate(endDate);
		condition.setPkg_name(pkg_name);
		condition.setLanguage(language);
		condition.setGubun(gubun);
		
		int count = schedulerHistMapper.count(condition);

		logger.debug( "scheduler history count : " + count );
		
		assertTrue( "한글 로케일, 종료시간 기준으로 검색", count>0 );
	}

	@Ignore
	public void testCount_영문_시작시간_기준으로_검색() {

		int start 			= 0;
		int end 			= 20;
		
		String language		= "en";
		String gubun		= "start";
		
		String startDate	= "04.01.2016 01:12:00";
		String endDate		= "01.01.2017 01:12:59";
		String pkg_name		= "ATOM";

		condition.setStart( start );
		condition.setEnd( end );
		condition.setStartDate(startDate);
		condition.setEndDate(endDate);
		condition.setPkg_name(pkg_name);
		condition.setLanguage(language);
		condition.setGubun(gubun);
		
		int count = schedulerHistMapper.count(condition);

		logger.debug( "scheduler history count : " + count );
		
		assertTrue( "영문 로케일, 시작시간 기준으로 검색", count>0 );
	}

	@Ignore
	public void testCount_영문_종료시간_기준으로_검색() {

		int start 			= 0;
		int end 			= 20;
		
		String language		= "en";
		String gubun		= "end";
		
		String startDate	= "04.01.2016 01:12:00";
		String endDate		= "01.01.2017 01:12:59";
		String pkg_name		= "ATOM";

		condition.setStart( start );
		condition.setEnd( end );
		condition.setStartDate(startDate);
		condition.setEndDate(endDate);
		condition.setPkg_name(pkg_name);
		condition.setLanguage(language);
		condition.setGubun(gubun);
		
		int count = schedulerHistMapper.count(condition);

		logger.debug( "scheduler history count : " + count );
		
		assertTrue( "영문 로케일, 종료시간 기준으로 검색", count>0 );
	}

	@Ignore
	public void testListExcel() {
		
		String language		= "en";
		String gubun		= "end";
		
		String startDate	= "04.01.2016 01:12:00";
		String endDate		= "01.01.2017 01:12:59";
		String pkg_name		= "ATOM";

		condition.setStartDate(startDate);
		condition.setEndDate(endDate);
		condition.setPkg_name(pkg_name);
		condition.setLanguage(language);
		condition.setGubun(gubun);
		
		List<LinkedHashMap<String, String>> list = schedulerHistMapper.listExcel(condition);

		logger.debug( "scheduler history excel list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( list.size()>0 );
	}

	@Ignore
	public void testDummy() {
		assertTrue(true);
	}

}
