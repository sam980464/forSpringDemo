package com.bo;

public class SchemeBO {
	private int id;
	private String schemeName;
	private int parent_scheme_id;
	private int status;
	private int gstValue;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getParent_scheme_id() {
		return this.parent_scheme_id;
	}

	public void setParent_scheme_id(int parent_scheme_id) {
		this.parent_scheme_id = parent_scheme_id;
	}

	public String getSchemeName() {
		return this.schemeName;
	}

	public void setSchemeName(String schemeName) {
		this.schemeName = schemeName;
	}

	public int getStatus() {
		return this.status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getGstValue() {
		return gstValue;
	}

	public void setGstValue(int gstValue) {
		this.gstValue = gstValue;
	}
	
}