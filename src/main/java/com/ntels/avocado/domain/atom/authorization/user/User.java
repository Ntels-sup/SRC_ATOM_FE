package com.ntels.avocado.domain.atom.authorization.user;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("user")
public class User {
	
	@NotEmpty
	@Length(min=4,max=20)
	private String user_id;
	private String password;
	private String passwordRe;
	@NotEmpty
	private String user_name;
	private String password_hint;
	@NotEmpty
	private String user_group_id;
	private String user_group_name;
	private String dept_name;
	private String tel_no;
	@Email
	private String e_mail;
	private String emp_no;
	@NotEmpty
	private String ip_bandwidth;
	private int    login_fail_count = 0;
	@NotEmpty
	private String password_due_date;
	@NotEmpty
	private String password_change_period = "30";
	private String alarm_use;
	private String last_login_date;
	private String last_login_time;
	private String account_lock;

	// other
	private String login_gateway_ip;
	
	private String user_group_id_c;
	private Integer page;
	private Integer perPage;
	
	private String password1;
	private String password2;
	
	private String passwordH;
	private String passwordReH;
	private String tel_noH;
	private String e_mailH;
	private String emp_noH;	
	
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPasswordRe() {
		return passwordRe;
	}

	public void setPasswordRe(String passwordRe) {
		this.passwordRe = passwordRe;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_group_id() {
		return user_group_id;
	}

	public void setUser_group_id(String user_group_id) {
		this.user_group_id = user_group_id;
	}

	public String getUser_group_name() {
		return user_group_name;
	}

	public void setUser_group_name(String user_group_name) {
		this.user_group_name = user_group_name;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getTel_no() {
		return tel_no;
	}

	public void setTel_no(String tel_no) {
		this.tel_no = tel_no;
	}

	public String getE_mail() {
		return e_mail;
	}

	public void setE_mail(String e_mail) {
		this.e_mail = e_mail;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public String getIp_bandwidth() {
		return ip_bandwidth;
	}

	public void setIp_bandwidth(String ip_bandwidth) {
		this.ip_bandwidth = ip_bandwidth;
	}

	public int getLogin_fail_count() {
		return login_fail_count;
	}

	public void setLogin_fail_count(int login_fail_count) {
		this.login_fail_count = login_fail_count;
	}

	public String getPassword_due_date() {
		return password_due_date;
	}

	public void setPassword_due_date(String password_due_date) {
		this.password_due_date = password_due_date;
	}

	public String getPassword_change_period() {
		return password_change_period;
	}

	public void setPassword_change_period(String password_change_period) {
		this.password_change_period = password_change_period;
	}

	public String getAlarm_use() {
		return alarm_use;
	}

	public void setAlarm_use(String alarm_use) {
		this.alarm_use = alarm_use;
	}

	public String getLast_login_date() {
		return last_login_date;
	}

	public void setLast_login_date(String last_login_date) {
		this.last_login_date = last_login_date;
	}

	public String getLast_login_time() {
		return last_login_time;
	}

	public void setLast_login_time(String last_login_time) {
		this.last_login_time = last_login_time;
	}

	public String getLogin_gateway_ip() {
		return login_gateway_ip;
	}

	public void setLogin_gateway_ip(String login_gateway_ip) {
		this.login_gateway_ip = login_gateway_ip;
	}

	public String getAccount_lock() {
		return account_lock;
	}

	public void setAccount_lock(String account_lock) {
		this.account_lock = account_lock;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getPerPage() {
		return perPage;
	}

	public void setPerPage(Integer perPage) {
		this.perPage = perPage;
	}

	public String getUser_group_id_c() {
		return user_group_id_c;
	}

	public void setUser_group_id_c(String user_group_id_c) {
		this.user_group_id_c = user_group_id_c;
	}

	public String getPassword1() {
		return password1;
	}

	public void setPassword1(String password1) {
		this.password1 = password1;
	}

	public String getPassword2() {
		return password2;
	}

	public void setPassword2(String password2) {
		this.password2 = password2;
	}

	public String getPasswordH() {
		return passwordH;
	}

	public void setPasswordH(String passwordH) {
		this.passwordH = passwordH;
	}

	public String getPasswordReH() {
		return passwordReH;
	}

	public void setPasswordReH(String passwordReH) {
		this.passwordReH = passwordReH;
	}

	public String getTel_noH() {
		return tel_noH;
	}

	public void setTel_noH(String tel_noH) {
		this.tel_noH = tel_noH;
	}

	public String getE_mailH() {
		return e_mailH;
	}

	public void setE_mailH(String e_mailH) {
		this.e_mailH = e_mailH;
	}

	public String getEmp_noH() {
		return emp_noH;
	}

	public void setEmp_noH(String emp_noH) {
		this.emp_noH = emp_noH;
	}

	@Override
	public String toString() {
		return "User [user_id=" + user_id + ", password=" + password
				+ ", passwordRe=" + passwordRe + ", password_hint=" + password_hint
				+ ", user_name=" + user_name
				+ ", user_group_id=" + user_group_id + ", user_group_name="
				+ user_group_name + ", dept_name=" + dept_name + ", tel_no="
				+ tel_no + ", e_mail=" + e_mail + ", emp_no=" + emp_no
				+ ", ip_bandwidth=" + ip_bandwidth + ", login_fail_count="
				+ login_fail_count + ", password_due_date=" + password_due_date
				+ ", password_change_period=" + password_change_period
				+ ", alarm_use=" + alarm_use + ", last_login_date="
				+ last_login_date + ", last_login_time=" + last_login_time
				+ ", login_gateway_ip=" + login_gateway_ip + "]";
	}

	/**
	 * @return the password_hint
	 */
	public String getPassword_hint() {
		return password_hint;
	}

	/**
	 * @param password_hint the password_hint to set
	 */
	public void setPassword_hint(String password_hint) {
		this.password_hint = password_hint;
	}
	
}
