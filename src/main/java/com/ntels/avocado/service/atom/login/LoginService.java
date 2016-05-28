package com.ntels.avocado.service.atom.login;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.Reader;
import java.sql.Connection;
import java.text.ParseException;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.ibatis.jdbc.ScriptRunner;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;

import com.ntels.avocado.common.Consts;
import com.ntels.avocado.dao.atom.history.login.LoginHistoryExtendedMapper;
import com.ntels.avocado.dao.atom.login.LoginMapper;
import com.ntels.avocado.dao.common.CommonCodeMapper;
import com.ntels.avocado.domain.atom.history.login.LoginHistoryExtended;
import com.ntels.avocado.domain.atom.login.IpBandwidth;
import com.ntels.avocado.domain.atom.login.LoginDomain;
import com.ntels.avocado.domain.common.SessionUser;
import com.ntels.avocado.exception.AtomException;
import com.ntels.avocado.service.common.CommonService;
import com.ntels.ncf.utils.StringUtils;
import com.ntels.ncf.utils.crypto.Sha256Util;

@Service("loginService")
public class LoginService {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private LoginMapper loginMapper;
    
    @Autowired
    private LoginHistoryExtendedMapper loginHistoryMapper;
    
	@Autowired
	private CommonCodeMapper commonCodeMapper;    
    
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private CookieLocaleResolver localeResolver;
	
	public int changePasswordAction(
			String userId,
			String current_password,
			String new_password) {

		LoginDomain loginUser = loginMapper.searchLoginUserInfo(userId, Sha256Util.getEncrypt(current_password));
		
		if (loginUser != null) { //로
			return loginMapper.updatePassword(userId, Sha256Util.getEncrypt(new_password),loginUser.getPasswdLifeCycle());
		}
		else {
			return -1;
		}
	}
	
	/**
	 * 로그인 처리 프로세스
	 * @param userId
	 * @param password
	 * @param request
	 * @param servletContext
	 * @return   0 : 로그인 성공
	 *           1 : 로그인 실패 (패스워드 실패)
	 *           2 : 로그인 실패 (없는 계정)
	 *           5 : config.properties 설정 파일 에러
	 *         100 : 필수파라메터(아아디 / 비번) null 에러
	 *         200 : 총 접속 유저수 제한
	 *         300 : 사용자 계정 잠김 여부
	 *         400 : 중복 접속 유저인지 여부
	 *         500 : 접속 IP 확인
	 *         600 : 계정기한 기한 만료 
	 *         700 : 계정기한 만료하기전 알림(노티)
	 *         800 : 패스워드 기간 만료하기전 알림(노티)
	 *         900 : 모름
	 * @throws PfnmException
	 * @throws ParseException 
	 */
	@Transactional 
    public int loginAction(
    		String userId, 
    		String password, 
    		HttpServletRequest request, 
    		ServletContext servletContext) throws ParseException {
    	
		// 1. ID와 Password가 존재하는지 확인
		if ((StringUtils.isEmpty(userId)) || (StringUtils.isEmpty(password))) {
        	logger.debug("▶▷▶▷input data (userId): " + userId + " (password): " + password);
        	return Consts.LOGIN_RESULT.FAIL_PARAM;
        }
        
		// 2. 로그인 사용자 정보 생성
        LoginHistoryExtended loginHistory  = new LoginHistoryExtended();
        String remoteAddress 	= request.getRemoteAddr(); //접속 아이피
    	String dateNow 			= commonCodeMapper.getSysDate("%Y%m%d"); //날짜
        String timeNow 			= commonCodeMapper.getSysDateTypeII("%H%i%s", 1, 8); //시간
        
        loginHistory.setLoginDate( dateNow + " " + timeNow );
    	loginHistory.setInout( Consts.LOGIN_INOUT.IN );
    	loginHistory.setLoginId(userId);
    	loginHistory.setLoginIp( remoteAddress );
        loginHistory.setLoginClientType( Consts.LOGIN_CLIENT_TYPE.WEB );
        
        logger.debug("▶▷▶▷remoteAddress : " + remoteAddress);
        logger.debug("▶▷▶▷dateNow : " + dateNow);
        logger.debug("▶▷▶▷timeNow : " + timeNow);
        logger.debug(" userId : " + userId);
        logger.debug(" password : " + password);
        
        // 3. 사용자 아이디로 사용자가 존재하는지 조회
        if (loginMapper.countUser(userId) > 0) { //계정 존재
        	
        	String ipBandwidth = isPassIP_Bandwidth(remoteAddress);
        	
        	logger.debug( "[mirinae.maru] IP 접속 확인");
        	logger.debug( "[mirinae.maru] remoteAddress : " + remoteAddress +"\t" + ipBandwidth );
        	logger.debug( "[mirinae.maru] ipBandwidth : " + ipBandwidth );
        	
        	// IP 접속 확인
            if ( ipBandwidth.equals("") ) {
            	
            	loginHistory.setLoginResult( Consts.LOGIN_RSLT.FAILURE );
                loginHistory.setDescription( Consts.LOGIN_DESCRIPTION.FAIL_IPBANDWIDTH );
                logger.debug("[mirinae.maru] ▶▷▶▷아이피접속 실패");
            	
            	loginHistoryMapper.insertLoginHistory(loginHistory);                	
                
            	return Consts.LOGIN_RESULT.FAIL_IP;
            }
            
            // 5. 로그인 실패 카운트 +1
        	loginMapper.updateLoginFailCount(userId); //접속하면 Count 1 업데이트한다.
        	
        	LoginDomain searchUserInfo = loginMapper.searchUserInfo(userId);
        	
            logger.debug("▶▷▶▷searchUserInfo : " + searchUserInfo);
            logger.debug(" retryCount : " + searchUserInfo.getRetryCount());
            logger.debug(" lockTime : " + searchUserInfo.getLockTime());
            logger.debug(" lockType : " + searchUserInfo.getLockType());
            
            
            int loginFailLimit = loginMapper.searchLoginFailLimit(userId);
        	
            logger.debug(" loginFailLimit : " + loginFailLimit);
            
            //config.propertis 설정 not found
        	if ( loginFailLimit==-1 ) 
        		return Consts.LOGIN_RESULT.FAIL_CONFIG;
        	        	
        	// 6. 로그인 실패 카운트 초과 했는지 확인
        	// limit count 체크
            if ( loginFailLimit < searchUserInfo.getRetryCount() ) { //계정 lock 업데이트 여부 확인
            	
            	logger.debug(" 무조건 락 건다. " );
            	
            	loginMapper.updateAccountLock(userId, Consts.ACCOUNT_STATUS.LOCK, Consts.STATUS_REASON.PASSWORD_LIMIT ); //무조건 락 건다.
            	
            	loginHistory.setLoginResult( Consts.LOGIN_RSLT.FAILURE );
	        	loginHistory.setDescription( Consts.LOGIN_DESCRIPTION.ACCOUNT_LOCK ); 
	        	
	        	logger.debug("▶▷▶▷account lock  : true");
            	logger.debug("▶▷▶▷LoginHistoryExtended : " + loginHistory.toString());
            	loginHistoryMapper.insertLoginHistory(loginHistory); 
            	
            	// 운영자가 LOCK해제해야 할 경우...
            	if( searchUserInfo.getLockType().equals( Consts.ACCOUNT_LOCK_TYPE.MANUAL) ) {
            		return Consts.LOGIN_RESULT.FAIL_ACCOUNT_LOCK;
            	}
            	// 일정시간 경과 후 자동 잠금해제해야 될 경우... 
            	else {
            		
            		String validLockTime = loginMapper.validLockTime(userId);
            		logger.debug("validLockTime : " + validLockTime);
            		
            		if( loginMapper.validLockTime(userId).equals(Consts.ACCOUNT_STATUS.YES) ) {
            			loginMapper.updateZeroLoginFailCount(userId); 	// LoginFailCount 0 으로 업데이트한다. 초기화한다.
            			loginMapper.updateLoginFailCountDate(userId); 	// 접속하면 Count 1 업데이트한다.
            			loginMapper.updateAccountLock(userId, Consts.ACCOUNT_STATUS.YES, Consts.STATUS_REASON.SUCCESS ); //락 초기화한다.(계정상태 정상)
            		}
            		else {
            			return Consts.LOGIN_RESULT.FAIL_ACCOUNT_LOCK;
            		}
            	}
            }
            
            logger.debug("userId : " + userId);
            logger.debug("password : " + password);
            logger.debug("encrypt password : " + Sha256Util.getEncrypt(password));
            
            //로그인 실패 횟수 초과로 계정이 잠겨있는지 검사
            if (Consts.ACCOUNT_STATUS.LOCK.equals(loginMapper.searchAccountLock(userId))) {
            	
            	loginHistory.setLoginResult( Consts.LOGIN_RSLT.FAILURE );
	        	loginHistory.setDescription( Consts.LOGIN_DESCRIPTION.ACCOUNT_LOCK ); 
	        	
	        	logger.debug("▶▷▶▷account lock  : true");
            	logger.debug("▶▷▶▷LoginHistoryExtended : " + loginHistory.toString());
            	loginHistoryMapper.insertLoginHistory(loginHistory); 
            	
                return Consts.LOGIN_RESULT.FAIL_ACCOUNT_LOCK;
            }
            
            //login check
            LoginDomain loginUser = loginMapper.searchLoginUserInfo(userId, Sha256Util.getEncrypt(password));
            
            
            if (loginUser != null) { //로그인 성공
            	
            	logger.debug("[mirinae.maru] userId, lockType : " + 
            			loginUser.getUserId() +"\t"+ 
            			loginUser.getLastLoginDate() +"\t"+ 
            			loginUser.getLockType() +"\t"+ 
            			loginUser.getAbsentLock() +"\t"+ 
            			loginUser.getAbsentLockDay() );
            	
            	// 장기 미접속 lock처리
            	if( loginUser.getLockType().equals(Consts.ACCOUNT_LOCK_TYPE.MANUAL) &&
            		loginUser.getAbsentLock().equals(Consts.ACCOUNT_STATUS.LOCK ) ) {
            		
            		// 계정 lock처리
                	loginMapper.updateAccountLock(userId, Consts.ACCOUNT_STATUS.LOCK, Consts.STATUS_REASON.ABSENT_LOCK_DAY ); //무조건 락 건다.
                	
            		loginHistory.setLoginResult( Consts.LOGIN_RSLT.FAILURE );
		        	loginHistory.setDescription( Consts.LOGIN_DESCRIPTION.ABSENT_LOCK ); 
		        	loginHistoryMapper.insertLoginHistory(loginHistory);
		        	
		        	return Consts.LOGIN_RESULT.LONGTIME_NOTLOGIN;
            	}
            	
            	// FIXME mirinae.maru 20160405 총 접속 유저수 제한(나중에 추가해야함)
                if (StringUtils.isEmpty(Consts.LOGIN.SESSION_FAIL_LIMIT)) { //config.propertis 설정 not found
                	return Consts.LOGIN_RESULT.FAIL_CONFIG;
                } 
                else {
			        int countLoginSession = loginMapper.countLoginSession();
			        
			        if (countLoginSession > Integer.parseInt(Consts.LOGIN.SESSION_FAIL_LIMIT)) {
			        	
			        	loginHistory.setLoginResult( Consts.LOGIN_RSLT.FAILURE );
			        	loginHistory.setDescription( Consts.LOGIN_DESCRIPTION.MAX_SESSION ); 
			        	
			        	logger.debug( "[mirinae.maru] ▶▷▶▷Logined User Count : " + countLoginSession );
			        	logger.debug( "[mirinae.maru] ▶▷▶▷LoginHistoryExtended : " + loginHistory.toString() );
			        	
			        	loginHistoryMapper.insertLoginHistory(loginHistory);
			        	
			        	return Consts.LOGIN_RESULT.FAIL_USERCNT_LIMIT;
			        }
                }
			        
	        	logger.debug( "[mirinae.maru] 접속계정 중복검사" );
                logger.debug( "[mirinae.maru] userId : " + userId );
                logger.debug( "[mirinae.maru] remoteAddress : " + remoteAddress );            	
	            
	            // 접속 계정 중복 검사
            	if (isDuplicatedSessionLogin(userId)) {
            		
            		//loginHistory.setLoginStatus("F");
            		loginHistory.setLoginResult( Consts.LOGIN_RSLT.FAILURE );
		        	loginHistory.setDescription( Consts.LOGIN_DESCRIPTION.DUPL_USER ); 
	            	
		        	logger.debug("LOGIN_RESULT : " + loginHistory.getLoginResult());
	            	
	            	loginHistoryMapper.insertLoginHistory(loginHistory);  
            		
	            	return Consts.LOGIN_RESULT.FAIL_USER_DUPL;
            	}

            	//계정 만료 확인
                if ((loginMapper.countNullAccountDate(userId) > 0) || (loginMapper.countOverAccountDate(userId) > 0)) {
                	
                	// 계정 lock처리
                	loginMapper.updateAccountLock(userId, Consts.ACCOUNT_STATUS.LOCK, Consts.STATUS_REASON.ACCOUNT_EXPIRE_DATE ); //무조건 락 건다.
                	
                	//loginHistory.setLoginStatus("F");
                	loginHistory.setLoginResult( Consts.LOGIN_RSLT.FAILURE );
                    loginHistory.setDescription( Consts.LOGIN_DESCRIPTION.ACCOUNT_EXPIRE ); 

                    logger.debug("▶▷▶▷user account  expired");
	            	logger.debug("▶▷▶▷LoginHistoryExtended : " + loginHistory.toString());           	
                	
	            	loginHistoryMapper.insertLoginHistory(loginHistory);
                	
	            	return Consts.LOGIN_RESULT.FAIL_ACCOUNT_EXPIRE;
                }
                
            	//로그인 시간 저장(비밀번호 변경주기를 위한...)
            	//loginMapper.updateLastLoginDate(userId, dateNow, timeNow);
                // TAT_USER의 LAST_LOGIN_DATE = NOW(), LOGIN_COUNT = LOGIN_COUNT+1
                int lldResult = loginMapper.updateLastLoginDate(userId, remoteAddress);
                logger.debug("lldResult : " + lldResult );
                
            	int zlfcResult = loginMapper.updateZeroLoginFailCount(userId); //LoginFailCount 0 으로 업데이트한다.
            	logger.debug("zlfcResult : " + zlfcResult );

                //session create
                HttpSession session = request.getSession(true);
                Locale locale = localeResolver.resolveLocale(request);
            	
            	//로그인 이력처리
                loginHistory.setLoginResult( Consts.LOGIN_RSLT.SUCCESS );
                loginHistory.setDescription( Consts.LOGIN_DESCRIPTION.SUCCESS );
                // 로그인에 성공하면 sessionid를 입력
                loginHistory.setSessionId(session.getId());
            	loginHistoryMapper.insertLoginHistory(loginHistory);
                                
                logger.info("---------------------- SessionUser Info start --------------------------------");
                logger.info("userId : " + loginUser.getUserId());
                logger.info("userGroup : " + loginUser.getGroupName() );
                logger.info("remoteAddress : " + remoteAddress );
                logger.info("userLevel : " + loginUser.getLevelName() );
                logger.info("userLoginDate : " + dateNow +" "+ timeNow );
                logger.info("language1 : " + request.getLocale().getLanguage() );
                logger.info("language2 : " + locale.getLanguage() );
                logger.info("country : " + request.getLocale().getCountry() );
                
                SessionUser sessionUser = new SessionUser();
                sessionUser.setUserId( loginUser.getUserId() );
                sessionUser.setUserGroup( loginUser.getGroupName() );
                sessionUser.setUserGroupNo( loginUser.getGroupNo() );
                sessionUser.setUserLevelId( loginUser.getLevelId() );
                sessionUser.setUserLevel( loginUser.getLevelName() );
                sessionUser.setUserIpAddress( remoteAddress );
                sessionUser.setUserLoginDate( dateNow +" "+ timeNow );
                sessionUser.setLanguage( locale.getLanguage() );
                sessionUser.setCountry( locale.getCountry() );
                sessionUser.setUserName( loginUser.getUserName());
                
                //sessionUser.setCountry( request.getLocale().getCountry() );
                
                Map<String, Object> map = commonService.findLocalePattern(locale.getLanguage());
        		if (map != null) {
        			sessionUser.setPatternDate((String) map.get("PATTERN_DATE"));
        			sessionUser.setPatternTime((String) map.get("PATTERN_TIME"));
        			sessionUser.setPatternMonth((String) map.get("PATTERN_MONTH"));
        		}
                logger.info("---------------------- SessionUser Info end ----------------------------------");

                session.removeAttribute( Consts.USER.SESSION_USER );
                session.setAttribute( Consts.USER.SESSION_USER, sessionUser );
                session.setAttribute("userId", loginUser.getUserId());
                session.setAttribute("loginDate", loginUser.getLastLoginDate());
                session.setAttribute("loginTime", loginUser.getLastLoginTime());
                
                //UAS address 
//                String uasGatewayAddress = (String) servletContext.getAttribute("uas.gateway.address");
//                session.setAttribute("uasGatewayAddress", uasGatewayAddress);
//                
                // FIXME mirinae.maru 이거 실행되는지 확인해야 됨.
                // session user 업데이트 또는 인서트
                if (loginMapper.countLoginSessionUser(userId, remoteAddress, session.getId()) > 0) {
            		updateLoginSessionUser(userId, session.getId(), remoteAddress, Consts.ACCOUNT_STATUS.YES);
            	} 
                else {
            		insertLoginSessionUser(userId, session.getId(), remoteAddress, Consts.ACCOUNT_STATUS.YES, ipBandwidth);
            	}  
            	
                //계정 기한 노티를 해준다. 갱신할때까지 계속 노티해준다.(만료날짜 30일전부터??)
                if((loginMapper.countNotiAccountDate(userId) > 0)) {
                	if (logger.isDebugEnabled()) logger.debug("▶▷▶▷계정만료 노티해줌");
                    return Consts.LOGIN_RESULT.NOTI_ACCOUNT_EXPIRE;
                }  
                
                // 패스워드 기한 만료가 없다. 갱신할때까지 계속 노티해준다.(만료날짜 7일전부터??)
                if((loginMapper.countNullPasswordDate(userId) > 0) || (loginMapper.countNotiPasswordDate(userId) > 0)) {
                	if (logger.isDebugEnabled()) logger.debug("▶▷▶▷패스워크 노티해줌");
                    return Consts.LOGIN_RESULT.NOTI_PASSWD_EXPIRE;
                }   
                
                // 관리자가 등록한 패스워드일 경우 알림
                if( loginUser.getDefaultPasswdYn().equals(Consts.DEFAULT_PASSWD_YN.YES) ) {
                    
                	return Consts.LOGIN_RESULT.NOTI_DEFAULT_PASSWD;
                }   
                
            	return Consts.LOGIN_RESULT.SUCCESS;
            	
            } 
            // 패스워드 오류 로그인 실패
            else { 
            	
            	logger.debug("▶▷▶▷login failed");
            	
            	// 로그인 이력처리
            	// loginHistory.setLoginStatus("F");       	            
                loginHistory.setLoginResult( Consts.LOGIN_RSLT.FAILURE );
                loginHistory.setDescription( Consts.LOGIN_DESCRIPTION.INVALID_PASSWD );
                loginHistory.setFailCount( searchUserInfo.getRetryCount() );
                
                logger.debug("▶▷▶▷LoginHistoryExtended : " + loginHistory.toString());
                
                loginHistoryMapper.insertLoginHistory(loginHistory);    
                
            	return Consts.LOGIN_RESULT.FAIL_PASSWORD;
            }
        } 
        // 계정이 없음
        else { 
        	logger.info("▶▷▶▷user id not found");
        	return Consts.LOGIN_RESULT.FAIL_ACCOUNT;
        }
        
    }    
    
    /**
     * 중복 접속 유저인지 확인 여부
     * @param userId
     * @param remoteAddress
     * @return
     */
    private boolean isDuplicatedSessionLogin(String userId) {
    	
    	LoginDomain lsu = loginMapper.searchLoginSessionUser(userId);
    		
    	if ( lsu.getLoginCount() < lsu.getLoginType() ) {
    		return false;
    	}
    	
    	return true;
    }  
    
    /**
     * 등록된 아이피가 접속아이피랑 체크 로직
     * 허용가능 IP대역이면 true 리턴
     * @param sessionUser
     * @param remoteAddress
     * @return
     */
    private String isPassIP_Bandwidth(String remoteAddress) {
    	
    	// 허용 IP 리스트
    	List<IpBandwidth> ipList = loginMapper.listIpBandwidth(Consts.IP_BANDWIDTH.ALLOW);
    	
    	IpBandwidth ib 				= null;
    	Iterator<IpBandwidth> itor 	= ipList.iterator();
    	String ipBandwidth 			= "";
    	int idx 					= -1;
    	
    	while( itor.hasNext() ) {
    		
    		logger.debug( "[mirinae.maru] remoteAddress : " + remoteAddress );
    		logger.debug( "[mirinae.maru] ( ipBandwidth.indexOf(Consts.IP_DELIM)==-1 )  : " + ( ipBandwidth.indexOf(Consts.IP_DELIM)==-1) );
    		
    		ib 			= (IpBandwidth)itor.next();
    		ipBandwidth = ib.getIp();
    		
    		// 등록된 IP대역이 full ip이면(ex. 127.0.0.1)
    		if( ipBandwidth.indexOf(Consts.IP_DELIM)==-1 ) {
    			
//    			logger.debug( "[mirinae.maru] 등록된 IP대역이 full ip이면(ex. 127.0.0.1)" + "\t"+ 
//    					ipBandwidth +"\t"+ 
//    					remoteAddress +"\t"+ 
//    					ib.getMaxSimult() +"\t"+ 
//    					ib.getSessionCnt() +"\t"+ 
//    					ipBandwidth.equals(remoteAddress));
    			
    			// 4-1. 사용자의 client IP가 허용 대역인지 확인
    			if( ipBandwidth.equals(remoteAddress) && (ib.getMaxSimult() > ib.getSessionCnt()) )
    				return ipBandwidth;
    		}
    		// 등록된 IP대역이 *를 포함하고 있으면...
    		else {
    			
    			idx = ipBandwidth.indexOf(Consts.IP_DELIM);
    			
//    			logger.debug( "[mirinae.maru] idx, remoteAddress, ipBandwidth, remoteAddress.length() : " + 
//    					idx 					+"\t"+ 
//    					remoteAddress 			+"\t"+ 
//    					ipBandwidth 			+"\t"+ 
//    					remoteAddress.length() 	+"\t"+ 
//    					(remoteAddress.length()<idx+2) 
//    			);
    			
    		
    			if (remoteAddress.length() >= idx+2) {
    			
//	    			logger.debug( ">>> " + ipBandwidth +"\t"+ remoteAddress.substring(0,idx));
//	    			logger.debug( 
//							ib.getAllowYn() +"\t"+ 
//							ib.getMaxSimult() +"\t"+ 
//							ib.getIp() +"\t"+ 
//							remoteAddress +"\t"+ 
//							ipBandwidth.indexOf(".*") +"\t"+ 
//	    					ib.getSessionCnt() +"\t"+ 
//							ipBandwidth.substring(0, idx).equals(remoteAddress.substring(0,idx)) );
			
    				// 4.2. 허용대역 IP이면 접속자 초과 하는지 확인
	    			if ( ipBandwidth.substring(0, idx).equals(remoteAddress.substring(0,idx)) && (ib.getMaxSimult() > ib.getSessionCnt()) ) {
	    				return ipBandwidth;
	    			}
	    			
    			}
    		}    		
    	}
    	
    	return Consts.EMPTY_STRING;
    }
    
    /**
     * 세션 유저 상태값 입력
     * @param userId
     * @param sessionId
     * @param remoteAddress
     * @param status
     */
    private void insertLoginSessionUser(
    		String userId, 
    		String sessionId, 
    		String remoteAddress, 
    		String status,
    		String ipBandwidth) {
		
    	LoginDomain loginSessionUser = new LoginDomain();
        
		loginSessionUser.setUserId(userId);
        loginSessionUser.setSessionId(sessionId);
        loginSessionUser.setStatus(status);
        loginSessionUser.setGatewayIp(remoteAddress);
        loginSessionUser.setIpBandwidth(ipBandwidth);
		
        loginMapper.insertLoginSessionUser(loginSessionUser);
	}    
    
	/**
	 * 세션 유저 상태값 업데이트
	 * @param userId
	 * @param sessionId
	 * @param remoteAddress
	 * @param status
	 */
	private void updateLoginSessionUser(
			String userId, 
			String sessionId,
			String remoteAddress, 
			String status) {
		LoginDomain loginSessionUser = new LoginDomain();
        loginSessionUser.setUserId(userId);
        loginSessionUser.setSessionId(sessionId);
        loginSessionUser.setStatus(status);
        loginSessionUser.setGatewayIp(remoteAddress);
        
        loginMapper.updateLoginSessionUser(loginSessionUser);
	}		
	
	/**
	 * 계정 만료 남은 일수 조회
	 * @param userId
	 * @return
	 * @throws PfnmException
	 */
	//public int searchAccountDueDate(String userId) throws AtomException {
	public int searchAccountDueDate(String userId) {
		return loginMapper.searchAccountDueDate(userId);
	}
	
	/**
	 * 패스워드 만료 남은 일수 조회
	 * @param userId
	 * @return
	 * @throws PfnmException
	 */
	//public int searchPasswordDueDate(String userId) throws AtomException {
	public int searchPasswordDueDate(String userId) {
				return loginMapper.searchPasswordDueDate(userId);
	}
	
	/**
	 * 비밀번호 오류 허용 한계
	 * @param userId
	 * @return
	 * @throws PfnmException
	 */
	public int searchLoginFailLimit(String userId) {
		return loginMapper.searchLoginFailLimit(userId);
	}
	
	/**
	 * 비밀번호 오류 횟수
	 * @param userId
	 * @return
	 * @throws PfnmException
	 */
	public int searchLoginFailCount(String userId) {
		return loginMapper.searchLoginFailCount(userId);
	}
	
	/**
	 * 로그아웃
	 * @param request
	 * @return
	 * @throws PfnmException
	 */
    public int logoutAction(HttpServletRequest request) throws AtomException {
    
    	//String resultUrl = "index";
        HttpSession session = request.getSession(false);
        if(session == null) return 0;
 
        SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
        
        logger.debug("▶▷▶▷sessionUser  : "+ sessionUser);
        
        LoginDomain loginSessionUser = new LoginDomain();
        
        loginSessionUser.setUserId(sessionUser.getUserId());
        loginSessionUser.setGatewayIp(request.getRemoteAddr());
        loginSessionUser.setStatus("N");
        loginSessionUser.setSessionId(session.getId() );
        
        logger.debug("▶▷▶▷loginSessionUser  : " + loginSessionUser);
        
        //세션 유저 상태값 업데이트
        int lsuResult = loginMapper.updateLoginSessionUser(loginSessionUser);
        
        /*private void updateLoginSessionUser(
			String userId, 
			String sessionId,
			String remoteAddress, 
			String status) {*/
        logger.debug("lsuResult : " + lsuResult );
        
        LoginHistoryExtended loginHistory = new LoginHistoryExtended();
        
        logger.debug("▶▷▶▷userId  : " + sessionUser.getUserId());
        logger.debug("▶▷▶▷loginDate : " + sessionUser.getUserLoginDate());
        
        loginHistory.setUserId(sessionUser.getUserId());
        loginHistory.setLoginClientType( Consts.LOGIN_CLIENT_TYPE.WEB ); 
        loginHistory.setLogoutResult( Consts.LOGOUT_RESULT.NORMAL ); 	// 정상적인 로그아웃
        loginHistory.setLoginDate( sessionUser.getUserLoginDate() );
        loginHistory.setInout( Consts.LOGIN_INOUT.OUT );
        
    	// 로그아웃 이력처리
        int lhResult = loginHistoryMapper.updateLoginHistory(loginHistory);        
    	logger.debug("lhResult : " + lhResult );
    	
        // session remove
        if (sessionUser != null) session.invalidate();
        
        return 0;
    }  
    
    /**
     * 접속 메뉴 권한 조회
     * @param url
     * @param user_group_id
     * @return
     * @throws PfnmException
     */
    public boolean authMenu(String userId, String password) throws AtomException {
    	
    	LoginDomain loginUser = loginMapper.searchLoginUserInfo(userId, Sha256Util.getEncrypt(password));
    	
    	if (loginUser == null) {
    		return false;
    	} 
    	else {
    		
    		logger.debug("searchLoginUserInfo userId : " + loginUser.getUserId() );
    		logger.debug("searchLoginUserInfo userName : " + loginUser.getUserName() );
    		logger.debug("searchLoginUserInfo groupNo : " + loginUser.getGroupNo() );
    		logger.debug("searchLoginUserInfo groupName : " + loginUser.getGroupName() );
    		logger.debug("searchLoginUserInfo levelId : " + loginUser.getLevelId() );
    		logger.debug("searchLoginUserInfo retruCount : " + loginUser.getRetryCount() );
    		logger.debug("searchLoginUserInfo lastLoginDate : " + loginUser.getLastLoginDate() );
    		
    		//if (loginMapper.authMenu("/pfnm/designer/online/list", loginUser.getUser_group_id()) == 0) return false;
    		// FIXME mirinae.maru 2016.04.01 menu url("/pfnm/designer/online/list")이 의미하는 것이 무엇인지 모르겠음...
    		//if (loginMapper.authMenu("/atom", loginUser.getLevelId()) == 0) return false;
    		return true;
    	}
	}
    
    @Autowired
    private DataSource dataSource;

    /*public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }*/

    private Connection getConnection() {
        // ....use dataSource to create connection
        return DataSourceUtils.getConnection(dataSource);
    }
    
    @Deprecated
    public void aaaa() throws FileNotFoundException  {
    	
    	File dir = new File("D:\\잡동사니\\cc");
		File[] fileList = dir.listFiles(); 
		File file = null;		//
		System.out.println(dir.getPath());
		//실행 파일에 select 구문이 업어야 한다.
		//실행 구문이 콜론(;)으로 끝나야 한다.
		ScriptRunner sr = new ScriptRunner(getConnection());
		Reader reader = null;
		for(int i = 0 ; i < fileList.length ; i++){
			file = fileList[i]; 
			if(file.isFile()){
				System.out.println("파일 이름 = " + file.getName());
				//reader = new BufferedReader(new FileReader(dir.getPath()+File.separator + "asas"));
				reader = new BufferedReader(new FileReader(dir.getPath()+File.separator + file.getName() ));
				sr.runScript(reader);
			}
		}
    }
    
    public String isValidUser(String userId, String sessionId) {
		return loginMapper.isValidUser(userId, sessionId);
	}
}
