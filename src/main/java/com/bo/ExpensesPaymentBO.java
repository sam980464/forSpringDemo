package com.bo;

public class ExpensesPaymentBO {
	private int id;
	private int expensesId;
	private int total_amount;
	private double amountReceived;
	private int receivedBy;
	private String paymentMethod;
	private String chequeNo;
	private String dateTime;
	private int bankId;

	public String getPaymentMethod() {
		return this.paymentMethod;
	}

	public String getDateTime() {
		return this.dateTime;
	}

	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getChequeNo() {
		return this.chequeNo;
	}

	public void setChequeNo(String chequeNo) {
		this.chequeNo = chequeNo;
	}

	public int getBankId() {
		return this.bankId;
	}

	public void setBankId(int bankId) {
		this.bankId = bankId;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getExpensesId() {
		return this.expensesId;
	}

	public void setExpensesId(int expensesId) {
		this.expensesId = expensesId;
	}

	public double getAmountReceived() {
		return this.amountReceived;
	}

	public void setAmountReceived(double amountReceived) {
		this.amountReceived = amountReceived;
	}

	public int getReceivedBy() {
		return this.receivedBy;
	}

	public void setReceivedBy(int receivedBy) {
		this.receivedBy = receivedBy;
	}

	public void setTotal_amount(int total_amount) {
		this.total_amount = total_amount;
	}

	public int getTotal_amount() {
		return this.total_amount;
	}
}