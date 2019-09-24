package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.SupplierBO;
import com.util.DBUtility;

public class Supplier {
	int id;
	String supplierName;
	int serviceId;
	String address;
	String phone;
	int createdBy;
	int status;
	int supplier_id;
	private int client_id;
	private double amount;

	public int getClient_id() {
		return this.client_id;
	}

	public void setClient_id(int client_id) {
		this.client_id = client_id;
	}

	public double getAmount() {
		return this.amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getSupplier_id() {
		return this.supplier_id;
	}

	public void setSupplier_id(int supplier_id) {
		this.supplier_id = supplier_id;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSupplierName() {
		return this.supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public int getServiceId() {
		return this.serviceId;
	}

	public void setServiceId(int serviceId) {
		this.serviceId = serviceId;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getCreatedBy() {
		return this.createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	public int getStatus() {
		return this.status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getMaxId() {
		int max;
		max = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT max(id) max FROM `supplier` ";
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

	public int addData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO  supplier (`company_name`,`address`,`phone`,`created_by`) values ('"
						+ this.getSupplierName()
						+ "', '"
						+ this.getAddress()
						+ "','"
						+ this.getPhone()
						+ "',"
						+ this.getCreatedBy()
						+ " )";
				if (!this.getSupplierName().equals("")) {
					returnVal = st.executeUpdate(sql);
				}
				int supplier_id = this.getMaxId();
				sql = "insert into  service_supplier (service_id ,supplier_id) values ("
						+ this.getServiceId() + "," + supplier_id + ")";
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

	public int addDataServiceSupplier() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO   service_supplier (`service_id`,`supplier_id`) values ("
						+ this.serviceId + "," + this.supplier_id + ")";
				returnVal=st.executeUpdate(sql);
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
				String sql = "UPDATE SUPPLIER SET   company_name  ='"
						+ this.getSupplierName() + "' , address ='"
						+ this.getAddress() + "',phone='" + this.getPhone()
						+ "' WHERE ID=" + this.getId();
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

	public int deleteSupplier() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE  supplier SET status=0 WHERE ID="
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

	public String getSupplierNameWithAddressById(int id) {
		String company_name;
		company_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT CONCAT(`company_name`,' [',`address`,']') as company_name FROM `supplier` WHERE ID="
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
					company_name = res.getString("company_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return company_name;
	}

	public int getServiceIdFromSupplier(int supplier_id) {
		int service_id;
		service_id = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT `service_id` FROM `service_supplier` WHERE `supplier_id` ="
				+ supplier_id;
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
					service_id = res.getInt("service_id");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return service_id;
	}

	public String getSupplierNameById(int id) {
		String company_name;
		company_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT `company_name` FROM `supplier` WHERE ID=" + id;
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
					company_name = res.getString("company_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return company_name;
	}

	public String getSupplierAddressById(int id) {
		String address;
		address = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT `address` FROM `supplier` WHERE ID=" + id;
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

	public String getSupplierPhoneById(int id) {
		String phone;
		phone = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT `phone` FROM `supplier` WHERE ID=" + id;
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
					phone = res.getString("phone");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return phone;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<SupplierBO> getAllItem(int service_id) {
		ArrayList<SupplierBO> supplierBOList;
		supplierBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "select * from supplier where supplier.id in (select supplier_id from  service_supplier where service_id="
						+ service_id + ")";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				supplierBOList = this.populateItemList(res);
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
		return supplierBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<SupplierBO> getAllServiceBySupplier(int supplier_id) {
		ArrayList<SupplierBO> supplierBOList;
		supplierBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "select service_id,(SELECT name FROM `services` WHERE `id` =service_id) supplier_name  from service_supplier  where  supplier_id="
						+ supplier_id;
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				supplierBOList = this.populateServiceList(res);
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
		return supplierBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<SupplierBO> getAllServiceBySupplier1(int supplier_id,
			String sid) {
		ArrayList<SupplierBO> supplierBOList;
		supplierBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "select  name as supplier_name,service_id,supplier_id,tbl3.company_name,tbl3.scheme_id from(select service_id,supplier_id,tbl2.company_name,scheme_service.scheme_id from  (SELECT service_id as srvice_id,supplier_id,supplier.company_name from (SELECT service_id,supplier_id from service_supplier WHERE supplier_id='"
						+ supplier_id
						+ "') as tbl1"
						+ " INNER join supplier on supplier.id=tbl1.supplier_id) as tbl2"
						+ " INNER join scheme_service on scheme_service.service_id=tbl2.srvice_id"
						+ " WHERE scheme_service.scheme_id='"
						+ sid
						+ "') as tbl3"
						+ " INNER join services on services.id=tbl3.service_id";
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				supplierBOList = this.populateServiceList(res);
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
		return supplierBOList;
	}

	private ArrayList<SupplierBO> populateServiceList(ResultSet res) {
		ArrayList<SupplierBO> supplierList = null;
		SupplierBO supplierBO = null;
		if (res != null) {
			supplierList = new ArrayList<SupplierBO>();
			try {
				while (res.next()) {
					supplierBO = new SupplierBO();
					supplierBO.setId(res.getInt("service_id"));
					supplierBO.setSupplierName(res.getString("supplier_name"));
					supplierList.add(supplierBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return supplierList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<SupplierBO> getAllItem() {
		ArrayList<SupplierBO> supplierBOList;
		supplierBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `supplier` where status=1 group by  company_name ";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				supplierBOList = this.populateItemList(res);
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
		return supplierBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<SupplierBO> getAllItembySupplierid(int supplierid) {
		ArrayList<SupplierBO> supplierBOList;
		supplierBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `supplier` where id=" + supplierid;
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				supplierBOList = this.populateItemList(res);
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
		return supplierBOList;
	}

	private ArrayList<SupplierBO> populateItemList(ResultSet res) {
		ArrayList<SupplierBO> supplierList = null;
		SupplierBO supplierBO = null;
		if (res != null) {
			supplierList = new ArrayList<SupplierBO>();
			try {
				while (res.next()) {
					supplierBO = new SupplierBO();
					supplierBO.setId(res.getInt("id"));
					supplierBO.setSupplierName(res.getString("company_name"));
					supplierBO.setAddress(res.getString("address"));
					supplierBO.setPhone(res.getString("phone"));
					supplierList.add(supplierBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return supplierList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<SupplierBO> getClientWiseExpensesBySupplier(int sup_id) {
		ArrayList<SupplierBO> supplierBOList;
		supplierBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT `client_id`,sum(`total_amount`) total_amount,`client`.status FROM `expenses`,`client` WHERE `client`.id=expenses.`client_id` and client.status=1 and   expenses.status=1 and expenses.`supplier_id`="
						+ sup_id + " group by expenses.`client_id`";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				supplierBOList = this.populateClientList(res);
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
		return supplierBOList;
	}

	private ArrayList<SupplierBO> populateClientList(ResultSet res) {
		ArrayList<SupplierBO> supplierList = null;
		SupplierBO supplierBO = null;
		if (res != null) {
			supplierList = new ArrayList<SupplierBO>();
			try {
				while (res.next()) {
					supplierBO = new SupplierBO();
					supplierBO.setClient_id(res.getInt("client_id"));
					supplierBO.setAmount(res.getDouble("total_amount"));
					supplierList.add(supplierBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return supplierList;
	}
}