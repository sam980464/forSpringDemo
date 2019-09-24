/*
 * Decompiled with CFR 0_122.
 * 
 * Could not load the following classes:
 *  com.bo.SupplierBO
 *  com.dao.Bank
 *  com.project.bean.Project
 *  com.project.bean.ProjectSupplierPaymentBean
 *  com.util.DBUtility
 */
package com.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.SupplierBO;
import com.dao.Bank;
import com.project.bean.Project;
import com.project.bean.ProjectSupplierPaymentBean;
import com.util.DBUtility;

public class ProjectDAO {
	static Connection con = null;

	public int getMaxRow(String column, String table) {
		int max;
		max = 0;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT max(" + column + ") max FROM `" + table + "` ";
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

	public int addProject(Project project) {
		int status = 0;
		try {
			con = DBUtility.getConnection();
			String sql = "insert into project_master(project_name,project_location,project_details,client_name,project_no_floor,project_no_unit,project_date,word_no,municipality,gar_rel,gar_name,project_type,Email1,Email2,Contact1,Contact2) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
			PreparedStatement prep = con.prepareStatement(sql);
			prep.setString(1, project.getPro_name());
			prep.setString(2, project.getSite_addr());
			prep.setString(3, project.getSite_details());
			prep.setString(4, project.getC_name());
			prep.setString(5, project.getSite_no_floors());
			prep.setString(6, project.getSite_no_units());
			prep.setString(7, project.getDate());
			prep.setString(8, project.getWord_no());
			prep.setString(9, project.getMunicipality());
			prep.setString(10, project.getGar_rel());
			prep.setString(11, project.getGar_name());
			prep.setString(12, project.getPro_typ());
			prep.setString(13, project.getEmail1());
			prep.setString(14, project.getEmail2());
			prep.setString(15, project.getContact1());
			prep.setString(16, project.getContact2());
			status = prep.executeUpdate();
			System.out.println(status);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public int updateProjectDetails(Project project) {
		int status = 0;
		try {
			con = DBUtility.getConnection();
			String sql = "update project_master set project_name='"
					+ project.getPro_name() + "',project_location='"
					+ project.getSite_addr() + "',project_details='"
					+ project.getSite_details() + "',client_name='"
					+ project.getC_name() + "',project_no_floor='"
					+ project.getSite_no_floors() + "',project_no_unit='"
					+ project.getSite_no_units() + "',project_date='"
					+ project.getDate() + "',word_no='" + project.getWord_no()
					+ "',municipality='" + project.getMunicipality()
					+ "',gar_rel='" + project.getGar_rel() + "',gar_name='"
					+ project.getGar_name() + "',project_type='"
					+ project.getPro_typ() + "',Contact1='"
					+ project.getContact1() + "',Contact2='"
					+ project.getContact2() + "',Email1='"
					+ project.getEmail1() + "',Email2='" + project.getEmail2()
					+ "' where project_id='" + project.getId() + "' ";
			PreparedStatement prep = con.prepareStatement(sql);
			System.out.println(sql);
			status = prep.executeUpdate(sql);
			System.out.println(status);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<Project> getProjectName() {
		ArrayList<Project> projectDaoList;
		projectDaoList = new ArrayList<Project>();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "select * from project_master";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				while (res.next()) {
					Project pdao = new Project();
					pdao.setId(res.getString("project_id"));
					pdao.setPro_name(res.getString("project_name"));
					pdao.setSite_addr(res.getString("project_location"));
					pdao.setC_name(res.getString("client_name"));
					pdao.setMunicipality(res.getString("municipality"));
					pdao.setWord_no(res.getString("word_no"));
					pdao.setGar_name(res.getString("gar_name"));
					pdao.setGar_rel(res.getString("gar_rel"));
					projectDaoList.add(pdao);
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
		return projectDaoList;
	}

	public ArrayList<Project> getAllProjectReport() throws Exception {
		ProjectDAO pdao = new ProjectDAO();
		ArrayList<Project> projectsumlist = new ArrayList<Project>();
		ArrayList<Project> plist = pdao.getProjectName();
		con = DBUtility.getConnection();
		int i = 0;
		while (i < plist.size()) {
			Project project = new Project();
			project.setId(plist.get(i).getId());
			project.setPro_name(plist.get(i).getPro_name());
			project.setSite_addr(plist.get(i).getSite_addr());
			project.setInvestment_sum(ProjectDAO.getSum("invested_amount",
					"project_investment", plist.get(i).getId(), con));
			project.setRefund_sum(ProjectDAO.getSum("refunded_amount",
					"project_investor_refund", plist.get(i).getId(), con));
			project.setExpensed_sum(ProjectDAO.getSum("expense_amount",
					"project_expense", plist.get(i).getId(), con));
			project.setBuyer_payment_sum(ProjectDAO.getSum("payment_amount",
					"project_buyer_payment", plist.get(i).getId(), con));
			projectsumlist.add(project);
			++i;
		}
		con.close();
		return projectsumlist;
	}

	public Project getProjectFundAmount(String proid) throws Exception {
		con = DBUtility.getConnection();
		Project project = new Project();
		project.setInvestment_sum(ProjectDAO.getSum("invested_amount",
				"project_investment", proid, con));
		project.setBuyer_payment_sum(ProjectDAO.getSum("payment_amount",
				"project_buyer_payment", proid, con));
		project.setExpensed_sum("0");
		project.setRefund_sum(ProjectDAO.getSum("refunded_amount",
				"project_investor_refund", proid, con));
		return project;
	}

	public static String getSum(String cols, String table, String proid,
			Connection con) throws SQLException {
		String sum;
		sum = null;
		Statement prep = null;
		ResultSet rs = null;
		try {
			try {
				String sql = "select sum(" + cols + ") as " + cols + " from "
						+ table + " where project_id='" + proid + "';";
				prep = con.prepareStatement(sql);
				rs = prep.executeQuery(sql);
				try {
					if (rs.next() && (sum = rs.getString(cols)) == null) {
						sum = "0";
					}
				} catch (NullPointerException e) {
					sum = "0";
				}
			} catch (Exception e) {
				sum = "0";
				prep.close();
				rs.close();
			}
		} finally {
			prep.close();
			rs.close();
		}
		return sum;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public String getInvestorName(String id) {
		String name;
		name = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "select * from project_investor_master where investor_id='"
						+ id + "'";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				if (res.next()) {
					name = res.getString("investor_name");
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
		return name;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public Project getProjectDetails(String id) {
		Project pro;
		Object name = null;
		PreparedStatement st = null;
		ResultSet res = null;
		pro = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "select * from project_master where project_id='"
						+ id + "'";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				if (res.next()) {
					pro = new Project();
					pro.setPro_name(res.getString("project_name"));
					pro.setSite_addr(res.getString("project_location"));
					pro.setC_name(res.getString("client_name"));
					pro.setDate(res.getString("project_date"));
					pro.setSite_details(res.getString("project_details"));
					pro.setSite_no_floors(res.getString("project_no_floor"));
					pro.setSite_no_units(res.getString("project_no_unit"));
					pro.setGar_name(res.getString("gar_name"));
					pro.setGar_rel(res.getString("gar_rel"));
					pro.setMunicipality(res.getString("municipality"));
					pro.setWord_no(res.getString("word_no"));
					pro.setPro_typ(res.getString("project_type"));
					pro.setContact1(res.getString("Contact1"));
					pro.setContact2(res.getString("Contact2"));
					pro.setEmail1(res.getString("Email1"));
					pro.setEmail2(res.getString("Email2"));
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
		return pro;
	}

	public ArrayList<ArrayList<String>> getInvestmentList(String proid) {
		ArrayList<ArrayList<String>> investmentdetails = new ArrayList<ArrayList<String>>();
		try {
			con = DBUtility.getConnection();
			String sql = "select *,sum(project_investment.invested_amount) as total_invested_amount,sum(project_investment.promised_refund_amount) as total_promised_refund_amount from (select *,sum(refunded_amount) as total_refunded from project_investor_refund where investor_id=any (select investor_id from project_investment where project_id='"
					+ proid
					+ "') and  project_investor_refund.project_id='"
					+ proid
					+ "' group by investor_id) as table1 "
					+ "\tinner join project_investor_master on project_investor_master.investor_id=table1.investor_id"
					+ "\tinner join project_investment on project_investment.investor_id=table1.investor_id where project_investment.project_id='"
					+ proid + "' group by table1.refund_id";
			System.out.println(sql);
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery(sql);
			while (rs.next()) {
				ArrayList<String> list = new ArrayList<String>();
				list.add(rs.getString("investor_id"));
				list.add(rs.getString("investor_name"));
				list.add(rs.getString("total_invested_amount"));
				list.add(rs.getString("total_refunded"));
				list.add(rs.getString("total_promised_refund_amount"));
				list.add(rs.getString("invested_date"));
				investmentdetails.add(list);
			}
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return investmentdetails;
	}

	public ArrayList<ArrayList<String>> getInvestmentBreakUp(String invid,
			String proid) {
		ArrayList<ArrayList<String>> investmentdetails = new ArrayList<ArrayList<String>>();
		try {
			con = DBUtility.getConnection();
			String sql = "select * from project_investment where project_id='"
					+ proid + "' and investor_id='" + invid
					+ "' order by investment_id";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery(sql);
			while (rs.next()) {
				ArrayList<String> list = new ArrayList<String>();
				list.add(rs.getString("investment_id"));
				list.add(rs.getString("invested_amount"));
				list.add(rs.getString("promised_refund_amount"));
				list.add(rs.getString("invested_date"));
				list.add(rs.getString("payment_method"));
				list.add(rs.getString("cheque_no"));
				list.add(rs.getString("bank_id"));
				investmentdetails.add(list);
			}
			System.out.println("sql :" + sql);
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return investmentdetails;
	}

	public ArrayList<ArrayList<String>> getRefundBreakUp(String proid) {
		ArrayList<ArrayList<String>> investmentdetails = new ArrayList<ArrayList<String>>();
		try {
			con = DBUtility.getConnection();
			String sql = "select * from (select * from project_investor_refund where project_id='"
					+ proid
					+ "') as table1 "
					+ " inner join project_investment on project_investment.investor_id=table1.investor_id "
					+ " inner join project_investor_master on project_investor_master.investor_id=table1.investor_id group by table1.refund_id order by investment_id";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery(sql);
			while (rs.next()) {
				ArrayList<String> list = new ArrayList<String>();
				list.add(rs.getString("refund_id"));
				list.add(rs.getString("investment_id"));
				list.add(rs.getString("investor_name"));
				list.add(rs.getString("refunded_amount"));
				list.add(rs.getString("invested_amount"));
				list.add(rs.getString("invested_date"));
				list.add(rs.getString("promised_refund_amount"));
				list.add(rs.getString("payment_method"));
				list.add(rs.getString("cheque_no"));
				list.add(rs.getString("bank_id"));
				investmentdetails.add(list);
			}
			System.out.println("sql :" + sql);
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return investmentdetails;
	}

	public ArrayList<ArrayList<String>> getMisIList(String proid) {
		ArrayList<ArrayList<String>> investmentdetails = new ArrayList<ArrayList<String>>();
		try {
			con = DBUtility.getConnection();
			String sql = "select * from (select * from misincome where project_id='"
					+ proid
					+ "') as table1 "
					+ "inner join promis on promis.id=table1.promis WHERE status=1";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery(sql);
			while (rs.next()) {
				ArrayList<String> list = new ArrayList<String>();
				list.add(rs.getString("promisName"));
				list.add(rs.getString("amount"));
				list.add(rs.getString("payment_method"));
				list.add(rs.getString("cheque_no"));
				list.add(rs.getString("bank_id"));
				list.add(rs.getString("date"));
				list.add(rs.getString("prom_eid"));
				list.add(rs.getString("promis"));
				investmentdetails.add(list);
			}
			System.out.println("sql :" + sql);
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return investmentdetails;
	}

	public ArrayList<ArrayList<String>> getMisEList(String proid) {
		ArrayList<ArrayList<String>> investmentdetails = new ArrayList<ArrayList<String>>();
		try {
			con = DBUtility.getConnection();
			String sql = "select * from (select * from misexpense where project_id='"
					+ proid
					+ "') as table1 "
					+ "inner join promis on promis.id=table1.promis WHERE status=1";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery(sql);
			while (rs.next()) {
				ArrayList<String> list = new ArrayList<String>();
				list.add(rs.getString("promisName"));
				list.add(rs.getString("amount"));
				list.add(rs.getString("payment_method"));
				list.add(rs.getString("cheque_no"));
				list.add(rs.getString("bank_id"));
				list.add(rs.getString("date"));
				list.add(rs.getString("misiid"));
				list.add(rs.getString("promis"));
				investmentdetails.add(list);
			}
			System.out.println("sql :" + sql);
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return investmentdetails;
	}

	public ArrayList<ArrayList<String>> getExpensePaymentList(String proid) {
		ArrayList<ArrayList<String>> investmentdetails = new ArrayList<ArrayList<String>>();
		try {
			con = DBUtility.getConnection();
			String sql = " select * from (select *,sum(paid_amount) as total_payment from project_supplier_payment where expense_id=any (select expense_id from project_expense where project_id='"
					+ proid
					+ "') GROUP BY expense_id) as table1 "
					+ " inner join supplier on supplier.id=table1.supplier_id "
					+ " inner join project_expense on project_expense.expense_id=table1.expense_id ORDER by P_id DESC";
			PreparedStatement prep = con.prepareStatement(sql);
			System.out.println(sql);
			ResultSet rs = prep.executeQuery(sql);
			while (rs.next()) {
				ArrayList<String> list = new ArrayList<String>();
				list.add(rs.getString("bill_no"));
				list.add(rs.getString("expense_id"));
				list.add(rs.getString("company_name"));
				list.add(rs.getString("expense_amount"));
				list.add(rs.getString("total_payment"));
				list.add(rs.getString("expense_date"));
				list.add(rs.getString("p_id"));
				list.add(rs.getString("supplier_id"));
				list.add(rs.getString("expense_details"));
				list.add(rs.getString("unit"));
				list.add(rs.getString("quan"));
				list.add(rs.getString("service_id"));
				investmentdetails.add(list);
			}
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return investmentdetails;
	}

	public ArrayList<ArrayList<String>> getExpensePaymentList(String proid,
			String supid) {
		ArrayList<ArrayList<String>> investmentdetails = new ArrayList<ArrayList<String>>();
		try {
			con = DBUtility.getConnection();
			String sql = " select * from (select *,sum(paid_amount) as total_payment from project_supplier_payment where expense_id=any (select expense_id from project_expense where project_id='"
					+ proid
					+ "' and supplier_id='"
					+ supid
					+ "') GROUP BY expense_id) as table1 "
					+ " inner join supplier on supplier.id=table1.supplier_id "
					+ " inner join project_expense on project_expense.expense_id=table1.expense_id ";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery(sql);
			while (rs.next()) {
				ArrayList<String> list = new ArrayList<String>();
				list.add(rs.getString("bill_no"));
				list.add(rs.getString("expense_id"));
				list.add(rs.getString("company_name"));
				list.add(rs.getString("expense_amount"));
				list.add(rs.getString("total_payment"));
				list.add(rs.getString("expense_date"));
				list.add(rs.getString("p_id"));
				list.add(rs.getString("supplier_id"));
				list.add(rs.getString("expense_details"));
				investmentdetails.add(list);
			}
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return investmentdetails;
	}

	public ArrayList<ArrayList<String>> getExpenseListByBillNo(String proid,
			String supid, String billno) {
		ArrayList<ArrayList<String>> investmentdetails = new ArrayList<ArrayList<String>>();
		try {
			con = DBUtility.getConnection();
			String sql = " select * from (select *,sum(paid_amount) as total_payment from project_supplier_payment where expense_id=any (select expense_id from project_expense where project_id='"
					+ proid
					+ "' and bill_no='"
					+ billno
					+ "') GROUP BY expense_id) as table1 "
					+ " inner join supplier on supplier.id=table1.supplier_id "
					+ " inner join project_expense on project_expense.expense_id=table1.expense_id ";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery(sql);
			while (rs.next()) {
				ArrayList<String> list = new ArrayList<String>();
				list.add(rs.getString("expense_date"));
				list.add(rs.getString("expense_id"));
				list.add(rs.getString("expense_amount"));
				list.add(rs.getString("total_payment"));
				list.add(rs.getString("p_id"));
				investmentdetails.add(list);
			}
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return investmentdetails;
	}

	public int updateInvestment(String invId, String invAmount,
			String proAmount, String proid, String date, String note,
			String pm, String no, String banklst) {
		int status = 0;
		try {
			con = DBUtility.getConnection();
			String sql = "update project_investment set invested_amount='"
					+ invAmount + "',promised_refund_amount='" + proAmount
					+ "',invested_date='" + date + "',note='" + note
					+ "',payment_method='" + pm + "',cheque_no='" + no
					+ "',bank_id='" + banklst + "' where investment_id='"
					+ invId + "'";
			PreparedStatement prep = con.prepareStatement(sql);
			status = prep.executeUpdate();
			System.out.println(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public int appendInvestment(String invId, String invAmount,
			String proAmount, String proid, String date, String pm, String no,
			String banklst) {
		int status = 0;
		try {
			con = DBUtility.getConnection();
			String sql = "insert into project_investment(invested_amount,promised_refund_amount,invested_date,investor_id,project_id,payment_method,cheque_no,bank_id) values('"
					+ invAmount
					+ "','"
					+ proAmount
					+ "','"
					+ date
					+ "','"
					+ invId
					+ "','"
					+ proid
					+ "','"
					+ pm
					+ "','"
					+ no
					+ "','"
					+ banklst + "')";
			PreparedStatement prep = con.prepareStatement(sql);
			status = prep.executeUpdate();
			System.out.println(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public int addInvestment(String invId, String invAmount, String proAmount,
			String proid, String date, String pm, String no, String bank_list) {
		int status = 0;
		try {
			con = DBUtility.getConnection();
			String sql = "insert into project_investment(project_id,investor_id,invested_amount,invested_date,promised_refund_amount,payment_method,cheque_no,bank_id) values('"
					+ proid
					+ "','"
					+ invId
					+ "','"
					+ invAmount
					+ "','"
					+ date
					+ "','"
					+ proAmount
					+ "','"
					+ pm
					+ "','"
					+ no
					+ "','"
					+ bank_list + "')";
			PreparedStatement prep = con.prepareStatement(sql);
			status = prep.executeUpdate();
			sql = "insert into project_investor_refund(project_id,investor_id,refunded_amount,status) values('"
					+ proid + "','" + invId + "','0','0')";
			prep = con.prepareStatement(sql);
			status = prep.executeUpdate();
			System.out.println(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public int addmInvestment(String invId, String invAmount, String proid,
			String date, String pm, String no, String bank_list) {
		int status = 0;
		try {
			con = DBUtility.getConnection();
			String sql = "insert into misincome(project_id,promis,amount,date,payment_method,cheque_no,bank_id) values('"
					+ proid
					+ "','"
					+ invId
					+ "','"
					+ invAmount
					+ "','"
					+ date
					+ "','" + pm + "','" + no + "','" + bank_list + "')";
			PreparedStatement prep = con.prepareStatement(sql);
			status = prep.executeUpdate();
			System.out.println(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public int addeInvestment(String invId, String invAmount, String proid,
			String date, String pm, String no, String bank_list) {
		int status = 0;
		try {
			con = DBUtility.getConnection();
			String sql = "insert into misexpense(project_id,promis,amount,date,payment_method,cheque_no,bank_id) values('"
					+ proid
					+ "','"
					+ invId
					+ "','"
					+ invAmount
					+ "','"
					+ date
					+ "','" + pm + "','" + no + "','" + bank_list + "')";
			PreparedStatement prep = con.prepareStatement(sql);
			status = prep.executeUpdate();
			System.out.println(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public ArrayList<String> getInvestorList() {
		ArrayList<String> list = new ArrayList<String>();
		try {
			con = DBUtility.getConnection();
			String sql = "select * from project_investor_master;";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery();
			while (rs.next()) {
				list.add(String.valueOf(rs.getString("investor_name"))
						+ ":INV_00" + rs.getString("investor_id"));
				System.out.println(list);
			}
			System.out.println(sql);
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean checkInvestment(String id, String proid) {
		boolean status = false;
		try {
			con = DBUtility.getConnection();
			String sql = "select * from project_investment where investor_id='"
					+ id.split("INV_00")[1] + "' and project_id='" + proid
					+ "';";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery();
			status = rs.next();
			System.out.println("Row :" + status + "sql :" + sql);
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public int addInvestmentRefund(String proid, String invId, String amount,
			String date, String note, String pm, String no, String bi) {
		int status = 0;
		try {
			con = DBUtility.getConnection();
			String sql = "insert into project_investor_refund(investor_id,project_id,refunded_amount,refunded_date,note,payment_method,cheque_no,bank_id) values('"
					+ invId
					+ "','"
					+ proid
					+ "','"
					+ amount
					+ "','"
					+ date
					+ "','"
					+ note
					+ "','"
					+ pm
					+ "','"
					+ no
					+ "','"
					+ bi
					+ "')";
			System.out.println(sql);
			PreparedStatement prep = con.prepareStatement(sql);
			status = prep.executeUpdate();
			System.out.println(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public ArrayList<ArrayList<String>> getServiceList(String scheme) {
		ArrayList<String> list = new ArrayList<String>();
		ArrayList<String> list1 = new ArrayList<String>();
		ArrayList<ArrayList<String>> total = new ArrayList<ArrayList<String>>();
		try {
			con = DBUtility.getConnection();
			String sql = "select * from (select * from scheme_service where scheme_id='"
					+ scheme
					+ "') as table1 "
					+ " inner join services on services.id=table1.service_id";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("service_id"));
				list1.add(rs.getString("name"));
			}
			total.add(list);
			total.add(list1);
			System.out.println(sql);
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return total;
	}

	public ArrayList<ArrayList<String>> getSupplierList(String service) {
		ArrayList<String> list = new ArrayList<String>();
		ArrayList<String> list1 = new ArrayList<String>();
		ArrayList<ArrayList<String>> total = new ArrayList<ArrayList<String>>();
		try {
			con = DBUtility.getConnection();
			String sql = "select * from (select * from service_supplier where service_id='"
					+ service
					+ "') as table1 "
					+ "inner join supplier on supplier.id=table1.supplier_id";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("supplier_id"));
				list1.add(rs.getString("company_name"));
			}
			total.add(list);
			total.add(list1);
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return total;
	}

	public ArrayList<ArrayList<String>> getPaymentBreakUp(String proid,
			String expid) {
		ArrayList<String> list = new ArrayList<String>();
		ArrayList<ArrayList<String>> total = new ArrayList<ArrayList<String>>();
		try {
			con = DBUtility.getConnection();
			String sql = "select * from project_supplier_payment where expense_id='"
					+ expid + "' and pro_id='" + proid + "'";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery();
			while (rs.next()) {
				list = new ArrayList();
				list.add(rs.getString("p_id"));
				list.add(rs.getString("paid_amount"));
				list.add(rs.getString("date"));
				System.out.println(list);
				total.add(list);
			}
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return total;
	}

	public ProjectSupplierPaymentBean getPaymentDetails(String proid,
			String p_id) {
		ProjectSupplierPaymentBean bean = null;
		try {
			con = DBUtility.getConnection();
			String sql = "select * from project_supplier_payment where p_id='"
					+ p_id + "' and pro_id='" + proid + "'";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery();
			if (rs.next()) {
				bean = new ProjectSupplierPaymentBean();
				bean.setP_id(rs.getString("p_id"));
				bean.setExpense_id(rs.getString("expense_id"));
				bean.setPro_id(rs.getString("pro_id"));
				bean.setPaid_amount(rs.getString("paid_amount"));
				bean.setDate(rs.getString("date"));
				bean.setNote(rs.getString("note"));
				bean.setSupplier_id(rs.getString("supplier_id"));
				bean.setBank_id(rs.getString("bank_id"));
				bean.setPayment_method(rs.getString("payment_method"));
				bean.setCheque_no(rs.getString("cheque_no"));
			}
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}

	public int addProjectExpense(String supplierId, String expenseAmount,
			String date, String proid, String details, String billno,
			String unit, String quantity, String service_id) {
		int status = 0;
		try {
			con = DBUtility.getConnection();
			String sql = "insert into project_expense(project_id,supplier_id,expense_amount,expense_date,expense_details,bill_no,unit,quan,service_id) values('"
					+ proid
					+ "','"
					+ supplierId
					+ "','"
					+ expenseAmount
					+ "','"
					+ date
					+ "','"
					+ details
					+ "','"
					+ billno
					+ "','"
					+ unit + "','" + quantity + "','" + service_id + "')";
			PreparedStatement prep = con.prepareStatement(sql);
			System.out.println(sql);
			status = prep.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public int addPaymentRow(String expense_id, String supplierId,
			String proid, String amount, String date, String billno) {
		int status = 0;
		try {
			con = DBUtility.getConnection();
			String sql = "insert into project_supplier_payment(pro_id,supplier_id,expense_id,paid_amount,date) values('"
					+ proid
					+ "','"
					+ supplierId
					+ "','"
					+ expense_id
					+ "','"
					+ amount + "','" + date + "')";
			PreparedStatement prep = con.prepareStatement(sql);
			status = prep.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public String getSupplierName(String sid) {
		String supname = null;
		try {
			con = DBUtility.getConnection();
			String sql = "select * from supplier where id='" + sid + "'";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery();
			if (rs.next()) {
				supname = rs.getString("company_name");
			}
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return supname;
	}

	public Bank getBankDetails(String bid) {
		Bank bank = null;
		try {
			con = DBUtility.getConnection();
			String sql = "select * from bank where id='" + bid + "'";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery();
			if (rs.next()) {
				bank = new Bank();
				bank.setBankName(rs.getString("bank_name"));
				bank.setAddress(rs.getString("address"));
			}
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bank;
	}

	public int addSupplierPayment(String pId, String expId, String paidAmount,
			String amountReceived, String supId, String paymentMethod,
			String bankId, String chequeNo, String notes, String date,
			String proId) throws Exception {
		String sql = null;
		int status = 0;
		sql = paidAmount.equals("0") ? "update project_supplier_payment set paid_amount='"
				+ amountReceived
				+ "',date='"
				+ date
				+ "',note='"
				+ notes
				+ "',bank_id='"
				+ bankId
				+ "',payment_method='"
				+ paymentMethod
				+ "',cheque_no='" + chequeNo + "' where p_id='" + pId + "' "
				: "insert into project_supplier_payment(expense_id,pro_id,paid_amount,date,note,supplier_id,bank_id,payment_method,cheque_no) values('"
						+ expId
						+ "','"
						+ proId
						+ "','"
						+ amountReceived
						+ "','"
						+ date
						+ "','"
						+ notes
						+ "','"
						+ supId
						+ "','"
						+ bankId
						+ "','"
						+ paymentMethod
						+ "','"
						+ chequeNo
						+ "')";
		con = DBUtility.getConnection();
		PreparedStatement prep = con.prepareStatement(sql);
		status = prep.executeUpdate(sql);
		con.close();
		prep.close();
		return status;
	}

	public int updateProjectExpense(String expId, String expAmount,
			String billNo, String date, String note) throws Exception {
		String sql = null;
		int status = 0;
		sql = "update project_expense set expense_amount='" + expAmount
				+ "',expense_date='" + date + "',bill_no='" + billNo
				+ "',expense_details='" + note + "' where expense_id='" + expId
				+ "'";
		con = DBUtility.getConnection();
		PreparedStatement prep = con.prepareStatement(sql);
		status = prep.executeUpdate(sql);
		con.close();
		prep.close();
		return status;
	}

	public int addFullpayment(String exp_id, String supId, String proId,
			String dueAmount, String paidAmount, String date, String billNo,
			String paymentMethod, String chequeNo, String bankList)
			throws Exception {
		String sql = null;
		int status = 0;
		sql = paidAmount.equals("0") ? "update project_supplier_payment set paid_amount='"
				+ dueAmount
				+ "',date='"
				+ date
				+ "',bank_id='"
				+ bankList
				+ "',payment_method='"
				+ paymentMethod
				+ "',cheque_no='"
				+ chequeNo + "' where expense_id='" + exp_id + "' "
				: "insert into project_supplier_payment(expense_id,pro_id,paid_amount,date,supplier_id,bank_id,payment_method,cheque_no) values('"
						+ exp_id
						+ "','"
						+ proId
						+ "','"
						+ dueAmount
						+ "','"
						+ date
						+ "','"
						+ supId
						+ "','"
						+ bankList
						+ "','"
						+ paymentMethod + "','" + chequeNo + "')";
		System.out.println(sql);
		con = DBUtility.getConnection();
		PreparedStatement prep = con.prepareStatement(sql);
		status = prep.executeUpdate(sql);
		con.close();
		prep.close();
		return status;
	}

	public int editSupplierPayment(String pId, String paidAmount,
			String paymentMethod, String chequeNo, String bankList,
			String note, String datecreated) throws Exception {
		int status = 0;
		String sql = "update project_supplier_payment set paid_amount='"
				+ paidAmount + "',date='" + datecreated + "',bank_id='"
				+ bankList + "',payment_method='" + paymentMethod
				+ "',cheque_no='" + chequeNo + "',note='" + note
				+ "' where p_id='" + pId + "' ";
		con = DBUtility.getConnection();
		PreparedStatement prep = con.prepareStatement(sql);
		status = prep.executeUpdate(sql);
		System.out.println(sql);
		con.close();
		prep.close();
		return status;
	}

	public int editInvestmentRefund(String rid, String amount, String note,
			String datecreated, String pm, String no, String bi)
			throws Exception {
		int status = 0;
		String sql = "update project_investor_refund set refunded_amount='"
				+ amount + "',refunded_date='" + datecreated + "',note='"
				+ note + "',bank_id='" + bi + "',payment_method='" + pm
				+ "',cheque_no='" + no + "' where refund_id='" + rid + "' ";
		con = DBUtility.getConnection();
		PreparedStatement prep = con.prepareStatement(sql);
		status = prep.executeUpdate(sql);
		System.out.println(sql);
		con.close();
		prep.close();
		return status;
	}

	public int editInvestmentMisI(String rid, String amount,
			String datecreated, String pm, String no, String bi, String mis)
			throws Exception {
		int status = 0;
		String sql = "update misincome set amount='" + amount + "',date='"
				+ datecreated + "',bank_id='" + bi + "',payment_method='" + pm
				+ "',cheque_no='" + no + "' where prom_eid='" + mis + "' ";
		con = DBUtility.getConnection();
		PreparedStatement prep = con.prepareStatement(sql);
		status = prep.executeUpdate(sql);
		System.out.println(sql);
		con.close();
		prep.close();
		return status;
	}

	public int editInvestmentMis(String rid, String amount, String datecreated,
			String pm, String no, String bi, String mis) throws Exception {
		int status = 0;
		String sql = "update misexpense set amount='" + amount + "',date='"
				+ datecreated + "',bank_id='" + bi + "',payment_method='" + pm
				+ "',cheque_no='" + no + "' where misiid='" + mis + "' ";
		con = DBUtility.getConnection();
		PreparedStatement prep = con.prepareStatement(sql);
		status = prep.executeUpdate(sql);
		System.out.println(sql);
		con.close();
		prep.close();
		return status;
	}

	public ArrayList<SupplierBO> getProjectSupplierList(String proid) {
		ArrayList<SupplierBO> suplist = new ArrayList<SupplierBO>();
		try {
			con = DBUtility.getConnection();
			String sql = "select * from (select * from project_expense  where project_id='"
					+ proid
					+ "' group by supplier_id) as table1"
					+ " inner join supplier on supplier.id=table1.supplier_id ";
			PreparedStatement prep = con.prepareStatement(sql);
			ResultSet rs = prep.executeQuery();
			while (rs.next()) {
				SupplierBO sup = new SupplierBO();
				sup.setId(Integer.parseInt(rs.getString("supplier_id")));
				sup.setSupplierName(rs.getString("company_name"));
				sup.setAddress(rs.getString("address"));
				suplist.add(sup);
			}
			DBUtility.closeConnection(con, prep, rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return suplist;
	}
}
