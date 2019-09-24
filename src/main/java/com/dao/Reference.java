package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.ReferenceBO;
import com.util.DBUtility;

public class Reference {
	int id;
	String name;
	String address;

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

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int addData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `refarence` (`name` ,`address`) VALUES ('"
						+ this.getName() + "', '" + this.getAddress() + "')";
				System.out.println(sql);
				if (!this.getName().equals("")) {
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

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ReferenceBO> getAllItem() {
		ArrayList<ReferenceBO> refarenceBOList;
		refarenceBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `refarence` where status=1";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				refarenceBOList = this.populateItemList(res);
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
		return refarenceBOList;
	}

	private ArrayList<ReferenceBO> populateItemList(ResultSet res) {
		ArrayList<ReferenceBO> refarenceList = null;
		ReferenceBO refarenceBO = null;
		if (res != null) {
			refarenceList = new ArrayList<ReferenceBO>();
			try {
				while (res.next()) {
					refarenceBO = new ReferenceBO();
					refarenceBO.setId(res.getInt("id"));
					refarenceBO.setName(res.getString("name"));
					refarenceBO.setAddress(res.getString("address"));
					refarenceList.add(refarenceBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return refarenceList;
	}
}