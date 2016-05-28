package com.ntels.avocado.domain.atom.authorization.user;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("package")
public class Package {
	
	@NotEmpty
	@Length(max=2)
	private String node_type;	
	@NotEmpty
	@Length(max=2)
	private String package_id;	
	@NotEmpty
	@Length(max=30)
	private String package_name;	
	@NotEmpty
	@Length(max=7)
	private String version;
	private String package_group;	
	@NotEmpty
	@Length(max=30)
	private String alias;	
	private String default_system_id;
	private String remark;
	
	public String getNode_type() {
		return node_type;
	}
	public void setNode_type(String node_type) {
		this.node_type = node_type;
	}
	public String getPackage_id() {
		return package_id;
	}
	public void setPackage_id(String package_id) {
		this.package_id = package_id;
	}
	public String getPackage_name() {
		return package_name;
	}
	public void setPackage_name(String package_name) {
		this.package_name = package_name;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getPackage_group() {
		return package_group;
	}
	public void setPackage_group(String package_group) {
		this.package_group = package_group;
	}
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	public String getDefault_system_id() {
		return default_system_id;
	}
	public void setDefault_system_id(String default_system_id) {
		this.default_system_id = default_system_id;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}	
}
