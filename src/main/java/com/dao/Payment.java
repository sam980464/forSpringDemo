package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;



import java.util.Date;

import com.bo.GstBO;

import javax.naming.NamingException;

import com.bo.PaymentBO;
import com.util.DBUtility;

public class Payment {
	int id;
	int clientId;
	int estimateId;
	String paymentMethod = "CASH";
	String chequeNo = "";
	int bankid;
	Double amountEstimated;
	Double amountReceived;
	String dateReceived;
	String addGst;
	int receivedBy;
	int sumClientId;
	Double gstAmount;
	int gstPercentage;
	String sumClientName;
	Double sumEstimate;
	Double sumPaid;
	Double sumUnPaid;

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

	public Double getAmountEstimated() {
		return this.amountEstimated;
	}

	public void setAmountEstimated(Double amountEstimated) {
		this.amountEstimated = amountEstimated;
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
	
	public String getAddGst() {
		return addGst;
	}

	public void setAddGst(String addGst) {
		this.addGst = addGst;
	}

	public int getMaxId() {
		int max;
		max = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT max(id) max FROM `payment` ";
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
					max = res.getInt("max");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return max;
	}

	public String getClientNameByPaymentId(int id) {
		String client_name;
		client_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select  distinct client.client_name client_name from client,payment where  client.id=payment.client_id and payment.id="
				+ id;
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
					client_name = res.getString("client_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return client_name;
	}

	public int deletePayment() {
		Connection conn = null;
		Statement st = null;
		ResultSet res = null;
		int returnVal = 0;
		try {
			try {
				try {
					conn = DBUtility.getConnection();
				} catch (NamingException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
				st = conn.createStatement();
				String sql = "delete from  `payment` WHERE `id` ="
						+ this.getId();
				returnVal = st.executeUpdate(sql);
			} catch (SQLException s) {
				System.out.println(s);
				s.printStackTrace();
				DBUtility.closeConnection(conn, st, res);
			}
		} finally {
			DBUtility.closeConnection(conn, st, res);
		}
		return returnVal;
	}

	public int getClientIdByPaymentId(int pid) {
		int client_id;
		client_id = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select  client_id from payment where  payment.id=" + pid;
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
					client_id = res.getInt("client_id");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return client_id;
	}

	public double getAmountReceivedByPaymentId(int pid) {
		double amount_received;
		amount_received = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select  amount_received from payment where  id=" + pid;
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
					amount_received = res.getInt("amount_received");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount_received;
	}

	public double getTotalAmountReceivedByCId(int cid) {
		double amount_received;
		amount_received = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT sum(`amount_received`) amount_received FROM `payment` WHERE `client_id` ="
				+ cid;
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
					amount_received = res.getDouble("amount_received");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount_received;
	}

	public double getTotalAmountReceivedByEstimateId(int eid) {
		double total_received;
		total_received = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT sum(`amount_received`) total_received FROM `payment` WHERE `estimate_id`="
				+ eid;
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
					total_received = res.getDouble("total_received");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return total_received;
	}

	public String getDateReceivedByPaymentId(int pid) {
		String received_date;
		received_date = "";
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select  received_date from payment where  id=" + pid;
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
					received_date = res.getString("received_date");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return received_date;
	}

	public String getPaymentMethodByPaymentId(int pid) {
		String paymeny_method;
		paymeny_method = "";
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select  paymeny_method from payment where  id=" + pid;
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
					paymeny_method = res.getString("paymeny_method");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return paymeny_method;
	}
	public String getAddGstFlagByPaymentId(int pid) {
		String add_gst;
		add_gst = "";
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select  add_gst from payment where  id=" + pid;
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
					add_gst = res.getString("add_gst");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return add_gst;
	}

	
	public GstBO getGstDetailByPaymentId(int pid) {
		GstBO gstBo = new GstBO();
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select  gst_percentage,gst_amount from payment where  id=" + pid;
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
					gstBo.setGst_amount(res.getString("gst_amount")); 
					gstBo.setGst_percentage(res.getString("gst_percentage")); 
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return gstBo;
	}
	public String getChecknoWithBankByPaymentId(int pid) {
		String cheque_no;
		String cheque_bank_name;
		cheque_bank_name="";
		cheque_no = "";
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select  p.cheque_no,b.bank_name from payment p,bank b where  p.id=" + pid +" and p.bank_id=b.id";
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
					cheque_no = res.getString("cheque_no");
					cheque_bank_name = res.getString("bank_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return cheque_no+" ("+cheque_bank_name+") ";
	}
	
	public String getChecknoByPaymentId(int pid) {
		String cheque_no;
		String cheque_bank_name;
		cheque_bank_name="";
		cheque_no = "";
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select  p.cheque_no,b.bank_name from payment p,bank b where  p.id=" + pid +" and p.bank_id=b.id";
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
					cheque_no = res.getString("cheque_no");
					cheque_bank_name = res.getString("bank_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return cheque_no;
	}
	
	public int getBankIdByPaymentId(int pid) {
		
		int bank_id= 0;
		
		
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select p.bank_id from payment p where  p.id=" + pid ;
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
					
					bank_id = res.getInt("bank_id");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return bank_id;
	}

	public String getSchemeNameByPaymentId(int pid) {
		String scheme_name;
		scheme_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select scheme_name from scheme where id=(select scheme_id from estimate where id=(SELECT estimate_id FROM `payment` where id="
				+ pid + "))";
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
					scheme_name = res.getString("scheme_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return scheme_name;
	}

	public int getEstimateIdByPaymentId(int pid) {
		int estimate_id;
		estimate_id = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT estimate_id FROM `payment` where id=" + pid;
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
					estimate_id = res.getInt("estimate_id");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return estimate_id;
	}

	public Double getDueByEstimateId(int eid) {
		Double due;
		due = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select estimate_amount,payment_amount, COALESCE((estimate_amount - payment_amount),0) as due from (select (select amount  from estimate where estimate.id="
				+ eid
				+ ") as estimate_amount,"
				+ "COALESCE(sum(amount_received),0) as payment_amount from payment "
				+ "where estimate_id=" + eid + ") as a";
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
					due = res.getDouble("due");
				}
			} catch (Exception e) {
				e.printStackTrace();
				due = 0.0;
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return due;
	}

	public int addData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `payment` (`client_id`, `estimate_id`, `paymeny_method`, `cheque_no`,`bank_id`, `amount_received`, `received_date`, `received_by`,`gst_percentage`,`gst_amount`,`add_gst`,`billPrintCount`,`receiptPrintCount`,`billPrintDate`,`receiptPtintDate`) VALUES ("
						+ this.getClientId()
						+ ", "
						+ this.getEstimateId()
						+ ", '"
						+ this.getPaymentMethod()
						+ "', '"
						+ this.getChequeNo()
						+ "',"
						+ this.getBankid()
						+ ", "
						+ this.getAmountReceived()
						+ ", '"
						+ this.getDateReceived()
						+ "', "
						+ this.getReceivedBy()
						+ ", "
						+ this.getGstPercentage()
						+ ", "
						+ this.getGstAmount()
						+", '"
						+this.getAddGst()
						+ "',"
						+ 0
						+ ", "						
						+ 0
						+ ", '"						
						+ "2018-03-11"
						+ "', '"											
						+ "2018-03-11"						
						+ "' )";
				System.out.println(sql);
				if (this.getAmountReceived() > 0.0) {
					returnVal = st.executeUpdate(sql);
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
		return returnVal;
	}

	public int updateData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				if(this.getPaymentMethod().equals("CASH")){
					this.setChequeNo("");
				}
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
				returnVal = st.executeUpdate(sql);
				st = null;
			} catch (Exception e) {
				System.out.println(e);
				e.printStackTrace();
				DBUtility.closeConnection(con, st, (ResultSet) null);
			}
		} finally {
			DBUtility.closeConnection(con, st, (ResultSet) null);
		}
		return returnVal;
	}
	
	
	public void updateBillCount(int billCount) {
		Connection con = null;
		Statement st = null;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				java.util.Date date=new java.util.Date();	            
	            java.sql.Date sqlDate=new java.sql.Date(date.getTime());
				String sql = "UPDATE  payment SET `billPrintCount`=" + billCount
						 + ",`billPrintDate`='"+  sqlDate
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
	}
	public void updateReceiptCount(int receiptCount) {
		Connection con = null;
		Statement st = null;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				java.util.Date date=new java.util.Date();	            
	            java.sql.Date sqlDate=new java.sql.Date(date.getTime());
	            
	            
				String sql = "UPDATE  payment SET `receiptPrintCount`=" + receiptCount
						 + ",`receiptPtintDate`='"+  sqlDate	
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
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<PaymentBO> getAllItem() {
		ArrayList<PaymentBO> paymentBOList;
		paymentBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `payment`";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				paymentBOList = this.populateItemList(res);
			} catch (SQLException s) {
				s.printStackTrace();
				DBUtility.closeConnection(con, st, res);
				return null;
			} catch (NamingException e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			} catch (Exception e) {
				e.printStackTrace();

				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return paymentBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<PaymentBO> getAllItemByCId(int cid) {
		ArrayList<PaymentBO> paymentBOList;
		paymentBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `payment` where client_id=" + cid +" order by received_date desc";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				paymentBOList = this.populateItemList(res);
			} catch (SQLException s) {
				s.printStackTrace();
				DBUtility.closeConnection(con, st, res);
				return null;
			} catch (NamingException e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			} catch (Exception e) {
				e.printStackTrace();

				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return paymentBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<PaymentBO> getAllItemByEId(int eid) {
		ArrayList<PaymentBO> paymentBOList;
		paymentBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `payment` where estimate_id="
						+ eid +" order by received_date desc";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				paymentBOList = this.populateItemList(res);
			} catch (SQLException s) {
				s.printStackTrace();
				DBUtility.closeConnection(con, st, res);
				return null;
			} catch (NamingException e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			} catch (Exception e) {
				e.printStackTrace();

				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return paymentBOList;
	}
	
	public ArrayList<PaymentBO> getAllItemByPId(int pid) {
		ArrayList<PaymentBO> paymentBOList;
		paymentBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `payment` where id="
						+ pid +" order by received_date desc";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				paymentBOList = this.populateItemList(res);
			} catch (SQLException s) {
				s.printStackTrace();
				DBUtility.closeConnection(con, st, res);
				return null;
			} catch (NamingException e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			} catch (Exception e) {
				e.printStackTrace();

				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return paymentBOList;
	}

	private ArrayList<PaymentBO> populateItemList(ResultSet res) {
		ArrayList<PaymentBO> paymentList = null;
		PaymentBO paymentBO = null;
		if (res != null) {
			paymentList = new ArrayList<PaymentBO>();
			try {
				while (res.next()) {
					paymentBO = new PaymentBO();
					paymentBO.setId(res.getInt("id"));
					paymentBO.setClientId(res.getInt("client_id"));
					paymentBO.setEstimateId(res.getInt("estimate_id"));
					paymentBO.setPaymentMethod(res.getString("paymeny_method"));
					paymentBO.setChequeNo(res.getString("cheque_no"));
					paymentBO.setAddGstFlag(res.getString("add_gst"));
					paymentBO.setBankid(res.getInt("bank_id"));
					paymentBO.setAmountReceived(Double.valueOf(res
							.getDouble("amount_received")));
					paymentBO.setDateReceived(res.getString("received_date"));
					paymentBO.setReceivedBy(res.getInt("received_by"));
					paymentBO.setGstAmount(res.getDouble("gst_amount"));
					paymentBO.setGstPercentage(res.getInt("gst_percentage"));
					paymentBO.setBillPrintCount(res.getInt("billPrintCount"));
					paymentBO.setReceiptPrintCount(res.getInt("receiptPrintCount"));
					paymentBO.setReceiptPtintDate(res.getString("receiptPtintDate"));
					paymentBO.setBillPrintDate(res.getString("billPrintDate"));
					paymentList.add(paymentBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return paymentList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<PaymentBO> getAllDueResult() {
		ArrayList<PaymentBO> paymentBOList;
		paymentBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT p.client_id as id, (select client_name from client where id=p.client_id) as `name`,(select ward_no from client where id=p.client_id) as `ward_no`,(select mobile_no from client where id=p.client_id) as `mobile_no`,(select m.municipality_name from client c,municipality m where c.id=p.client_id and c.municipality=m.id) as `municipality_name`, (select sum(estimate.amount) from estimate where estimate.client_id=p.client_id)  as `estimate`, SUM(p.amount_received) AS amount_received, (select sum(estimate.amount) from estimate where estimate.client_id=p.client_id)-SUM(p.amount_received) as amount_unpaid FROM payment p,client c where p.client_id=c.id and c.status =1 GROUP BY p.client_id  order by p.received_date desc";
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				paymentBOList = this.populateSummarizeList(res);
			} catch (SQLException s) {
				s.printStackTrace();
				DBUtility.closeConnection(con, st, res);
				return null;
			} catch (NamingException e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			} catch (Exception e) {
				e.printStackTrace();

				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return paymentBOList;
	}

	private ArrayList<PaymentBO> populateSummarizeList(ResultSet res) {
		ArrayList<PaymentBO> paymentList = null;
		PaymentBO paymentBO = null;
		if (res != null) {
			paymentList = new ArrayList<PaymentBO>();
			try {
				while (res.next()) {
					if(Double.valueOf(res
							.getDouble("amount_unpaid"))>0){
						paymentBO = new PaymentBO();
						paymentBO.setMobile_no(res.getString("mobile_no"));
						paymentBO.setWard_no(res.getString("ward_no"));
						paymentBO.setMunicipality_name(res.getString("municipality_name"));
						paymentBO.setSumClientId(res.getInt("id"));
						paymentBO.setSumClientName(res.getString("name"));
						paymentBO.setSumEstimate(Double.valueOf(res
								.getDouble("estimate")));
						paymentBO.setSumPaid(Double.valueOf(res
								.getDouble("amount_received")));
						paymentBO.setSumUnPaid(Double.valueOf(res
								.getDouble("amount_unpaid")));
						paymentList.add(paymentBO);
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return paymentList;
	}
}