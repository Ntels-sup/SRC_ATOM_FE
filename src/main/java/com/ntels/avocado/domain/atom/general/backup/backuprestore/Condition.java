package com.ntels.avocado.domain.atom.general.backup.backuprestore;

import com.ntels.avocado.domain.common.CommonCondition;

/**
 * The Class Condition.
 */
public class Condition extends CommonCondition {
	
	private String node_id;
	private String targ_cd;
	private String targ_nm;
	private String system_id;
	private String system_id1;
	private String system_id2;
	private String language;
	
	private String[] systemArray;
	
	
	public String getNode_id() {
		return node_id;
	}
	public void setNode_id(String node_id) {
		this.node_id = node_id;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
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
	public String getSystem_id1() {
		return system_id1;
	}
	public void setSystem_id1(String system_id1) {
		this.system_id1 = system_id1;
	}
	public String getSystem_id2() {
		return system_id2;
	}
	public void setSystem_id2(String system_id2) {
		this.system_id2 = system_id2;
	}
	public String getTarg_cd() {
		return targ_cd;
	}
	public void setTarg_cd(String targ_cd) {
		this.targ_cd = targ_cd;
	}
	public String getTarg_nm() {
		return targ_nm;
	}
	public void setTarg_nm(String targ_nm) {
		this.targ_nm = targ_nm;
	}

}
