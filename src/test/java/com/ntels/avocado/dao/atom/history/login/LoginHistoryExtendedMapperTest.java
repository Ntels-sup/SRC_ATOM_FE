package com.ntels.avocado.dao.atom.history.login;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import org.apache.log4j.Logger;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.domain.atom.history.login.LoginHistoryExtended;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/root-context.xml",
        "classpath:/junit_test/datasource-config.xml"
})
@WebAppConfiguration
public class LoginHistoryExtendedMapperTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private LoginHistoryExtendedMapper loginHistoryMapper;
	
	@Ignore
	public void testListUserGroup() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListUser() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testListAction() {
		fail("Not yet implemented");
	}

	@Ignore
	public void testCount() {
		fail("Not yet implemented");
	}

	@Test
	@Transactional
	@Rollback(true)
	public void testInsertLoginHistory() {
		
		LoginHistoryExtended loginHistory = new LoginHistoryExtended();
		
		loginHistory.setLoginId("admin");
		loginHistory.setLoginResult( Consts.LOGIN_RSLT.SUCCESS );
		loginHistory.setLoginIp("127.0.0.1");
		loginHistory.setLoginClientType( Consts.LOGIN_CLIENT_TYPE.WEB );
		loginHistory.setDescription("login history description...");
		loginHistory.setFailCount( 0 );
		loginHistory.setSessionId( "7C76C8A00499137313273CEFC74ADD69" );
		loginHistory.setInout(Consts.LOGIN_INOUT.IN);
		loginHistory.setLoginDate( "20160321 214003" );
		
		int result = loginHistoryMapper.insertLoginHistory(loginHistory);
		
		assertEquals( 1, result);
	}

	@Test
	@Transactional
	@Rollback(true)
	public void testUpdateLoginHistory() {
		
		LoginHistoryExtended loginHistory = new LoginHistoryExtended();
		
		loginHistory.setUserId("admin");
		loginHistory.setLoginClientType(Consts.LOGIN_CLIENT_TYPE.WEB);
		loginHistory.setLoginResult(Consts.LOGIN_RSLT.FAILURE);
		loginHistory.setDescription("logout history description...");
		loginHistory.setLoginDate( "20160321 214003" );
		loginHistory.setLoginIp("127.0.0.1");
		loginHistory.setInout("OUT");
		
		int result = loginHistoryMapper.updateLoginHistory(loginHistory);
		
		assertTrue( result> -1 );
	}

	@Ignore
	public void testListExcel() {
		fail("Not yet implemented");
	}

}
