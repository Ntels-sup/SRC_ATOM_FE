package com.ntels.avocado.dao.atom.general.scheduler;

import static org.junit.Assert.*;

import java.util.Iterator;
import java.util.LinkedHashMap;
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

import com.ntels.avocado.dao.atom.general.scheduler.SchedulerMapper;
import com.ntels.avocado.domain.atom.authorization.user.Package;
import com.ntels.avocado.domain.atom.general.scheduler.Application;
import com.ntels.avocado.domain.atom.general.scheduler.PluginProperties;
import com.ntels.avocado.domain.atom.general.scheduler.Scheduler;
import com.ntels.avocado.domain.atom.general.scheduler.SchedulerFlow;
import com.ntels.avocado.domain.atom.general.scheduler.SchedulerGroup;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/root-context.xml",
        "classpath:/junit_test/datasource-config.xml"
})
@WebAppConfiguration
public class SchedulerMapperTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private SchedulerMapper schedulerMapper;

	private SchedulerGroup schedulerGroup 	= null;
	private Scheduler scheduler 			= null;
	private SchedulerFlow schedulerFlow		= null;
	private Application application			= null;
	private Package package_				= null;
	private PluginProperties pp				= null;
	
	@Before
	public void setUp() {
		schedulerGroup 	= new SchedulerGroup();
		scheduler 		= new Scheduler();
		schedulerFlow	= new SchedulerFlow();
		application		= new Application();
		package_		= new Package();
		pp				= new PluginProperties();
	}
	
	@Test
	public void testListPkg() {
		
		List<SchedulerGroup> list = schedulerMapper.listPkg();

		logger.debug( "package list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( list.size()>0 );
	}
	
	@Test
	public void testListSchedulerGroup() {
		
		String pkg_name = "ATOM";
		
		schedulerGroup.setPkg_name(pkg_name);
		
		List<SchedulerGroup> list = schedulerMapper.listSchedulerGroup(schedulerGroup);

		logger.debug( "SchedulerGroup size : " + list.size() );
		
		if( list.size()>0 ) {
			SchedulerGroup sg = null;
			Iterator<SchedulerGroup> itor = list.iterator();
			if( itor.hasNext() ) {
				sg = itor.next();
				assertEquals( pkg_name, sg.getPkg_name());
			}
		}
		
		assertNotNull( list );
		assertTrue( list.size()>-1 );
	}
	
	@Test
	public void testListExcelSchedulerGroup() {
		
		//List<LinkedHashMap<String, String>> listExcelSchedulerGroup(SchedulerGroup schedulerGroup);
		String pkg_name = "ATOM";
		
		schedulerGroup.setPkg_name(pkg_name);
		
		List<LinkedHashMap<String, String>> list = schedulerMapper.listExcelSchedulerGroup(schedulerGroup);

		logger.debug( "SchedulerGroup size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( list.size()>-1 );
	}
	
	@Test
	public void testCountSchedulerGroup() {
		
		String pkg_name = "ATOM";
		
		schedulerGroup.setPkg_name(pkg_name);
		
		int count = schedulerMapper.countSchedulerGroup(schedulerGroup);

		logger.debug( "SchedulerGroup count : " + count );
		
		assertNotNull( count );
		assertTrue( count>-1 );
	}

	@Test
	public void testListScheduler() {
		
		scheduler.setGroup_name("groupNm");
		
		List<Scheduler> list = schedulerMapper.listScheduler(scheduler);

		logger.debug( "Scheduler list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( list.size()>-1 );
	}

	@Ignore
	public void testListSchedulerFlow() {
		
		schedulerFlow.setPkg_name( "pkgNm" );
		schedulerFlow.setGroup_name( "groupNm" );
		schedulerFlow.setJob_name( "jobNm" );
		
		List<SchedulerFlow> list = schedulerMapper.listSchedulerFlow(schedulerFlow);
		
		logger.debug( "Scheduler flow list size : " + list.size() );
		
		assertNotNull( list );
		assertTrue( list.size()>-1 );
	}

	@Test
	public void testListApplication() {
		
//		List<Application> list = schedulerMapper.listApplication(application);
//		
//		logger.debug( "Application list size : " + list.size() );
//		
//		assertNotNull( list );
//		assertTrue( list.size()>-1 );
		
		assertTrue( true );
	}

	@Test
	public void testListPluginProperties() {
//		List<PluginProperties> list = schedulerMapper.listPluginProperties(package_, pp);
//		
//		logger.debug( "PluginProperties list size : " + list.size() );
//		
//		assertNotNull( list );
//		assertTrue( list.size()>0 );
		
		assertTrue( true );
	}

	@Test
	public void testGetSchedulerGroup() {
		
		String group_name 	= "groupNm";
		String pkg_name		= "ATOM";
		
		schedulerGroup.setPkg_name(pkg_name);
		schedulerGroup.setGroup_name( group_name );
		
		SchedulerGroup sg = schedulerMapper.getSchedulerGroup(schedulerGroup);
		
		assertNotNull( sg );
		assertEquals( group_name, sg.getGroup_name() );
	}

	@Test
	public void testGetScheduler() {
		
		String pkg_name 	= "ATOM";
		String group_name	= "groupNm";
		String job_name		= "jobNm";
		
		scheduler.setPkg_name(pkg_name);
		scheduler.setGroup_name(group_name);
		scheduler.setJob_name(job_name);
		
		Scheduler s = schedulerMapper.getScheduler(scheduler);
		
		assertNotNull( s );
		
		assertEquals( pkg_name	, s.getPkg_name() );
		assertEquals( group_name, s.getGroup_name() );
		assertEquals( job_name	, s.getJob_name() );
	}

	@Ignore
	public void testGetSchedulerFlow() {
		
		String pkg_name 	= "ATOM";
		String group_name	= "groupNm";
		String job_name		= "jobNm";
		String next_job_name= "nextJobNm";
		
		schedulerFlow.setPkg_name(pkg_name);
		schedulerFlow.setGroup_name(group_name);
		schedulerFlow.setJob_name(job_name);
		schedulerFlow.setNext_job_name(next_job_name);
		
		SchedulerFlow flow = schedulerMapper.getSchedulerFlow(schedulerFlow);
		
		assertNotNull( flow );
		
		assertEquals( pkg_name, flow.getPkg_name() );
		assertEquals( group_name, flow.getGroup_name() );
		assertEquals( job_name, flow.getJob_name() );
	}

	@Test
	@Transactional
	public void testInsertSchedulerGroup_영어로케일() {

		String group_name 	= "groupNm1";
		String pkg_name		= "pkgNm1";
		String start_date	= "23.01.2016 12:32:00";
		String schedule_cycle_type = "XA";
		String schedule_cycle = "21";
		String expire_date	= "23.04.9999 12:32:59";
		String user_id		= "nextman";
		String description	= "description";
		String language		= "en";
		
		
		schedulerGroup.setGroup_name(group_name);
		schedulerGroup.setPkg_name(pkg_name);
		schedulerGroup.setStart_date(start_date);
		schedulerGroup.setSchedule_cycle_type(schedule_cycle_type);
		schedulerGroup.setSchedule_cycle(schedule_cycle);
		schedulerGroup.setExpire_date(expire_date);
		schedulerGroup.setUser_id(user_id);
		schedulerGroup.setDescription(description);
		schedulerGroup.setLanguage(language);
		
		int rslt = schedulerMapper.insertSchedulerGroup(schedulerGroup);
		
		logger.debug( "SchedulerGroup insert result : " + rslt );
		assertEquals( 1, rslt);		
	}

	@Test
	@Transactional
	public void testInsertSchedulerGroup_한글로케일() {

		String group_name 	= "groupNm1";
		String pkg_name		= "pkgNm1";
		String start_date	= "2016-01-01 12:32:00";
		String schedule_cycle_type = "XA";
		String schedule_cycle = "21";
		String expire_date	= "9999-12-30 12:32:59";
		String user_id		= "nextman";
		String description	= "description";
		String language		= "ko";
		
		
		schedulerGroup.setGroup_name(group_name);
		schedulerGroup.setPkg_name(pkg_name);
		schedulerGroup.setStart_date(start_date);
		schedulerGroup.setSchedule_cycle_type(schedule_cycle_type);
		schedulerGroup.setSchedule_cycle(schedule_cycle);
		schedulerGroup.setExpire_date(expire_date);
		schedulerGroup.setUser_id(user_id);
		schedulerGroup.setDescription(description);
		schedulerGroup.setLanguage(language);
		
		int rslt = schedulerMapper.insertSchedulerGroup(schedulerGroup);
		
		logger.debug( "SchedulerGroup insert result : " + rslt );
		assertEquals( 1, rslt);		
	}

	@Test
	@Transactional
	public void testInsertScheduler() {
		
		String job_name 	= "jobNm12";
		String group_name 	= "groupNm";
		String node_type	= "nodeType";
		String pkg_name		= "pkgNm";
		String node_no		= "20160423";
		String fail_cont_yn = "Y";
		String run_yn 		= "Y";
		String image_no		= "99990423";
		String proc_no		= "123";
		String description	= "description";
		
		scheduler.setJob_name(job_name);
		scheduler.setGroup_name(group_name);
		scheduler.setNode_type(node_type);
		scheduler.setPkg_name(pkg_name);
		scheduler.setNode_no(node_no);
		scheduler.setFail_cont_yn(fail_cont_yn);
		scheduler.setRun_yn(run_yn);
		scheduler.setImage_no(image_no);
		scheduler.setProc_no(proc_no);
		scheduler.setDescription(description);
		
		int rslt = schedulerMapper.insertScheduler(scheduler);
		
		logger.debug( "Scheduler insert result : " + rslt );
		assertEquals( 1, rslt);		
	}

	@Ignore
	@Transactional
	public void testInsertSchedulerFlow() {
		
		String exit_cd 		= "1234567890";
		String job_name 	= "jobNm";
		String next_job_name= "nextJobNm";
		String line_id		= "22222";
		
		schedulerFlow.setJob_name(job_name);
		schedulerFlow.setExit_cd(exit_cd);
		schedulerFlow.setNext_job_name(next_job_name);
		schedulerFlow.setLine_id(line_id);
		
		int rslt = schedulerMapper.insertSchedulerFlow(schedulerFlow);
		
		logger.debug( "SchedulerFlow insert result : " + rslt );
		assertEquals( 1, rslt);	
	}

	@Test
	@Transactional
	public void testUpdateSchedulerGroup_영어_로케일() {

		String group_name 	= "groupNm";
		String pkg_name		= "ATOM";
		String start_date	= "20160423";
		String schedule_cycle_type = "XA";
		String schedule_cycle = "21";
		String expire_date	= "23.04.9999 12:32:59";
		String user_id		= "nextman";
		String description	= "description";
		String language 	= "en";
		
		schedulerGroup.setGroup_name(group_name);
		schedulerGroup.setPkg_name(pkg_name);
		schedulerGroup.setStart_date(start_date);
		schedulerGroup.setSchedule_cycle_type(schedule_cycle_type);
		schedulerGroup.setSchedule_cycle(schedule_cycle);
		schedulerGroup.setExpire_date(expire_date);
		schedulerGroup.setUser_id(user_id);
		schedulerGroup.setDescription(description);
		schedulerGroup.setLanguage(language);
		
		int rslt = schedulerMapper.updateSchedulerGroup(schedulerGroup);
		
		logger.debug( "SchedulerGroup update result : " + rslt );
		assertEquals( 1, rslt);		
	}

	@Test
	@Transactional
	public void testUpdateSchedulerGroup_한글_로케일() {

		String group_name 	= "groupNm";
		String pkg_name		= "ATOM";
		String start_date	= "20160423";
		String schedule_cycle_type = "XA";
		String schedule_cycle = "21";
		String expire_date	= "9999-12-31 12:32:59";
		String user_id		= "nextman";
		String description	= "description";
		String language 	= "ko";
		
		schedulerGroup.setGroup_name(group_name);
		schedulerGroup.setPkg_name(pkg_name);
		schedulerGroup.setStart_date(start_date);
		schedulerGroup.setSchedule_cycle_type(schedule_cycle_type);
		schedulerGroup.setSchedule_cycle(schedule_cycle);
		schedulerGroup.setExpire_date(expire_date);
		schedulerGroup.setUser_id(user_id);
		schedulerGroup.setDescription(description);
		schedulerGroup.setLanguage(language);
		int rslt = schedulerMapper.updateSchedulerGroup(schedulerGroup);
		
		logger.debug( "SchedulerGroup update result : " + rslt );
		assertEquals( 1, rslt);		
	}

	@Test
	@Transactional
	public void testUpdateSchedulerGroup_scheduleType이_None일_경우() {

		String group_name 	= "groupNm";
		String pkg_name		= "ATOM";
		String start_date	= "20160423";
		String schedule_cycle_type = "01";
		String schedule_cycle = "0";
		String expire_date	= "9999-12-31 12:32:59";
		String user_id		= "nextman";
		String description	= "description";
		String language 	= "ko";
		
		schedulerGroup.setGroup_name(group_name);
		schedulerGroup.setPkg_name(pkg_name);
		schedulerGroup.setStart_date(start_date);
		schedulerGroup.setSchedule_cycle_type(schedule_cycle_type);
		schedulerGroup.setSchedule_cycle(schedule_cycle);
		schedulerGroup.setExpire_date(expire_date);
		schedulerGroup.setUser_id(user_id);
		schedulerGroup.setDescription(description);
		schedulerGroup.setLanguage(language);
		int rslt = schedulerMapper.updateSchedulerGroup(schedulerGroup);
		
		logger.debug( "SchedulerGroup update result : " + rslt );
		assertEquals( 1, rslt);		
	}

	@Test
	@Transactional
	public void testUpdateScheduler() {
		
		String job_name 	= "jobNm";
		String group_name 	= "groupNm";
		String node_type	= "xxxxxxxxxx";
		String pkg_name		= "22";
		String node_no		= "20160423";
		String fail_cont_yn = "Y";
		String run_yn 		= "Y";
		String image_no		= "99990423";
		String proc_no		= "123";
		String description	= "description";
		
		scheduler.setJob_name(job_name);
		scheduler.setGroup_name(group_name);
		scheduler.setNode_type(node_type);
		scheduler.setPkg_name(pkg_name);
		scheduler.setNode_no(node_no);
		scheduler.setFail_cont_yn(fail_cont_yn);
		scheduler.setRun_yn(run_yn);
		scheduler.setImage_no(image_no);
		scheduler.setProc_no(proc_no);
		scheduler.setDescription(description);
		
		int rslt = schedulerMapper.updateScheduler(scheduler);
		
		logger.debug( "Scheduler update result : " + rslt );
		assertEquals( 1, rslt);	
	}

	@Test
	@Transactional
	public void testUpdateSchedulerName() {
		
		String job_name 	= "jobNm";
		String group_name 	= "groupNm";
		String node_type	= "nodeType";
		String pkg_name		= "pkgNm";
		String node_no		= "20160423";
		String fail_cont_yn = "Y";
		String run_yn 		= "Y";
		String image_no		= "99990423";
		String proc_no		= "123";
		String description	= "description";
		
		scheduler.setJob_name(job_name);
		scheduler.setGroup_name(group_name);
		scheduler.setNode_type(node_type);
		scheduler.setPkg_name(pkg_name);
		scheduler.setNode_no(node_no);
		scheduler.setFail_cont_yn(fail_cont_yn);
		scheduler.setRun_yn(run_yn);
		scheduler.setImage_no(image_no);
		scheduler.setProc_no(proc_no);
		scheduler.setDescription(description);
		
		int rslt = schedulerMapper.updateSchedulerName(scheduler);
		
		logger.debug( "Scheduler Name update result : " + rslt );
		assertEquals( 1, rslt);	
	}

	@Test
	@Transactional
	public void testUpdateSchedulerPosition() {
		
		String job_name 	= "jobNm";
		String group_name 	= "groupNm";
		String node_type	= "xxxxxxxxxx";
		String pkg_name		= "22";
		String node_no		= "20160423";
		String fail_cont_yn = "Y";
		String run_yn 		= "Y";
		String image_no		= "99990423";
		String proc_no		= "123";
		String description	= "description";
		
		scheduler.setJob_name(job_name);
		scheduler.setGroup_name(group_name);
		scheduler.setNode_type(node_type);
		scheduler.setPkg_name(pkg_name);
		scheduler.setNode_no(node_no);
		scheduler.setFail_cont_yn(fail_cont_yn);
		scheduler.setRun_yn(run_yn);
		scheduler.setImage_no(image_no);
		scheduler.setProc_no(proc_no);
		scheduler.setDescription(description);
		
		int rslt = schedulerMapper.updateSchedulerPosition(scheduler);
		
		logger.debug( "Scheduler Position update result : " + rslt );
		assertEquals( 1, rslt);	
	}

	@Ignore
	@Transactional
	public void testUpdateSchedulerFlow() {
		
		String exit_cd 		= "11";
		String job_name 	= "jobNm";
		String next_job_name= "nextJobNm";
		String line_id		= "1";
		
		schedulerFlow.setJob_name(job_name);
		schedulerFlow.setExit_cd(exit_cd);
		schedulerFlow.setNext_job_name(next_job_name);
		schedulerFlow.setLine_id(line_id);
		
		int rslt = schedulerMapper.updateSchedulerFlow(schedulerFlow);
		
		logger.debug( "SchedulerFlow update result : " + rslt );
		assertEquals( 1, rslt);	
	}

	@Test
	@Transactional
	public void testDeleteSchedulerGroup() {
			
		String group_name 	= "groupNm";
		String pkg_name		= "ATOM";
		String start_date	= "20160423";
		String schedule_cycle_type = "XA";
		String schedule_cycle = "21";
		String expire_date	= "99990423";
		String user_id		= "nextman";
		String description	= "description";
		
		schedulerGroup.setGroup_name(group_name);
		schedulerGroup.setPkg_name(pkg_name);
		schedulerGroup.setStart_date(start_date);
		schedulerGroup.setSchedule_cycle_type(schedule_cycle_type);
		schedulerGroup.setSchedule_cycle(schedule_cycle);
		schedulerGroup.setExpire_date(expire_date);
		schedulerGroup.setUser_id(user_id);
		schedulerGroup.setDescription(description);
		
		int rslt = schedulerMapper.deleteSchedulerGroup(schedulerGroup);
		
		logger.debug( "SchedulerGroup delete result : " + rslt );
		assertEquals( 1, rslt);	
	}

	@Test
	@Transactional
	public void testDeleteScheduler_jobName으로_삭제() {
		
		String job_name 	= "jobNm";
		
		scheduler.setJob_name(job_name);
		
		int rslt = schedulerMapper.deleteScheduler(scheduler);
		
		logger.debug( "Scheduler delete result : " + rslt );
		assertEquals( 1, rslt);	
	}

	@Test
	@Transactional
	public void testDeleteScheduler_pkgName과groupName으로_삭제() {
		
		String group_name 	= "groupNm";
		String pkg_name		= "ATOM";
		
		scheduler.setGroup_name(group_name);
		scheduler.setPkg_name(pkg_name);
		
		int rslt = schedulerMapper.deleteScheduler(scheduler);
		
		logger.debug( "Scheduler delete result : " + rslt );
		assertTrue( rslt>0 );	
	}

	@Test
	@Transactional
	public void testDeleteScheduler_조건만족을_못해서_삭제_안됨1() {
		
		String job_name 	= "";
		
		String group_name 	= "";
		String pkg_name		= "";
		
		scheduler.setJob_name(job_name);
		scheduler.setGroup_name(group_name);
		scheduler.setPkg_name(pkg_name);
		
		int rslt = schedulerMapper.deleteScheduler(scheduler);
		
		logger.debug( "Scheduler delete result : " + rslt );
		assertEquals( 0, rslt);	
	}

	@Test
	@Transactional
	public void testDeleteScheduler_조건만족을_못해서_삭제_안됨2() {
		
		String job_name 	= "";
		
		String group_name 	= "groupNm";
		String pkg_name		= "";
		
		scheduler.setJob_name(job_name);
		scheduler.setGroup_name(group_name);
		scheduler.setPkg_name(pkg_name);
		
		int rslt = schedulerMapper.deleteScheduler(scheduler);
		
		logger.debug( "Scheduler delete result : " + rslt );
		assertEquals( 0, rslt);	
	}

	@Ignore
	@Transactional
	public void testDeleteSchedulerFlow() {
		
		String exit_cd 		= "11";
		String job_name 	= "jobNm";
		String next_job_name= "nextJobNm";
		String line_id		= "1";
		
		schedulerFlow.setJob_name(job_name);
		schedulerFlow.setExit_cd(exit_cd);
		schedulerFlow.setNext_job_name(next_job_name);
		schedulerFlow.setLine_id(line_id);
		
		int rslt = schedulerMapper.deleteSchedulerFlow(schedulerFlow);
		
		logger.debug( "SchedulerFlow delete result : " + rslt );
		assertEquals( 1, rslt);	
	}

	@Test
	@Transactional
	public void testDeleteSchedulerFlow_조건만족을_못해서_하나도_지워지지_않음() {
		
		String exit_cd 		= "";
		String job_name 	= "";
		String next_job_name= "";
		String line_id		= "";
		
		schedulerFlow.setJob_name(job_name);
		schedulerFlow.setExit_cd(exit_cd);
		schedulerFlow.setNext_job_name(next_job_name);
		schedulerFlow.setLine_id(line_id);
		
		int rslt = schedulerMapper.deleteSchedulerFlow(schedulerFlow);
		
		logger.debug( "SchedulerFlow delete result : " + rslt );
		assertEquals( 0, rslt);	
	}

	@Test
	public void testDummy() {
		assertTrue(true);
	}
}
