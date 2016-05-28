package com.ntels.avocado.domain.common;

public class SessionUser {
	private String userId;
	private String userName;
	private String userIpAddress;
	private String userIpBandwidth;
	private String userLevel;
	private String userLevelId;
	private String userGroup;
	private String userGroupNo;
	private String userPackage;
	private String userLoginDate;
	private String language;
	private String country;
	private String patternDate;
	private String patternTime;
	private String patternMonth;
	private String loginGatewayIp;
	private String lastLoginDate;
	private String lastLoginTime;
	
	
	public String getUserGroupNo() {
		return userGroupNo;
	}
	public void setUserGroupNo(String userGroupNo) {
		this.userGroupNo = userGroupNo;
	}
	public String getUserLevelId() {
		return userLevelId;
	}
	public void setUserLevelId(String userLevelId) {
		this.userLevelId = userLevelId;
	}
	public String getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(String lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	public String getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(String lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	public String getLoginGatewayIp() {
		return loginGatewayIp;
	}
	public void setLoginGatewayIp(String loginGatewayIp) {
		this.loginGatewayIp = loginGatewayIp;
	}
	public String getUserIpBandwidth() {
		return userIpBandwidth;
	}
	public void setUserIpBandwidth(String userIpBandwidth) {
		this.userIpBandwidth = userIpBandwidth;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserIpAddress() {
		return userIpAddress;
	}
	public void setUserIpAddress(String userIpAddress) {
		this.userIpAddress = userIpAddress;
	}
	public String getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
	}
	public String getUserGroup() {
		return userGroup;
	}
	public void setUserGroup(String userGroup) {
		this.userGroup = userGroup;
	}
	public String getUserPackage() {
		return userPackage;
	}
	public void setUserPackage(String userPackage) {
		this.userPackage = userPackage;
	}
	public String getUserLoginDate() {
		return userLoginDate;
	}
	public void setUserLoginDate(String userLoginDate) {
		this.userLoginDate = userLoginDate;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getPatternDate() {
		return patternDate;
	}
	public void setPatternDate(String patternDate) {
		this.patternDate = patternDate;
	}
	public String getPatternTime() {
		return patternTime;
	}
	public void setPatternTime(String patternTime) {
		this.patternTime = patternTime;
	}
	public String getPatternMonth() {
		return patternMonth;
	}
	public void setPatternMonth(String patternMonth) {
		this.patternMonth = patternMonth;
	}
	@Override
	public String toString() {
		return "SessionUser [userId=" + userId + ", userName=" + userName + ", userIpAddress=" + userIpAddress
				+ ", userIpBandwidth=" + userIpBandwidth + ", userLevel=" + userLevel + ", userLevelId=" + userLevelId
				+ ", userGroup=" + userGroup + ", userGroupNo=" + userGroupNo + ", userPackage=" + userPackage
				+ ", userLoginDate=" + userLoginDate + ", language=" + language + ", country=" + country
				+ ", patternDate=" + patternDate + ", patternTime=" + patternTime + ", patternMonth=" + patternMonth
				+ ", loginGatewayIp=" + loginGatewayIp + ", lastLoginDate=" + lastLoginDate + ", lastLoginTime="
				+ lastLoginTime + "]";
	}
	
	
	
}
