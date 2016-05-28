package com.ntels.avocado.domain.atom.fault.alarmhistory;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("alarmHistory")
public class AlarmHistory {
    
    private String prc_date       ;
    private String cleared_date   ;
    private String code           ;
    private String probable_cause ;
    private String pkg_name       ;
    private String node_name      ;
    private String severity_nm    ;
    private String location       ;
    private String duration       ;
    private String snmp_send_yn   ;
    private String clear_type;
    private String additional_text;
    private String tracking_id;
    private String severity_ccd;
	public String getPrc_date() {
		return prc_date;
	}
	public void setPrc_date(String prc_date) {
		this.prc_date = prc_date;
	}
	public String getCleared_date() {
		return cleared_date;
	}
	public void setCleared_date(String cleared_date) {
		this.cleared_date = cleared_date;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getProbable_cause() {
		return probable_cause;
	}
	public void setProbable_cause(String probable_cause) {
		this.probable_cause = probable_cause;
	}
	public String getPkg_name() {
		return pkg_name;
	}
	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
	}
	public String getNode_name() {
		return node_name;
	}
	public void setNode_name(String node_name) {
		this.node_name = node_name;
	}
	public String getSeverity_nm() {
		return severity_nm;
	}
	public void setSeverity_nm(String severity_nm) {
		this.severity_nm = severity_nm;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public String getSnmp_send_yn() {
		return snmp_send_yn;
	}
	public void setSnmp_send_yn(String snmp_send_yn) {
		this.snmp_send_yn = snmp_send_yn;
	}
	public String getClear_type() {
		return clear_type;
	}
	public void setClear_type(String clear_type) {
		this.clear_type = clear_type;
	}
	public String getAdditional_text() {
		return additional_text;
	}
	public void setAdditional_text(String additional_text) {
		this.additional_text = additional_text;
	}
	public String getTracking_id() {
		return tracking_id;
	}
	public void setTracking_id(String tracking_id) {
		this.tracking_id = tracking_id;
	}
	public String getSeverity_ccd() {
		return severity_ccd;
	}
	public void setSeverity_ccd(String severity_ccd) {
		this.severity_ccd = severity_ccd;
	}
    
	
}
