package com.ntels.avocado.domain.atom.general.scheduler;

import java.io.Serializable;

import com.ntels.avocado.domain.atom.config.networkmanager.AtomImage;
import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("scheduler")
public class Scheduler extends AtomImage implements Serializable {	

	private static final long serialVersionUID = -1826061107678628496L;
	
	private String job_name;
	private String job_name_old;
	private String group_name;
	private String proc_name;
	private String svc_no;
	private String node_type;
	private String node_no;
	private String fail_cont_yn;
	private String run_yn;
	private String description;
	private String create_date;
	private String start_date;
	private String schedule_cycle_type;
	private String schedule_cycle;
	private String expire_date;
	private String user_id;
	private String pkg_name;
	private String image_no;
	private String proc_no;
	private String rootjob_yn;
	
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getJob_name_old() {
		return job_name_old;
	}
	public void setJob_name_old(String job_name_old) {
		this.job_name_old = job_name_old;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getProc_name() {
		return proc_name;
	}
	public void setProc_name(String proc_name) {
		this.proc_name = proc_name;
	}
	public String getSvc_no() {
		return svc_no;
	}
	public void setSvc_no(String svc_no) {
		this.svc_no = svc_no;
	}
	public String getNode_type() {
		return node_type;
	}
	public void setNode_type(String node_type) {
		this.node_type = node_type;
	}
	public String getNode_no() {
		return node_no;
	}
	public void setNode_no(String node_no) {
		this.node_no = node_no;
	}
	public String getFail_cont_yn() {
		return fail_cont_yn;
	}
	public void setFail_cont_yn(String fail_cont_yn) {
		this.fail_cont_yn = fail_cont_yn;
	}
	public String getRun_yn() {
		return run_yn;
	}
	public void setRun_yn(String run_yn) {
		this.run_yn = run_yn;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getSchedule_cycle_type() {
		return schedule_cycle_type;
	}
	public void setSchedule_cycle_type(String schedule_cycle_type) {
		this.schedule_cycle_type = schedule_cycle_type;
	}
	public String getSchedule_cycle() {
		return schedule_cycle;
	}
	public void setSchedule_cycle(String schedule_cycle) {
		this.schedule_cycle = schedule_cycle;
	}
	public String getExpire_date() {
		return expire_date;
	}
	public void setExpire_date(String expire_date) {
		this.expire_date = expire_date;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPkg_name() {
		return pkg_name;
	}
	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
	}
	public String getImage_no() {
		return image_no;
	}
	public void setImage_no(String image_no) {
		this.image_no = image_no;
	}
	public String getProc_no() {
		return proc_no;
	}
	public void setProc_no(String proc_no) {
		this.proc_no = proc_no;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getRootjob_yn() {
		return rootjob_yn;
	}
	public void setRootjob_yn(String rootjob_yn) {
		this.rootjob_yn = rootjob_yn;
	}
}
