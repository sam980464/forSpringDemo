package com.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.project.bean.AddBuyerToProjectBean;
import com.util.DBUtility;

public class AddBuyerToProject {
	private String payment_id;
	private String buyer_estimate_id;
	private String buyer_id;
	private String project_id;
	private String buyer_estimate_amount;
	private String buyer_estimate_details;
	private String buyer_estimate_date;
	private String paid_amount;
	private String payment_method;
	private String cheque_no;
	private String bank_list;

	public void setBuyer_estimate_id(String buyer_estimate_id) {
		this.buyer_estimate_id = buyer_estimate_id;
	}

	public String getBuyer_estimate_id() {
		return this.buyer_estimate_id;
	}

	public void setBuyer_estimate_details(String buyer_estimate_details) {
		this.buyer_estimate_details = buyer_estimate_details;
	}

	public String getBuyer_estimate_details() {
		return this.buyer_estimate_details;
	}

	public void setBuyer_estimate_date(String buyer_estimate_date) {
		this.buyer_estimate_date = buyer_estimate_date;
	}

	public String getBuyer_estimate_date() {
		return this.buyer_estimate_date;
	}

	public void setProject_id(String project_id) {
		this.project_id = project_id;
	}

	public String getProject_id() {
		return this.project_id;
	}

	public void setBuyer_estimate_amount(String buyer_estimate_amount) {
		this.buyer_estimate_amount = buyer_estimate_amount;
	}

	public String getBuyer_estimate_amount() {
		return this.buyer_estimate_amount;
	}

	public void setBuyer_id(String buyer_id) {
		this.buyer_id = buyer_id;
	}

	public String getBuyer_id() {
		return this.buyer_id;
	}

	public void setPaid_amount(String paid_amount) {
		this.paid_amount = paid_amount;
	}

	public String getPaid_amount() {
		return this.paid_amount;
	}

	public void addBuyerToProject() {
		Connection con = null;
		Statement st = null;
		try {
			try {
				int max2 = this.getMaxId("SELECT * from project_buyer_master",
						"buyer_id");
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `project_buyer_estimation` (buyer_id,project_id,buyer_estimate_amount,buyer_estimate_details,buyer_estimate_date,est_status) VALUES ('"
						+ max2
						+ "', '"
						+ this.getProject_id()
						+ "', '"
						+ this.getBuyer_estimate_amount()
						+ "', '"
						+ this.getBuyer_estimate_details()
						+ "', '"
						+ this.getBuyer_estimate_date() + "','1')";
				System.out.println(sql);
				st.executeUpdate(sql);
				int max = this.getMaxId(
						"select * from project_buyer_estimation",
						"buyer_estimate_id");
				sql = "INSERT INTO `project_buyer_payment` (buyer_id,project_id,buyer_estimate_id,payment_amount,payment_date,payment_details,pay_status,payment_method,cheque_no,bank_list) VALUES ('"
						+ max2
						+ "', '"
						+ this.getProject_id()
						+ "','"
						+ max
						+ "', '"
						+ this.getPaid_amount()
						+ "', '"
						+ this.getBuyer_estimate_date()
						+ "', '"
						+ this.getBuyer_estimate_details()
						+ "','1','"
						+ this.getPayment_method()
						+ "', '"
						+ this.getCheque_no()
						+ "', '"
						+ this.getBank_list()
						+ "')";
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
	public ArrayList<AddBuyerToProjectBean> getAllBuyer(String flag, String id) {
		ArrayList<AddBuyerToProjectBean> buyerArrayList;
		buyerArrayList = new ArrayList<AddBuyerToProjectBean>();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		String sql = "";
		try {
			try {
				con = DBUtility.getConnection();
				sql = flag.equals("all") ? "SELECT * FROM  `project_buyer_estimation` where est_status='1' and project_id='"
						+ id + "'"
						: "select * from (select *,sum(payment_amount) as totalpaid from project_buyer_payment where project_id='"
								+ id
								+ "' and buyer_id='"
								+ flag
								+ "') as table1"
								+ " inner join project_buyer_estimation on project_buyer_estimation.buyer_estimate_id=table1.buyer_estimate_id";
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				while (res.next()) {
					AddBuyerToProjectBean buyerList = new AddBuyerToProjectBean();
					if (flag.equals("all")) {
						buyerList.setBuyer_id(res.getString("buyer_id"));
					} else {
						buyerList.setBuyer_estimate_amount(res
								.getString("buyer_estimate_amount"));
						buyerList.setBuyer_estimate_id(res
								.getString("buyer_estimate_id"));
						buyerList.setBuyer_estimate_details(res
								.getString("totalpaid"));
					}
					System.out.println("iterator" + buyerList.getBuyer_id());
					buyerArrayList.add(buyerList);
				}
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
		return buyerArrayList;
	}

	public int getMaxId(String sql, String id) {
		int max;
		max = 0;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
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
					max = res.getInt(id);
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

	public void addbuyerpaymentsubmit(String proid) {
		Connection con = null;
		Statement st = null;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "insert into project_buyer_payment (buyer_id,project_id,buyer_estimate_id,payment_amount,payment_date,payment_details,pay_status,payment_method,cheque_no,bank_list) VALUES ('"
						+ this.getBuyer_id()
						+ "', '"
						+ proid
						+ "', '"
						+ this.getBuyer_estimate_id()
						+ "', '"
						+ this.getPaid_amount()
						+ "', '"
						+ this.getBuyer_estimate_date()
						+ "', '"
						+ this.getBuyer_estimate_details()
						+ "','1','"
						+ this.getPayment_method()
						+ "', '"
						+ this.getCheque_no()
						+ "', '"
						+ this.getBank_list()
						+ "')";
				System.out.println(sql);
				if (!this.getBuyer_id().equals("")) {
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

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<AddBuyerToProjectBean> getPaymentList(String flag,
			String id) {
		ArrayList<AddBuyerToProjectBean> buyerArrayList;
		buyerArrayList = new ArrayList<AddBuyerToProjectBean>();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		String sql = "";
		try {
			try {
				con = DBUtility.getConnection();
				sql = flag.equals("all") ? "select * from(SELECT * from project_buyer_payment where project_id='"
						+ id
						+ "' and pay_status='1' ORDER by buyer_id) as table1"
						+ " inner join project_buyer_master on project_buyer_master.buyer_id=table1.buyer_id"
						+ " inner join project_buyer_estimation on project_buyer_estimation.buyer_estimate_id=table1.buyer_estimate_id"
						: "select * from(SELECT * from project_buyer_payment where project_id='"
								+ id
								+ "' and payment_id='"
								+ flag
								+ "' ORDER by buyer_id) as table1 inner join project_buyer_master on project_buyer_master.buyer_id=table1.buyer_id inner join project_buyer_estimation on project_buyer_estimation.buyer_estimate_id=table1.buyer_estimate_id";
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				while (res.next()) {
					AddBuyerToProjectBean buyerList = new AddBuyerToProjectBean();
					buyerList.setBuyer_id(res.getString("buyer_id"));
					buyerList.setBuyer_estimate_id(res
							.getString("buyer_estimate_id"));
					buyerList.setPayment_id(res.getString("payment_id"));
					buyerList.setBuyer_name(res.getString("buyer_name"));
					buyerList.setBuyer_estimate_amount(res
							.getString("buyer_estimate_amount"));
					buyerList.setPaidamount(res.getString("payment_amount"));
					buyerList.setBuyer_estimate_date(res
							.getString("payment_date"));
					buyerList.setBuyer_estimate_details(res
							.getString("payment_details"));
					buyerList.setPm(res.getString("payment_method"));
					buyerList.setNo(res.getString("cheque_no"));
					buyerList.setBi(res.getString("bank_list"));
					System.out.println("iterator" + buyerList.getBuyer_id());
					buyerArrayList.add(buyerList);
				}
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
		return buyerArrayList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<AddBuyerToProjectBean> getEstimateList(String flag,
			String id) {
		ArrayList<AddBuyerToProjectBean> buyerArrayList;
		buyerArrayList = new ArrayList<AddBuyerToProjectBean>();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		String sql = "";
		try {
			try {
				con = DBUtility.getConnection();
				sql = flag.equals("est") ? "select * from(SELECT * from project_buyer_estimation where project_id='"
						+ id
						+ "' and est_status='1' ORDER by buyer_estimate_id) as table1"
						+ " inner join project_buyer_master on project_buyer_master.buyer_id=table1.buyer_id"
						: "select * from(SELECT * from project_buyer_estimation where buyer_estimate_id='"
								+ flag
								+ "') as table1 "
								+ " inner join project_buyer_master on project_buyer_master.buyer_id=table1.buyer_id"
								+ " inner join project_buyer_estimation on project_buyer_estimation.buyer_id=table1.buyer_id";
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				while (res.next()) {
					AddBuyerToProjectBean buyerList = new AddBuyerToProjectBean();
					buyerList.setBuyer_id(res.getString("buyer_id"));
					buyerList.setBuyer_estimate_id(res
							.getString("buyer_estimate_id"));
					buyerList.setBuyer_name(res.getString("buyer_name"));
					buyerList.setBuyer_estimate_amount(res
							.getString("buyer_estimate_amount"));
					buyerList.setBuyer_estimate_date(res
							.getString("buyer_estimate_date"));
					buyerList.setBuyer_estimate_details(res
							.getString("buyer_estimate_details"));
					System.out.println("iterator" + buyerList.getBuyer_id());
					buyerArrayList.add(buyerList);
				}
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
		return buyerArrayList;
	}

	public void updatePayment() {
		Connection con = null;
		Statement st = null;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "update project_buyer_payment set payment_amount='"
						+ this.getPaid_amount()
						+ "',payment_date='"
						+ this.getBuyer_estimate_date()
						+ "',payment_details='"
						+ this.getBuyer_estimate_details()
						+ "',payment_method='"
						+ this.getPayment_method()
						+ "',cheque_no='"
						+ this.getCheque_no()
						+ "',bank_list='"
						+ this.getBank_list()
						+ "' where payment_id='" + this.getPayment_id() + "'";
				System.out.println(sql);
				st.executeUpdate(sql);
			} catch (Exception e) {
				System.out.println(e);
				e.printStackTrace();
				DBUtility.closeConnection(con, st, (ResultSet) null);
			}
		} finally {
			DBUtility.closeConnection(con, st, (ResultSet) null);
		}
	}

	public void updateEstimate() {
		Connection con = null;
		Statement st = null;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "update project_buyer_estimation set buyer_estimate_amount='"
						+ this.getPaid_amount()
						+ "',buyer_estimate_date='"
						+ this.getBuyer_estimate_date()
						+ "',buyer_estimate_details='"
						+ this.getBuyer_estimate_details()
						+ "' where buyer_estimate_id='"
						+ this.getBuyer_estimate_id() + "'";
				System.out.println(sql);
				st.executeUpdate(sql);
			} catch (Exception e) {
				System.out.println(e);
				e.printStackTrace();
				DBUtility.closeConnection(con, st, (ResultSet) null);
			}
		} finally {
			DBUtility.closeConnection(con, st, (ResultSet) null);
		}
	}

	public void deleteProAttrib(String id, String flag) {
		Connection con = null;
		Statement st = null;
		String sql = "";
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				if (flag.equals("inv")) {
					sql = "update project_investor_master set project_investor_master.status='0' where investor_id='"
							+ id + "'";
					st.executeUpdate(sql);
				}
				if (flag.equals("devep")) {
					sql = "update project_developer_master set project_developer_master.status='0' where id='"
							+ id + "'";
					st.executeUpdate(sql);
				}
				if (flag.equals("buyer")) {
					sql = "update project_buyer_master set project_buyer_master.status='0' where buyer_id='"
							+ id + "'";
					st.executeUpdate(sql);
					sql = "update project_buyer_estimation set est_status='0' where buyer_id='"
							+ id + "'";
					st.executeUpdate(sql);
					sql = "update project_buyer_payment set pay_status='0' where buyer_id='"
							+ id + "'";
					st.executeUpdate(sql);
				}
				if (flag.equals("estdel")) {
					sql = "update project_buyer_estimation set est_status='0' where buyer_estimate_id='"
							+ id + "'";
					st.executeUpdate(sql);
					sql = "update project_buyer_payment set pay_status='0' where buyer_estimate_id='"
							+ id + "'";
					st.executeUpdate(sql);
				}
				if (flag.equals("paydel")) {
					sql = "update project_buyer_payment set pay_status='0' where payment_id='"
							+ id + "'";
					st.executeUpdate(sql);
				}
				System.out.println("SQL:" + sql);
			} catch (Exception e) {
				System.out.println(e);
				e.printStackTrace();
				DBUtility.closeConnection(con, st, (ResultSet) null);
			}
		} finally {
			DBUtility.closeConnection(con, st, (ResultSet) null);
		}
	}

	public void setPayment_id(String payment_id) {
		this.payment_id = payment_id;
	}

	public String getPayment_id() {
		return this.payment_id;
	}

	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}

	public String getPayment_method() {
		return this.payment_method;
	}

	public void setCheque_no(String cheque_no) {
		this.cheque_no = cheque_no;
	}

	public String getCheque_no() {
		return this.cheque_no;
	}

	public void setBank_list(String bank_list) {
		this.bank_list = bank_list;
	}

	public String getBank_list() {
		return this.bank_list;
	}
}
