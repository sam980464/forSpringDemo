package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.util.DBUtility;

public class promis {
	int id;
	String promisName;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPromisName() {
		return this.promisName;
	}

	public void setPromisName(String promisName) {
		this.promisName = promisName;
	}

	public int addData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `promis` (`promisname`,`status`) VALUES ('"
						+ this.getPromisName() + "','1')";
				if (!this.getPromisName().equals("")) {
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

	public int deletePromis() {
		Connection con = null;
		Statement st = null;
		int retrunVal =0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE promis SET status=0 WHERE ID="
						+ this.getId();
				System.out.println(sql);
				retrunVal= st.executeUpdate(sql);
				st = null;
			} catch (Exception e) {
				System.out.println(e);
				e.printStackTrace();
				DBUtility.closeConnection(con, st, (ResultSet) null);
			}
		} finally {
			DBUtility.closeConnection(con, st, (ResultSet) null);
		}
		return retrunVal;
	}

	public int updatePromis() {
		Connection con = null;
		Statement st = null;
		int returnVal =0 ;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE promis SET  promisname ='"
						+ this.getPromisName() + "' WHERE ID=" + this.getId();
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
	public ArrayList<promis> getAllItem() {
		ArrayList<promis> bankBOList;
		bankBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `promis` where status=1";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				bankBOList = this.populateItemList(res);
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
		return bankBOList;
	}

	private ArrayList<promis> populateItemList(ResultSet res) {
		ArrayList<promis> bankList = null;
		promis bankBO = null;
		if (res != null) {
			bankList = new ArrayList<promis>();
			try {
				while (res.next()) {
					bankBO = new promis();
					bankBO.setId(res.getInt("id"));
					bankBO.setPromisName(res.getString("promisname"));
					bankList.add(bankBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return bankList;
	}
}