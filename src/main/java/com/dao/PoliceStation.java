package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.PoliceStationBO;
import com.util.DBUtility;

public class PoliceStation {
	private int id;
	private String policeStationName;
	private String address;
	private int status;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPoliceStationName() {
		return this.policeStationName;
	}

	public void setPoliceStationName(String policeStationName) {
		this.policeStationName = policeStationName;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
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
	public ArrayList<PoliceStationBO> getAllItem() {
		ArrayList<PoliceStationBO> policeStationBOList;
		policeStationBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `police_station_master` where status=1 order by police_station_name";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				policeStationBOList = this.populateItemList(res);
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
		return policeStationBOList;
	}

	private ArrayList<PoliceStationBO> populateItemList(ResultSet res) {
		ArrayList<PoliceStationBO> policeStationList = null;
		PoliceStationBO policeStationBO = null;
		if (res != null) {
			policeStationList = new ArrayList<PoliceStationBO>();
			try {
				while (res.next()) {
					policeStationBO = new PoliceStationBO();
					policeStationBO.setId(res.getInt("id"));
					policeStationBO.setPoliceStationName(res
							.getString("police_station_name"));
					policeStationBO.setAddress(res.getString("address"));
					policeStationBO.setStatus(res.getInt("status"));
					policeStationList.add(policeStationBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return policeStationList;
	}

	public int addNew() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0 ;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `police_station_master` (`police_station_name` ,`address`) VALUES (upper('"
						+ this.getPoliceStationName()
						+ "'), UPPER('"
						+ this.getAddress() + "'))";
				if (!this.getPoliceStationName().equals("")) {
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

	public String getPoliceStationNameById(int id) {
		String police_station_name;
		police_station_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT `police_station_name` FROM `police_station_master` WHERE ID="
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
					police_station_name = res.getString("police_station_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return police_station_name;
	}

	public String getPoliceStationAddressById(int id) {
		String address;
		address = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT `address` FROM `police_station_master` WHERE ID=" + id;
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

	public int deleteData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE police_station_master SET status=0 WHERE ID="
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
				String sql = "UPDATE police_station_master SET police_station_name='"
						+ this.getPoliceStationName()
						+ "' , address='"
						+ this.getAddress() + "' WHERE ID=" + this.getId();
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