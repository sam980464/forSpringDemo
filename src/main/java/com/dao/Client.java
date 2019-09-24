/*
 * Decompiled with CFR 0_122.
 * 
 * Could not load the following classes:
 *  com.bo.ClientBO
 *  com.util.DBUtility
 */
package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


import javax.naming.NamingException;

import com.bo.ClientBO;
import com.bo.PaymentBO;
import com.util.DBUtility;

public class Client {
	private int id;
	private String mrMs;
	private String clientName;
	private String guardianRelation;
	private String guardianName;
	private int municipality;
	private String wordNo;
	private String presentAddress;
	private String permanentAddress;
	private String mobile;
	private String land;
	private int ref;
	private String email;
	private String email1;
	private String dateCreated;
	private String fromDate;
	private String toDateExp;
	private int scheme_id;
	private String state_name;
	private int associatedDeveloperId;

	public int getScheme_id() {
		return this.scheme_id;
	}
	
	public String getState_name() {
		return state_name;
	}

	public void setState_name(String state_name) {
		this.state_name = state_name;
	}

	public void setScheme_id(int scheme_id) {
		this.scheme_id = scheme_id;
	}

	public String getFromDate() {
		return this.fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getToDateExp() {
		return this.toDateExp;
	}

	public void setToDateExp(String toDateExp) {
		this.toDateExp = toDateExp;
	}

	public String getMrMs() {
		return this.mrMs;
	}

	public void setMrMs(String mrMs) {
		this.mrMs = mrMs;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getClientName() {
		System.out.print(this.clientName);
		return this.clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getGuardianRelation() {
		return this.guardianRelation;
	}

	public void setGuardianRelation(String guardianRelation) {
		this.guardianRelation = guardianRelation;
	}

	public String getGuardianName() {
		return this.guardianName;
	}

	public void setGuardianName(String guardianName) {
		this.guardianName = guardianName;
	}

	public int getMunicipality() {
		return this.municipality;
	}

	public void setMunicipality(int municipality) {
		this.municipality = municipality;
	}

	public String getWordNo() {
		return this.wordNo;
	}

	public void setWordNo(String wordNo) {
		this.wordNo = wordNo;
	}

	public String getPresentAddress() {
		return this.presentAddress;
	}

	public void setPresentAddress(String presentAddress) {
		this.presentAddress = presentAddress;
	}

	public String getPermanentAddress() {
		return this.permanentAddress;
	}

	public void setPermanentAddress(String permanentAddress) {
		this.permanentAddress = permanentAddress;
	}

	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getLand() {
		return this.land;
	}

	public void setLand(String land) {
		this.land = land;
	}

	public int getRef() {
		return this.ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDateCreated() {
		return this.dateCreated;
	}

	public void setDateCreated(String dateCreated) {
		this.dateCreated = dateCreated;
	}
	
	

	
	public int getAssociatedDeveloperId() {
		return associatedDeveloperId;
	}

	public void setAssociatedDeveloperId(int associatedDeveloperId) {
		this.associatedDeveloperId = associatedDeveloperId;
	}

	public int addData() {
		Connection con = null;
		Statement st = null;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `client` (`mr_ms`,`client_name`, `guardian_rel`, `guardian_name`, `municipality`, `ward_no`, `present_address`, `permanent_address`, `mobile_no`, `land_no`, `refarence_id`, `email`, `email1`, `date_created`,`state_name`,`associatedDeveloperId`) VALUES ('"
						+ this.getMrMs()
						+ "',UPPER('"
						+ this.getClientName()
						+ "'), '"
						+ this.getGuardianRelation()
						+ "', '"
						+ this.getGuardianName()
						+ "', "
						+ this.getMunicipality()
						+ ", '"
						+ this.getWordNo()
						+ "', '"
						+ this.getPresentAddress()
						+ "', '"
						+ this.getPermanentAddress()
						+ "', '"
						+ this.getMobile()
						+ "', '"
						+ this.getLand()
						+ "', "
						+ this.getRef()
						+ ", '"
						+ this.getEmail()
						+ "', '"
						+ this.getEmail1()
						+ "','"
						+ this.getDateCreated()
						+ "','"
						+ this.getState_name()
						+ "',"
						+ this.getAssociatedDeveloperId()+")";
				if (!this.getClientName().equals("")) {
					return st.executeUpdate(sql);
				}				
				st = null;
			} catch (Exception e) {				
				System.out.println(e);
				e.printStackTrace();
				DBUtility.closeConnection(con, st, (ResultSet) null);
				return 0;
			}
		} finally {
			DBUtility.closeConnection(con, st, (ResultSet) null);
		}
		return 0;
	}

	public int getMaxId() {
		int max;
		max = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT max(id) max FROM `client` ";
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

	public double getTotalPaidCid(int cid,String fromDate) {
		double amount_received;
		amount_received = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT payment.client_id as id,  (select client_name from client where id=payment.client_id) as `name`, (select sum(estimate.amount) from estimate where estimate.client_id=payment.client_id)  as `estimate`, SUM(payment.amount_received) AS amount_received, (select sum(estimate.amount) from estimate where estimate.client_id=payment.client_id)-SUM(payment.amount_received) as amount_unpaid FROM payment  where payment.client_id="
				+ cid + " and payment.received_date <= '"+fromDate+"' GROUP BY payment.client_id";
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
					amount_received = res.getInt("amount_received");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount_received;
	}
	public double getTotalPaidByDateRange(int cid,String fromDate,String toDate) {
		double amount_received;
		amount_received = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT payment.client_id as id,  (select client_name from client where id=payment.client_id) as `name`, (select sum(estimate.amount) from estimate where estimate.client_id=payment.client_id)  as `estimate`, SUM(payment.amount_received) AS amount_received, (select sum(estimate.amount) from estimate where estimate.client_id=payment.client_id)-SUM(payment.amount_received) as amount_unpaid FROM payment  where payment.client_id="
				+ cid + " and payment.received_date >= '"+fromDate+"' and payment.received_date <= '"+toDate+"'";
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
					amount_received = res.getInt("amount_received");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount_received;
	}

	public double getTotalPaidCid(int cid, int scheme_id,String fromDate) {
		double amount_received;
		amount_received = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select sum(amount_received) amount_received  from payment,estimate  where  payment.client_id="
				+ cid
				+ " and payment.received_date <= '"+fromDate+"' and payment.estimate_id=estimate.id  and estimate.scheme_id="
				+ scheme_id;
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
					amount_received = res.getInt("amount_received");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount_received;
	}
	
	public double getTotalPaidByDateRange(int cid, int scheme_id,String fromDate,String toDate) {
		double amount_received;
		amount_received = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select sum(amount_received) amount_received  from payment,estimate  where  payment.client_id="
				+ cid
				+ " and payment.received_date >='"+fromDate+"' and payment.received_date <= '"+toDate+"' and payment.estimate_id=estimate.id  and estimate.scheme_id="
				+ scheme_id ;
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
					amount_received = res.getInt("amount_received");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount_received;
	}
	
	public double getTotalPaidCid(int cid) {
		double amount_received;
		amount_received = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT payment.client_id as id,  (select client_name from client where id=payment.client_id) as `name`, (select sum(estimate.amount) from estimate where estimate.client_id=payment.client_id)  as `estimate`, SUM(payment.amount_received) AS amount_received, (select sum(estimate.amount) from estimate where estimate.client_id=payment.client_id)-SUM(payment.amount_received) as amount_unpaid FROM payment  where payment.client_id="
				+ cid + " GROUP BY payment.client_id";
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
					amount_received = res.getInt("amount_received");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount_received;
	}

	public double getTotalPaidCid(int cid, int scheme_id) {
		double amount_received;
		amount_received = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select sum(amount_received) amount_received  from payment,estimate  where  payment.client_id="
				+ cid
				+ " and payment.estimate_id=estimate.id  and estimate.scheme_id="
				+ scheme_id;
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
					amount_received = res.getInt("amount_received");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount_received;
	}

	public double getTotalDueCid(int cid) {
		double amount_unpaid;
		amount_unpaid = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		
		String sql = null;
		ResultSet res = null;
		sql = "SELECT payment.client_id as id,  (select client_name from client where id=payment.client_id) as `name`, (select sum(estimate.amount) from estimate where estimate.client_id=payment.client_id)  as `estimate`, SUM(payment.amount_received) AS amount_received, (select sum(estimate.amount) from estimate where estimate.client_id=payment.client_id)-SUM(payment.amount_received) as amount_unpaid FROM payment  where payment.client_id="
				+ cid + " GROUP BY payment.client_id";
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
					amount_unpaid = res.getInt("amount_unpaid");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount_unpaid;
	}

	public double getTotalExpByCid(int cid) {
		double total_amount;
		total_amount = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT sum(total_amount) total_amount FROM `expenses` WHERE status=1 and `client_id`="
				+ cid;
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
					total_amount = res.getInt("total_amount");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return total_amount;
	}
	
	public double getBeforeDateExpByCid(int cid, String fromDate) {
		double total_amount;
		total_amount = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT sum(amount_received) total_amount FROM `expenses`,expenses_payment WHERE expenses.status=1 and expenses.id=expenses_payment.expenses_id and expenses.date <= '"+fromDate+"' and expenses.client_id="
				+ cid;
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
					total_amount = res.getInt("total_amount");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return total_amount;
	}
	
	public double getBeforeDateExpByCid(int cid, int scheme_id, String fromDate) {
		double total_amount;
		total_amount = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT sum(amount_received) total_amount FROM `expenses`,expenses_payment,estimate WHERE expenses.status=1 and expenses.id=expenses_payment.expenses_id and expenses.date <='"+fromDate +"' and expenses.`client_id`="
				+ cid +" and expenses.estimate_id=estimate.id and estimate.scheme_id="+scheme_id;
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
					total_amount = res.getInt("total_amount");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return total_amount;
	}

	public double getTotalExpByCid(int cid, int scheme_id) {
		double total_amount;
		total_amount = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		
		if (this.getFromDate().equals("")
				|| this.getToDateExp().equals("")) {
			sql= "SELECT sum(total_amount) total_amount FROM newrtechdb.`expenses` WHERE status=1 and  `client_id`="+
					cid+" and `estimate_id` in( SELECT `id` FROM newrtechdb.`estimate`  where `client_id`="+cid+" and `scheme_id`="+ scheme_id +")";
		} else { 
			sql= "SELECT sum(total_amount) total_amount FROM newrtechdb.`expenses` WHERE status=1 and  `client_id`="+
					cid+" and `estimate_id` in( SELECT `id` FROM newrtechdb.`estimate`  where `client_id`="+cid+" and `scheme_id`="
					+ scheme_id+") and " +" date between '"+ this.getFromDate()
					+ "' and '"
					+ this.getToDateExp()+"'";
		}
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
				System.out.println(sql);
				res = st.executeQuery(sql);
				while (res.next()) {
					total_amount = res.getInt("total_amount");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return total_amount;
	}

	public double getTotalExpPaidByCid(int cid) {
		double amount_paid;
		amount_paid = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT sum(amount_received) amount_paid FROM expenses_payment,expenses  WHERE expenses.status=1 and expenses.id=expenses_payment.expenses_id and expenses.client_id ="
				+ cid;
		System.out.println(sql);
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
					amount_paid = res.getInt("amount_paid");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount_paid;
	}

	public double getTotalExpPaidByCid(int cid, int scheme_id) {
		double amount_paid;
		amount_paid = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		if (this.getFromDate().equals("")
				|| this.getToDateExp().equals("")) {
			sql = "SELECT sum(amount_received) amount_paid FROM expenses_payment,expenses  WHERE expenses.status=1 and "
					+ "expenses.id=expenses_payment.expenses_id and expenses.`estimate_id` in( SELECT `id` FROM newrtechdb.`estimate`  where `client_id`="+cid+" and `scheme_id`="+ scheme_id +")"
					+" and expenses.client_id =" + cid;
		} else {
			sql = "SELECT sum(amount_received) amount_paid FROM expenses_payment,expenses  WHERE expenses.status=1 and "
					+ "expenses.id=expenses_payment.expenses_id and expenses.`estimate_id` in( SELECT `id` FROM newrtechdb.`estimate`  where `client_id`="+cid+" and `scheme_id`="
					+ scheme_id +" and date_created between '"+ this.getFromDate()
					+ "' and '"
					+ this.getToDateExp()+"')"
					+" and expenses.client_id =" + cid;
		}
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
					amount_paid = res.getInt("amount_paid");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount_paid;
	}
	
	public double getActualExpenseByDateRange(int cid, int scheme_id,String fromDate, String toDate) {
		double amount_paid;
		amount_paid = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		
		/*sql = "SELECT sum(amount_received) amount_paid FROM expenses_payment,expenses  WHERE expenses.status=1 and "
				+ "expenses.id=expenses_payment.expenses_id and expenses.`estimate_id` in( SELECT `id` FROM newrtechdb.`estimate`  where `client_id`="+cid+" and `scheme_id`="
				+ scheme_id +" and date_created between '"+ fromDate
				+ "' and '"
				+ toDate+"')"
				+" and expenses.client_id =" + cid;*/
		sql = "SELECT sum(amount_received) amount_paid FROM `expenses`,expenses_payment,estimate WHERE expenses.status=1 and "
				+"expenses.id=expenses_payment.expenses_id and expenses.date >= '"+fromDate+"' and expenses.date <= '"+toDate+"' and expenses.client_id="
				+ cid +" and expenses.estimate_id=estimate.id and estimate.scheme_id="+scheme_id;
		
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
					amount_paid = res.getInt("amount_paid");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount_paid;
	}

	public double getActualExpenseByDateRange(int cid, String fromDate, String toDate) {
		double amount_paid;
		amount_paid = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		
		/*sql = "SELECT sum(amount_received) amount_paid FROM expenses_payment,expenses  WHERE expenses.status=1 and "
				+ "expenses.id=expenses_payment.expenses_id and expenses.`estimate_id` in( SELECT `id` FROM newrtechdb.`estimate`  where `client_id`="+cid+" and date_created between '"+ fromDate
				+ "' and '"
				+ toDate+"')"
				+" and expenses.client_id =" + cid;*/
		sql = "SELECT sum(amount_received) amount_paid FROM `expenses`,expenses_payment WHERE expenses.status=1 and "
				+"expenses.id=expenses_payment.expenses_id and expenses.date >= '"+fromDate+"' and expenses.date <= '"+toDate+"' and expenses.client_id="
				+ cid;
		
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
					amount_paid = res.getInt("amount_paid");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount_paid;
	}
	public String getClientNameById(int id) {
		String client_name;
		client_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT CONCAT(`mr_ms`,' ',`client_name`) as client_name FROM `client` WHERE ID="
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
					client_name = res.getString("client_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return client_name;
	}
	public String getDeveloperNameById(int id) {
		String developer_name;
		developer_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT `developer_name` as developer_name FROM `client` c,`project_developer_master` d  WHERE c.ID="
				+ id +" and  c.associatedDeveloperId=d.id ";
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
					developer_name = res.getString("developer_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return developer_name;
	}


	public String getClientAddressById(int id) {
		String present_address;
		present_address = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT  present_address  FROM `client` WHERE ID=" + id;
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
					present_address = res.getString("present_address");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return present_address;
	}
	
	public boolean isClientRegional(int id) {
		String stae_name;
		stae_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT  state_name  FROM `client` WHERE ID=" + id;
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
					stae_name = res.getString("state_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		
		if("West Bengal".equalsIgnoreCase(stae_name)){
			return true;
		} else {
			return false;
		}
		
	}

	public int updateData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE `client` SET `mr_ms` = '" + this.getMrMs()
						+ "', " + "`client_name` = '" + this.getClientName()
						+ "', " + "`guardian_rel` = '"
						+ this.getGuardianRelation() + "', "
						+ "`guardian_name` = '" + this.getGuardianName()
						+ "', " + "`municipality` = '" + this.getMunicipality()
						+ "', " + "`ward_no` = '" + this.getWordNo() + "', "
						+ "`present_address` = '" + this.getPresentAddress()
						+ "', " + "`permanent_address` = '"
						+ this.getPermanentAddress() + "', "
						+ "`mobile_no` = '" + this.getMobile() + "', "
						+ "`land_no` = '" + this.getLand() + "', "
						+ "`refarence_id` = '" + this.getRef() + "', "
						+ "`email` = '" + this.getEmail() + "' ,"
						+ "`email1` = '" + this.getEmail1()
						+ "',`date_created` = '" + this.getDateCreated() + "', "
						+ "`state_name` = '" + this.getState_name() + "', "
						+ "`associatedDeveloperId` = " + this.getAssociatedDeveloperId() 
						+ " WHERE `client`.`id` = " + this.getId();
				System.out.println(sql);
				returnVal = st.executeUpdate(sql);
				st = null;
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, (ResultSet) null);
			}
		} finally {
			DBUtility.closeConnection(con, st, (ResultSet) null);
		}
		return returnVal;
	}

	public int deleteClient() {
		Connection conn = null;
		Statement st = null;
		ResultSet res = null;
		int returnVal = 0;
		try {
			try {
				try {
					conn = DBUtility.getConnection();
				} catch (NamingException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
				st = conn.createStatement();
				String sql = "UPDATE `client` SET `status` = '0' WHERE `client`.`id` ="
						+ this.getId();
				returnVal = st.executeUpdate(sql);
			} catch (SQLException s) {
				System.out.println(s);
				s.printStackTrace();
				DBUtility.closeConnection(conn, st, res);
			}
		} finally {
			DBUtility.closeConnection(conn, st, res);
		}
		return returnVal;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ClientBO> getAllItem() {
		ArrayList<ClientBO> clientBOList;
		clientBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `client` where status=1 order by client_name";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				clientBOList = this.populateItemList(res);
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
		return clientBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ClientBO> getAllLatestItem(int count) {
		ArrayList<ClientBO> clientBOList;
		clientBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "select client_id,date,total_amount from expenses order by date desc limit 0,"
						+ count;
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				clientBOList = this.populateItemListMax(res);
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
		return clientBOList;
	}

	private ArrayList<ClientBO> populateItemListMax(ResultSet res) {
		ArrayList<ClientBO> clientList = null;
		ClientBO clientBO = null;
		if (res != null) {
			clientList = new ArrayList<ClientBO>();
			try {
				while (res.next()) {
					clientBO = new ClientBO();
					clientBO.setId(res.getInt("client_id"));
					clientBO.setDateCreated(res.getString("date"));
					clientBO.setTotal_amount(res.getDouble("total_amount"));
					clientList.add(clientBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return clientList;
	}

	public ArrayList<ClientBO> getAllItemForReport() {
		ArrayList<ClientBO> clientBOList;
		clientBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = null;
				if (this.getFromDate().equals("")
						|| this.getToDateExp().equals("")) {
					sql = "SELECT * FROM `client`  where id in (select distinct client_id from estimate order by `date_created` desc) order by id desc";
					if (this.getScheme_id() != 0) {
						sql = "SELECT * FROM `client`  where id in (select distinct client_id from estimate where scheme_id="
								+ this.getScheme_id()
								+ " order by `date_created` desc) order by id desc";
					}
				} else {
					sql = "SELECT * FROM `client` where id in (select distinct client_id from estimate where date_created between '"
							+ this.getFromDate()
							+ "' and '"
							+ this.getToDateExp()
							+ "' order by `date_created` desc) order by id desc";
					if (this.getScheme_id() != 0) {
						sql = "SELECT * FROM `client` where id in (select distinct client_id from estimate where scheme_id="
								+ this.getScheme_id()
								+ " and date_created between '"
								+ this.getFromDate()
								+ "' and '"
								+ this.getToDateExp()
								+ "' order by `date_created` desc) order by id desc";
					}
				}
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				clientBOList = this.populateItemListForReport(res);
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
		return clientBOList;
	}
	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ClientBO> getClientDetailsByPaymentDate() {
		ArrayList<ClientBO> clientBOList;
		clientBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = null;
				if (this.getFromDate().equals("")
						|| this.getToDateExp().equals("")) {
					sql = "SELECT * FROM `client`  where id in (select distinct client_id from payment order by `received_date` desc) order by id desc";
					if (this.getScheme_id() != 0) {
						sql = "SELECT * FROM `client`  where id in (select distinct client_id from estimate e,payment p where e.scheme_id="
								+ this.getScheme_id()
								+ " and e.id=p.estimate_id ) and and status=1 order by id desc";
					}
				} else {
					sql = "SELECT * FROM `client` where id in (select distinct client_id from payment where received_date between '"
							+ this.getFromDate()
							+ "' and '"
							+ this.getToDateExp()
							+ "' order by `received_date` desc) and status=1 order by id desc";
					if (this.getScheme_id() != 0) {
						sql = "SELECT * FROM `client` where id in (select distinct e.client_id from estimate e, payment p where e.id=p.estimate_id and  e.scheme_id="
								+ this.getScheme_id()
								+ " and p.received_date between '"
								+ this.getFromDate()
								+ "' and '"
								+ this.getToDateExp()
								+ "' and e.status=1 ) and status=1 order by id desc";
					}
				}
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				clientBOList = this.populateItemListForReport(res);
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
		return clientBOList;
	}
	
	public ArrayList<PaymentBO> getAllItemForGSTReport() {
		ArrayList<PaymentBO> paymentBOList;
		paymentBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = null;
				if (this.getFromDate().equals("")
						|| this.getToDateExp().equals("")) {
					sql = "SELECT p.id,client_name,scheme_name,gst_percentage,amount_received,gst_amount,received_date FROM `payment` p, `scheme` s,`estimate` e,`client` c where s.`id`=e.`scheme_id` and p.`estimate_id`=e.`id` and p.client_id=c.id and p.gst_amount>0 and e.status='1' order by client_name";
					if (this.getScheme_id() != 0) {
						sql = "SELECT p.id,client_name,scheme_name,gst_percentage,amount_received,gst_amount,received_date FROM `payment` p, `scheme` s,`estimate` e,`client` c where s.`id`="+this.getScheme_id()+" and s.`id`=e.`scheme_id` and p.`estimate_id`=e.`id` and p.client_id=c.id and p.gst_amount>0 and e.status='1' order by client_name";
					}
				} else {
					sql = "SELECT p.id,client_name,scheme_name,gst_percentage,amount_received,gst_amount,received_date FROM `payment` p, `scheme` s,`estimate` e,`client` c where s.`id`=e.`scheme_id` and p.`estimate_id`=e.`id` and p.client_id=c.id  and p.received_date between '"
							+ this.getFromDate()
							+ "' and '"
							+ this.getToDateExp()
							+ "' and p.gst_amount>0 and e.status='1' order by client_name";
					if (this.getScheme_id() != 0) {
						sql = "SELECT p.id, client_name,scheme_name,gst_percentage,amount_received,gst_amount,received_date FROM `payment` p, `scheme` s,`estimate` e,`client` c where s.`id`="+this.getScheme_id()+" and s.`id`=e.`scheme_id` and p.`estimate_id`=e.`id` and p.client_id=c.id and received_date between '"
								+ this.getFromDate()
								+ "' and '"
								+ this.getToDateExp()
								+ "' and p.gst_amount>0 and e.status='1' order by client_name";
					}
				}
				System.out.println("SQLLLLLLLLLLLLLL");
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				paymentBOList = this.populateItemListForGSTReport(res);
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
		return paymentBOList;
	}

	private ArrayList<ClientBO> populateItemListForReport(ResultSet res) {
		ArrayList<ClientBO> clientList = null;
		ClientBO clientBO = null;
		if (res != null) {
			clientList = new ArrayList<ClientBO>();
			try {
				while (res.next()) {
					clientBO = new ClientBO();
					clientBO.setId(res.getInt("id"));
					clientBO.setClientName(res.getString("client_name"));
					clientBO.setMobile(res.getString("mobile_no"));
					clientBO.setDateCreated(res.getString("date_created"));
					clientList.add(clientBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return clientList;
	}
	private ArrayList<PaymentBO> populateItemListForGSTReport(ResultSet res) {
		ArrayList<PaymentBO> paymentList = null;
		PaymentBO paymentBO = null;
		if (res != null) {
			paymentList = new ArrayList<PaymentBO>();
			try {
				while (res.next()) {
					paymentBO = new PaymentBO();
					paymentBO.setId(res.getInt("id"));
					paymentBO.setClientName(res.getString("client_name"));
					paymentBO.setSchemeName(res.getString("scheme_name"));
					paymentBO.setGstPercentage(res.getInt("gst_percentage"));
					paymentBO.setAmountReceived((double)res.getInt("amount_received"));
					paymentBO.setGstAmount(res.getDouble("gst_amount"));
					paymentBO.setDateReceived((res.getDate("received_date")).toString());
					
					paymentList.add(paymentBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return paymentList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ClientBO> getAllItem(int cid) {
		ArrayList<ClientBO> clientBOList;
		clientBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `client` where status=1 and id="
						+ cid;
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				clientBOList = this.populateItemList(res);
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
		return clientBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ClientBO> getAllItemWithSameNameClient() {
		ArrayList<ClientBO> clientBOList;
		clientBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "select id,CONCAT(client_name,'-',id) as client_name from client where status=1 and client_name in (select client_name from client group by client_name having (count(client_name)>1)) union select id,client_name as client_name from client where status=1 and client_name in ( select client_name from client group by client_name having (count(client_name)=1)) order by client_name";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				clientBOList = this.populateItemListWithSameNameClient(res);
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
		return clientBOList;
	}

	private ArrayList<ClientBO> populateItemListWithSameNameClient(ResultSet res) {
		ArrayList<ClientBO> clientList = null;
		ClientBO clientBO = null;
		if (res != null) {
			clientList = new ArrayList<ClientBO>();
			try {
				while (res.next()) {
					clientBO = new ClientBO();
					clientBO.setId(res.getInt("id"));
					clientBO.setClientName(res.getString("client_name"));
					clientList.add(clientBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return clientList;
	}

	private ArrayList<ClientBO> populateItemList(ResultSet res) {
		ArrayList<ClientBO> clientList = null;
		ClientBO clientBO = null;
		if (res != null) {
			clientList = new ArrayList<ClientBO>();
			try {
				while (res.next()) {
					clientBO = new ClientBO();
					clientBO.setId(res.getInt("id"));
					clientBO.setMrMs(res.getString("mr_ms"));
					clientBO.setClientName(res.getString("client_name"));
					clientBO.setGuardianRelation(res.getString("guardian_rel"));
					clientBO.setGuardianName(res.getString("guardian_name"));
					clientBO.setMunicipality(res.getInt("municipality"));
					clientBO.setWordNo(res.getString("ward_no"));
					clientBO.setPresentAddress(res.getString("present_address"));
					clientBO.setPermanentAddress(res
							.getString("permanent_address"));
					clientBO.setMobile(res.getString("mobile_no"));
					clientBO.setLand(res.getString("land_no"));
					clientBO.setRef(res.getInt("refarence_id"));
					clientBO.setEmail(res.getString("email"));
					clientBO.setEmail1(res.getString("email1"));
					clientBO.setDateCreated(res.getString("date_created"));
					clientBO.setState_name(res.getString("state_name"));
					clientBO.setAssociatedDeveloperId(res.getInt("associatedDeveloperId"));
					clientList.add(clientBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return clientList;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail1() {
		return this.email1;
	}
}
