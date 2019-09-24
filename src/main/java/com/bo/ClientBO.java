package com.bo;

public class ClientBO {
	private int id;
	String clientName;
	String mrMs;
	String guardianRelation;
	String guardianName;
	int municipality;
	String wordNo;
	String presentAddress;
	String permanentAddress;
	String mobile;
	String land;
	int ref;
	String email;
	String email1;
	String dateCreated;
	private double total_amount;
	String state_name;
	int associatedDeveloperId;

	public String getMrMs() {
		return this.mrMs;
	}

	public void setMrMs(String mrMs) {
		this.mrMs = mrMs;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getClientName() {
		return this.clientName;
	}

	public double getTotal_amount() {
		return this.total_amount;
	}

	public void setTotal_amount(double total_amount) {
		this.total_amount = total_amount;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getGuardianRelation() {
		return this.guardianRelation;
	}

	public void setGuardianRelation(String guardianRelation) {
		this.guardianRelation = guardianRelation;
	}

	public String getGuardianName() {
		return this.guardianName;
	}

	public void setGuardianName(String guardianName) {
		this.guardianName = guardianName;
	}

	public int getMunicipality() {
		return this.municipality;
	}

	public void setMunicipality(int municipality) {
		this.municipality = municipality;
	}

	public String getWordNo() {
		return this.wordNo;
	}

	public void setWordNo(String wordNo) {
		this.wordNo = wordNo;
	}

	public String getPresentAddress() {
		return this.presentAddress;
	}

	public void setPresentAddress(String presentAddress) {
		this.presentAddress = presentAddress;
	}

	public String getPermanentAddress() {
		return this.permanentAddress;
	}

	public void setPermanentAddress(String permanentAddress) {
		this.permanentAddress = permanentAddress;
	}

	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getLand() {
		return this.land;
	}

	public void setLand(String land) {
		this.land = land;
	}

	public int getRef() {
		return this.ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail1() {
		return this.email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getDateCreated() {
		return this.dateCreated;
	}

	public void setDateCreated(String dateCreated) {
		this.dateCreated = dateCreated;
	}

	public String getState_name() {
		return state_name;
	}

	public void setState_name(String state_name) {
		this.state_name = state_name;
	}

	public int getAssociatedDeveloperId() {
		return associatedDeveloperId;
	}

	public void setAssociatedDeveloperId(int associatedDeveloperId) {
		this.associatedDeveloperId = associatedDeveloperId;
	}

	
	
}