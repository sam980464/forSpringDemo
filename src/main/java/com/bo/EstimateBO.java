package com.bo;

public class EstimateBO {
	int id;
	int clientId;
	int schemeId;
	double amount;
	int createdBy;
	String dateCreated;
	String dateModified;
	String estimateNote;
	String schemeName;
	double sumtotal;

	public double getSumtotal() {
		return this.sumtotal;
	}

	public void setSumtotal(double sumtotal) {
		this.sumtotal = sumtotal;
	}

	public String getSchemeName() {
		return this.schemeName;
	}

	public void setSchemeName(String schemeName) {
		this.schemeName = schemeName;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getClientId() {
		return this.clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public int getSchemeId() {
		return this.schemeId;
	}

	public void setSchemeId(int schemeId) {
		this.schemeId = schemeId;
	}

	public double getAmount() {
		return this.amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public int getCreatedBy() {
		return this.createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	public String getDateCreated() {
		return this.dateCreated;
	}

	public void setDateCreated(String dateCreated) {
		this.dateCreated = dateCreated;
	}

	public String getDateModified() {
		return this.dateModified;
	}

	public void setDateModified(String dateModified) {
		this.dateModified = dateModified;
	}

	public String getEstimateNote() {
		return this.estimateNote;
	}

	public void setEstimateNote(String estimateNote) {
		this.estimateNote = estimateNote;
	}
}