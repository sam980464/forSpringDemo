package com.bo;

public class OfficeExpensesBO {
	private int id;
	private int ExpensesName;
	private String ExpensesDesc;
	private String DateTime;
	private double amount;
	private String ChequeNo;
	private int BankId;
	private int UserID;
	private int status;
	private String ExpensesNameTxt;
	private String BankName;

	public String getBankName() {
		return this.BankName;
	}

	public void setBankName(String bankName) {
		this.BankName = bankName;
	}

	public String getExpensesNameTxt() {
		return this.ExpensesNameTxt;
	}

	public void setExpensesNameTxt(String expensesNameTxt) {
		this.ExpensesNameTxt = expensesNameTxt;
	}

	public int getId() {
		return this.id;
	}

	public int getUserID() {
		return this.UserID;
	}

	public void setUserID(int userID) {
		this.UserID = userID;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getExpensesName() {
		return this.ExpensesName;
	}

	public void setExpensesName(int expensesName) {
		this.ExpensesName = expensesName;
	}

	public String getExpensesDesc() {
		return this.ExpensesDesc;
	}

	public void setExpensesDesc(String expensesDesc) {
		this.ExpensesDesc = expensesDesc;
	}

	public String getDateTime() {
		return this.DateTime;
	}

	public void setDateTime(String dateTime) {
		this.DateTime = dateTime;
	}

	public double getAmount() {
		return this.amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getChequeNo() {
		return this.ChequeNo;
	}

	public void setChequeNo(String chequeNo) {
		this.ChequeNo = chequeNo;
	}

	public int getBankId() {
		return this.BankId;
	}

	public void setBankId(int bankId) {
		this.BankId = bankId;
	}

	public int getStatus() {
		return this.status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}