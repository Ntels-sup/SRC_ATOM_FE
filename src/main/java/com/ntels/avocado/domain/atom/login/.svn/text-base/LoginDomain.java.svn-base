package com.ntels.avocado.domain.atom.login;

import com.ntels.avocado.domain.common.SessionUser;
import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("loginSessionUser")
public class LoginDomain extends SessionUser {
	
	private int retryCount;
	private int cnt;	/* TAT_USER_SESSION.CNT 접속카운트 */
	
	private String userName;
	private String userPhone;
	private String userEmail;
	private String sessionId;
	private String ipBandwidth;
	private String gatewayIp;
	private String status;	/* TAT_USER_SESSION.STATUS DEFAULT는  'Y'로 설정 (Y는 세션 사용, N은 세션 강제 종료) */
	private String groupNo;
	private String levelId;
	private String groupName;
	private String levelName;
	private String accountExfire;
	private String exfireNotiDay;
	private String passwdExfire;
	private String passwdNotiDay;
	private String lockType;
	private String absentLock;
	private String defaultPasswdYn;
	private String passwdLifeCycle;
	
	private int type;	/* TAT_USER_SESSION.TYPE "접속 경로(DEFAULT은  '0')- 웹(client) '0', 커맨트 CLI(=서버) '1'- 웹(client)만 강제 종료 가능" */
	private int loginType;
	private int loginCount;
	private int maxWrongPasswd;
	private int lockTime;
	private int absentLockDay;
	
	
	public String getPasswdLifeCycle() {
		return passwdLifeCycle;
	}
	public void setPasswdLifeCycle(String passwdLifeCycle) {
		this.passwdLifeCycle = passwdLifeCycle;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getDefaultPasswdYn() {
		return defaultPasswdYn;
	}
	public void setDefaultPasswdYn(String defaultPasswdYn) {
		this.defaultPasswdYn = defaultPasswdYn;
	}
	public String getAbsentLock() {
		return absentLock;
	}
	public void setAbsentLock(String absentLock) {
		this.absentLock = absentLock;
	}
	public int getAbsentLockDay() {
		return absentLockDay;
	}
	public void setAbsentLockDay(int absentLockDay) {
		this.absentLockDay = absentLockDay;
	}
	public String getIpBandwidth() {
		return ipBandwidth;
	}
	public void setIpBandwidth(String ipBandwidth) {
		this.ipBandwidth = ipBandwidth;
	}
	public String getLockType() {
		return lockType;
	}
	public void setLockType(String lockType) {
		this.lockType = lockType;
	}
	public int getLockTime() {
		return lockTime;
	}
	public void setLockTime(int lockTime) {
		this.lockTime = lockTime;
	}
	public int getMaxWrongPasswd() {
		return maxWrongPasswd;
	}
	public void setMaxWrongPasswd(int maxWrongPasswd) {
		this.maxWrongPasswd = maxWrongPasswd;
	}
	public String getPasswdExfire() {
		return passwdExfire;
	}
	public void setPasswdExfire(String passwdExfire) {
		this.passwdExfire = passwdExfire;
	}
	public String getPasswdNotiDay() {
		return passwdNotiDay;
	}
	public void setPasswdNotiDay(String passwdNotiDay) {
		this.passwdNotiDay = passwdNotiDay;
	}
	public String getExfireNotiDay() {
		return exfireNotiDay;
	}
	public void setExfireNotiDay(String exfireNotiDay) {
		this.exfireNotiDay = exfireNotiDay;
	}
	public String getAccountExfire() {
		return accountExfire;
	}
	public void setAccountExfire(String accountExfire) {
		this.accountExfire = accountExfire;
	}
	public int getLoginType() {
		return loginType;
	}
	public void setLoginType(int loginType) {
		this.loginType = loginType;
	}
	public int getLoginCount() {
		return loginCount;
	}
	public void setLoginCount(int loginCount) {
		this.loginCount = loginCount;
	}
	public String getLevelName() {
		return levelName;
	}
	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getLevelId() {
		return levelId;
	}
	public void setLevelId(String levelId) {
		this.levelId = levelId;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	
	public int getRetryCount() {
		return retryCount;
	}
	public void setRetryCount(int retryCount) {
		this.retryCount = retryCount;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public String getGatewayIp() {
		return gatewayIp;
	}
	public void setGatewayIp(String gatewayIp) {
		this.gatewayIp = gatewayIp;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getGroupNo() {
		return groupNo;
	}
	public void setGroupNo(String groupNo) {
		this.groupNo = groupNo;
	}
	@Override
	public String toString() {
		return "LoginDomain [retryCount=" + retryCount + ", cnt=" + cnt + ", userName=" + userName + ", userPhone="
				+ userPhone + ", userEmail=" + userEmail + ", sessionId=" + sessionId + ", ipBandwidth=" + ipBandwidth
				+ ", gatewayIp=" + gatewayIp + ", status=" + status + ", groupNo=" + groupNo + ", levelId=" + levelId
				+ ", groupName=" + groupName + ", levelName=" + levelName + ", accountExfire=" + accountExfire
				+ ", exfireNotiDay=" + exfireNotiDay + ", passwdExfire=" + passwdExfire + ", passwdNotiDay="
				+ passwdNotiDay + ", lockType=" + lockType + ", absentLock=" + absentLock + ", defaultPasswdYn="
				+ defaultPasswdYn + ", passwdLifeCycle=" + passwdLifeCycle + ", type=" + type + ", loginType="
				+ loginType + ", loginCount=" + loginCount + ", maxWrongPasswd=" + maxWrongPasswd + ", lockTime="
				+ lockTime + ", absentLockDay=" + absentLockDay + "]";
	}
	
}
