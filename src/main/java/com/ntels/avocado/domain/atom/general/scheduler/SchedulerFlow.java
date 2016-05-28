package com.ntels.avocado.domain.atom.general.scheduler;

import java.io.Serializable;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("schedulerFlow")
public class SchedulerFlow implements Serializable {	

	private static final long serialVersionUID = -8989571277914660928L;
	
	private String node_type;
	private String line_id;
	private String pkg_name;
	private String scheduler_group_id;
	private String scheduler_job_id;
	private String exit_cd;
	private String next_job_name;
	private String remark;
	private String user_id;
	private String job_name;
	private String group_name;

	
	public String getLine_id() {
		return line_id;
	}
	public void setLine_id(String line_id) {
		this.line_id = line_id;
	}
	public String getExit_cd() {
		return exit_cd;
	}
	public void setExit_cd(String exit_cd) {
		this.exit_cd = exit_cd;
	}
	public String getNext_job_name() {
		return next_job_name;
	}
	public void setNext_job_name(String next_job_name) {
		this.next_job_name = next_job_name;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getPkg_name() {
		return pkg_name;
	}
	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getNode_type() {
		return node_type;
	}
	public void setNode_type(String node_type) {
		this.node_type = node_type;
	}
	public String getScheduler_group_id() {
		return scheduler_group_id;
	}
	public void setScheduler_group_id(String scheduler_group_id) {
		this.scheduler_group_id = scheduler_group_id;
	}
	public String getScheduler_job_id() {
		return scheduler_job_id;
	}
	public void setScheduler_job_id(String scheduler_job_id) {
		this.scheduler_job_id = scheduler_job_id;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
}
