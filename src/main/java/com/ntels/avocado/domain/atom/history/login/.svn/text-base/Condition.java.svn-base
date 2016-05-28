/*****************************************************************************************
 * Copyright (c) 2012 nTels, All rights reserved.
 *
 * com.ntels.avocado.domain.pfnm.history.login.Condition.java 
 * Alarm Statistics 조회시 조건값을 저장 하기 위한 클래스
 * 
 * 사용 방법:
 * <pre>
 *    사용 방법을 넣어 주세요.
 *    여러줄이라도 상관 없습니다.
 * </pre>
 *
 * @저자  : Kidae, Kim
 * @버전  :
 * @작성일 : 2012.10.04
 *   
 * @작업 완료
 *    2012.12.11 : Finish
 * @작업중
 *    일자 : 내역을 적으세요
 ******************************************************************************************/
package com.ntels.avocado.domain.atom.history.login;

import com.ntels.avocado.domain.common.CommonCondition;
import com.ntels.ncf.utils.DateUtil;

/**
 * The Class Condition.
 */
public class Condition extends CommonCondition {
	
	private String startDate;
	private String endDate;
	private String startTime;
	private String endTime;
	private String startHour;
	private String endHour;
	private String startMin;
	private String endMin;	
	private String session_user_group_id;
	private String session_user_id;
	private String session_user_group_level;
	private String language;
	
	// 조회 조건 값
	/** The user_group_id. */
	private String user_group_id;
	/** The user_id. */
	private String user_id;
	
	public String getSession_user_group_id() {
		return session_user_group_id;
	}
	public void setSession_user_group_id(String session_user_group_id) {
		this.session_user_group_id = session_user_group_id;
	}
	public String getSession_user_id() {
		return session_user_id;
	}
	public void setSession_user_id(String session_user_id) {
		this.session_user_id = session_user_id;
	}	
	public String getSession_user_group_level() {
		return session_user_group_level;
	}
	public void setSession_user_group_level(String session_user_group_level) {
		this.session_user_group_level = session_user_group_level;
	}	
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getStartHour() {
		return startHour;
	}
	public void setStartHour(String startHour) {
		this.startHour = startHour;
	}
	public String getEndHour() {
		return endHour;
	}
	public void setEndHour(String endHour) {
		this.endHour = endHour;
	}
	public String getStartMin() {
		return startMin;
	}
	public void setStartMin(String startMin) {
		this.startMin = startMin;
	}
	public String getEndMin() {
		return endMin;
	}
	public void setEndMin(String endMin) {
		this.endMin = endMin;
	}
	public String getUser_group_id() {
		return user_group_id;
	}
	public void setUser_group_id(String user_group_id) {
		this.user_group_id = user_group_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	@Override
	public String toString() {
		StringBuffer buffer = new StringBuffer();
		
		if(this.user_group_id == null)
			buffer.append("all").append(",");
		else
			buffer.append(user_group_id).append(",");
		
		if(this.user_id == null)
			buffer.append("all").append(",");
		else
			buffer.append(user_id).append(",");
		
		String startDate = this.getStartDate() == null?DateUtil.getNow("yyyyMMdd"):this.getStartDate().replace("-", "");
		String endDate = this.getEndDate()==null?DateUtil.getNow("yyyyMMdd"):this.getEndDate().replace("-", "");
		String startTime = (this.getStartHour()==null?"":this.getStartHour()) + (this.getStartMin()==null?"":this.getStartMin()) + "0000";
		String endMin = this.getEndMin()== null?"":this.getEndMin();
		String endTime = (this.getEndHour()==null?"":this.getEndHour()) + (endMin) + "6099";
		
		buffer.append(startDate).append(startTime).append(",").append(endDate).append(endTime);
		
		return buffer.toString();
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}			
}
