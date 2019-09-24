package com.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.project.bean.BuyerBean;
import com.util.DBUtility;

public class Buyer {
	private int buyer_id;
	private String buyer_name;
	private String buyer_address;
	private String buyer_email;
	private String buyer_contactno;
	private String buyer_details;

	public void setBuyer_id(int buyer_id) {
		this.buyer_id = buyer_id;
	}

	public int getBuyer_id() {
		return this.buyer_id;
	}

	public void setBuyer_details(String buyer_details) {
		this.buyer_details = buyer_details;
	}

	public String getBuyer_details() {
		return this.buyer_details;
	}

	public void setBuyer_name(String buyer_name) {
		this.buyer_name = buyer_name;
	}

	public String getBuyer_name() {
		return this.buyer_name;
	}

	public void setBuyer_address(String buyer_address) {
		this.buyer_address = buyer_address;
	}

	public String getBuyer_address() {
		return this.buyer_address;
	}

	public void setBuyer_contactno(String buyer_contactno) {
		this.buyer_contactno = buyer_contactno;
	}

	public String getBuyer_contactno() {
		return this.buyer_contactno;
	}

	public void setBuyer_email(String buyer_email) {
		this.buyer_email = buyer_email;
	}

	public String getBuyer_email() {
		return this.buyer_email;
	}

	public int addBuyer() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `project_buyer_master` (buyer_name,buyer_address,buyer_email,buyer_contactno,buyer_details,status) VALUES ('"
						+ this.getBuyer_name()
						+ "', '"
						+ this.getBuyer_address()
						+ "', '"
						+ this.getBuyer_email()
						+ "', '"
						+ this.getBuyer_contactno()
						+ "', '"
						+ this.getBuyer_details() + "','1')";
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

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<BuyerBean> getAllBuyer(String flag, String id) {
		ArrayList<BuyerBean> buyerArrayList;
		buyerArrayList = new ArrayList<BuyerBean>();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		String sql = "";
		try {
			try {
				con = DBUtility.getConnection();
				sql = flag.equals("all") ? "SELECT * FROM  `project_buyer_master` where status='1'"
						: "SELECT * FROM  `project_buyer_master` where buyer_id="
								+ flag;
				if (flag.equals("paymentbuyer")) {
					sql = "select * from(select * from project_buyer_estimation where est_status='1' and project_id="
							+ id
							+ ") as table1 INNER JOIN project_buyer_master on table1.buyer_id=project_buyer_master.buyer_id";
				}
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				while (res.next()) {
					BuyerBean buyerList = new BuyerBean();
					buyerList.setBuyer_name(res.getString("buyer_name"));
					buyerList.setBuyer_id(res.getInt("buyer_id"));
					buyerList.setBuyer_address(res.getString("buyer_address"));
					buyerList.setBuyer_contactno(res
							.getString("buyer_contactno"));
					buyerList.setBuyer_email(res.getString("buyer_email"));
					buyerList.setBuyer_details(res.getString("buyer_details"));
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

	public int updateData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE project_buyer_master SET  buyer_name ='"
						+ this.getBuyer_name() + "' , buyer_address ='"
						+ this.getBuyer_address() + "', buyer_contactno ='"
						+ this.getBuyer_contactno() + "', buyer_email ='"
						+ this.getBuyer_email() + "', buyer_details ='"
						+ this.getBuyer_details() + "' WHERE buyer_id="
						+ this.getBuyer_id();
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
