/*****************************************************************************************
 * Copyright (c) 2011 nTels, All rights reserved.
 *
 * com.ntels.avocado.domain.pfnm.history.work.login.LoginHistory.java 
 * Login History 조회 결과를 담을 하기 위한 클래스
 * 
 * 사용 방법:
 * <pre>
 *    사용 방법을 넣어 주세요.
 *    여러줄이라도 상관 없습니다.
 * </pre>
 *
 * @저자  : yongseok
 * @버전  :
 * @작성일 : 2011. 10. 12
 *   
 * @작업 완료
 *    2011-10-12 : Finish
 * @작업중
 *    일자 : 내역을 적으세요
 ******************************************************************************************/
package com.ntels.avocado.domain.atom.history.login;

import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * The Class LoginHistory.
 */
@XStreamAlias("loginHistory")
public class LoginHistory {
	
	/** The user_group_name. */
	private String user_group_name;
	
	/** The user_id. */
	private String user_id;
	
	/** The user_name. */
	private String user_name;
	
	/** The login_date. */
	private String login_date;
	
	/** The login_status. */
	private String login_time;

	/** The login_time. */
	private String login_status;
	
	/** The login_gateway_ip. */
	private String login_gateway_ip;
	
	/** The logout_date. */
	private String logout_date;
	
	/** The logout_time. */
	private String logout_time;
	
	/** The logout_status. */
	private String logout_status;
	
	/** The remark. */
	private String remark;
	
	/** The Client type. */
	private String client_type;
	
	
	/**
	 * Gets the user_group_name.
	 *
	 * @return the user_group_name
	 */
	public String getUser_group_name() {
		return user_group_name;
	}

	/**
	 * Sets the user_group_name.
	 *
	 * @param user_group_name the new user_group_name
	 */
	public void setUser_group_name(String user_group_name) {
		this.user_group_name = user_group_name;
	}

	/**
	 * Gets the user_id.
	 *
	 * @return the user_id
	 */
	public String getUser_id() {
		return user_id;
	}
	
	/**
	 * Sets the user_id.
	 *
	 * @param user_id the new user_id
	 */
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	/**
	 * Gets the login_date.
	 *
	 * @return the login_date
	 */
	public String getLogin_date() {
		return login_date;
	}
	
	/**
	 * Sets the login_date.
	 *
	 * @param login_date the new login_date
	 */
	public void setLogin_date(String login_date) {
		this.login_date = login_date;
	}
	
	/**
	 * Gets the login_time.
	 *
	 * @return the login_time
	 */
	public String getLogin_time() {
		return login_time;
	}
	
	/**
	 * Sets the login_time.
	 *
	 * @param login_time the new login_time
	 */
	public void setLogin_time(String login_time) {
		this.login_time = login_time;
	}
	
	/**
	 * Gets the login_status.
	 *
	 * @return the logout_status
	 */
	public String getLogin_status() {
		return login_status;
	}
	
	/**
	 * Sets the login_status.
	 *
	 * @param login_status the new login_status
	 */
	public void setLogin_status(String login_status) {
		this.login_status = login_status;
	}
	
	/**
	 * Gets the login_gateway_ip.
	 *
	 * @return the login_gateway_ip
	 */
	public String getLogin_gateway_ip() {
		return login_gateway_ip;
	}
	
	/**
	 * Sets the login_gateway_ip.
	 *
	 * @param login_gateway_ip the new login_gateway_ip
	 */
	public void setLogin_gateway_ip(String login_gateway_ip) {
		this.login_gateway_ip = login_gateway_ip;
	}
	
	/**
	 * Gets the logout_date.
	 *
	 * @return the logout_date
	 */
	public String getLogout_date() {
		return logout_date;
	}
	
	/**
	 * Sets the logout_date.
	 *
	 * @param logout_date the new logout_date
	 */
	public void setLogout_date(String logout_date) {
		this.logout_date = logout_date;
	}
	
	/**
	 * Gets the logout_time.
	 *
	 * @return the logout_time
	 */
	public String getLogout_time() {
		return logout_time;
	}
	
	/**
	 * Sets the logout_time.
	 *
	 * @param logout_time the new logout_time
	 */
	public void setLogout_time(String logout_time) {
		this.logout_time = logout_time;
	}
	
	/**
	 * Gets the logout_status.
	 *
	 * @return the logout_status
	 */
	public String getLogout_status() {
		return logout_status;
	}
	
	/**
	 * Sets the logout_status.
	 *
	 * @param logout_status the new logout_status
	 */
	public void setLogout_status(String logout_status) {
		this.logout_status = logout_status;
	}
	
	/**
	 * Gets the remark.
	 *
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}
	
	/**
	 * Sets the remark.
	 *
	 * @param remark the new remark
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * Gets the user_name.
	 *
	 * @return the user_name
	 */
	public String getUser_name() {
		return user_name;
	}

	/**
	 * Sets the user_name.
	 *
	 * @param user_name the new user_name
	 */
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	/**
	 * Gets the Client_type.
	 *
	 * @return the client_type
	 */
	public String getClient_type() {
		return client_type;
	}

	/**
	 * Sets the Client_type.
	 *
	 * @param client_type the new Client_type
	 */
	public void setClient_type(String client_type) {
		this.client_type = client_type;
	}	
}
