package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.MoujaBO;
import com.util.DBUtility;

public class Mouja {
	private int id;
	private String moujaName;
	private int status;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMoujaName() {
		return this.moujaName;
	}

	public void setMoujaName(String moujaName) {
		this.moujaName = moujaName;
	}

	public int getStatus() {
		return this.status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<MoujaBO> getAllItem() {
		ArrayList<MoujaBO> moujaBOList;
		moujaBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `mouja_master` where status=1 order by mouja_name";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				moujaBOList = this.populateItemList(res);
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
		return moujaBOList;
	}

	private ArrayList<MoujaBO> populateItemList(ResultSet res) {
		ArrayList<MoujaBO> moujaList = null;
		MoujaBO moujaBO = null;
		if (res != null) {
			moujaList = new ArrayList<MoujaBO>();
			try {
				while (res.next()) {
					moujaBO = new MoujaBO();
					moujaBO.setId(res.getInt("id"));
					moujaBO.setMoujaName(res.getString("mouja_name"));
					moujaBO.setStatus(res.getInt("status"));
					moujaList.add(moujaBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return moujaList;
	}

	public int addNew() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0 ;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `mouja_master` (`mouja_name` ,`status`) VALUES (upper('"
						+ this.getMoujaName() + "'), " + this.getStatus() + ")";
				if (!this.getMoujaName().equals("")) {
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

	public String getMoujaNameById(int id) {
		String mouja_name;
		mouja_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT `mouja_name` FROM `mouja_master` WHERE ID=" + id;
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
					mouja_name = res.getString("mouja_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return mouja_name;
	}

	public int deleteData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE mouja_master SET status=0 WHERE ID="
						+ this.getId();
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

	public int updateData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0 ;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE mouja_master SET mouja_name='"
						+ this.getMoujaName() + "' WHERE ID=" + this.getId();
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
}