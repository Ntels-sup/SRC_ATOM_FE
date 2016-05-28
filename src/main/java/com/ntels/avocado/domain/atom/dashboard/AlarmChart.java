package com.ntels.avocado.domain.atom.dashboard;

public class AlarmChart {

	private String alarm_group;
	private String critical;
	private String major;
	private String minor;
	private String fault;
	
	public String getAlarm_group() {
		return alarm_group;
	}
	public void setAlarm_group(String alarm_group) {
		this.alarm_group = alarm_group;
	}
	public String getCritical() {
		return critical;
	}
	public void setCritical(String critical) {
		this.critical = critical;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getMinor() {
		return minor;
	}
	public void setMinor(String minor) {
		this.minor = minor;
	}
	public String getFault() {
		return fault;
	}
	public void setFault(String fault) {
		this.fault = fault;
	}
	
	
}
