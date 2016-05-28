package com.ntels.avocado.domain.atom.fault.alarmlevel;

import java.util.List;

public class AlmMonitorDef implements Cloneable {
	String monitor_def_no;
	String pkg_name;
	String code;
	String node_type;
	String max_value;
	String unit_value;
	String ref_table;
	String ref_column;
	String column_condition;
	String target_name_column;
	String max_value_column;
	String node_type_column;
	String desctiption;
	String target;
	List<AlmLevel> almLevelList;
	
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}
	
	public String getMonitor_def_no() {
		return monitor_def_no;
	}
	public void setMonitor_def_no(String monitor_def_no) {
		this.monitor_def_no = monitor_def_no;
	}
	public String getPkg_name() {
		return pkg_name;
	}
	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getNode_type() {
		return node_type;
	}
	public void setNode_type(String node_type) {
		this.node_type = node_type;
	}
	public String getMax_value() {
		return max_value;
	}
	public void setMax_value(String max_value) {
		this.max_value = max_value;
	}
	public String getUnit_value() {
		return unit_value;
	}
	public void setUnit_value(String unit_value) {
		this.unit_value = unit_value;
	}
	public String getRef_table() {
		return ref_table;
	}
	public void setRef_table(String ref_table) {
		this.ref_table = ref_table;
	}
	public String getRef_column() {
		return ref_column;
	}
	public void setRef_column(String ref_column) {
		this.ref_column = ref_column;
	}
	public String getColumn_condition() {
		return column_condition;
	}
	public void setColumn_condition(String column_condition) {
		this.column_condition = column_condition;
	}
	public String getTarget_name_column() {
		return target_name_column;
	}
	public void setTarget_name_column(String target_name_column) {
		this.target_name_column = target_name_column;
	}
	public String getMax_value_column() {
		return max_value_column;
	}
	public void setMax_value_column(String max_value_column) {
		this.max_value_column = max_value_column;
	}
	public String getNode_type_column() {
		return node_type_column;
	}
	public void setNode_type_column(String node_type_column) {
		this.node_type_column = node_type_column;
	}
	public String getDesctiption() {
		return desctiption;
	}
	public void setDesctiption(String desctiption) {
		this.desctiption = desctiption;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public List<AlmLevel> getAlmLevelList() {
		return almLevelList;
	}
	public void setAlmLevelList(List<AlmLevel> almLevelList) {
		this.almLevelList = almLevelList;
	}
}
