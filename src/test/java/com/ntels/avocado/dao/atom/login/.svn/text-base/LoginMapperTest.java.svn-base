package com.ntels.avocado.dao.atom.login;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Before;
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
import com.ntels.avocado.domain.atom.login.IpBandwidth;
import com.ntels.avocado.domain.atom.login.LoginDomain;
import com.ntels.ncf.utils.crypto.Sha256Util;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/root-context.xml",
        "classpath:/junit_test/datasource-config.xml"
})
@WebAppConfiguration
public class LoginMapperTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private LoginMapper loginMapper;

	private String validUserId;
	private String inValidUserId;
	
	@Before
	public void setUp() {
		validUserId = "h";
		inValidUserId = "xxx";
	}
	
	@Test
	public void testCountUser() {

		int countUser = loginMapper.countUser( validUserId );

		logger.debug( "[mirinae.maru] countUser : " + countUser );
		
		assertTrue( countUser > 0 );
	}

	@Test
	public void testCountUserFail() {

		int countUser = loginMapper.countUser( inValidUserId );

		logger.debug( "[mirinae.maru] countUser : " + countUser );
		
		assertFalse( countUser > 0 );
	}

	@Test
	public void testCountLoginSession() {
		
		int countLoginSesssion = loginMapper.countLoginSession();

		logger.debug( "[mirinae.maru] countLoginSesssion : " + countLoginSesssion );
		
		assertNotNull( "세션유저가 null이 아니어야 합니다.", countLoginSesssion );
	}

	@Test
	public void testSearchAccountLock() {
		
		String accountLock = loginMapper.searchAccountLock( validUserId );
		
		logger.debug( "[mirinae.maru] searchAccountLock accountLock : " + accountLock );
		
		assertEquals( "Y", accountLock );
		
	}

	@Test
	public void testSearchUserInfo() {
		
		LoginDomain searchUserInfo = loginMapper.searchUserInfo( validUserId );

		logger.debug( "[mirinae.maru] lastLoginDate : " + searchUserInfo.getLastLoginDate() );
		logger.debug( "[mirinae.maru] retryCount : " + searchUserInfo.getRetryCount() );

		assertNotNull( searchUserInfo.getLastLoginDate() );
		assertTrue( searchUserInfo.getRetryCount()>-1 );
	}

	@Test
	public void testSearchLoginUserInfo() {
		
		String passwd = Sha256Util.getEncrypt("1");
		
		LoginDomain lsu = loginMapper.searchLoginUserInfo(validUserId, passwd );
		
		logger.debug( "[mirinae.maru] testSearchLoginUserInfo userId : " + lsu.getUserId() );
		
		assertEquals( "h", lsu.getUserId() );
		
	}

	
	@Test
	public void testSearchLoginSessionUser() {
		
		LoginDomain sessionUser = loginMapper.searchLoginSessionUser(validUserId);
		assertNotNull(sessionUser);
	}

	@Test
	@Transactional
	@Rollback(true)	// true:rollback됨, false:commit됨
	public void testUpdateLoginFailCount() {
		int rslt = loginMapper.updateLoginFailCount( validUserId );
		
		logger.debug( "[mirinae.maru] testUpdateLoginFailCount userId : " + rslt );
		
		assertEquals(1, rslt);
	}

	@Test
	@Transactional
	public void testUpdateLastLoginDate() {
		int rslt = loginMapper.updateLastLoginDate(validUserId,"127.0.0.1");

		logger.debug( "[mirinae.maru] testUpdateLastLoginDate userId : " + rslt );
		
		assertEquals(1, rslt);
	}

	@Test
	@Transactional
	public void testUpdateZeroLoginFailCount() {
		int rslt = loginMapper.updateZeroLoginFailCount(validUserId);

		logger.debug( "[mirinae.maru] testUpdateZeroLoginFailCount userId : " + rslt );
		
		assertEquals(1, rslt);
	}

	@Test
	public void testCountNullPasswordDate() {
		int rslt = loginMapper.countNullPasswordDate(validUserId);

		logger.debug( "[mirinae.maru] testCountNullPasswordDate userId : " + rslt );
		
		assertTrue(rslt>-1);
	}

	@Test
	public void testCountNotiPasswordDate() {
		int rslt = loginMapper.countNotiPasswordDate(validUserId);

		logger.debug( "[mirinae.maru] testCountNotiPasswordDate userId : " + rslt );
		
		assertTrue(rslt>-1);
	}

	@Test
	public void testCountNotiAccountDate() {
		int rslt = loginMapper.countNotiAccountDate(validUserId);

		logger.debug( "[mirinae.maru] countNotiAccountDate rslt : " + rslt );
		
		assertTrue( rslt>-1 );
	}

	@Test
	public void testCountNullAccountDate() {
		int rslt = loginMapper.countNullAccountDate(validUserId);

		logger.debug( "[mirinae.maru] countNotiAccountDate rslt : " + rslt );
		
		assertEquals(0, rslt);
	}

	@Test
	public void testCountOverAccountDate() {
		int rslt = loginMapper.countOverAccountDate(validUserId);

		logger.debug( "[mirinae.maru] countOverAccountDate rslt : " + rslt );
		
		assertEquals(0, rslt);
	}

	@Test
	public void testSearchLoginFailCount() {
		
		int rslt = loginMapper.searchLoginFailCount(validUserId);

		logger.debug( "[mirinae.maru] searchLoginFailCount rslt : " + rslt );
		
		assertTrue(rslt>-1);
	}

	@Test
	@Transactional
	public void testUpdateAccountLock() {
		
		int rslt = loginMapper.updateAccountLock(
				validUserId, 
				Consts.ACCOUNT_STATUS.LOCK,
				Consts.STATUS_REASON.PASSWORD_LIMIT
		);

		logger.debug( "[mirinae.maru] testUpdateAccountLock rslt : " + rslt );
		
		assertEquals(1, rslt);
	}

	@Test
	public void testCountLoginSessionUser() {
		
		int rslt = loginMapper.countLoginSessionUser(validUserId, "127.0.0.1", "ACD3B42C1349E118129E9030C8BDCD14" );

		logger.debug( "[mirinae.maru] countLoginSessionUser rslt : " + rslt );
		
		assertTrue(rslt>-1);
	}

	@Test
	@Transactional
	public void testInsertLoginSessionUser() {
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId("h");
		lsu.setSessionId("dummySessionId");
		lsu.setGatewayIp("127.0.0.1");
		lsu.setStatus("0");
		lsu.setCnt(0);
		lsu.setType(0);
		
		int rslt = loginMapper.insertLoginSessionUser(lsu);

		logger.debug( "[mirinae.maru] testInsertLoginSessionUser rslt : " + rslt );
		
		assertEquals(1, rslt);
	}

	@Test
	@Transactional
	public void testUpdateLoginSessionUser() {
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId("h");
		lsu.setSessionId("dummySessionId");
		lsu.setGatewayIp("127.0.0.1");
		lsu.setStatus("0");
		lsu.setCnt(0);
		lsu.setType(0);
		
		int rslt = loginMapper.updateLoginSessionUser(lsu);

		logger.debug( "[mirinae.maru] testUpdateLoginSessionUser rslt : " + rslt );
		
		assertTrue(rslt>-1);
	}

	@Test
	public void testSearchAccountDueDate() {
		
		int rslt = loginMapper.searchAccountDueDate(validUserId);

		logger.debug( "[mirinae.maru] testSearchAccountDueDate rslt : " + rslt );
		
		assertTrue(rslt>-1);
	}

	@Test
	public void testSearchPasswordDueDate() {
		
		int rslt = loginMapper.searchPasswordDueDate(validUserId);
		logger.debug( "[mirinae.maru] testSearchPasswordDueDate rslt : " + rslt );
		
		assertTrue(rslt>-1);
	}

	@Ignore
	public void testAuthMenu() {
		
		String url 		= "";
		String levelId	= "";
		
		int rslt = loginMapper.authMenu(url, levelId);

		logger.debug( "[mirinae.maru] testAuthMenu rslt : " + rslt );
		
		assertTrue(rslt>-1);
	}
	
	@Test
	public void testListIpBandwidth() {
		
		List<IpBandwidth> list = loginMapper.listIpBandwidth(Consts.IP_BANDWIDTH.ALLOW);

		logger.debug( "[mirinae.maru] IpBandwidth list size : " + list.size() );
		
		assertTrue( list.size()>-1);
	}
	
	@Test
	public void testIsValidUser() {
		
		String isValidUser = loginMapper.isValidUser("nextman","dummySessionId");

		logger.debug( "[mirinae.maru] isValidUser : " + isValidUser );
		
		assertEquals( "N", isValidUser );
		
	}
	
	@Test
	@Transactional
	public void testUpdatePassword() {
		
		String userId = "nextman";
		String passwd = "6B86B273FF34FCE19D6B804EFF5A3F5747ADA4EAA22F1D49C01E52DDB7875B4B";
		String passwdLifeCycle = "10";
		
		int result = loginMapper.updatePassword(userId, passwd, passwdLifeCycle);
		
		assertEquals( 1, result );
	}

}
