package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.DistrictBO;
import com.bo.GstBO;
import com.util.DBUtility;

public class Print {
	private int id;
	private int payment_id;
	private String receipt_date;
	private int count;
	private int receiptBy;
	
	

	public int getId() {
		return id;
	}




	public void setId(int id) {
		this.id = id;
	}




	public int getPayment_id() {
		return payment_id;
	}




	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
	}




	public String getReceipt_date() {
		return receipt_date;
	}




	public void setReceipt_date(String receipt_date) {
		this.receipt_date = receipt_date;
	}




	public int getCount() {
		return count;
	}




	public void setCount(int count) {
		this.count = count;
	}




	public int getReceiptBy() {
		return receiptBy;
	}




	public void setReceiptBy(int receiptBy) {
		this.receiptBy = receiptBy;
	}




	public int getIdByPaymentId(int paymentId) {
		int printCount;
		printCount = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select  count from printreceipt where  payment_id"
				+ paymentId;
		try {
			con = DBUtility.getConnection();
		} catch (NamingException e1) {
			e1.printStackTrace();
		} catch (SQLException e1) {
			e1.printStackTrace();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		try {
			try {
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				while (res.next()) {
					printCount = res.getInt("count");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return printCount;
	}
	
	public void addData() {
		Connection con = null;
		Statement st = null;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `payment` (`payment_id`, `receipt_date`, `count`, `receiptBy`) VALUES ("
						+ this.getPayment_id()
						+ ", '"
						+ this.getReceipt_date()
						+ "', "
						+ this.getCount()
						+ ", "
						+ this.getReceiptBy()										
						+ " )";
				System.out.println(sql);
				if (this.getPayment_id() > 0.0) {
					st.executeUpdate(sql);
				}
				st = null;
			} catch (Exception e) {
				System.out.println(e);
				e.printStackTrace();
				DBUtility.closeConnection(con, st, (ResultSet) null);
			}
		} finally {
			DBUtility.closeConnection(con, st, (ResultSet) null);
		}
	}
	
	/*public void updateData() {
		Connection con = null;
		Statement st = null;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();				
				String sql = "UPDATE  payment SET `paymeny_method`='" + this.getPaymentMethod() + 
						"',`cheque_no`='"+ this.getChequeNo()
						 + "',`bank_id`="+ this.getBankid()
						 + ",`amount_received`="+ this.getAmountReceived()
						 + ",`gst_percentage`="+ this.getGstPercentage()
						 + ",`add_gst`='"+ this.getAddGst()
						 + "',`gst_amount`="+ this.getGstAmount()
						 + ",`received_date`='"+ this.getDateReceived()
						 + "'  WHERE ID="
						+ this.getId();
				System.out.println(sql);
				st.executeUpdate(sql);
				st = null;
			} catch (Exception e) {
				System.out.println(e);
				e.printStackTrace();
				DBUtility.closeConnection(con, st, (ResultSet) null);
			}
		} finally {
			DBUtility.closeConnection(con, st, (ResultSet) null);
		}
	}*/

}