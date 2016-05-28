package com.ntels.avocado.domain.atom.general.scheduler;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("application")
public class Application {	

	private String node_type;
	private String package_id;
	private String application_id;
	private String app_name;
	private String app_location;
	private String app_version;
	private String app_type;
	private String component_type;
	private String app_menu_no;
	private String remark;
	
	
	public String getNode_type() {
		return node_type;
	}
	public void setNode_type(String node_type) {
		this.node_type = node_type;
	}
	public String getPackage_id() {
		return package_id;
	}
	public void setPackage_id(String package_id) {
		this.package_id = package_id;
	}
	public String getApplication_id() {
		return application_id;
	}
	public void setApplication_id(String application_id) {
		this.application_id = application_id;
	}
	public String getApp_name() {
		return app_name;
	}
	public void setApp_name(String app_name) {
		this.app_name = app_name;
	}
	public String getApp_location() {
		return app_location;
	}
	public void setApp_location(String app_location) {
		this.app_location = app_location;
	}
	public String getApp_version() {
		return app_version;
	}
	public void setApp_version(String app_version) {
		this.app_version = app_version;
	}
	public String getApp_type() {
		return app_type;
	}
	public void setApp_type(String app_type) {
		this.app_type = app_type;
	}
	public String getComponent_type() {
		return component_type;
	}
	public void setComponent_type(String component_type) {
		this.component_type = component_type;
	}
	public String getApp_menu_no() {
		return app_menu_no;
	}
	public void setApp_menu_no(String app_menu_no) {
		this.app_menu_no = app_menu_no;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
