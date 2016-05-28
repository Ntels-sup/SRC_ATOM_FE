package com.ntels.avocado.domain.atom.fault.alarmstatistics;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("alarmStatistics")
public class AlarmStatistics {

    private String node_id;
    private String node_name;
    private String pkg_name;
    
    
    private String package_id;
    private String prc_date;
    private String prc_hhmm;    
//    private String group_type;
//    private String group_type_nm;
    private String severity;
    private String code;
    private String alarm_cnt;
    private String severity_nm;
    private String dst_flag;
// 추가
    private String location;
    private String probable_cause;
	public String getNode_id() {
		return node_id;
	}
	public void setNode_id(String node_id) {
		this.node_id = node_id;
	}
	public String getNode_name() {
		return node_name;
	}
	public void setNode_name(String node_name) {
		this.node_name = node_name;
	}
	public String getPkg_name() {
		return pkg_name;
	}
	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
	}
	public String getPackage_id() {
		return package_id;
	}
	public void setPackage_id(String package_id) {
		this.package_id = package_id;
	}
	public String getPrc_date() {
		return prc_date;
	}
	public void setPrc_date(String prc_date) {
		this.prc_date = prc_date;
	}
	public String getPrc_hhmm() {
		return prc_hhmm;
	}
	public void setPrc_hhmm(String prc_hhmm) {
		this.prc_hhmm = prc_hhmm;
	}
	public String getSeverity() {
		return severity;
	}
	public void setSeverity(String severity) {
		this.severity = severity;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getAlarm_cnt() {
		return alarm_cnt;
	}
	public void setAlarm_cnt(String alarm_cnt) {
		this.alarm_cnt = alarm_cnt;
	}
	public String getSeverity_nm() {
		return severity_nm;
	}
	public void setSeverity_nm(String severity_nm) {
		this.severity_nm = severity_nm;
	}
	public String getDst_flag() {
		return dst_flag;
	}
	public void setDst_flag(String dst_flag) {
		this.dst_flag = dst_flag;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getProbable_cause() {
		return probable_cause;
	}
	public void setProbable_cause(String probable_cause) {
		this.probable_cause = probable_cause;
	}
    
    
    
}
