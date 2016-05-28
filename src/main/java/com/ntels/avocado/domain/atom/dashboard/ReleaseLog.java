package com.ntels.avocado.domain.atom.dashboard;

public class ReleaseLog {

	private String pkg_name;
	private String pkg_version;
	private String release_date;
	private String patch_date;
	
	public String getPkg_name() {
		return pkg_name;
	}
	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
	}
	public String getPkg_version() {
		return pkg_version;
	}
	public void setPkg_version(String pkg_version) {
		this.pkg_version = pkg_version;
	}
	public String getRelease_date() {
		return release_date;
	}
	public void setRelease_date(String release_date) {
		this.release_date = release_date;
	}
	public String getPatch_date() {
		return patch_date;
	}
	public void setPatch_date(String patch_date) {
		this.patch_date = patch_date;
	}



}
