package com.ntels.avocado.domain.atom.performance.statisticsconfig;

import com.ntels.avocado.domain.common.CommonCondition;

public class StatisticsConfigDomain extends CommonCondition {
	
	
	private String titleName;
	private String orderBy;
	
	private String pkg_name;
	private String table_name; //statistics
	private String collect_yn;
	private String collect_period;
	public String getTitleName() {
		return titleName;
	}
	public void setTitleName(String titleName) {
		this.titleName = titleName;
	}
	public String getOrderBy() {
		return orderBy;
	}
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	public String getPkg_name() {
		return pkg_name;
	}
	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
	}
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}
	public String getCollect_yn() {
		return collect_yn;
	}
	public void setCollect_yn(String collect_yn) {
		this.collect_yn = collect_yn;
	}
	public String getCollect_period() {
		return collect_period;
	}
	public void setCollect_period(String collect_period) {
		this.collect_period = collect_period;
	}
	
}
