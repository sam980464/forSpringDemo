package com.bo;

public class OfficeExpensesItemBO {
	private int id;
	private String ItemName;
	private int status;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getItemName() {
		return this.ItemName;
	}

	public void setItemName(String itemName) {
		this.ItemName = itemName;
	}

	public int getStatus() {
		return this.status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}