package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.OfficeExpensesItemBO;
import com.util.DBUtility;

public class OfficeExpensesItem {
	private int id;
	private String ItemName;
	private int status;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getItemName() {
		return this.ItemName;
	}

	public void setItemName(String itemName) {
		this.ItemName = itemName;
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
				String sql = "INSERT INTO `office_expenses_item` (`expenses_name`) VALUES (UPPER('"
						+ this.getItemName() + "'))";
				if (!this.getItemName().equals("")) {
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

	public int updateData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "update  office_expenses_item set expenses_name=upper('"
						+ this.getItemName()
						+ "') where `id` = "
						+ this.getId();
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

	public int deleteData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "update  office_expenses_item set status=0 where `id` = "
						+ this.getId();
				st.executeUpdate(sql);
				sql = "update  office_expenses set status=0 where `expenses_name` = "
						+ this.getId();
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

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<OfficeExpensesItemBO> getAllItem() {
		ArrayList<OfficeExpensesItemBO> officeExpensesItemBOList;
		officeExpensesItemBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `office_expenses_item` where status=1  ORDER by expenses_name";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				officeExpensesItemBOList = this.populateItemList(res);
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
		return officeExpensesItemBOList;
	}

	private ArrayList<OfficeExpensesItemBO> populateItemList(ResultSet res) {
		ArrayList<OfficeExpensesItemBO> officeExpensesItemList = null;
		OfficeExpensesItemBO officeExpensesItemBO = null;
		if (res != null) {
			officeExpensesItemList = new ArrayList<OfficeExpensesItemBO>();
			try {
				while (res.next()) {
					officeExpensesItemBO = new OfficeExpensesItemBO();
					officeExpensesItemBO.setId(res.getInt("id"));
					officeExpensesItemBO.setItemName(res
							.getString("expenses_name"));
					officeExpensesItemBO.setStatus(res.getInt("status"));
					officeExpensesItemList.add(officeExpensesItemBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return officeExpensesItemList;
	}

	public String getItemNameById(int id) {
		String expenses_name;
		expenses_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT expenses_name FROM `office_expenses_item` WHERE id=" + id
				+ " ORDER by expenses_name ";
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
					expenses_name = res.getString("expenses_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return expenses_name;
	}
}