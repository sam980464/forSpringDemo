package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.AddRoleBO;
import com.bo.PoliceStationBO;
import com.util.DBUtility;

public class AddRole {
	private int id;
	private String role;
	private String roleDescription;
	private int status;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getRoleDescription() {
		return roleDescription;
	}

	public void setRoleDescription(String roleDescription) {
		this.roleDescription = roleDescription;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<AddRoleBO> getAllItem() {
		ArrayList<AddRoleBO> addRoleBOList;
		addRoleBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `roles` where status=1 order by role";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				addRoleBOList = this.populateItemList(res);
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
		return addRoleBOList;
	}

	private ArrayList<AddRoleBO> populateItemList(ResultSet res) {
		ArrayList<AddRoleBO> addRoleList = null;
		AddRoleBO addRoleBO = null;
		if (res != null) {
			addRoleList = new ArrayList<AddRoleBO>();
			try {
				while (res.next()) {
					addRoleBO = new AddRoleBO();
					addRoleBO.setId(res.getInt("id"));
					addRoleBO.setRole(res
							.getString("role"));
					addRoleBO.setRoleDescription(res.getString("roleDescription"));
					addRoleBO.setStatus(res.getInt("status"));
					addRoleList.add(addRoleBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return addRoleList;
	}

	public int addNew() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0 ;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `roles` (`role` ,`roleDescription`) VALUES (upper('"
						+ this.getRole()
						+ "'), UPPER('"
						+ this.getRoleDescription() + "'))";
				if (!this.getRole().equals("")) {
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
	
}