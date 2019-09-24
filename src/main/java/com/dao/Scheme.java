package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.SchemeBO;
import com.util.DBUtility;

public class Scheme {
	private int id;
	private String schemeName;
	private int parent_scheme_id;
	private int status;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSchemeName() {
		return this.schemeName;
	}

	public int getParent_scheme_id() {
		return this.parent_scheme_id;
	}

	public void setParent_scheme_id(int parent_scheme_id) {
		this.parent_scheme_id = parent_scheme_id;
	}

	public void setSchemeName(String schemeName) {
		this.schemeName = schemeName;
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
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `scheme` (`scheme_name`,`parent`) VALUES (UPPER('"
						+ this.getSchemeName()
						+ "'),"
						+ this.getParent_scheme_id() + ")";
				if (!this.getSchemeName().equals("")) {
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

	public int hasParent(int eid) {
		int has_parent;
		has_parent = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT  parent  FROM `scheme` WHERE `id` = " + eid;
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
					has_parent = res.getInt("parent");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return has_parent;
	}

	public int updateData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "update scheme set scheme_name='"
						+ this.getSchemeName() + "' where id='" + this.getId()
						+ "' ";
				if (!this.getSchemeName().equals("")) {
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

	public int deleteScheme() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "update scheme set status=0 where id="
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

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<SchemeBO> getAllItem() {
		ArrayList<SchemeBO> schemeBOList;
		schemeBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `scheme` where status=1 order by  scheme_name ";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				schemeBOList = this.populateItemList(res);
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
		return schemeBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<SchemeBO> getAllParentItem() {
		ArrayList<SchemeBO> schemeBOList;
		schemeBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `scheme` where parent=0 and status=1 order by  scheme_name";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				schemeBOList = this.populateItemList(res);
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
		return schemeBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<SchemeBO> getAllChildItem(int parent_id) {
		ArrayList<SchemeBO> schemeBOList;
		schemeBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `scheme` where parent="
						+ parent_id + " and status=1 order by  scheme_name";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				schemeBOList = this.populateItemList(res);
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
		return schemeBOList;
	}

	private ArrayList<SchemeBO> populateItemList(ResultSet res) {
		ArrayList<SchemeBO> schemeList = null;
		SchemeBO schemeBO = null;
		if (res != null) {
			schemeList = new ArrayList<SchemeBO>();
			try {
				while (res.next()) {
					schemeBO = new SchemeBO();
					schemeBO.setId(res.getInt("id"));
					schemeBO.setParent_scheme_id(res.getInt("parent"));
					if (res.getInt("parent") != 0) {
						String parent_name = this.getSchemeNameById(res
								.getInt("parent"));
						schemeBO.setSchemeName(String.valueOf(parent_name)
								+ "=>" + res.getString("scheme_name"));
					} else {
						schemeBO.setSchemeName(res.getString("scheme_name"));
					}
					schemeBO.setStatus(res.getInt("status"));
					schemeBO.setGstValue(res.getInt("gst_value"));
					schemeList.add(schemeBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return schemeList;
	}

	public String getSchemeNameById(int id) {
		String scheme_name;
		scheme_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select scheme_name from  scheme WHERE ID=" + id;
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
					scheme_name = res.getString("scheme_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return scheme_name;
	}

	public int getGstValueById(int id) {
		int gstAmount =0;		
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select gst_value from  scheme WHERE ID=" + id;
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
					gstAmount = res.getInt("gst_value");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return gstAmount;
	}

	public String getSchemeNameByEstimateId(int id) {
		String scheme_name;
		scheme_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select * from scheme,estimate where scheme.id=estimate.scheme_id and estimate.id="
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
					scheme_name = String.valueOf(res.getString("scheme_id"))
							+ ":" + res.getString("scheme_name");
					System.out.println(scheme_name);
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return scheme_name;
	}
	public int getGSTPersNameByEstimateId(int id) {
		int gstPers = 0;
		
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select * from scheme,estimate where scheme.id=estimate.scheme_id and estimate.id="
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
					gstPers = res.getInt("gst_value");					
					System.out.println(gstPers);
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return gstPers;
	}
}