package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.OfficeExpensesBO;
import com.util.DBUtility;

public class OfficeExpenses {
	private int id;
	private int ExpensesName;
	private String ExpensesNameTxt;
	private String BankName;
	private String ExpensesDesc;
	private String DateTime;
	private double amount;
	private String ChequeNo;
	private int BankId;
	private int UserId;
	private int status;
	private String fromDate;
	private String toDateExp;

	public String getBankName() {
		return this.BankName;
	}

	public void setBankName(String bankName) {
		this.BankName = bankName;
	}

	public String getFromDate() {
		return this.fromDate;
	}

	public String getExpensesNameTxt() {
		return this.ExpensesNameTxt;
	}

	public void setExpensesNameTxt(String expensesNameTxt) {
		this.ExpensesNameTxt = expensesNameTxt;
	}

	public void setToDateExp(String toDateExp) {
		this.toDateExp = toDateExp;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getToDateExp() {
		return this.toDateExp;
	}

	public void setToDate(String toDate) {
		this.toDateExp = toDate;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return this.UserId;
	}

	public void setUserId(int userId) {
		this.UserId = userId;
	}

	public int getExpensesName() {
		return this.ExpensesName;
	}

	public void setExpensesName(int i) {
		this.ExpensesName = i;
	}

	public String getExpensesDesc() {
		return this.ExpensesDesc;
	}

	public void setExpensesDesc(String expensesDesc) {
		expensesDesc = expensesDesc.replace("'", " ");
		expensesDesc = expensesDesc.replace("@", " at ");
		expensesDesc = expensesDesc.replace("\\n", " ");
		expensesDesc = expensesDesc.replace(" ", "_");
		this.ExpensesDesc = expensesDesc = expensesDesc.replaceAll("(\r\n|\n)",
				"<br />");
	}

	public String getDateTime() {
		return this.DateTime;
	}

	public void setDateTime(String dateTime) {
		this.DateTime = dateTime;
	}

	public double getAmount() {
		return this.amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getChequeNo() {
		return this.ChequeNo;
	}

	public void setChequeNo(String chequeNo) {
		this.ChequeNo = chequeNo;
	}

	public int getBankId() {
		return this.BankId;
	}

	public void setBankId(int bankId) {
		this.BankId = bankId;
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
				String sql = "INSERT INTO `office_expenses` (`expenses_name`, `expenses_desc`,`date_time`, `amount`, `cheque_number`,`user_id`, `bank_id`) VALUES ("
						+ this.getExpensesName()
						+ ", '"
						+ this.getExpensesDesc()
						+ "','"
						+ this.getDateTime()
						+ "',"
						+ this.getAmount()
						+ ", '"
						+ this.getChequeNo()
						+ "',"
						+ this.getUserId()
						+ ", "
						+ this.getBankId()
						+ ")";
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
				String sql = "UPDATE `office_expenses` SET  `expenses_name` =  "
						+ this.getExpensesName()
						+ ","
						+ "`expenses_desc` =  '"
						+ this.getExpensesDesc()
						+ "',"
						+ "`amount` =  "
						+ this.getAmount()
						+ ","
						+ "`cheque_number` =  '"
						+ this.getChequeNo()
						+ "',"
						+ "`date_time` =  '"
						+ this.getDateTime()
						+ "',"
						+ "`bank_id` =  "
						+ this.getBankId()
						+ " "
						+ "WHERE `id` ="
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

	public void deleteOfficeExpenses() {
		Connection conn = null;
		Statement st = null;
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
				String sql = "UPDATE `office_expenses` SET `status` = '0' WHERE `id` ="
						+ this.getId();
				st.executeUpdate(sql);
			} catch (SQLException s) {
				System.out.println(s);
				s.printStackTrace();
				DBUtility.closeConnection(conn, st, res);
			}
		} finally {
			DBUtility.closeConnection(conn, st, res);
		}
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<OfficeExpensesBO> getAllItemByDate() {
		ArrayList<OfficeExpensesBO> officeExpensesBOList;
		officeExpensesBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM `office_expenses` where status=1 and date_time between '"
						+ this.getFromDate()
						+ "' and '"
						+ this.toDateExp
						+ "' ";
				if (this.getExpensesName() >= 1) {
					sql = String.valueOf(sql) + " and expenses_name="
							+ this.getExpensesName();
				}
				sql = String.valueOf(sql) + " order by date_time desc ";
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				officeExpensesBOList = this.populateItemList(res);
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
		return officeExpensesBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<OfficeExpensesBO> getAllItemLimited(int limited) {
		ArrayList<OfficeExpensesBO> officeExpensesBOList;
		officeExpensesBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM `office_expenses` where status=1 order by date_time DESC LIMIT 0 , "
						+ limited;
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				officeExpensesBOList = this.populateItemList(res);
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
		return officeExpensesBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<OfficeExpensesBO> getAllItembyId() {
		ArrayList<OfficeExpensesBO> officeExpensesBOList;
		officeExpensesBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `office_expenses` where id="
						+ this.getId();
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				officeExpensesBOList = this.populateItemList(res);
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
		return officeExpensesBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<OfficeExpensesBO> getAllItemForCsv() {
		ArrayList<OfficeExpensesBO> officeExpensesBOList;
		officeExpensesBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "";
				sql = this.getExpensesName() != 0 ? "select id,(select expenses_name from office_expenses_item where id=office_expenses.expenses_name) expenses_name,expenses_desc,DATE_FORMAT(date_time,'%d/%m/%Y') date_time,amount,cheque_number,(select bank_name from bank where id=office_expenses.bank_id) bank from office_expenses where status=1  and date_time between '"
						+ this.getFromDate()
						+ "' and '"
						+ this.toDateExp
						+ "' and expenses_name="
						+ this.getExpensesName()
						+ " order by date_time desc"
						: "select id,(select expenses_name from office_expenses_item where id=office_expenses.expenses_name) expenses_name,expenses_desc,DATE_FORMAT(date_time,'%d/%m/%Y') date_time,amount,cheque_number,(select bank_name from bank where id=office_expenses.bank_id) bank from office_expenses where status=1  and date_time between '"
								+ this.getFromDate()
								+ "' and '"
								+ this.toDateExp + "' order by date_time desc";
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				officeExpensesBOList = this.prepareStatementForCsv(res);
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
		return officeExpensesBOList;
	}

	private ArrayList<OfficeExpensesBO> prepareStatementForCsv(ResultSet res) {
		ArrayList<OfficeExpensesBO> officeExpensesList = null;
		OfficeExpensesBO officeExpensesBO = null;
		if (res != null) {
			officeExpensesList = new ArrayList<OfficeExpensesBO>();
			try {
				while (res.next()) {
					officeExpensesBO = new OfficeExpensesBO();
					officeExpensesBO.setId(res.getInt("id"));
					officeExpensesBO.setExpensesNameTxt(res
							.getString("expenses_name"));
					officeExpensesBO.setExpensesDesc(res
							.getString("expenses_desc"));
					officeExpensesBO.setDateTime(res.getString("date_time"));
					officeExpensesBO.setAmount(res.getDouble("amount"));
					officeExpensesBO.setBankName(res.getString("bank"));
					officeExpensesBO
							.setChequeNo(res.getString("cheque_number"));
					officeExpensesList.add(officeExpensesBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return officeExpensesList;
	}

	private ArrayList<OfficeExpensesBO> populateItemList(ResultSet res) {
		ArrayList<OfficeExpensesBO> officeExpensesList = null;
		OfficeExpensesBO officeExpensesBO = null;
		if (res != null) {
			officeExpensesList = new ArrayList<OfficeExpensesBO>();
			try {
				while (res.next()) {
					officeExpensesBO = new OfficeExpensesBO();
					officeExpensesBO.setId(res.getInt("id"));
					officeExpensesBO.setExpensesName(res
							.getInt("expenses_name"));
					officeExpensesBO.setExpensesDesc(res
							.getString("expenses_desc"));
					officeExpensesBO.setDateTime(res.getString("date_time"));
					officeExpensesBO.setAmount(res.getDouble("amount"));
					officeExpensesBO.setBankId(res.getInt("bank_id"));
					officeExpensesBO
							.setChequeNo(res.getString("cheque_number"));
					officeExpensesList.add(officeExpensesBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return officeExpensesList;
	}
}