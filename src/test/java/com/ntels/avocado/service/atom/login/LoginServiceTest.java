package com.ntels.avocado.service.atom.login;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.text.ParseException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.dao.atom.login.LoginMapper;
import com.ntels.avocado.domain.atom.login.LoginDomain;
import com.ntels.avocado.domain.common.SessionUser;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={
        "classpath:/junit_test/root-context.xml",
        "classpath:/junit_test/datasource-config.xml"
})
@WebAppConfiguration
public class LoginServiceTest {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
    private ServletContext servletContext;
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private LoginMapper loginMapper;
	
	MockHttpServletRequest request;
	
	@Before
	public void setUp() {
		request = new MockHttpServletRequest();
	}
	
	@Ignore
	public void testIsValidUser() {
		
		String userId 		= "admin";
		String sessionId 	= "1";
		
		String isValidUser = loginService.isValidUser(userId, sessionId);
		
		logger.debug( "isValidUser : " + isValidUser );
		
		assertEquals( isValidUser, "N" );
	}
	
	@Test
	@Transactional
	public void testLoginAction_로그인_성공_테스트() {
		
		String userId = "admin";
		String password = "1";
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setRetryCount(0);			// 0으로 셋팅해서 로그인 실패한적이 없는것으로 셋팅
		lsu.setMaxWrongPasswd( 5 );		// 패스워드 입력오류 5회 실패시 계정 잠김
		lsu.setLockType( Consts.ACCOUNT_LOCK_TYPE.TIME );
		lsu.setLockTime( 5 );			// 단위 : 분
		lsu.setLastLoginDate( "15" );	// 단위 : 분
		
		int rslt = -1;
		
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.error( "[mirinae.maru] updateTATUSERForTest result : " + rslt );
		
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.error( "[mirinae.maru] updateTATUSERLEVELForTest result : " + rslt );
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("1.2.3.4");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		logger.error( "loginAction result : " + result );
		
		assertTrue( result>-1 );
	}
	
	@Ignore
	@Transactional
	public void testLoginAction_로그인_실패_테스트() {
		
		String userId = "admin";
		String password = "2";
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("127.0.0.1");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		logger.debug( "loginAction result : " + result );
		
		assertTrue( result>-1 );
	}

	@Ignore
	public void testSearchAccountDueDate() {

		String userId = "admin";
		int result = loginService.searchAccountDueDate(userId);

		logger.debug( "testSearchAccountDueDate result : " + result );
		
		assertTrue( result>1 );	
	}

	@Ignore
	public void testSearchPasswordDueDate() {
		String userId = "admin";
		int result = loginService.searchPasswordDueDate(userId);

		logger.debug( "testSearchPasswordDueDate result : " + result );
		
		assertTrue( result>1 );	
	}

	@Ignore
	@Transactional
	public void testLogoutAction() {
		
		HttpSession session = new MockHttpSession();
		
		SessionUser sessionUser = new SessionUser();
		sessionUser.setUserId("admin");
		session.setAttribute(Consts.USER.SESSION_USER, sessionUser);		
		
		request = new MockHttpServletRequest();
		
		request.setRemoteAddr("127.0.0.1");
		request.setSession(session);
		
		int result = loginService.logoutAction(request);

		logger.debug( "testLogoutAction result : " + result );
		
		assertTrue( result > -1 );
	}

	@Ignore
	public void testAuthMenu() {
		
		String userId = "admin";
		String password = "1";
		
		boolean result = loginService.authMenu(userId, password);

		logger.debug( "testAuthMenu result : " + result );
		
		assertFalse( result );
	}
	
	@Ignore
	@Transactional
	public void testDuplLoginAction_중복로그인_실패_테스트() {
		
		String userId 		= "nextman";// 테스트용 계정
		String password 	= "1";
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setLoginType( 5 );		// 동시 접속할 수 있는 수량
		lsu.setLoginCount( 5 );		// 현재 로그인되어 있는 계정 수량
		lsu.setRetryCount(0);			// 0으로 셋팅해서 로그인 실패한적이 없는것으로 셋팅
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setMaxWrongPasswd( 5 );		// 패스워드 입력오류 5회 실패시 계정 잠김
		lsu.setLockType( Consts.ACCOUNT_LOCK_TYPE.TIME );
		lsu.setLockTime( 5 );			// 단위 : 분
		lsu.setLastLoginDate( "15" );	// 단위 : 분
		
		int rslt = -1;
		
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERForTest result : " + rslt );
		
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERLEVELForTest result : " + rslt );
		
		
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("1.2.3.4");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );		
		
		assertEquals( "계정이 중복 로그인 할 수 있는지 검사", Consts.LOGIN_RESULT.FAIL_USER_DUPL, result );
	}
	
	@Ignore
	@Transactional
	public void testDuplLoginAction_중복로그인_실패_테스트_허용개수1() {
		
		String userId 		= "nextman";// 테스트용 계정
		String password 	= "1";
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setLoginType( 1 );			// 동시 접속할 수 있는 수량
		lsu.setLoginCount( 1 );			// 현재 로그인되어 있는 계정 수량
		lsu.setRetryCount(0);			// 0으로 셋팅해서 로그인 실패한적이 없는것으로 셋팅
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setMaxWrongPasswd( 5 );		// 패스워드 입력오류 5회 실패시 계정 잠김
		lsu.setLockType( Consts.ACCOUNT_LOCK_TYPE.TIME );
		lsu.setLockTime( 5 );			// 단위 : 분
		lsu.setLastLoginDate( "15" );	// 단위 : 분
		
		int rslt = -1;
		
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERForTest result : " + rslt );
		
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERLEVELForTest result : " + rslt );
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("192.168.2.180");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );		
		
		assertEquals( "계정이 중복 로그인 할 수 있는지 검사", Consts.LOGIN_RESULT.FAIL_USER_DUPL, result );
	}
	
	@Ignore
	@Transactional
	public void testDuplLoginAction_중복로그인_성공_테스트_허용개수1() {
		
		String userId 		= "nextman";// 테스트용 계정
		String password 	= "1";
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setLoginType( 1 );		// 동시 접속할 수 있는 수량
		lsu.setLoginCount( 0 );		// 현재 로그인되어 있는 계정 수량
		
		int rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "updateTATUSERForTest result : " + rslt );
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr( "192.168.1.123" );
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );		
		
		assertEquals( "계정이 중복 로그인 할 수 있는지 검사", Consts.LOGIN_RESULT.SUCCESS, result );
	}
	
	@Ignore
	@Transactional
	public void testDuplLoginAction_중복로그인_성공_테스트() {
		
		String userId 		= "nextman";// 테스트용 계정
		String password 	= "1";
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setLoginType( 5 );		// 동시 접속할 수 있는 수량
		lsu.setLoginCount( 4 );		// 현재 로그인되어 있는 계정 수량
		
		int rslt = loginMapper.updateTATUSERForTest(lsu);
		
		logger.debug( "updateTATUSERForTest result : " + rslt );		
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("192.168.2.234");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		assertEquals( "계정이 중복 로그인 할 수 있는지 검사", Consts.LOGIN_RESULT.SUCCESS, result );
	}
	
	@Ignore
	@Transactional
	public void test패스워드오류로_로그인_실패_테스트() {
		
		String userId 		= "nextman";// 테스트용 계정
		String password 	= "11";
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setRetryCount(0);			// 0으로 셋팅해서 로그인 실패한적이 없는것으로 셋팅
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setMaxWrongPasswd( 5 );		// 패스워드 입력오류 5회 실패시 계정 잠김
		lsu.setLockType( Consts.ACCOUNT_LOCK_TYPE.TIME );
		lsu.setLockTime( 5 );			// 단위 : 분
		lsu.setLastLoginDate( "15" );	// 단위 : 분
		
		int rslt = -1;
		
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERForTest result : " + rslt );
		
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERLEVELForTest result : " + rslt );
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("1.2.3.4");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		assertEquals( "비밀번호 오류일 경우 결과는 1", Consts.LOGIN_RESULT.FAIL_PASSWORD, result );
	}
	
	@Test
	@Transactional
	public void test_없는계정으로_로그인_시도시_결과는_2() {
		
		String userId 		= "null_id";// 테스트용 계정
		String password 	= "11";
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("1.2.3.4");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		assertEquals( "없는 계정으로 로그인 시도시 결과는 2==>", Consts.LOGIN_RESULT.FAIL_ACCOUNT, result );
	}
	
	@Ignore
	@Transactional
	public void test_비밀번호를_입력하지_않았을_경우_테스트() {
		
		String userId 		= "nextman";// 테스트용 계정
		String password 	= null;
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("1.2.3.4");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		assertEquals( "비밀번호를 입력하지 않았을 경우 결과는? ==>", Consts.LOGIN_RESULT.FAIL_PARAM, result );
	}
	
	@Ignore
	@Transactional
	public void test_아이디를_입력하지_않았을_경우_테스트() {
		
		String userId 		= "";	// 비밀번호를 입력 안함.
		String password 	= "1";
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("1.2.3.4");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		assertEquals( "아이디를 입력하지 않았을 경우 결과는? ==>", Consts.LOGIN_RESULT.FAIL_PARAM, result );
	}

	@Ignore
	@Transactional
	public void test_사용자_계정_잠김_테스트() {
		
		String userId 		= "nextman";
		String password 	= "1";
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setStatus( Consts.ACCOUNT_STATUS.LOCK );
		
		// 계정 잠그기(lock)
		int rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "updateTATUSERForTest result : " + rslt );
		
		String lock = loginMapper.searchAccountLock(userId);
		logger.debug( "account status : " + lock );
		logger.debug( "Consts.ACCOUNT_STATUS.LOCK : " + Consts.ACCOUNT_STATUS.LOCK );
		logger.debug( "lock.equals(Consts.ACCOUNT_STATUS.LOCK) : " + lock.equals(Consts.ACCOUNT_STATUS.LOCK) );
		
		MockHttpServletRequest request = new MockHttpServletRequest();
		request.setRemoteAddr("1.2.3.4");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		assertEquals( "사용자 계정 잠김 테스트 결과? ==>", Consts.LOGIN_RESULT.FAIL_ACCOUNT_LOCK, result );
	}
	
	@Ignore
	@Transactional
	public void test_계정_기한_알림_테스트() {
		
		String userId 		= "nextman";
		String password 	= "1";
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setLoginCount( 0 );
		lsu.setLoginType( 1 );
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setAccountExfire( "7" );	// 7일 후에 계정만료 셋팅
		lsu.setExfireNotiDay( "10" );   // 10일 전부터 계정만료 알림
		
		// 계정 만료 범위내로 수정
		int rslt = -1;
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "updateTATUSERForTest result : " + rslt );
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "updateTATUSERLEVELForTest result : " + rslt );
		
		MockHttpServletRequest request = new MockHttpServletRequest();
		request.setRemoteAddr("192.168.2.33");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		assertEquals( "계정 기한 알림 테스트? ==>", Consts.LOGIN_RESULT.NOTI_ACCOUNT_EXPIRE, result );
	}
	
	@Ignore
	@Transactional
	public void test_패스워드_기한_알림_테스트() {
		
		String userId 		= "nextman";
		String password 	= "1";
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setLoginCount( 0 );
		lsu.setLoginType( 1 );
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setPasswdExfire( "8" );		// 7일 후에 계정만료 셋팅
		lsu.setPasswdNotiDay( "10" );   // 10일 전부터 계정만료 알림
		
		// 계정 만료 범위내로 수정
		int rslt = -1;
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "updateTATUSERForTest result : " + rslt );
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "updateTATUSERLEVELForTest result : " + rslt );
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("192.168.2.34");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		assertEquals( "패스워드 기한 알림 테스트? ==>", Consts.LOGIN_RESULT.NOTI_PASSWD_EXPIRE, result );
	}
	
	@Ignore
	@Transactional
	public void test_패스워드_기한_지났을_경우_테스트() {
		
		String userId 		= "nextman";
		String password 	= "1";
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setLoginCount( 0 );
		lsu.setLoginType( 1 );
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setPasswdExfire( "-2" );	// 2일 전에 패스워드가 만료 되었음.
		lsu.setPasswdNotiDay( "10" );   // 10일 전부터 계정만료 알림
		
		// 계정 만료 범위내로 수정
		int rslt = -1;
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "updateTATUSERForTest result : " + rslt );
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "updateTATUSERLEVELForTest result : " + rslt );
		
		lsu = loginMapper.searchLoginSessionUser(userId);
		
		logger.debug( "[mirinae.maru] passwdExfire, accountExfire : " + lsu.getPasswdExfire() +"\t"+ lsu.getAccountExfire() );
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("192.168.2.34");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		assertEquals( "패스워드 기한이 지났을 경우 테스트? ==>", Consts.LOGIN_RESULT.NOTI_PASSWD_EXPIRE, result );
	}
	
	@Ignore
	@Transactional
	public void test_계정_만료시_잠김_처리_테스트() {
		
		String userId 		= "nextman";
		String password 	= "1";
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setLoginCount( 0 );
		lsu.setLoginType( 1 );
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setAccountExfire( "-1" );	// 계정만료일을 1일전으로 셋팅
		
		// 계정 만료 범위내로 수정
		int rslt = -1;
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "updateTATUSERForTest result : " + rslt );
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("127.0.0.1");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		assertEquals( "계정 만료시 잠김 처리 테스트? ==>", Consts.LOGIN_RESULT.FAIL_ACCOUNT_EXPIRE, result );
		
		lsu = loginMapper.searchLoginSessionUser(userId);

		logger.debug( "user status : " + lsu.getStatus() );
		
		assertEquals( "계정이 Lock되었음을 확인 ", Consts.ACCOUNT_STATUS.LOCK, lsu.getStatus() );
	}
	
	@Ignore
	@Transactional
	public void test_패스워드_오류_횟수_초과_계정_잠김_처리_테스트1_MANUAL_LOCK() {
		
		String userId 		= "nextman";
		String password 	= "1";			// 틀린 비밀번호
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setRetryCount(5);
		lsu.setMaxWrongPasswd( 5 );		// 패스워드 입력오류 5회 실패시 계정 잠김
		lsu.setLockType( Consts.ACCOUNT_LOCK_TYPE.MANUAL );
		
		int rslt = -1;
		
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "updateTATUSERForTest result : " + rslt );
		
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "updateTATUSERLEVELForTest result : " + rslt );
		
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("1.2.3.4");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		assertEquals( "계정 만료시 잠김 처리 테스트? ==>", Consts.LOGIN_RESULT.FAIL_ACCOUNT_LOCK, result );
	}
	
	@Ignore
	@Transactional
	public void test_패스워드_오류_횟수_초과_계정_잠김_처리_테스트2_MANUAL_LOCK() {
		
		String userId 		= "nextman";
		String password 	= "1";			// 틀린 비밀번호
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setRetryCount(5);
		lsu.setMaxWrongPasswd( 5 );		// 패스워드 입력오류 5회 실패시 계정 잠김
		lsu.setLockType( Consts.ACCOUNT_LOCK_TYPE.MANUAL );
		
		int rslt = -1;
		
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "updateTATUSERForTest result : " + rslt );
		
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "updateTATUSERLEVELForTest result : " + rslt );
		
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("1.2.3.4");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		lsu = loginMapper.searchLoginSessionUser(userId);

		logger.debug( "user status : " + lsu.getStatus() );
		
		assertEquals( "패스워드 오류 횟수 초과 계정 잠김 처리 테스트 2 ", Consts.ACCOUNT_STATUS.LOCK, lsu.getStatus() );
	}
	
	@Ignore
	@Transactional
	public void test_패스워드_오류_횟수_초과_계정_잠김_처리_테스트1_TIME_LOCK() {
		
		String userId 		= "nextman";
		String password 	= "1";			// 틀린 비밀번호
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setRetryCount(0);
		lsu.setMaxWrongPasswd( 5 );		// 패스워드 입력오류 5회 실패시 계정 잠김
		lsu.setLockType( Consts.ACCOUNT_LOCK_TYPE.TIME );
		lsu.setLockTime( 5 );			// 단위 : 분
		lsu.setLastLoginDate( "15" );	// 단위 : 분
		
		int rslt = -1;
		
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "updateTATUSERForTest result : " + rslt );
		
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "updateTATUSERLEVELForTest result : " + rslt );
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("127.0.0.1");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		assertEquals( "계정 만료시 잠김 처리 테스트? ==>", Consts.LOGIN_RESULT.SUCCESS, result );
	}
	
	@Ignore
	@Transactional
	public void test_패스워드_오류_횟수_초과_계정_잠김_처리_테스트2_TIME_LOCK() {
		
		String userId 		= "nextman";
		String password 	= "1";			// 틀린 비밀번호
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setRetryCount(5);
		lsu.setStatus( Consts.ACCOUNT_STATUS.LOCK );
		lsu.setMaxWrongPasswd( 5 );		// 패스워드 입력오류 5회 실패시 계정 잠김
		lsu.setLockType( Consts.ACCOUNT_LOCK_TYPE.TIME );
		lsu.setLockTime( 5 );			// 단위 : 분
		lsu.setLastLoginDate( "15" );	// 단위 : 분, 최근 로그인 시도 시간을 -15분(15분 전으로 셋팅)
		
		int rslt = -1;
		
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "updateTATUSERForTest result : " + rslt );
		
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "updateTATUSERLEVELForTest result : " + rslt );
		
		request = new MockHttpServletRequest();
		request.setRemoteAddr("127.0.0.1");
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "loginAction result : " + result );
		
		lsu = loginMapper.searchLoginSessionUser(userId);

		logger.debug( "user status : " + lsu.getStatus() );
		
		assertEquals( "패스워드 오류 횟수 초과 계정 잠김 처리 테스트 2 ", Consts.ACCOUNT_STATUS.LOCK, lsu.getStatus() );
	}
	
	@Ignore
	@Transactional
	public void test_IP_대역_테스트_로그인_가능_대역() {
		
		String userId 		= "nextman";
		String password 	= "1";
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setRetryCount(0);			// 0으로 셋팅해서 로그인 실패한적이 없는것으로 셋팅
		lsu.setMaxWrongPasswd( 5 );		// 패스워드 입력오류 5회 실패시 계정 잠김
		lsu.setLockType( Consts.ACCOUNT_LOCK_TYPE.TIME );
		lsu.setLockTime( 5 );			// 단위 : 분
		lsu.setLastLoginDate( "15" );	// 단위 : 분
		
		int rslt = -1;
		
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERForTest result : " + rslt );
		
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERLEVELForTest result : " + rslt );
		
		lsu = loginMapper.searchLoginSessionUser(userId);
		
		logger.debug( "[mirinae.maru] user status : " + lsu.getStatus() +"\t"+ lsu.getRetryCount() );
		
		request = new MockHttpServletRequest();
		
		// TAT_IP_MANAGER에 로그인 가능한 대역을 먼저 등록해야 한다.
		request.setRemoteAddr("127.0.0.1");		
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "[mirinae.maru] loginAction result : " + result );
		
		lsu = loginMapper.searchLoginSessionUser(userId);
		
		logger.debug( "[mirinae.maru] user status : " + lsu.getStatus() +"\t"+ lsu.getRetryCount() );
		
		assertEquals( "IP 대역 테스트 : 로그인 가능 대역? ==>", Consts.LOGIN_RESULT.SUCCESS, result );
	}
	
	@Ignore
	@Transactional
	public void test_IP_대역_테스트_로그인_불가능_대역() {
		
		String userId 		= "nextman";
		String password 	= "1";			// 틀린 비밀번호
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setRetryCount(0);			// 0으로 셋팅해서 로그인 실패한적이 없는것으로 셋팅
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setMaxWrongPasswd( 5 );		// 패스워드 입력오류 5회 실패시 계정 잠김
		lsu.setLockType( Consts.ACCOUNT_LOCK_TYPE.TIME );
		lsu.setLockTime( 5 );			// 단위 : 분
		lsu.setLastLoginDate( "15" );	// 단위 : 분
		
		int rslt = -1;
		
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERForTest result : " + rslt );
		
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERLEVELForTest result : " + rslt );
		
		request = new MockHttpServletRequest();
		
		// TAT_IP_MANAGER에 로그인 가능한 대역을 먼저 등록해야 한다.
		request.setRemoteAddr("192.169.1.20");		
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "[mirinae.maru] loginAction result : " + result );
		
		assertEquals( "IP 대역 테스트 : 로그인 가능 대역? ==>", Consts.LOGIN_RESULT.FAIL_IP, result );
	}
	
	@Ignore
	@Transactional
	public void test_장기_미접속시_계정_잠김_처리_테스트_LOCK_TYPE_M() {
		
		String userId 		= "nextman";
		String password 	= "1";			// 틀린 비밀번호
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setRetryCount(0);			// 0으로 셋팅해서 로그인 실패한적이 없는것으로 셋팅
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setMaxWrongPasswd( 5 );		// 패스워드 입력오류 5회 실패시 계정 잠김
		lsu.setLockType( Consts.ACCOUNT_LOCK_TYPE.MANUAL );
		lsu.setLockTime( 5 );					// 단위 : 분
		lsu.setLastLoginDate( (60*24*365)+"" );	// 60분*24시간*365일(1년전에 최종 로그인)
		lsu.setAbsentLockDay( 36 ); 			// 30일동안 미접속이면 계정 잠금
		
		int rslt = -1;
		
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERForTest result : " + rslt );
		
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERLEVELForTest result : " + rslt );
		
		lsu = loginMapper.searchLoginSessionUser(userId);
				
		logger.debug( "[mirinae.maru] lockType, accountExfire : " + lsu.getLockType() +"\t"+ lsu.getAccountExfire() );
		
		request = new MockHttpServletRequest();
		
		// TAT_IP_MANAGER에 로그인 가능한 대역을 먼저 등록해야 한다.
		request.setRemoteAddr("192.168.1.20");		
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "[mirinae.maru] loginAction result : " + result );
		
		assertEquals( "장기 미접속시 계정 잠김 처리 테스트 LOCK_TYPE=M ==>", Consts.LOGIN_RESULT.LONGTIME_NOTLOGIN, result );
	}
	
	@Ignore
	@Transactional
	public void test_관리자가_등록한_패스워드일_경우() {
		
		String userId 		= "nextman";
		String password 	= "1";			// 틀린 비밀번호
		
		LoginDomain lsu = new LoginDomain();
		lsu.setUserId( userId );
		lsu.setRetryCount(0);			// 0으로 셋팅해서 로그인 실패한적이 없는것으로 셋팅
		lsu.setStatus( Consts.ACCOUNT_STATUS.YES );
		lsu.setDefaultPasswdYn( Consts.DEFAULT_PASSWD_YN.YES );
		
		int rslt = -1;
		
		rslt = loginMapper.updateTATUSERForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERForTest result : " + rslt );
		
		rslt = loginMapper.updateTATUSERLEVELForTest(lsu);
		logger.debug( "[mirinae.maru] updateTATUSERLEVELForTest result : " + rslt );
		
		lsu = loginMapper.searchLoginSessionUser(userId);
				
		logger.debug( "[mirinae.maru] lockType, accountExfire : " + lsu.getLockType() +"\t"+ lsu.getAccountExfire() );
		
		request = new MockHttpServletRequest();
		
		// TAT_IP_MANAGER에 로그인 가능한 대역을 먼저 등록해야 한다.
		request.setRemoteAddr("192.168.1.20");		
		
		int result = -1;
		
		try {
			result = loginService.loginAction(userId, password, request, servletContext);
		} 
		catch (ParseException e) {
			e.printStackTrace();
		}

		logger.debug( "[mirinae.maru] loginAction result : " + result );
		
		assertEquals( "기본 패스워드 변경 알림 ==>", Consts.LOGIN_RESULT.NOTI_DEFAULT_PASSWD, result );
	}
}
