package com.ntels.avocado.domain.atom.management.trace;

public class Condition {

	private String system_id_c;
	private String package_id_c;
	private String service_id_c;
	
	private String trace_req_id;
	private String result_udr_id;
	private String udr_id;
	private String condition_value_c;

	private String start_date_c;
	private String start_hour_c;
	private String start_min_c;
	private String end_date_c;
	private String end_hour_c;
	private String end_min_c;
	
	private Integer page;
	private Integer perPage;
	private Integer start;
	private Integer end;
	
	
	public String getSystem_id_c() {
		return system_id_c;
	}
	public void setSystem_id_c(String system_id_c) {
		this.system_id_c = system_id_c;
	}
	public String getPackage_id_c() {
		return package_id_c;
	}
	public void setPackage_id_c(String package_id_c) {
		this.package_id_c = package_id_c;
	}
	public String getService_id_c() {
		return service_id_c;
	}
	public void setService_id_c(String service_id_c) {
		this.service_id_c = service_id_c;
	}
	public String getTrace_req_id() {
		return trace_req_id;
	}
	public void setTrace_req_id(String trace_req_id) {
		this.trace_req_id = trace_req_id;
	}
	public String getResult_udr_id() {
		return result_udr_id;
	}
	public void setResult_udr_id(String result_udr_id) {
		this.result_udr_id = result_udr_id;
	}
	public String getUdr_id() {
		return udr_id;
	}
	public void setUdr_id(String udr_id) {
		this.udr_id = udr_id;
	}
	public String getStart_date_c() {
		return start_date_c;
	}
	public void setStart_date_c(String start_date_c) {
		this.start_date_c = start_date_c;
	}
	public String getEnd_date_c() {
		return end_date_c;
	}
	public void setEnd_date_c(String end_date_c) {
		this.end_date_c = end_date_c;
	}
	public String getStart_hour_c() {
		return start_hour_c;
	}
	public void setStart_hour_c(String start_hour_c) {
		this.start_hour_c = start_hour_c;
	}
	public String getEnd_hour_c() {
		return end_hour_c;
	}
	public void setEnd_hour_c(String end_hour_c) {
		this.end_hour_c = end_hour_c;
	}
	public String getStart_min_c() {
		return start_min_c;
	}
	public void setStart_min_c(String start_min_c) {
		this.start_min_c = start_min_c;
	}
	public String getEnd_min_c() {
		return end_min_c;
	}
	public void setEnd_min_c(String end_min_c) {
		this.end_min_c = end_min_c;
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
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public Integer getEnd() {
		return end;
	}
	public void setEnd(Integer end) {
		this.end = end;
	}
	public String getCondition_value_c() {
		return condition_value_c;
	}
	public void setCondition_value_c(String condition_value_c) {
		this.condition_value_c = condition_value_c;
	}
	@Override
	public String toString() {
		return "Condition [system_id_c=" + system_id_c + ", package_id_c="
				+ package_id_c + ", service_id_c=" + service_id_c
				+ ", trace_req_id=" + trace_req_id + ", condition_value_c=" + condition_value_c
				+ ", start_date_c=" + start_date_c + ", start_hour_c="
				+ start_hour_c + ", start_min_c=" + start_min_c
				+ ", end_date_c=" + end_date_c + ", end_hour_c=" + end_hour_c
				+ ", end_min_c=" + end_min_c + ", page=" + page + ", perPage="
				+ perPage + ", start=" + start + ", end=" + end + "]";
	}
}
