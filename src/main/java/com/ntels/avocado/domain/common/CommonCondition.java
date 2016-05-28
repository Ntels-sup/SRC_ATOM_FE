package com.ntels.avocado.domain.common;

public class CommonCondition {

	private Integer page = 1;
	private Integer perPage=10;
	private Integer start;
	private Integer end;
	private String default_orderBy_clause;
	private String orderBy_clause;
	private String language;
	

	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getPerPage() {
		return perPage;
	}
	public void setPerPage(Integer perPage) {
		this.perPage = perPage;
	}
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public Integer getEnd() {
		return end;
	}
	public void setEnd(Integer end) {
		this.end = end;
	}
	public String getDefault_orderBy_clause() {
		return default_orderBy_clause;
	}
	public void setDefault_orderBy_clause(String default_orderBy_clause) {
		this.default_orderBy_clause = default_orderBy_clause;
	}
	public String getOrderBy_clause() {
		return orderBy_clause;
	}
	public void setOrderBy_clause(String orderBy_clause) {
		this.orderBy_clause = orderBy_clause;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}

	
	@Override
	public String toString() {
		return "CommonCondition [page=" + page + ", perPage=" + perPage
				+ ", start=" + start + ", end=" + end
				+ ", default_orderBy_clause=" + default_orderBy_clause
				+ ", orderBy_clause=" + orderBy_clause + ", language="
				+ language + "]";
	}

}
