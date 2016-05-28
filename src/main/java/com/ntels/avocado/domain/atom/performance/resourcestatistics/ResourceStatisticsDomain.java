package com.ntels.avocado.domain.atom.performance.resourcestatistics;

import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import com.ntels.avocado.domain.common.CommonCondition;

public class ResourceStatisticsDomain extends CommonCondition{

	private String system_id;
	private String typeId;
	private String startDate;
	private String startHour;
	private String startMin;
	private String endDate;
	private String endHour;
	private String endMin;
	private String startTime;
	private String endTime;
	private String dateformat;
	
	private String[] systemArray;
	private String orderBy;
	private String locale;
	
	private List<LinkedHashMap<String, Object>> rscIdCase ;
	private List<LinkedHashMap<String, Object>> rscIdList ;
	private String rsc_grp_id ;
    private String rsc_id;
    private String titleName;
    
    
	public String getSystem_id() {
		return system_id;
	}
	public void setSystem_id(String system_id) {
		this.system_id = system_id;
	}
	public String getTypeId() {
		return typeId;
	}
	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getStartHour() {
		return startHour;
	}
	public void setStartHour(String startHour) {
		this.startHour = startHour;
	}
	public String getStartMin() {
		return startMin;
	}
	public void setStartMin(String startMin) {
		this.startMin = startMin;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getEndHour() {
		return endHour;
	}
	public void setEndHour(String endHour) {
		this.endHour = endHour;
	}
	public String getEndMin() {
		return endMin;
	}
	public void setEndMin(String endMin) {
		this.endMin = endMin;
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
	public String getDateformat() {
		return dateformat;
	}
	public void setDateformat(String dateformat) {
		this.dateformat = dateformat;
	}
	public String[] getSystemArray() {
		return systemArray;
	}
	public void setSystemArray(String[] systemArray) {
		this.systemArray = systemArray;
	}
	public String getOrderBy() {
		return orderBy;
	}
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
	public List<LinkedHashMap<String, Object>> getRscIdCase() {
		return rscIdCase;
	}
	public void setRscIdCase(List<LinkedHashMap<String, Object>> rscIdCase) {
		this.rscIdCase = rscIdCase;
	}
	public List<LinkedHashMap<String, Object>> getRscIdList() {
		return rscIdList;
	}
	public void setRscIdList(List<LinkedHashMap<String, Object>> rscIdList) {
		this.rscIdList = rscIdList;
	}
	public String getRsc_grp_id() {
		return rsc_grp_id;
	}
	public void setRsc_grp_id(String rsc_grp_id) {
		this.rsc_grp_id = rsc_grp_id;
	}
	public String getRsc_id() {
		return rsc_id;
	}
	public void setRsc_id(String rsc_id) {
		this.rsc_id = rsc_id;
	}
	public String getTitleName() {
		return titleName;
	}
	public void setTitleName(String titleName) {
		this.titleName = titleName;
	}
	
	@Override
	public String toString() {
		return "ResourceStatisticsDomain [system_id=" + system_id + ", typeId="
				+ typeId + ", startDate=" + startDate + ", startHour="
				+ startHour + ", startMin=" + startMin + ", endDate=" + endDate
				+ ", endHour=" + endHour + ", endMin=" + endMin
				+ ", startTime=" + startTime + ", endTime=" + endTime
				+ ", dateformat=" + dateformat + ", systemArray="
				+ Arrays.toString(systemArray) + ", orderBy=" + orderBy
				+ ", locale=" + locale + ", rscIdCase=" + rscIdCase
				+ ", rscIdList=" + rscIdList + ", rsc_grp_id=" + rsc_grp_id
				+ ", rsc_id=" + rsc_id + ", titleName=" + titleName + "]";
	}
    
    
}
