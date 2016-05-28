/*****************************************************************************************
 * Copyright (c) 2012 nTels, All rights reserved.
 *
 * com.ntels.avocado.domain.pfnm.history.login.LoginHistoryExtended.java 
 * Domain 클래스
 * 
 * 사용 방법:
 * <pre>
 *    사용 방법을 넣어 주세요.
 *    여러줄이라도 상관 없습니다.
 * </pre>
 *
 * @저자  : Kidae, Kim
 * @버전  :
 * @작성일 : 2012.08.30
 *   
 * @작업 완료
 *    2012.12.11 : Finish
 * @작업중
 *    일자 : 내역을 적으세요
 ******************************************************************************************/
package com.ntels.avocado.domain.atom.history.login;

import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * The Class LoginHistoryExtended.
 */
@XStreamAlias("loginHistoryExtended")
public class LoginHistoryExtended {
	
	private String loginId;			// 로그인 시퀀스
	private String loginResult;		// 로그인 성공여부 확인이 가능
	private String logoutResult;	// 로그인 성공여부 확인이 가능
	private String loginClientType;		// 접속 경로(DEFAULT은  '0')	- 웹 '0', 서버 '1'
	private String description;
	private String loginDate;
	private String logoutDate;
	private int failCount;				// 로그인 실패 횟수
	private String userId;
	private String loginIp;
	private String inout;			// 로그인인지 아니면 로그아웃인지?
	private String sessionId;
	
	@Override
	public String toString() {
		return "LoginHistoryExtended [loginId=" + loginId + ", loginResult=" + loginResult + ", logoutResult="
				+ logoutResult + ", loginClientType=" + loginClientType + ", description=" + description
				+ ", loginDate=" + loginDate + ", logoutDate=" + logoutDate + ", failCount=" + failCount + ", userId="
				+ userId + ", loginIp=" + loginIp + ", inout=" + inout + ", sessionId=" + sessionId + "]";
	}

	public String getLoginClientType() {
		return loginClientType;
	}

	public void setLoginClientType(String loginClientType) {
		this.loginClientType = loginClientType;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getLogoutResult() {
		return logoutResult;
	}

	public void setLogoutResult(String logoutResult) {
		this.logoutResult = logoutResult;
	}

	public String getLoginResult() {
		return loginResult;
	}

	public void setLoginResult(String loginResult) {
		this.loginResult = loginResult;
	}

	public String getInout() {
		return inout;
	}

	public void setInout(String inout) {
		this.inout = inout;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(String loginDate) {
		this.loginDate = loginDate;
	}

	public String getLogoutDate() {
		return logoutDate;
	}

	public void setLogoutDate(String logoutDate) {
		this.logoutDate = logoutDate;
	}

	public int getFailCount() {
		return failCount;
	}

	public void setFailCount(int failCount) {
		this.failCount = failCount;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getLoginIp() {
		return loginIp;
	}

	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}
	
}
