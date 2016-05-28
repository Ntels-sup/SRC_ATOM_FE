package com.ntels.avocado.domain.atom.security.operationhist;

public class OperationHistDomain {
	private Integer oper_id;
	private String pkg_name;
	private String node_no;
	private String node_name;
	private String user_id;
	private String oper_target;
	private String oper_target_name;
	private String menu_id;
	private String menu_name;
	private String oper_message;
	private String result_yn;
	private String oper_ip;
	private String prc_date;
	private String res_date;
	private String oper_cmd;
	private String cmd_arg;
	private String fail_reason;
	
	public Integer getOper_id() {
		return oper_id;
	}
	public void setOper_id(Integer oper_id) {
		this.oper_id = oper_id;
	}
	public String getPkg_name() {
		return pkg_name;
	}
	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
	}
	public String getNode_no() {
		return node_no;
	}
	public void setNode_no(String node_no) {
		this.node_no = node_no;
	}
	public String getNode_name() {
		return node_name;
	}
	public void setNode_name(String node_name) {
		this.node_name = node_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getOper_target() {
		return oper_target;
	}
	public void setOper_target(String oper_target) {
		this.oper_target = oper_target;
	}
	public String getOper_target_name() {
		return oper_target_name;
	}
	public void setOper_target_name(String oper_target_name) {
		this.oper_target_name = oper_target_name;
	}
	public String getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public String getOper_message() {
		return oper_message;
	}
	public void setOper_message(String oper_message) {
		this.oper_message = oper_message;
	}
	public String getResult_yn() {
		return result_yn;
	}
	public void setResult_yn(String result_yn) {
		this.result_yn = result_yn;
	}
	public String getOper_ip() {
		return oper_ip;
	}
	public void setOper_ip(String oper_ip) {
		this.oper_ip = oper_ip;
	}
	public String getPrc_date() {
		return prc_date;
	}
	public void setPrc_date(String prc_date) {
		this.prc_date = prc_date;
	}
	public String getRes_date() {
		return res_date;
	}
	public void setRes_date(String res_date) {
		this.res_date = res_date;
	}
	public String getOper_cmd() {
		return oper_cmd;
	}
	public void setOper_cmd(String oper_cmd) {
		this.oper_cmd = oper_cmd;
	}
	public String getCmd_arg() {
		return cmd_arg;
	}
	public void setCmd_arg(String cmd_arg) {
		this.cmd_arg = cmd_arg;
	}
	public String getFail_reason() {
		return fail_reason;
	}
	public void setFail_reason(String fail_reason) {
		this.fail_reason = fail_reason;
	}
}
