package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.ExpensesPaymentBO;
import com.util.DBUtility;

public class ExpensesPayment {
	private int id;
	private int expensesId;
	private double amountReceived;
	private int receivedBy;
	private String datetime;
	private String paymentMethod = "CASH";
	private String chequeNo = "";
	private int bankId;
	private String bill_number;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getBill_number() {
		return this.bill_number;
	}

	public void setBill_number(String bill_number) {
		this.bill_number = bill_number;
	}

	public String getDatetime() {
		return this.datetime;
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
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

	public int getBankId() {
		return this.bankId;
	}

	public void setBankId(int bankId) {
		this.bankId = bankId;
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

	public double getPaidAmountForPaymentId(int payment_id) {
		double amount_received;
		amount_received = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select amount_received  from expenses_payment where id="
				+ payment_id;
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

	public double getTotalPaidByExpId(int exp_id) {
		double paid;
		paid = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT sum(`amount_received`) paid FROM `expenses_payment` WHERE `expenses_id` ="
				+ exp_id;
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
					paid = res.getDouble("paid");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return paid;
	}

	public double getTotalPaidBySupplierAndClient(int sup_id, int cid) {
		double total_paid;
		total_paid = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select sum(amount_received) total_paid  from expenses_payment where expenses_id in ( SELECT id FROM `expenses` WHERE status=1 and `supplier_id` ="
				+ sup_id + " and client_id=" + cid + ")";
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
					total_paid = res.getDouble("total_paid");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return total_paid;
	}

	public double getTotalPaidToSupplierByCid(int cid) {
		double paid;
		paid = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT sum( `amount_received` ) paid FROM `expenses_payment` WHERE `expenses_id` IN ( SELECT id FROM `expenses` WHERE `status` =1 AND `client_id` ="
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
					paid = res.getDouble("paid");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return paid;
	}

	public double getTotalPaidAmountByExpensesIdUsingEstimate(int expId) {
		double amount_received;
		amount_received = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select sum(amount_received) amount_received  from expenses_payment where expenses_id in (select id from expenses where estimate_id=(select estimate_id  from expenses where status=1 and id="
				+ expId + "))";
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

	public double getPaidAmountForExp(int exp_id) {
		double amount_received;
		amount_received = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select sum(amount_received) amount_received  from expenses_payment where expenses_payment.expenses_id="
				+ exp_id;
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

	public String getPaidDateByPaymentId(int p_id) {
		String datetime;
		datetime = "";
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select datetime  from expenses_payment where id=" + p_id;
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
					datetime = res.getString("datetime");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return datetime;
	}

	public void deleteData() {
		Connection con = null;
		Statement st = null;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "delete  from `expenses_payment` where id= "
						+ this.getId();
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

	public int getPaidByBillNo() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO expenses_payment ( expenses_id, amount_received, payment_method, cheque_number,bank_id,received_by,datetime )SELECT  id,total_amount-(SELECT IFNULL(sum(amount_received),0) total_received FROM  `expenses_payment` where expenses_id=expenses.id ) total_amount,'"
						+ this.getPaymentMethod()
						+ "','"
						+ this.getChequeNo()
						+ "',"
						+ this.getBankId()
						+ ","
						+ this.getReceivedBy()
						+ ",'"
						+ this.getDatetime()
						+ "' "
						+ "FROM    expenses "
						+ "WHERE `bill_number` LIKE '"
						+ this.getBill_number() + "'";
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

	public int addData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `expenses_payment` (`expenses_id`, `amount_received`,`payment_method`,`cheque_number`,`bank_id`,`datetime`, `received_by`) VALUES ("
						+ this.getExpensesId()
						+ ", "
						+ this.getAmountReceived()
						+ ", '"
						+ this.getPaymentMethod()
						+ "', '"
						+ this.getChequeNo()
						+ "',"
						+ this.getBankId()
						+ ",'"
						+ this.getDatetime()
						+ "', " + this.getReceivedBy() + ")";
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
				String sql = "UPDATE `expenses_payment` SET `amount_received` = "
						+ this.getAmountReceived()
						+ ","
						+ "`payment_method` = '"
						+ this.getPaymentMethod()
						+ "',"
						+ "`cheque_number` = '"
						+ this.getChequeNo()
						+ "',"
						+ "`bank_id` = "
						+ this.getBankId()
						+ ","
						+ "`datetime` = '"
						+ this.getDatetime()
						+ "' "
						+ "WHERE `id` =" + this.getId();
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

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ExpensesPaymentBO> getAllItem(int cid) {
		ArrayList<ExpensesPaymentBO> expensesPaymentBOList;
		expensesPaymentBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "select * from (select * from  expenses_payment  where expenses_payment.expenses_id in (select id  from expenses where client_id="
						+ cid
						+ ") ORDER by id DESC) as tab1"
						+ " INNER JOIN expenses on tab1.expenses_id=expenses.id";
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				expensesPaymentBOList = this.populateItemList(res);
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
		return expensesPaymentBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ExpensesPaymentBO> getAllItemByExpensesId(int ex_id) {
		ArrayList<ExpensesPaymentBO> expensesPaymentBOList;
		expensesPaymentBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "select * from  expenses_payment  where expenses_id="
						+ ex_id;
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				expensesPaymentBOList = this.populateItemList(res);
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
		return expensesPaymentBOList;
	}

	private ArrayList<ExpensesPaymentBO> populateItemList(ResultSet res) {
		ArrayList<ExpensesPaymentBO> expensesPaymentBOList = null;
		ExpensesPaymentBO expensesPaymentBO = null;
		if (res != null) {
			expensesPaymentBOList = new ArrayList<ExpensesPaymentBO>();
			try {
				while (res.next()) {
					expensesPaymentBO = new ExpensesPaymentBO();
					expensesPaymentBO.setId(res.getInt("id"));
					expensesPaymentBO.setExpensesId(res.getInt("expenses_id"));
					expensesPaymentBO.setAmountReceived(res
							.getDouble("amount_received"));
					expensesPaymentBO.setPaymentMethod(res
							.getString("payment_method"));
					expensesPaymentBO.setChequeNo(res
							.getString("cheque_number"));
					expensesPaymentBO.setBankId(res.getInt("bank_id"));
					expensesPaymentBO.setReceivedBy(res.getInt("received_by"));
					expensesPaymentBO.setDateTime(res.getString("datetime"));
					expensesPaymentBOList.add(expensesPaymentBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return expensesPaymentBOList;
	}
}