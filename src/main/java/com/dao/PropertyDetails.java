package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.PropertyDetailsBO;
import com.util.DBUtility;

public class PropertyDetails {
	private int id;
	private int cid;
	private String mouja;
	private String dag_no;
	private String khatian_no;
	private String jl_no;
	private String touji_no;
	private String word_no;
	private int police_station;
	private int district;
	private double bigha;
	private double katha;
	private double chatak;
	private double sq_ft;
	private double total_sq_ft;
	private double total_sq_mtr;
	private String date_of_deposit;
	private String date_of_sanction;
	private String remarks;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCid() {
		return this.cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public double getTotal_sq_ft() {
		return this.total_sq_ft;
	}

	public void setTotal_sq_ft(double total_sq_ft) {
		this.total_sq_ft = total_sq_ft;
	}

	public double getTotal_sq_mtr() {
		return this.total_sq_mtr;
	}

	public void setTotal_sq_mtr(double total_sq_mtr) {
		this.total_sq_mtr = total_sq_mtr;
	}

	public String getMouja() {
		return this.mouja;
	}

	public void setMouja(String mouja) {
		this.mouja = mouja;
	}

	public String getDag_no() {
		return this.dag_no;
	}

	public void setDag_no(String dag_no) {
		this.dag_no = dag_no;
	}

	public String getKhatian_no() {
		return this.khatian_no;
	}

	public void setKhatian_no(String khatian_no) {
		this.khatian_no = khatian_no;
	}

	public String getJl_no() {
		return this.jl_no;
	}

	public void setJl_no(String jl_no) {
		this.jl_no = jl_no;
	}

	public String getTouji_no() {
		return this.touji_no;
	}

	public void setTouji_no(String touji_no) {
		this.touji_no = touji_no;
	}

	public String getWord_no() {
		return this.word_no;
	}

	public void setWord_no(String word_no) {
		this.word_no = word_no;
	}

	public int getPolice_station() {
		return this.police_station;
	}

	public void setPolice_station(int police_station) {
		this.police_station = police_station;
	}

	public int getDistrict() {
		return this.district;
	}

	public void setDistrict(int district) {
		this.district = district;
	}

	public double getBigha() {
		return this.bigha;
	}

	public void setBigha(double bigha) {
		this.bigha = bigha;
	}

	public double getKatha() {
		return this.katha;
	}

	public void setKatha(double katha) {
		this.katha = katha;
	}

	public double getChatak() {
		return this.chatak;
	}

	public void setChatak(double chatak) {
		this.chatak = chatak;
	}

	public double getSq_ft() {
		return this.sq_ft;
	}

	public void setSq_ft(double sq_ft) {
		this.sq_ft = sq_ft;
	}

	public String getDate_of_deposit() {
		return this.date_of_deposit;
	}

	public void setDate_of_deposit(String date_of_deposit) {
		this.date_of_deposit = date_of_deposit;
	}

	public String getDate_of_sanction() {
		return this.date_of_sanction;
	}

	public void setDate_of_sanction(String date_of_sanction) {
		this.date_of_sanction = date_of_sanction;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public int hasExists() {
		int flag;
		int count;
		block10: {
			PreparedStatement st;
			Connection con;
			ResultSet res;
			count = 0;
			flag = 0;
			con = null;
			st = null;
			String sql = null;
			res = null;
			sql = "SELECT count(id) count  FROM `property_details` where client_id= "
					+ this.getCid();
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
						count = res.getInt("count");
					}
				} catch (Exception e) {
					e.printStackTrace();
					DBUtility.closeConnection(con, st, res);
					break block10;
				}
			} catch (Throwable throwable) {
				DBUtility.closeConnection(con, st, res);
				// throw throwable;
			}
			DBUtility.closeConnection(con, st, res);
		}
		flag = count > 0 ? 1 : 0;
		return flag;
	}

	public int getPropertyIdByClientId(int cid) {
		int property_id;
		property_id = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT id FROM `property_details` WHERE client_id=" + cid;
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
					property_id = res.getInt("property_id");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return property_id;
	}

	public int addData() {
		Connection con = null;
		Statement st = null;
		int retrunValue = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `property_details` (`client_id`, `mouja`, `dag_no`, `khatian_no`, `jl_no`, `touji_no`, `word_no`, `police_station`, `district`, `bigha`, `katha`, `chatak`, `sq_ft`,`total_sq_ft`,`total_sq_mtr`, `date_of_deposit`, `date_of_sanction`, `remarks`) VALUES ("
						+ this.getCid()
						+ ", "
						+ this.getMouja()
						+ ",'"
						+ this.getDag_no()
						+ "','"
						+ this.getKhatian_no()
						+ "', '"
						+ this.getJl_no()
						+ "', '"
						+ this.getTouji_no()
						+ "','"
						+ this.getWord_no()
						+ "',"
						+ this.getPolice_station()
						+ ", "
						+ this.getDistrict()
						+ ", "
						+ this.getBigha()
						+ ", "
						+ this.getKatha()
						+ ", "
						+ this.getChatak()
						+ ", "
						+ this.getSq_ft()
						+ ", "
						+ this.getTotal_sq_ft()
						+ ", "
						+ this.getTotal_sq_mtr()
						+ ", '"
						+ this.getDate_of_deposit()
						+ "', '"
						+ this.getDate_of_sanction()
						+ "', '"
						+ this.getRemarks() + "')";
				retrunValue = st.executeUpdate(sql);
				st = null;
			} catch (Exception e) {
				System.out.println(e);
				e.printStackTrace();
				DBUtility.closeConnection(con, st, (ResultSet) null);
			}
		} finally {
			DBUtility.closeConnection(con, st, (ResultSet) null);
		}
		return retrunValue;
	}

	public int updateData() {
		Connection con = null;
		Statement st = null;
		int returnValue = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE `property_details` SET `mouja` = '"
						+ this.getMouja() + "'," + "`dag_no` = '"
						+ this.getDag_no() + "'," + "`khatian_no` = '"
						+ this.getKhatian_no() + "'," + "`jl_no` = '"
						+ this.getJl_no() + "'," + "`touji_no` = '"
						+ this.getTouji_no() + "'," + "`word_no` = '"
						+ this.getWord_no() + "'," + "`police_station` = "
						+ this.getPolice_station() + "," + "`district` = "
						+ this.getDistrict() + "," + "`bigha` = "
						+ this.getBigha() + "," + "`katha` = "
						+ this.getKatha() + "," + "`chatak` = "
						+ this.getChatak() + "," + "`sq_ft` = "
						+ this.getSq_ft() + "," + "`total_sq_ft` = "
						+ this.getTotal_sq_ft() + "," + "`total_sq_mtr` = "
						+ this.getTotal_sq_mtr() + ","
						+ "`date_of_deposit` = '" + this.getDate_of_deposit()
						+ "'," + "`date_of_sanction` = '"
						+ this.getDate_of_sanction() + "'," + "`remarks` = '"
						+ this.getRemarks() + "' WHERE `client_id`="
						+ this.getCid();
				returnValue = st.executeUpdate(sql);
				st = null;
			} catch (Exception e) {
				System.out.println(e);
				e.printStackTrace();
				DBUtility.closeConnection(con, st, (ResultSet) null);
			}
		} finally {
			DBUtility.closeConnection(con, st, (ResultSet) null);
		}
		return returnValue;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<PropertyDetailsBO> getAllItem(int cid) {
		ArrayList<PropertyDetailsBO> propertyDetailsBOList;
		propertyDetailsBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `property_details` where \tclient_id ="
						+ cid;
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				propertyDetailsBOList = this.populateItemList(res);
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
		return propertyDetailsBOList;
	}

	private ArrayList<PropertyDetailsBO> populateItemList(ResultSet res) {
		ArrayList<PropertyDetailsBO> propertyDetailsList = null;
		PropertyDetailsBO propertyDetailsBO = null;
		if (res != null) {
			propertyDetailsList = new ArrayList<PropertyDetailsBO>();
			try {
				while (res.next()) {
					propertyDetailsBO = new PropertyDetailsBO();
					propertyDetailsBO.setCid(res.getInt("client_id"));
					propertyDetailsBO.setMouja(res.getString("mouja"));
					propertyDetailsBO.setDag_no(res.getString("dag_no"));
					propertyDetailsBO
							.setKhatian_no(res.getString("khatian_no"));
					propertyDetailsBO.setJl_no(res.getString("jl_no"));
					propertyDetailsBO.setTouji_no(res.getString("touji_no"));
					propertyDetailsBO.setWord_no(res.getString("word_no"));
					propertyDetailsBO.setPolice_station(res
							.getInt("police_station"));
					propertyDetailsBO.setDistrict(res.getInt("district"));
					propertyDetailsBO.setBigha(res.getDouble("bigha"));
					propertyDetailsBO.setKatha(res.getDouble("katha"));
					propertyDetailsBO.setChatak(res.getDouble("chatak"));
					propertyDetailsBO.setSq_ft(res.getDouble("sq_ft"));
					propertyDetailsBO.setTotal_sq_ft(res
							.getDouble("total_sq_ft"));
					propertyDetailsBO.setTotal_sq_mtr(res
							.getDouble("total_sq_mtr"));
					propertyDetailsBO.setDate_of_deposit(res
							.getString("date_of_deposit"));
					propertyDetailsBO.setDate_of_sanction(res
							.getString("date_of_sanction"));
					propertyDetailsBO.setRemarks(res.getString("remarks"));
					propertyDetailsList.add(propertyDetailsBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return propertyDetailsList;
	}
}