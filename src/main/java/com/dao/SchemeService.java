package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.SchemeServiceBO;
import com.util.DBUtility;

public class SchemeService {
	private int id;
	private int SchemeId;
	private int ServiceId;
	private String SchemeName;
	private String Servicename;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getSchemeId() {
		return this.SchemeId;
	}

	public String getSchemeName() {
		return this.SchemeName;
	}

	public void setSchemeName(String schemeName) {
		this.SchemeName = schemeName;
	}

	public String getServicename() {
		return this.Servicename;
	}

	public void setServicename(String servicename) {
		this.Servicename = servicename;
	}

	public void setSchemeId(int schemeId) {
		this.SchemeId = schemeId;
	}

	public int getServiceId() {
		return this.ServiceId;
	}

	public void setServiceId(int serviceId) {
		this.ServiceId = serviceId;
	}

	public int deleteSchemeService() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "delete from `scheme_service` where id="
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

	public int getSchemeIdbyId(int id) {
		int scheme_id;
		scheme_id = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT scheme_id   FROM `scheme_service` WHERE `id` = " + id;
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
					scheme_id = Integer.parseInt(res.getString("scheme_id"));
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return scheme_id;
	}

	public int addSchemeService() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;		
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `scheme_service` (`scheme_id`, `service_id`) VALUES ("
						+ this.getSchemeId() + ", " + this.getServiceId() + ")";
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
	public ArrayList<SchemeServiceBO> getAllItem(int scheme_id) {
		ArrayList<SchemeServiceBO> SchemeServiceBOList;
		SchemeServiceBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "select id, scheme_id,service_id , (select scheme_name  from scheme where  id=scheme_id) scheme,(select name from services where id=service_id) service from scheme_service where scheme_id="
						+ scheme_id + "  ORDER BY service ";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				SchemeServiceBOList = this.populateItemList(res);
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
		return SchemeServiceBOList;
	}

	private ArrayList<SchemeServiceBO> populateItemList(ResultSet res) {
		ArrayList<SchemeServiceBO> schemeServiceList = null;
		SchemeServiceBO schemeserviceBO = null;
		if (res != null) {
			schemeServiceList = new ArrayList<SchemeServiceBO>();
			try {
				while (res.next()) {
					schemeserviceBO = new SchemeServiceBO();
					schemeserviceBO.setId(res.getInt("id"));
					schemeserviceBO.setSchemeId(res.getInt("scheme_id"));
					schemeserviceBO.setServiceId(res.getInt("service_id"));
					schemeserviceBO.setSchemeName(res.getString("scheme"));
					schemeserviceBO.setServicename(res.getString("service"));
					schemeServiceList.add(schemeserviceBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return schemeServiceList;
	}
}