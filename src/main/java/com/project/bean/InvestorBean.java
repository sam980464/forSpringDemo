package com.project.bean;

public class InvestorBean {
	private int investor_id;
	private String investor_name;
	private String investor_address;
	private String investor_email_id;
	private String investor_contactno;
	private String investor_details;

	public void setInvestor_id(int investor_id) {
		this.investor_id = investor_id;
	}

	public int getInvestor_id() {
		return this.investor_id;
	}

	public void setInvestor_address(String investor_address) {
		this.investor_address = investor_address;
	}

	public String getInvestor_address() {
		return this.investor_address;
	}

	public void setInvestor_name(String investor_name) {
		this.investor_name = investor_name;
	}

	public String getInvestor_name() {
		return this.investor_name;
	}

	public void setInvestor_contactno(String investor_contactno) {
		this.investor_contactno = investor_contactno;
	}

	public String getInvestor_contactno() {
		return this.investor_contactno;
	}

	public void setInvestor_details(String investor_details) {
		this.investor_details = investor_details;
	}

	public String getInvestor_details() {
		return this.investor_details;
	}

	public void setInvestor_email_id(String investor_email_id) {
		this.investor_email_id = investor_email_id;
	}

	public String getInvestor_email_id() {
		return this.investor_email_id;
	}
}
