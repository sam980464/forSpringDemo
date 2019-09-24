package com.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.project.bean.DeveloperBean;
import com.project.bean.InvestorBean;
import com.util.DBUtility;

public class Developer {
	private int developer_id;
	private String developer_name;
	private String developer_address;
	private String developer_email_id;
	private String developer_contactno;

	public int getDeveloper_id() {
		return developer_id;
	}

	public void setDeveloper_id(int developer_id) {
		this.developer_id = developer_id;
	}

	public String getDeveloper_name() {
		return developer_name;
	}

	public void setDeveloper_name(String developer_name) {
		this.developer_name = developer_name;
	}

	public String getDeveloper_address() {
		return developer_address;
	}

	public void setDeveloper_address(String developer_address) {
		this.developer_address = developer_address;
	}

	public String getDeveloper_email_id() {
		return developer_email_id;
	}

	public void setDeveloper_email_id(String developer_email_id) {
		this.developer_email_id = developer_email_id;
	}

	public String getDeveloper_contactno() {
		return developer_contactno;
	}

	public void setDeveloper_contactno(String developer_contactno) {
		this.developer_contactno = developer_contactno;
	}

	
	public int addDeveloper() {
		Connection con = null;
		Statement st = null;
		int returnVal= 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `project_developer_master` (developer_name,developer_address,developer_email_id,developer_contactno,status) VALUES ('"
						+ this.getDeveloper_name()
						+ "', '"
						+ this.getDeveloper_address()
						+ "', '"
						+ this.getDeveloper_email_id()
						+ "', '"
						+ this.getDeveloper_contactno()
						+ "', '"
						+"1')";
				System.out.println(sql);
				if (!this.getDeveloper_name().equals("")) {
					returnVal= st.executeUpdate(sql);
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

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<DeveloperBean> getAllDeveloper(String flag) {
		ArrayList<DeveloperBean> developerList;
		developerList = new ArrayList<DeveloperBean>();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		String sql = "";
		try {
			try {
				con = DBUtility.getConnection();
				sql = flag.equals("all") ? "SELECT * FROM  `project_developer_master` where status='1'"
						: "SELECT * FROM  `project_developer_master` where id="
								+ flag;
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				while (res.next()) {
					DeveloperBean developer = new DeveloperBean();
					developer.setDeveloper_id(res.getInt("id"));
					developer.setDeveloper_name(res.getString("developer_name"));
					developer.setDeveloper_contactno(res
							.getString("developer_contactno"));
					developer.setDeveloper_address(res
							.getString("developer_address"));
					developer.setDeveloper_email_id(res
							.getString("developer_email_id"));
					
					developerList.add(developer);
				}
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
		return developerList;
	}

	public String getInvestorDetailsById(int bid) {
		String address;
		address = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT * FROM `bank` WHERE ID=" + bid;
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

	public int updateData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE project_developer_master SET  developer_name ='"
						+ this.getDeveloper_name()
						+ "' , developer_address ='"
						+ this.getDeveloper_address()
						+ "', developer_contactno ='"
						+ this.getDeveloper_contactno()
						+ "', developer_email_id ='"
						+ this.getDeveloper_email_id()		
						
						+ "' WHERE id=" + this.getDeveloper_id();
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
