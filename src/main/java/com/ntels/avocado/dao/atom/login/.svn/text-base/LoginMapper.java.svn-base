package com.ntels.avocado.dao.atom.login;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ntels.avocado.domain.atom.login.IpBandwidth;
import com.ntels.avocado.domain.atom.login.LoginDomain;


@Component
public interface LoginMapper {
	
	/**
	 * 유저 아이디 존재 유무
	 * @return
	 */
	int countUser(String userId);
	
	/**
     * 접속 유저 수
     * @return
     */
    int countLoginSession();
    
    /**
     * 사용자 계정 잠김 여부 조회
     * @param userId
     * @return
     */
    String searchAccountLock(String userId);
    
    /**
     * 
     * @param userId
     * @return
     */
    String isValidUser(
    		@Param("userId") String userId,
    		@Param("sessionId") String sessionId
    );
    
    /**
     * 
     * @param userId
     * @return
     */
    LoginDomain searchUserInfo(@Param("userId") String userId);
    
    /**
     * 사용자 정보 조회
     * @param userId
     * @param password
     * @return
     */
    LoginDomain searchLoginUserInfo(
    		@Param("userId") String userId,
    		@Param("password") String password);
    
    /**
     * 중복 접속 유저인지 조회
     * @param userId
     * @param remoteAddress
     * @return
     */
    LoginDomain searchLoginSessionUser(@Param("userId") String userId);
    
    /**
     * 로그인 실패 카운터 업데이트
     * @param userId
     * @return
     */
    int updateLoginFailCount(String userId);
    
    /**
     * 비밀번호 변경
     * @param userId
     * @return
     */
    int updatePassword(
    		@Param("userId") String userId, 
    		@Param("passwd") String passwd,
    		@Param("passwdLifeCycle") String passwdLifeCycle);
    
    /**
     * 로그인 실패 카운터 업데이트
     * @param userId
     * @return
     */
    int updateLoginFailCountDate(String userId);
    
    /**
     * User 테이블에 마지막 날짜 업데이트
     * @param userId
     */
    int updateLastLoginDate(
    		@Param("userId") String userId,
    		@Param("remoteAddress") String remoteAddress
    );
    
    /**
     * User 테이블에 LOGIN_FAIL_COUNT 0 으로 업데이트
     * @param sessionUser
     */
    int updateZeroLoginFailCount(@Param("userId") String userId);
    
    /**
     * 패스워드 만료 컬럼 널(null)여부 체크
     * @param userId
     * @return
     */
    int countNullPasswordDate(String userId);
    
    /**
     * 패스워드 기한 만료 체크
     * @param userId
     * @return
     */
    int countNotiPasswordDate(String userId);
    
    /**
     * 계정 만료전 노티 해줌
     * @param userId
     * @return
     */
    int countNotiAccountDate(String userId);
    
    /**
     * 계정 만료 컬럼 널(null)여부 체크
     * @param userId
     * @return
     */
    int countNullAccountDate(String userId);
    
    /**
     * 계정 기한 만료
     * @param userId
     * @return
     */
    int countOverAccountDate(String userId);
    
    /**
     * 로그인 실패 카운터 조회
     * @param userId
     * @return
     */
    int searchLoginFailCount(String userId);
    
    /**
     * 로그인 실패 최대 카운터 조회
     * @param userId
     * @return
     */
    int searchLoginFailLimit(String userId);
    
    /**
     * 계정 락을 건다
     * @param userId
     * @return
     */
    int updateAccountLock(
    		@Param("userId") String userId, 
    		@Param("status") String status, 
    		@Param("statusReason") String statusReason
    );
    
    
    /**
     * 세션 유저 상태값 조회
     * @param userId
     * @param remoteAddress
     * @return
     */
    int countLoginSessionUser(@Param("userId") String userId
            , @Param("remoteAddress") String remoteAddress
            , @Param("sessionId") String sessionId);
    
    /**
     * 세션 유저 상태값 입력
     * @param loginSessionUser
     * @return
     */
    int insertLoginSessionUser(LoginDomain loginSessionUser);
    
    /**
     * 세션 유저 상태값 업데이트
     * @param loginSessionUser
     * @return
     */
    int updateLoginSessionUser(LoginDomain loginSessionUser);
    
    /**
     * 세션 유저 로그아웃 처리
     * @param loginSessionUser
     * @return
     */
    int destoryLogin(LoginDomain loginSessionUser);
    
    /**
     * 계정 만료 남은 일수 조회
     * @param userId
     * @return
     */
    int searchAccountDueDate(String userId);
    
    /**
     * 패스워드 만료 남은 일수 조회
     * @param userId
     * @return
     */
    int searchPasswordDueDate(String userId); 
    
    /**
     * 메뉴 권한 조회
     * @param url
     * @param user_group_id
     * @return
     */
    int authMenu(@Param("url") String url
               , @Param("levelId") String levelId); 
    
    /**
     * 패스워드 오류로 LOCK된 후 LOCK_TIME이 지나면 0, 아직 지나지 않았으면 1
     * @param userId
     * @return
     */
    String validLockTime(@Param("userId") String userId); 
    
	/**
	 * 
	 *   @return List<Map<String,Object>>
	 *   @param userId
	 *   @return
	 */
	List<Map<String, Object>> findRecent(@Param(value="userId")String userId);
    
    /**
     * 중복 접속 유저인지 조회
     * @param userId
     * @param remoteAddress
     * @return
     */
	List<IpBandwidth> listIpBandwidth(@Param("allowYn") String allowYn);
    
    /**
     * JUnit 테스트를 위한 TAT_USER update
	 * 테스트하는 쪽에서 auto rollback 되어야 함.
     * @param userId
     * @return
     */
    int updateTATUSERForTest(LoginDomain lsu);
    
    /**
     * JUnit 테스트를 위한 TAT_USER_LEVEL update
	 * 테스트하는 쪽에서 auto rollback 되어야 함.
     * @param userId
     * @return
     */
    int updateTATUSERLEVELForTest(LoginDomain lsu);
    
}
