package com.ntels.avocado.controller.atom.general.backup.dailypolicy;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.UUID;

import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.google.gson.Gson;
import com.ntels.avocado.common.Consts;
import com.ntels.avocado.controller.atom.general.backup.dailypolicy.DailyController;
import com.ntels.avocado.domain.atom.general.backup.dailypolicy.Daily;
import com.ntels.avocado.domain.common.SessionUser;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/datasource-config.xml",
        "classpath:/junit_test/root-context.xml"
})
@WebAppConfiguration
@EnableWebMvc
public class DailyControllerTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@InjectMocks
    private DailyController dailyController;
	 
	@Autowired
    private WebApplicationContext wac;

	private MockMvc mockMvc;
	protected MockHttpSession mockSession;

	private SessionUser sessionUser;
	 
	@Before
	public void setUp() {
		
        MockitoAnnotations.initMocks(this);
        //mockMvc = MockMvcBuilders.standaloneSetup(dailyController).build();
        mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
        mockSession = new MockHttpSession(wac.getServletContext(), UUID.randomUUID().toString());
        
        sessionUser = new SessionUser();
        sessionUser.setUserId("admin");
		mockSession.setAttribute(Consts.USER.SESSION_USER, sessionUser);
		
//		MockHttpServletRequest request= new MockHttpServletRequest();
	}
	
	@Test
	public void testList() throws Exception {
		
		logger.debug( "testList start..." );
		mockMvc.perform(post("/atom/general/backup/management/daily/list")
							.session(mockSession)
							.param("node_id", "123"))
					.andExpect(status().isOk())
					.andExpect(status().is(200))
					.andReturn();
	}

	@Test
	@Transactional
	public void testSaveAction() throws Exception {
		
		logger.debug( "testSaveAction start..." );
		
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
		
		String dailyStr = new Gson().toJson(daily);
		
		logger.debug( "dailyStr : " + dailyStr );
		
		mockMvc.perform(post("/atom/general/backup/management/daily/saveAction")
							.session(mockSession)
							.param("daily", dailyStr))
					.andExpect(status().isOk());
	}

}
