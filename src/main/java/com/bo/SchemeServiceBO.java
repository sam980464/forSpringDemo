package com.bo;

public class SchemeServiceBO {
	private int id;
	private int SchemeId;
	private int ServiceId;
	private String SchemeName;
	private String Servicename;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getSchemeId() {
		return this.SchemeId;
	}

	public void setSchemeId(int schemeId) {
		this.SchemeId = schemeId;
	}

	public int getServiceId() {
		return this.ServiceId;
	}

	public void setServiceId(int serviceId) {
		this.ServiceId = serviceId;
	}

	public String getSchemeName() {
		return this.SchemeName;
	}

	public void setSchemeName(String schemeName) {
		this.SchemeName = schemeName;
	}

	public String getServicename() {
		return this.Servicename;
	}

	public void setServicename(String servicename) {
		this.Servicename = servicename;
	}
}