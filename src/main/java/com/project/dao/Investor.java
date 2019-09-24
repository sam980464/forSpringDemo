package com.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.project.bean.InvestorBean;
import com.util.DBUtility;

public class Investor {
	private int investor_id;
	private String investor_name;
	private String investor_address;
	private String investor_email_id;
	private String investor_contactno;
	private String investor_details;

	public void setInvestor_id(int investor_id) {
		this.investor_id = investor_id;
	}

	public int getInvestor_id() {
		return this.investor_id;
	}

	public void setInvestor_address(String investor_address) {
		this.investor_address = investor_address;
	}

	public String getInvestor_address() {
		return this.investor_address;
	}

	public void setInvestor_name(String investor_name) {
		this.investor_name = investor_name;
	}

	public String getInvestor_name() {
		return this.investor_name;
	}

	public void setInvestor_contactno(String investor_contactno) {
		this.investor_contactno = investor_contactno;
	}

	public String getInvestor_contactno() {
		return this.investor_contactno;
	}

	public void setInvestor_details(String investor_details) {
		this.investor_details = investor_details;
	}

	public String getInvestor_details() {
		return this.investor_details;
	}

	public void setInvestor_email_id(String investor_email_id) {
		this.investor_email_id = investor_email_id;
	}

	public String getInvestor_email_id() {
		return this.investor_email_id;
	}

	public int addInvestor() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `project_investor_master` (investor_name,investor_address,investor_email_id,investor_contactno,investor_details,status) VALUES ('"
						+ this.getInvestor_name()
						+ "', '"
						+ this.getInvestor_address()
						+ "', '"
						+ this.getInvestor_email_id()
						+ "', '"
						+ this.getInvestor_contactno()
						+ "', '"
						+ this.getInvestor_details() + "','1')";
				System.out.println(sql);
				if (!this.getInvestor_name().equals("")) {
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
	public ArrayList<InvestorBean> getAllInvestor(String flag) {
		ArrayList<InvestorBean> investorList;
		investorList = new ArrayList<InvestorBean>();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		String sql = "";
		try {
			try {
				con = DBUtility.getConnection();
				sql = flag.equals("all") ? "SELECT * FROM  `project_investor_master` where status='1'"
						: "SELECT * FROM  `project_investor_master` where investor_id="
								+ flag;
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				while (res.next()) {
					InvestorBean investor = new InvestorBean();
					investor.setInvestor_id(res.getInt("investor_id"));
					investor.setInvestor_name(res.getString("investor_name"));
					investor.setInvestor_contactno(res
							.getString("investor_contactno"));
					investor.setInvestor_address(res
							.getString("investor_address"));
					investor.setInvestor_email_id(res
							.getString("investor_email_id"));
					investor.setInvestor_details(res
							.getString("investor_details"));
					investorList.add(investor);
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
		return investorList;
	}

	public String getInvestorDetailsById(int bid) {
		String address;
		address = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT * FROM `bank` WHERE ID=" + bid;
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
					address = res.getString("address");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return address;
	}

	public int updateData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE project_investor_master SET  investor_name ='"
						+ this.getInvestor_name()
						+ "' , investor_address ='"
						+ this.getInvestor_address()
						+ "', investor_contactno ='"
						+ this.getInvestor_contactno()
						+ "', investor_email_id ='"
						+ this.getInvestor_email_id()
						+ "', investor_details ='"
						+ this.getInvestor_details()
						+ "' WHERE investor_id=" + this.getInvestor_id();
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
}
