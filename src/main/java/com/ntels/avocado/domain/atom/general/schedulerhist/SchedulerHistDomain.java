/*****************************************************************************************
 * Copyright (c) 2011 nTels, All rights reserved.
 *
 * com.ntels.avocado.domain.atom.history.system.schedulerlog.SchedulerLogHistory.java 
 * Domain 클래스
 * 
 * 사용 방법:
 * <pre>
 *    사용 방법을 넣어 주세요.
 *    여러줄이라도 상관 없습니다.
 * </pre>
 *
 * @저자  : yongseok
 * @버전  :
 * @작성일 : 2011. 10. 25
 *   
 * @작업 완료
 *    2011-10-25 : finish
 * @작업중
 *    일자 : 내역을 적으세요
 ******************************************************************************************/
package com.ntels.avocado.domain.atom.general.schedulerhist;

import java.io.Serializable;

import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * The Class SchedulerLogHistory.
 */
@XStreamAlias("schedulerHist")
public class SchedulerHistDomain implements Serializable {

	private static final long serialVersionUID = -4916129706061045383L;
	
	private String group_name;
	private String job_name;
	private String pkg_id;
	private String prc_date;
	private String end_date;
	private String proc_name;
	private String node_name;
	private String exit_cd;
	private String success_yn;
	private String pkg_name;
	
	
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getPkg_id() {
		return pkg_id;
	}
	public void setPkg_id(String pkg_id) {
		this.pkg_id = pkg_id;
	}
	public String getPrc_date() {
		return prc_date;
	}
	public void setPrc_date(String prc_date) {
		this.prc_date = prc_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getProc_name() {
		return proc_name;
	}
	public void setProc_name(String proc_name) {
		this.proc_name = proc_name;
	}
	public String getNode_name() {
		return node_name;
	}
	public void setNode_name(String node_name) {
		this.node_name = node_name;
	}
	public String getExit_cd() {
		return exit_cd;
	}
	public void setExit_cd(String exit_cd) {
		this.exit_cd = exit_cd;
	}
	public String getSuccess_yn() {
		return success_yn;
	}
	public void setSuccess_yn(String success_yn) {
		this.success_yn = success_yn;
	}
	public String getPkg_name() {
		return pkg_name;
	}
	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
	}
}
