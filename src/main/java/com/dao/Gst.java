package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.DistrictBO;
import com.bo.GstBO;
import com.util.DBUtility;

public class Gst {
	private int id;
	private String gstNo;
	private int scheme_id;
	private int gst_value;
	
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	
	public String getGstNo() {
		return gstNo;
	}

	public void setGstNo(String gstNo) {
		this.gstNo = gstNo;
	}
	
	public int getScheme_id() {
		return scheme_id;
	}

	public void setScheme_id(int scheme_id) {
		this.scheme_id = scheme_id;
	}
	
	public int getGst_value() {
		return gst_value;
	}

	public void setGst_value(int gst_value) {
		this.gst_value = gst_value;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public String getGstDetail() {
		ArrayList<GstBO> gstBOList;
		gstBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `gst`";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				gstBOList = this.populateItemList(res);
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
		return gstBOList.get(0).getGst_no();
	}

	
	

	public void deleteData() {
		Connection con = null;
		Statement st = null;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE district_master SET status=0 WHERE ID="
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

	public int updateGstNo() {
		Connection con = null;
		Statement st = null;
		int returnValue=0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE gst SET gst_no='"+this.gstNo+"'";
				System.out.println(sql);
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
	public int updateGstValue() {
		Connection con = null;
		Statement st = null;
		int returnValue=0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE scheme SET gst_value="+this.gst_value +" where id="+this.scheme_id;
				System.out.println(sql);
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
	private ArrayList<GstBO> populateItemList(ResultSet res) {
		ArrayList<GstBO> gstBOList = null;
		GstBO gstBO = null;
		if (res != null) {
			gstBOList = new ArrayList<GstBO>();
			try {
				while (res.next()) {
					gstBO = new GstBO();
					gstBO.setGst_no(res.getString("gst_no"));					
					gstBOList.add(gstBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return gstBOList;
	}

}