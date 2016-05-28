package com.ntels.avocado.domain.atom.performance.resourcestatistics;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("resourceStatistics")
public class ResourceStatistics {

  private String prc_date;
  private String node_id;
  private String node_name;
  private String rsc_grp_name;
  private String rsc_name;
  private String rsc_id;
  
public String getPrc_date() {
	return prc_date;
}
public void setPrc_date(String prc_date) {
	this.prc_date = prc_date;
}
public String getNode_id() {
	return node_id;
}
public void setNode_id(String node_id) {
	this.node_id = node_id;
}
public String getNode_name() {
	return node_name;
}
public void setNode_name(String node_name) {
	this.node_name = node_name;
}
public String getRsc_grp_name() {
	return rsc_grp_name;
}
public void setRsc_grp_name(String rsc_grp_name) {
	this.rsc_grp_name = rsc_grp_name;
}
public String getRsc_name() {
	return rsc_name;
}
public void setRsc_name(String rsc_name) {
	this.rsc_name = rsc_name;
}
public String getRsc_id() {
	return rsc_id;
}
public void setRsc_id(String rsc_id) {
	this.rsc_id = rsc_id;
}


}
