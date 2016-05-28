package com.ntels.avocado.domain.atom.general.scheduler;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("pluginProperties")
public class PluginProperties {	

	private String alias; 
	private String type_code;
	private String disp_order;
	private String type_name;
	private String group_flag;
	private String app_type;
	private String comm_proc_flag;
	private String use_flag;
	
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	public String getType_code() {
		return type_code;
	}
	public void setType_code(String type_code) {
		this.type_code = type_code;
	}
	public String getDisp_order() {
		return disp_order;
	}
	public void setDisp_order(String disp_order) {
		this.disp_order = disp_order;
	}
	public String getType_name() {
		return type_name;
	}
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}
	public String getGroup_flag() {
		return group_flag;
	}
	public void setGroup_flag(String group_flag) {
		this.group_flag = group_flag;
	}
	public String getApp_type() {
		return app_type;
	}
	public void setApp_type(String app_type) {
		this.app_type = app_type;
	}
	public String getComm_proc_flag() {
		return comm_proc_flag;
	}
	public void setComm_proc_flag(String comm_proc_flag) {
		this.comm_proc_flag = comm_proc_flag;
	}
	public String getUse_flag() {
		return use_flag;
	}
	public void setUse_flag(String use_flag) {
		this.use_flag = use_flag;
	}
}
