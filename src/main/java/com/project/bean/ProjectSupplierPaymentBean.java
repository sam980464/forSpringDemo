/*
 * Decompiled with CFR 0_122.
 */
package com.project.bean;

public class ProjectSupplierPaymentBean {
    private String p_id;
    private String expense_id;
    private String pro_id;
    private String paid_amount;
    private String date;
    private String note;
    private String supplier_id;
    private String bank_id;
    private String payment_method;
    private String cheque_no;

    public void setSupplier_id(String supplier_id) {
        this.supplier_id = supplier_id;
    }

    public String getSupplier_id() {
        return this.supplier_id;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDate() {
        return this.date;
    }

    public void setBank_id(String bank_id) {
        this.bank_id = bank_id;
    }

    public String getBank_id() {
        return this.bank_id;
    }

    public void setP_id(String p_id) {
        this.p_id = p_id;
    }

    public String getP_id() {
        return this.p_id;
    }

    public void setCheque_no(String cheque_no) {
        this.cheque_no = cheque_no;
    }

    public String getCheque_no() {
        return this.cheque_no;
    }

    public void setPro_id(String pro_id) {
        this.pro_id = pro_id;
    }

    public String getPro_id() {
        return this.pro_id;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getNote() {
        return this.note;
    }

    public void setPayment_method(String payment_method) {
        this.payment_method = payment_method;
    }

    public String getPayment_method() {
        return this.payment_method;
    }

    public void setPaid_amount(String paid_amount) {
        this.paid_amount = paid_amount;
    }

    public String getPaid_amount() {
        return this.paid_amount;
    }

    public void setExpense_id(String expense_id) {
        this.expense_id = expense_id;
    }

    public String getExpense_id() {
        return this.expense_id;
    }
}
