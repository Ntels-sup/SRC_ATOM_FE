package com.ntels.avocado.domain.atom.general.systeminfor;

import com.ntels.avocado.domain.common.CommonCondition;

public class SystemInforDomain extends CommonCondition {
	
	private String nodeId;	// 검색 조건
	private String userLevelId; //사용자 레벨 아이디
	private String language;
	
	private String orderBy;
	private String titleName;
	
	//LIST DATA
	private String node_id;
	private String pkg_name;
	private String node_name;
	private String prc_date;
	private String cpu_name;
	private String kernel;
	private String memory;
	private String db_name;
	private String os;
	private String python;
	

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getUserLevelId() {
		return userLevelId;
	}

	public void setUserLevelId(String userLevelId) {
		this.userLevelId = userLevelId;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}
	//LIST DATA

	

	public String getPkg_name() {
		return pkg_name;
	}

	public String getNode_id() {
		return node_id;
	}

	public void setNode_id(String node_id) {
		this.node_id = node_id;
	}

	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
	}

	public String getNode_name() {
		return node_name;
	}

	public void setNode_name(String node_name) {
		this.node_name = node_name;
	}

	public String getPrc_date() {
		return prc_date;
	}

	public void setPrc_date(String prc_date) {
		this.prc_date = prc_date;
	}

	public String getCpu_name() {
		return cpu_name;
	}

	public void setCpu_name(String cpu_name) {
		this.cpu_name = cpu_name;
	}

	public String getKernel() {
		return kernel;
	}

	public void setKernel(String kernel) {
		this.kernel = kernel;
	}

	public String getMemory() {
		return memory;
	}

	public void setMemory(String memory) {
		this.memory = memory;
	}

	public String getDb_name() {
		return db_name;
	}

	public void setDb_name(String db_name) {
		this.db_name = db_name;
	}

	public String getOs() {
		return os;
	}

	public void setOs(String os) {
		this.os = os;
	}

	public String getPython() {
		return python;
	}

	public void setPython(String python) {
		this.python = python;
	}

	public String getNodeId() {
		return nodeId;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public String getTitleName() {
		return titleName;
	}

	public void setTitleName(String titleName) {
		this.titleName = titleName;
	}
	
	
}
