package com.ntels.avocado.domain.atom.general.scheduler;

import java.io.Serializable;

import com.ntels.avocado.domain.common.CommonCondition;
import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("schedulerGroup")
public class SchedulerGroup extends CommonCondition implements Serializable {	

	private static final long serialVersionUID = 7952710807387753977L;
	
	private String param_group_name;
	private String group_name;
	private String create_date;
	private String expire_date;
	private String expire_dt;
	private String expire_hr;
	private String expire_mn;
	private String expire_tm;
	private String start_dt;
	private String start_tm;
	private String start_date;
	private String schedule_cycle_type;
	private String schedule_cycle_type_nm;
	private String schedule_cycle;
	private String node_type;
	private String description;
	private String pkg_name;
	private String param_pkg_name;
	private String user_id;
	private String language;
	private String titleName;
	private String use_yn;
	private String use_yn_nm;
	private String proc_no;
	private String proc_name;
	private String node_no;
	
	
	public String getProc_no() {
		return proc_no;
	}
	public void setProc_no(String proc_no) {
		this.proc_no = proc_no;
	}
	public String getProc_name() {
		return proc_name;
	}
	public void setProc_name(String proc_name) {
		this.proc_name = proc_name;
	}
	public String getNode_no() {
		return node_no;
	}
	public void setNode_no(String node_no) {
		this.node_no = node_no;
	}
	public String getUse_yn_nm() {
		return use_yn_nm;
	}
	public void setUse_yn_nm(String use_yn_nm) {
		this.use_yn_nm = use_yn_nm;
	}
	@Override
	public String toString() {
		return "SchedulerGroup [param_group_name=" + param_group_name + ", group_name=" + group_name + ", create_date="
				+ create_date + ", expire_date=" + expire_date + ", expire_dt=" + expire_dt + ", expire_hr=" + expire_hr
				+ ", expire_mn=" + expire_mn + ", expire_tm=" + expire_tm + ", start_dt=" + start_dt + ", start_tm="
				+ start_tm + ", start_date=" + start_date + ", schedule_cycle_type=" + schedule_cycle_type
				+ ", schedule_cycle_type_nm=" + schedule_cycle_type_nm + ", schedule_cycle=" + schedule_cycle
				+ ", node_type=" + node_type + ", description=" + description + ", pkg_name=" + pkg_name
				+ ", param_pkg_name=" + param_pkg_name + ", user_id=" + user_id + ", language=" + language
				+ ", titleName=" + titleName + ", use_yn=" + use_yn + ", use_yn_nm=" + use_yn_nm + ", proc_no="
				+ proc_no + ", proc_name=" + proc_name + ", node_no=" + node_no + "]";
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getParam_group_name() {
		return param_group_name;
	}
	public void setParam_group_name(String param_group_name) {
		this.param_group_name = param_group_name;
	}
	public String getParam_pkg_name() {
		return param_pkg_name;
	}
	public void setParam_pkg_name(String param_pkg_name) {
		this.param_pkg_name = param_pkg_name;
	}
	public String getStart_dt() {
		return start_dt;
	}
	public void setStart_dt(String start_dt) {
		this.start_dt = start_dt;
	}
	public String getStart_tm() {
		return start_tm;
	}
	public void setStart_tm(String start_tm) {
		this.start_tm = start_tm;
	}
	public String getExpire_tm() {
		return expire_tm;
	}
	public void setExpire_tm(String expire_tm) {
		this.expire_tm = expire_tm;
	}
	public String getExpire_dt() {
		return expire_dt;
	}
	public void setExpire_dt(String expire_dt) {
		this.expire_dt = expire_dt;
	}
	public String getExpire_hr() {
		return expire_hr;
	}
	public void setExpire_hr(String expire_hr) {
		this.expire_hr = expire_hr;
	}
	public String getExpire_mn() {
		return expire_mn;
	}
	public void setExpire_mn(String expire_mn) {
		this.expire_mn = expire_mn;
	}
	public String getTitleName() {
		return titleName;
	}
	public void setTitleName(String titleName) {
		this.titleName = titleName;
	}
	public String getSchedule_cycle_type_nm() {
		return schedule_cycle_type_nm;
	}
	public void setSchedule_cycle_type_nm(String schedule_cycle_type_nm) {
		this.schedule_cycle_type_nm = schedule_cycle_type_nm;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getExpire_date() {
		return expire_date;
	}
	public void setExpire_date(String expire_date) {
		this.expire_date = expire_date;
	}
	public String getNode_type() {
		return node_type;
	}
	public void setNode_type(String node_type) {
		this.node_type = node_type;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getSchedule_cycle_type() {
		return schedule_cycle_type;
	}
	public void setSchedule_cycle_type(String schedule_cycle_type) {
		this.schedule_cycle_type = schedule_cycle_type;
	}
	public String getSchedule_cycle() {
		return schedule_cycle;
	}
	public void setSchedule_cycle(String schedule_cycle) {
		this.schedule_cycle = schedule_cycle;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPkg_name() {
		return pkg_name;
	}
	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
	}
	
}
