package com.ntels.avocado.domain.atom.fault.alarmlevel;

import com.ntels.avocado.domain.common.CommonCondition;

public class AlmCodeDef extends CommonCondition {
	String pkg_name;
	String pkg_names;
	String code;
	String type_ccd;
	String group_ccd;
	String alias_code;
	String probable_cause;
	String severity_ccd;
	String sms_yn;
	String email_yn;
	String snmp_yn;
	String alarm_yn;
	String description;
	String[] pkg_name_arr;
	String titleName;
	
	public String getPkg_name() {
		return pkg_name;
	}
	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
	}
	public String getPkg_names() {
		return pkg_names;
	}
	public void setPkg_names(String pkg_names) {
		this.pkg_names = pkg_names;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getType_ccd() {
		return type_ccd;
	}
	public void setType_ccd(String type_ccd) {
		this.type_ccd = type_ccd;
	}
	public String getGroup_ccd() {
		return group_ccd;
	}
	public void setGroup_ccd(String group_ccd) {
		this.group_ccd = group_ccd;
	}
	public String getAlias_code() {
		return alias_code;
	}
	public void setAlias_code(String alias_code) {
		this.alias_code = alias_code;
	}
	public String getProbable_cause() {
		return probable_cause;
	}
	public void setProbable_cause(String probable_cause) {
		this.probable_cause = probable_cause;
	}
	public String getSeverity_ccd() {
		return severity_ccd;
	}
	public void setSeverity_ccd(String severity_ccd) {
		this.severity_ccd = severity_ccd;
	}
	public String getSms_yn() {
		return sms_yn;
	}
	public void setSms_yn(String sms_yn) {
		this.sms_yn = sms_yn;
	}
	public String getEmail_yn() {
		return email_yn;
	}
	public void setEmail_yn(String email_yn) {
		this.email_yn = email_yn;
	}
	public String getSnmp_yn() {
		return snmp_yn;
	}
	public void setSnmp_yn(String snmp_yn) {
		this.snmp_yn = snmp_yn;
	}
	public String getAlarm_yn() {
		return alarm_yn;
	}
	public void setAlarm_yn(String alarm_yn) {
		this.alarm_yn = alarm_yn;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String[] getPkg_name_arr() {
		return pkg_name_arr;
	}
	public void setPkg_name_arr(String[] pkg_name_arr) {
		this.pkg_name_arr = pkg_name_arr;
	}
	public String getTitleName() {
		return titleName;
	}
	public void setTitleName(String titleName) {
		this.titleName = titleName;
	}
}
