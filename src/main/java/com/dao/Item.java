package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.ItemBO;
import com.util.DBUtility;

public class Item {
	int id;
	String Name;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return this.Name;
	}

	public void setName(String name) {
		this.Name = name;
	}

	public String getItemNameById(int id) {
		String item_name;
		item_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT item_name FROM `item` WHERE ID=" + id;
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
					item_name = res.getString("item_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return item_name;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ItemBO> getAllItem() {
		ArrayList<ItemBO> itemBOList;
		itemBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `item`";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				itemBOList = this.populateItemList(res);
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
		return itemBOList;
	}

	private ArrayList<ItemBO> populateItemList(ResultSet res) {
		ArrayList<ItemBO> itemList = null;
		ItemBO itemBO = null;
		if (res != null) {
			itemList = new ArrayList<ItemBO>();
			try {
				while (res.next()) {
					itemBO = new ItemBO();
					itemBO.setId(res.getInt("id"));
					itemBO.setName(res.getString("item_name"));
					itemList.add(itemBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return itemList;
	}
}