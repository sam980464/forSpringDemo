package com.project.bean;

public class BuyerBean {
	private int buyer_id;
	private String buyer_name;
	private String buyer_address;
	private String buyer_email;
	private String buyer_contactno;
	private String buyer_details;

	public void setBuyer_id(int buyer_id) {
		this.buyer_id = buyer_id;
	}

	public int getBuyer_id() {
		return this.buyer_id;
	}

	public void setBuyer_details(String buyer_details) {
		this.buyer_details = buyer_details;
	}

	public String getBuyer_details() {
		return this.buyer_details;
	}

	public void setBuyer_name(String buyer_name) {
		this.buyer_name = buyer_name;
	}

	public String getBuyer_name() {
		return this.buyer_name;
	}

	public void setBuyer_address(String buyer_address) {
		this.buyer_address = buyer_address;
	}

	public String getBuyer_address() {
		return this.buyer_address;
	}

	public void setBuyer_contactno(String buyer_contactno) {
		this.buyer_contactno = buyer_contactno;
	}

	public String getBuyer_contactno() {
		return this.buyer_contactno;
	}

	public void setBuyer_email(String buyer_email) {
		this.buyer_email = buyer_email;
	}

	public String getBuyer_email() {
		return this.buyer_email;
	}
}
