package com.bo;

public class PaymentBO {
	int id;
	int clientId;
	String clientName;
	String municipality_name;
	String ward_no;
	String mobile_no;
	int estimateId;
	String paymentMethod;
	String chequeNo;
	String addGstFlag;
	int bankid;
	Double amountReceived;
	Double gstAmount;
	int gstPercentage;
	String dateReceived;
	int receivedBy;
	int sumClientId;
	String sumClientName;
	Double sumEstimate;
	Double sumPaid;
	Double sumUnPaid;
	int schemeId;
	String schemeName;
	int billPrintCount;
	int receiptPrintCount;
	String receiptPtintDate;
	String billPrintDate;
	
	
	public String getWard_no() {
		return ward_no;
	}

	public void setWard_no(String ward_no) {
		this.ward_no = ward_no;
	}

	public String getMunicipality_name() {
		return municipality_name;
	}

	public void setMunicipality_name(String municipality_name) {
		this.municipality_name = municipality_name;
	}

	public String getMobile_no() {
		return mobile_no;
	}

	public void setMobile_no(String mobile_no) {
		this.mobile_no = mobile_no;
	}

	public int getSchemeId() {
		return schemeId;
	}

	public void setSchemeId(int schemeId) {
		this.schemeId = schemeId;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getBankid() {
		return this.bankid;
	}

	public void setBankid(int bankid) {
		this.bankid = bankid;
	}

	public int getClientId() {
		return this.clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public int getEstimateId() {
		return this.estimateId;
	}

	public void setEstimateId(int estimateId) {
		this.estimateId = estimateId;
	}

	public String getPaymentMethod() {
		return this.paymentMethod;
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

	public Double getAmountReceived() {
		return this.amountReceived;
	}

	public void setAmountReceived(Double amountReceived) {
		this.amountReceived = amountReceived;
	}

	public String getDateReceived() {
		return this.dateReceived;
	}

	public void setDateReceived(String dateReceived) {
		this.dateReceived = dateReceived;
	}

	public int getReceivedBy() {
		return this.receivedBy;
	}

	public void setReceivedBy(int receivedBy) {
		this.receivedBy = receivedBy;
	}

	public int getSumClientId() {
		return this.sumClientId;
	}

	public void setSumClientId(int sumClientId) {
		this.sumClientId = sumClientId;
	}

	public String getSumClientName() {
		return this.sumClientName;
	}

	public void setSumClientName(String sumClientName) {
		this.sumClientName = sumClientName;
	}

	public Double getSumEstimate() {
		return this.sumEstimate;
	}

	public void setSumEstimate(Double sumEstimate) {
		this.sumEstimate = sumEstimate;
	}

	public Double getSumPaid() {
		return this.sumPaid;
	}

	public void setSumPaid(Double sumPaid) {
		this.sumPaid = sumPaid;
	}

	public Double getSumUnPaid() {
		return this.sumUnPaid;
	}

	public void setSumUnPaid(Double sumUnPaid) {
		this.sumUnPaid = sumUnPaid;
	}

	public Double getGstAmount() {
		return gstAmount;
	}

	public void setGstAmount(Double gstAmount) {
		this.gstAmount = gstAmount;
	}

	public int getGstPercentage() {
		return gstPercentage;
	}

	public void setGstPercentage(int gstPercentage) {
		this.gstPercentage = gstPercentage;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getSchemeName() {
		return schemeName;
	}

	public void setSchemeName(String schemeName) {
		this.schemeName = schemeName;
	}

	public String getAddGstFlag() {
		return addGstFlag;
	}

	public void setAddGstFlag(String addGstFlag) {
		this.addGstFlag = addGstFlag;
	}

	public int getBillPrintCount() {
		return billPrintCount;
	}

	public void setBillPrintCount(int billPrintCount) {
		this.billPrintCount = billPrintCount;
	}

	public int getReceiptPrintCount() {
		return receiptPrintCount;
	}

	public void setReceiptPrintCount(int receiptPrintCount) {
		this.receiptPrintCount = receiptPrintCount;
	}

	public String getReceiptPtintDate() {
		return receiptPtintDate;
	}

	public void setReceiptPtintDate(String receiptPtintDate) {
		this.receiptPtintDate = receiptPtintDate;
	}

	public String getBillPrintDate() {
		return billPrintDate;
	}

	public void setBillPrintDate(String billPrintDate) {
		this.billPrintDate = billPrintDate;
	}
	
	
	
}