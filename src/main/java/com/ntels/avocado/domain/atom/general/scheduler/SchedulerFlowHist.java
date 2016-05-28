package com.ntels.avocado.domain.atom.general.scheduler;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("schedulerFlowHist")
public class SchedulerFlowHist {	

	private String system_id;
	private String package_id;
	private String batch_group_id;
	private String work_date;
	private Integer seq;
	private String work_type;
	private String work_time;
	private String user_id;
	private String description;
	
	public String getSystem_id() {
		return system_id;
	}
	public void setSystem_id(String system_id) {
		this.system_id = system_id;
	}
	public String getPackage_id() {
		return package_id;
	}
	public void setPackage_id(String package_id) {
		this.package_id = package_id;
	}
	public String getBatch_group_id() {
		return batch_group_id;
	}
	public void setBatch_group_id(String batch_group_id) {
		this.batch_group_id = batch_group_id;
	}
	public String getWork_date() {
		return work_date;
	}
	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public String getWork_type() {
		return work_type;
	}
	public void setWork_type(String work_type) {
		this.work_type = work_type;
	}
	public String getWork_time() {
		return work_time;
	}
	public void setWork_time(String work_time) {
		this.work_time = work_time;
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
}
