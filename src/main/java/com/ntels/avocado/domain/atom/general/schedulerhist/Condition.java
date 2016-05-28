/*****************************************************************************************
 * Copyright (c) 2011 nTels, All rights reserved.
 *
 * com.ntels.avocado.domain.pfnm.history.work.login.Condition.java 
 * History 조회시 조건값을 저장 하기 위한 클래스
 * 
 * 사용 방법:
 * <pre>
 *    사용 방법을 넣어 주세요.
 *    여러줄이라도 상관 없습니다.
 * </pre>
 *
 * @저자  : yongseok
 * @버전  :
 * @작성일 : 2011. 10. 20
 *   
 * @작업 완료
 *    2011-10-20 : Finish
 * @작업중
 *    일자 : 내역을 적으세요
 ******************************************************************************************/
package com.ntels.avocado.domain.atom.general.schedulerhist;

import java.util.Arrays;

import com.ntels.avocado.domain.atom.history.common.HistoryCondition;

/**
 * The Class Condition.
 */
public class Condition extends HistoryCondition {
	
	private String system_id;
	private String pkg_name;
	private String group_name;
	private String job_name;
	
	private String language;
	private String titleName;
	private String gubun;

	private String startDt;
	private String endDt;
	private String startTm;
	private String endTm;
	private Integer perPage=10;
	private String[] systemArray;
	
	@Override
	public String toString() {
		return "Condition [system_id=" + system_id + ", pkg_name=" + pkg_name + ", group_name=" + group_name
				+ ", job_name=" + job_name + ", language=" + language + ", titleName=" + titleName + ", gubun=" + gubun
				+ ", startDt=" + startDt + ", endDt=" + endDt + ", startTm=" + startTm + ", endTm=" + endTm
				+ ", perPage=" + perPage + ", systemArray=" + Arrays.toString(systemArray) + "]";
	}

	
	public String[] getSystemArray() {
		return systemArray;
	}


	public void setSystemArray(String[] systemArray) {
		this.systemArray = systemArray;
	}


	public String getSystem_id() {
		return system_id;
	}


	public void setSystem_id(String system_id) {
		this.system_id = system_id;
	}


	public String getStartDt() {
		return startDt;
	}

	public Integer getPerPage() {
		return perPage;
	}

	public void setPerPage(Integer perPage) {
		this.perPage = perPage;
	}

	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}

	public String getEndDt() {
		return endDt;
	}

	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}

	public String getStartTm() {
		return startTm;
	}

	public void setStartTm(String startTm) {
		this.startTm = startTm;
	}

	public String getEndTm() {
		return endTm;
	}

	public void setEndTm(String endTm) {
		this.endTm = endTm;
	}

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

	public String getPkg_name() {
		return pkg_name;
	}

	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getTitleName() {
		return titleName;
	}

	public void setTitleName(String titleName) {
		this.titleName = titleName;
	}

	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	
}
