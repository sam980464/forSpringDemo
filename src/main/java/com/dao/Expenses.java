package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.ExpensesBO;
import com.util.DBUtility;

public class Expenses {
	private int id;
	private int clientId;
	private int estimateId;
	private int schemeId;
	private Double qty;
	private Double unitPrice;
	private Double totalAmount;
	private String billNumber;
	private int itemId;
	private int userId;
	private String expDate;
	private int services_id;
	private int supplierId;
	private String note;
	private String fromDate;
	private String toDateExp;

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

	public String getNote() {
		return this.note;
	}

	public int getServices_id() {
		return this.services_id;
	}

	public void setServices_id(int services_id) {
		this.services_id = services_id;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getBillNumber() {
		return this.billNumber;
	}

	public void setBillNumber(String billNumber) {
		this.billNumber = billNumber;
	}

	public void setQty(double qty) {
		this.qty = qty;
	}

	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public int getSupplierId() {
		return this.supplierId;
	}

	public void setSupplierId(int supplierId) {
		this.supplierId = supplierId;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getClientId() {
		return this.clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public int getEstimateId() {
		return this.estimateId;
	}

	public void setEstimateId(int estimateId) {
		this.estimateId = estimateId;
	}

	public int getSchemeId() {
		return this.schemeId;
	}

	public void setSchemeId(int schemeId) {
		this.schemeId = schemeId;
	}

	public Double getQty() {
		return this.qty;
	}

	public void setQty(Double qty) {
		this.qty = qty;
	}

	public Double getUnitPrice() {
		return this.unitPrice;
	}

	public void setUnitPrice(Double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public Double getTotalAmount() {
		System.out.println(this.totalAmount);
		return this.totalAmount;
	}

	public void setTotalAmount(Double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public int getItemId() {
		return this.itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getExpDate() {
		return this.expDate;
	}

	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	public int getClientIdByExpensesId(int exid) {
		int client_id;
		client_id = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT  client_id   FROM `expenses` WHERE `id` = " + exid;
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
					client_id = Integer.parseInt(res.getString("client_id"));
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return client_id;
	}

	public int getEstimateIdByExpensesId(int exid) {
		int estimate_id;
		estimate_id = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT estimate_id   FROM `expenses` WHERE `id` = " + exid;
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
					estimate_id = Integer
							.parseInt(res.getString("estimate_id"));
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return estimate_id;
	}

	public int deleteExpenses() {
		int cid;
		Connection conn = null;
		Statement st = null;
		cid = 0;
		ResultSet res = null;
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
				String sql = "UPDATE `expenses` SET `status` = '0' WHERE `id` ="
						+ this.getId();
				st.executeUpdate(sql);
				cid = this.getClientIdByExpensesId(this.getId());
			} catch (SQLException s) {
				System.out.println(s);
				s.printStackTrace();
				DBUtility.closeConnection(conn, st, res);
			}
		} finally {
			DBUtility.closeConnection(conn, st, res);
		}
		return cid;
	}

	public int deleteExpensesByBill() {
		int cid;
		Connection conn = null;
		Statement st = null;
		cid = 0;
		ResultSet res = null;
		int returnVal= 0;
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
				String sql = "UPDATE `expenses` SET `status` = '0' WHERE `bill_number` ='"
						+ this.getBillNumber() + "'";
				System.out.print(sql);
				returnVal = st.executeUpdate(sql);
				cid = this.getClientIdByExpensesId(this.getId());
			} catch (SQLException s) {
				System.out.println(s);
				s.printStackTrace();
				DBUtility.closeConnection(conn, st, res);
			}
		} finally {
			DBUtility.closeConnection(conn, st, res);
		}
		return cid;
	}

	public void addData() {
		Connection con = null;
		Statement st = null;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `expenses` (`client_id`, `estimate_id`, `date`, `scheme_id`, `quantity`, `price_per_unit`, `total_amount`,`bill_number`, `item_id`,`services_id` ,`supplier_id`, `user_id`, `note`) VALUES ("
						+ this.getClientId()
						+ ", "
						+ this.getEstimateId()
						+ ",'"
						+ this.getExpDate()
						+ "',"
						+ this.getSchemeId()
						+ ", "
						+ this.getQty()
						+ ", "
						+ this.getUnitPrice()
						+ ", "
						+ this.getTotalAmount()
						+ ",'"
						+ this.getBillNumber()
						+ "', "
						+ this.getItemId()
						+ ", "
						+ this.getServices_id()
						+ ", "
						+ this.getSupplierId()
						+ ", "
						+ this.getUserId()
						+ ",'"
						+ this.getNote() + "')";
				System.out.println(sql);
				if (this.getClientId() != 0) {
					st.executeUpdate(sql);
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
	}

	public double getTotalDueByExpId(int expid) {
		double due_amount;
		due_amount = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "select id,client_id ,total_amount ,(SELECT IFNULL(sum(amount_received),0) total_received FROM  `expenses_payment` where expenses_id="
				+ expid
				+ ") total_received,"
				+ "total_amount-(SELECT IFNULL(sum(amount_received),0) total_received FROM  `expenses_payment` where expenses_id="
				+ expid + ") total_due " + "from expenses where id=" + expid;
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
					due_amount = Double.parseDouble(res.getString("total_due"));
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return due_amount;
	}

	public double getTotalOrderedByExpId(int expid) {
		double total_ordered;
		total_ordered = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT sum(total_amount) total_ordered FROM `expenses` WHERE status=1 and `estimate_id` ="
				+ expid;
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
					total_ordered = res.getDouble("total_ordered");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return total_ordered;
	}

	public double getTotalExpensesByCid(int cid) {
		double total_amount;
		total_amount = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT sum( `total_amount` ) total_amount FROM `expenses` WHERE  `status` =1 and `client_id` ="
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
					total_amount = res.getDouble("total_amount");
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

	public void updateData() {
		Connection con = null;
		Statement st = null;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE `expenses` SET `client_id` = "
						+ this.getClientId() + " ,estimate_id ="
						+ this.getEstimateId() + " , date='"
						+ this.getExpDate() + "',  quantity=" + this.getQty()
						+ " ,  price_per_unit =" + this.getUnitPrice()
						+ " ,  total_amount =" + this.getTotalAmount()
						+ ",  services_id =" + this.getServices_id()
						+ ",  supplier_id =" + this.getSupplierId() + ", "
						+ "user_id =" + this.getUserId() + ", "
						+ "bill_number ='" + this.getBillNumber() + "', "
						+ "note ='" + this.getNote() + "'  WHERE `id` ="
						+ this.getId();
				if (this.getClientId() != 0) {
					st.executeUpdate(sql);
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
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ExpensesBO> getAllItem() {
		ArrayList<ExpensesBO> expensesBOList;
		expensesBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `expenses` where status=1";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				expensesBOList = this.populateItemList(res);
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
		return expensesBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ExpensesBO> getAllItem(int eid) {
		ArrayList<ExpensesBO> expensesBOList;
		expensesBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `expenses`   where status=1 and  id="
						+ eid;
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				expensesBOList = this.populateItemList(res);
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
		return expensesBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ExpensesBO> getAllItemByEstimateid(int eid) {
		ArrayList<ExpensesBO> expensesBOList;
		expensesBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `expenses`   where status=1 and   estimate_id ="
						+ eid;
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				expensesBOList = this.populateItemList(res);
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
		return expensesBOList;
	}

	public int getMaxId() {
		int max;
		max = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT max(id) max FROM `expenses`";
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
	public ArrayList<ExpensesBO> getAllItemByCid(int cid) {
		ArrayList<ExpensesBO> expensesBOList;
		expensesBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT id,bill_number,date,estimate_id,total_amount,client_id,scheme_id,supplier_id  FROM  `expenses` where client_id="
						+ cid
						+ " and status=1  ORDER by id DESC";
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				expensesBOList = this.populateItemListByBill(res);
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
		return expensesBOList;
	}

	private ArrayList<ExpensesBO> populateItemListByBill(ResultSet res) {
		ArrayList<ExpensesBO> expensesList = null;
		ExpensesBO expensesBO = null;
		if (res != null) {
			expensesList = new ArrayList<ExpensesBO>();
			try {
				while (res.next()) {
					expensesBO = new ExpensesBO();
					expensesBO.setId(res.getInt("id"));
					expensesBO.setClientId(res.getInt("client_id"));
					expensesBO.setEstimateId(res.getInt("estimate_id"));
					expensesBO.setSchemeId(res.getInt("scheme_id"));
					expensesBO.setTotalAmount(Double.valueOf(res
							.getDouble("total_amount")));
					expensesBO.setExpDate(res.getString("date"));
					expensesBO.setBillNumber(res.getString("bill_number"));
					expensesBO.setSupplierId(res.getInt("supplier_id"));
					expensesList.add(expensesBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return expensesList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ExpensesBO> getAllItemBySupplierId(int supplier_id) {
		ArrayList<ExpensesBO> expensesBOList;
		expensesBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `expenses` where  supplier_id ="
						+ supplier_id;
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				expensesBOList = this.populateItemList(res);
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
		return expensesBOList;
	}

	public double getTotalAmountByExID(int id) {
		double total_amount;
		total_amount = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT  total_amount  FROM `expenses` where id= " + id;
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
					total_amount = res.getDouble("total_amount");
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

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ExpensesBO> getAllItemForBill() {
		ArrayList<ExpensesBO> expensesBOList;
		expensesBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM `expenses` WHERE `client_id` ="
						+ this.getClientId() + " AND `bill_number` = '"
						+ this.getBillNumber() + "' AND `supplier_id` ="
						+ this.getSupplierId() + " AND status=1";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				expensesBOList = this.populateItemList(res);
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
		return expensesBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ExpensesBO> getAllItemBetweenDate() {
		ArrayList<ExpensesBO> expensesBOList;
		expensesBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM `expenses` WHERE `date` BETWEEN '"
						+ this.getFromDate() + "' AND '" + this.getToDateExp()
						+ "'  group by supplier_id";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				expensesBOList = this.populateItemList(res);
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
		return expensesBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ExpensesBO> getAllItemByEid(int eid) {
		ArrayList<ExpensesBO> expensesBOList;
		expensesBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `expenses` where estimate_id="
						+ eid + " and status=1";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				expensesBOList = this.populateItemList(res);
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
		return expensesBOList;
	}

	private ArrayList<ExpensesBO> populateItemList(ResultSet res) {
		ArrayList<ExpensesBO> expensesList = null;
		ExpensesBO expensesBO = null;
		if (res != null) {
			expensesList = new ArrayList<ExpensesBO>();
			try {
				while (res.next()) {
					expensesBO = new ExpensesBO();
					expensesBO.setId(res.getInt("id"));
					expensesBO.setClientId(res.getInt("client_id"));
					expensesBO.setEstimateId(res.getInt("estimate_id"));
					expensesBO.setSchemeId(res.getInt("scheme_id"));
					expensesBO
							.setQty(Double.valueOf(res.getDouble("quantity")));
					expensesBO.setUnitPrice(Double.valueOf(res
							.getDouble("price_per_unit")));
					expensesBO.setTotalAmount(Double.valueOf(res
							.getDouble("total_amount")));
					expensesBO.setItemId(res.getInt("item_id"));
					expensesBO.setExpDate(res.getString("date"));
					expensesBO.setNote(res.getString("note"));
					expensesBO.setBillNumber(res.getString("bill_number"));
					expensesBO.setServices_id(res.getInt("services_id"));
					expensesBO.setSupplierId(res.getInt("supplier_id"));
					expensesBO.setUserId(res.getInt("user_id"));
					expensesList.add(expensesBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return expensesList;
	}
}