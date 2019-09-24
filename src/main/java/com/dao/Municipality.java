package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.MunicipalityBO;
import com.util.DBUtility;

public class Municipality {
	int id;
	String municipalityName;
	int status;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMunicipalityName() {
		return this.municipalityName;
	}

	public void setMunicipalityName(String municipalityName) {
		this.municipalityName = municipalityName;
	}

	public int getStatus() {
		return this.status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int addData() {
		Connection con = null;
		Statement st = null;
		int returnVal =0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `municipality` (`municipality_name` ,`status`) VALUES (upper('"
						+ this.getMunicipalityName()
						+ "'), "
						+ this.getStatus() + ")";
				if (!this.getMunicipalityName().equals("")) {
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
				String sql = "update  municipality set  municipality_name =upper('"
						+ this.getMunicipalityName()
						+ "') where id= "
						+ this.getId();
				System.out.println(sql);
				if (!this.getMunicipalityName().equals("")) {
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
		int returnVal =0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "update  municipality set  status = 0 where id= "
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

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<MunicipalityBO> getAllItem() {
		ArrayList<MunicipalityBO> municipalitBOList;
		municipalitBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `municipality` where status=1 order by municipality_name";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				municipalitBOList = this.populateItemList(res);
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
		return municipalitBOList;
	}

	private ArrayList<MunicipalityBO> populateItemList(ResultSet res) {
		ArrayList<MunicipalityBO> municipalityList = null;
		MunicipalityBO municipalityBO = null;
		if (res != null) {
			municipalityList = new ArrayList<MunicipalityBO>();
			try {
				while (res.next()) {
					municipalityBO = new MunicipalityBO();
					municipalityBO.setId(res.getInt("id"));
					municipalityBO.setMunicipalityName(res
							.getString("municipality_name"));
					municipalityList.add(municipalityBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return municipalityList;
	}

	public String getMunicipalityNameById(int id) {
		String municipalityName;
		municipalityName = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select  municipality_name from  municipality WHERE id=" + id;
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
					municipalityName = res.getString("municipality_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return municipalityName;
	}
}