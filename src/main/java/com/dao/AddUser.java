package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.OfficeExpensesBO;
import com.bo.UserDataBO;
import com.util.DBUtility;

public class AddUser {
	private int id;
	private String userid;
	private String password;
	private String name;
	private String email;
	private int role;
	private int status;
	private String mobileNo;
	private String address;	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int addData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		if(!checkUserIdExist(this.getUserid())){
			try {
				try {
					con = DBUtility.getConnection();
					st = con.createStatement();
					String sql = "INSERT INTO `user` (`userid`, `password`,`name`, `email`, `role`,`mobileNo`, `address`) VALUES ('"
							+ this.getUserid()
							+ "', '"
							+ this.getPassword()
							+ "','"
							+ this.getName()
							+ "','"
							+ this.getEmail()
							+ "', "
							+ this.getRole()
							+ ",'"
							+ this.getMobileNo()
							+ "', '"
							+ this.getAddress()
							+ "')";
					System.out.println("Query:::::::::"+sql);
					returnVal =st.executeUpdate(sql);
					st = null;
				} catch (Exception e) {
					System.out.println(e);
					e.printStackTrace();
					DBUtility.closeConnection(con, st, (ResultSet) null);
				}
			} finally {
				DBUtility.closeConnection(con, st, (ResultSet) null);
			}
		 } else {
			returnVal = 99;
		}
		return returnVal;
	}
	
	public int addRolePermission(int roleId,String[] permissions) {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		deleteRolePermission(roleId);
		for(int i=0;i<permissions.length;i++) {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `rolepermissions` (`roleId`, `permission`) VALUES ("
						+ roleId
						+ ", '"
						+ permissions[i]						
						+ "')";
				System.out.println("Query:::::::::"+sql);
				returnVal =st.executeUpdate(sql);
				st = null;
			} catch (Exception e) {
				System.out.println(e);
				e.printStackTrace();
				DBUtility.closeConnection(con, st, (ResultSet) null);
			}
			finally {
				DBUtility.closeConnection(con, st, (ResultSet) null);
			}			
		} 
		return returnVal;
	}
	
	public int deleteRolePermission(int roleId) {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "delete from `rolepermissions` where roleId="
						+ roleId;
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

	public int updateData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		
			try {
				try {
					con = DBUtility.getConnection();
					st = con.createStatement();
					String sql = "UPDATE `user` SET  `password` =  '"
							+ this.getPassword()
							+ "',"
							+ "`name` =  '"
							+ this.getName()
							+ "',"
							+ "`email` =  '"
							+ this.getEmail()
							+ "',"
							+ "`role` =  "
							+ this.getRole()
							+ ","
							+ "`mobileNo` =  '"
							+ this.getMobileNo()
							+ "', "
							+ "`address` =  '"
							+ this.getAddress()
							+ "'"
							+ " WHERE `id` ="
							+ this.getId();
					System.out.println("Query::::::::::::::");
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

	public int deleteUser() {
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
				String sql = "UPDATE `user` SET `status` = '0' WHERE `id` ="
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
	public ArrayList<UserDataBO> getUserDetailsById() {
		ArrayList<UserDataBO> userBOList;
		userBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `user` where id="
						+ this.getId();
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				userBOList = this.populateItemList(res);
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
		return userBOList;
	}
	
	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public boolean checkUserIdExist(String userId) {
		boolean result = false;
		
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `user` where userid='"
						+ userId + "' and status=1";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				result = res.next();
				
			} catch (SQLException s) {
				s.printStackTrace();
				DBUtility.closeConnection(con, st, res);
				
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
		return result;
	}
	
	
	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<UserDataBO> getAllUserDetails() {
		ArrayList<UserDataBO> userBOList;
		userBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `user` where status=1 ";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				userBOList = this.populateItemList(res);
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
		return userBOList;
	}

	
	private ArrayList<UserDataBO> populateItemList(ResultSet res) {
		ArrayList<UserDataBO> userDataBOList = null;
		UserDataBO userDataBO = null;
		if (res != null) {
			userDataBOList = new ArrayList<UserDataBO>();
			try {
				while (res.next()) {
					userDataBO = new UserDataBO();
					userDataBO.setId(res.getInt("id"));
					userDataBO.setUserid(res
							.getString("userid"));
					userDataBO.setPassword(res
							.getString("password"));
					userDataBO.setName(res.getString("name"));
					userDataBO.setEmail(res.getString("email"));
					userDataBO.setRole(res.getInt("role"));
					userDataBO
							.setMobileNo(res.getString("mobileNo"));
					userDataBO
					.setAddress(res.getString("address"));
					userDataBOList.add(userDataBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return userDataBOList;
	}
}