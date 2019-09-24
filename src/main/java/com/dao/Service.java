package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.ServiceBO;
import com.util.DBUtility;

public class Service {
	int id;
	String name;
	int status;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getStatus() {
		return this.status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public ArrayList<String> getServiceList(int i) throws NamingException,
			SQLException, Exception {
		ArrayList<String> serviceList = new ArrayList<String>();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		con = DBUtility.getConnection();
		String sql = "select service_id,(SELECT name FROM `services` WHERE `id` =service_id) supplier_name  from service_supplier  where  supplier_id="
				+ i;
		st = con.prepareStatement(sql);
		rs = st.executeQuery(sql);
		System.out.println(sql);
		while (rs.next()) {
			serviceList.add(String.valueOf(rs.getString("service_id")) + ":"
					+ rs.getString("supplier_name"));
		}
		rs.close();
		st.close();
		con.close();
		return serviceList;
	}

	public ArrayList<String> getSchemeName(int i) throws NamingException,
			SQLException, Exception {
		ArrayList<String> serviceList = new ArrayList<String>();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		con = DBUtility.getConnection();
		String sql = "select * from services WHERE id=" + i;
		st = con.prepareStatement(sql);
		rs = st.executeQuery(sql);
		System.out.println(sql);
		while (rs.next()) {
			System.out.println("xx" + rs.getString("id") + "$"
					+ rs.getString("name"));
			serviceList.add(String.valueOf(rs.getString("id")) + "$"
					+ rs.getString("name"));
		}
		rs.close();
		st.close();
		con.close();
		return serviceList;
	}

	public ArrayList<String> getSupList(int serviceid) throws NamingException,
			SQLException, Exception {
		ArrayList<String> serviceList = new ArrayList<String>();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		con = DBUtility.getConnection();
		String sql = null;
		sql = serviceid > 0 ? "SELECT supplier.id,supplier.company_name,service_supplier.service_id FROM `supplier`,`service_supplier` WHERE service_supplier.supplier_id = supplier.id and  service_supplier.service_id="
				+ serviceid
				: "SELECT supplier.id,supplier.company_name,service_supplier.service_id FROM `supplier`,`service_supplier` WHERE service_supplier.supplier_id = supplier.id ";
		st = con.prepareStatement(sql);
		rs = st.executeQuery(sql);
		System.out.println(sql);
		while (rs.next()) {
			System.out.println("yy" + rs.getString("id") + ":"
					+ rs.getString("company_name"));
			serviceList.add(String.valueOf(rs.getString("id")) + ":"
					+ rs.getString("company_name"));
		}
		rs.close();
		st.close();
		con.close();
		return serviceList;
	}

	public void addData() {
		Connection con = null;
		Statement st = null;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `services` (`name`) VALUES (upper('"
						+ this.getName() + "'))";
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

	public int getMaxId() {
		int max;
		max = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT max(id) max FROM `services` ";
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
					max = res.getInt("max");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return max;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ServiceBO> getAllServiceForSupplier(int supplier_id) {
		ArrayList<ServiceBO> serviceBOList;
		serviceBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM `service_supplier` WHERE `supplier_id` ="
						+ supplier_id;
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				serviceBOList = this.populateItemList(res);
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
		return serviceBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ServiceBO> getAllItem() {
		ArrayList<ServiceBO> serviceBOList;
		serviceBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `services` order by name";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				serviceBOList = this.populateItemList(res);
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
		return serviceBOList;
	}

	private ArrayList<ServiceBO> populateItemList(ResultSet res) {
		ArrayList<ServiceBO> serviceList = null;
		ServiceBO serviceBO = null;
		if (res != null) {
			serviceList = new ArrayList<ServiceBO>();
			try {
				while (res.next()) {
					serviceBO = new ServiceBO();
					serviceBO.setId(res.getInt("id"));
					serviceBO.setName(res.getString("name"));
					serviceBO.setStatus(res.getInt("status"));
					serviceList.add(serviceBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return serviceList;
	}

	public String getServiceNameById(int id) {
		String service_name;
		service_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select name from services WHERE id=" + id;
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
					service_name = res.getString("name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return service_name;
	}
}