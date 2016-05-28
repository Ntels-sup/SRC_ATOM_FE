package com.ntels.avocado.domain.atom.management.trace;

import org.hibernate.validator.constraints.NotEmpty;

public class TraceReq {
	@NotEmpty
	private String system_id;
	private String system_name;
	@NotEmpty
	private String package_id;
	private String package_name;
	@NotEmpty
	private String service_id;
	private String service_name;
	private Integer trace_req_id;
	@NotEmpty
	private String filter_grp_nm;
	
	private String start_datetime;
	private String start_date;
	private String start_hour;
	private String start_min;
	private String start_sec;
	
	@NotEmpty
	private String end_datetime;
	private String end_date;
	private String end_hour;
	private String end_min;
	private String end_sec;
	
	@NotEmpty
	private String trace_type;
	private String trace_type_name;
	@NotEmpty
	private String condition_value;
	private String user_id;
	private String description;
	
	private String table_cmd;
	private Integer result;
	
	
	public String getSystem_id() {
		return system_id;
	}
	public void setSystem_id(String system_id) {
		this.system_id = system_id;
	}
	public String getSystem_name() {
		return system_name;
	}
	public void setSystem_name(String system_name) {
		this.system_name = system_name;
	}
	public String getPackage_id() {
		return package_id;
	}
	public void setPackage_id(String package_id) {
		this.package_id = package_id;
	}
	public String getPackage_name() {
		return package_name;
	}
	public void setPackage_name(String package_name) {
		this.package_name = package_name;
	}
	public String getService_id() {
		return service_id;
	}
	public void setService_id(String service_id) {
		this.service_id = service_id;
	}
	public String getService_name() {
		return service_name;
	}
	public void setService_name(String service_name) {
		this.service_name = service_name;
	}
	public Integer getTrace_req_id() {
		return trace_req_id;
	}
	public void setTrace_req_id(Integer trace_req_id) {
		this.trace_req_id = trace_req_id;
	}
	public String getFilter_grp_nm() {
		return filter_grp_nm;
	}
	public void setFilter_grp_nm(String filter_grp_nm) {
		this.filter_grp_nm = filter_grp_nm;
	}
	public String getStart_datetime() {
		return start_datetime;
	}
	public void setStart_datetime(String start_datetime) {
		this.start_datetime = start_datetime;
	}
	public String getEnd_datetime() {
		return end_datetime;
	}
	public void setEnd_datetime(String end_datetime) {
		this.end_datetime = end_datetime;
	}
	public String getTrace_type() {
		return trace_type;
	}
	public void setTrace_type(String trace_type) {
		this.trace_type = trace_type;
	}
	public String getTrace_type_name() {
		return trace_type_name;
	}
	public void setTrace_type_name(String trace_type_name) {
		this.trace_type_name = trace_type_name;
	}
	public String getCondition_value() {
		return condition_value;
	}
	public void setCondition_value(String condition_value) {
		this.condition_value = condition_value;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getStart_hour() {
		return start_hour;
	}
	public void setStart_hour(String start_hour) {
		this.start_hour = start_hour;
	}
	public String getStart_min() {
		return start_min;
	}
	public void setStart_min(String start_min) {
		this.start_min = start_min;
	}
	public String getStart_sec() {
		return start_sec;
	}
	public void setStart_sec(String start_sec) {
		this.start_sec = start_sec;
	}
	public String getEnd_hour() {
		return end_hour;
	}
	public void setEnd_hour(String end_hour) {
		this.end_hour = end_hour;
	}
	public String getEnd_min() {
		return end_min;
	}
	public void setEnd_min(String end_min) {
		this.end_min = end_min;
	}
	public String getEnd_sec() {
		return end_sec;
	}
	public void setEnd_sec(String end_sec) {
		this.end_sec = end_sec;
	}
	public String getTable_cmd() {
		return table_cmd;
	}
	public void setTable_cmd(String table_cmd) {
		this.table_cmd = table_cmd;
	}
	public Integer getResult() {
		return result;
	}
	public void setResult(Integer result) {
		this.result = result;
	}
	@Override
	public String toString() {
		return "TraceReq [system_id=" + system_id + ", system_name="
				+ system_name + ", package_id=" + package_id + ", service_id="
				+ service_id + ", trace_req_id=" + trace_req_id
				+ ", filter_grp_nm=" + filter_grp_nm + ", start_datetime="
				+ start_datetime + ", start_date=" + start_date
				+ ", start_hour=" + start_hour + ", start_min=" + start_min
				+ ", start_sec=" + start_sec + ", end_datetime=" + end_datetime
				+ ", end_date=" + end_date + ", end_hour=" + end_hour
				+ ", end_min=" + end_min + ", end_sec=" + end_sec
				+ ", trace_type=" + trace_type + ", condition_value="
				+ condition_value + ", user_id=" + user_id + ", description="
				+ description + "]";
	}

}
