package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.DistrictBO;
import com.util.DBUtility;

public class District {
	private int id;
	private String districtName;
	private int status;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDistrictName() {
		return this.districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
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
	public ArrayList<DistrictBO> getAllItem() {
		ArrayList<DistrictBO> districtList;
		districtList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `district_master` where status=1 order by district_name";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				districtList = this.populateItemList(res);
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
		return districtList;
	}

	private ArrayList<DistrictBO> populateItemList(ResultSet res) {
		ArrayList<DistrictBO> districtList = null;
		DistrictBO districtBO = null;
		if (res != null) {
			districtList = new ArrayList<DistrictBO>();
			try {
				while (res.next()) {
					districtBO = new DistrictBO();
					districtBO.setId(res.getInt("id"));
					districtBO.setDistrictName(res.getString("district_name"));
					districtBO.setStatus(res.getInt("status"));
					districtList.add(districtBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return districtList;
	}

	public int addNew() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `district_master` (`district_name`) VALUES (upper('"
						+ this.getDistrictName() + "'))";
				if (!this.getDistrictName().equals("")) {
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

	public int deleteData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE district_master SET status=0 WHERE ID="
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
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE district_master SET district_name=UPPER('"
						+ this.getDistrictName() + "') WHERE ID="
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

	public String getDistrictNameById(int id) {
		String district_name;
		district_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT `district_name` FROM `district_master` WHERE ID=" + id;
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
					district_name = res.getString("district_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return district_name;
	}
}