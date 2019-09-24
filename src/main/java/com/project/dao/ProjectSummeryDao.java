package com.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.project.bean.ProjectSummeryBean;
import com.util.DBUtility;

public class ProjectSummeryDao {
	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<ProjectSummeryBean> getSummeryList(String flag, String id) {
		ArrayList<ProjectSummeryBean> summeryArrayList;
		summeryArrayList = new ArrayList<ProjectSummeryBean>();
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		String sql = "";
		try {
			try {
				con = DBUtility.getConnection();
				if (flag.equals("buyer")) {
					sql = "select * from (select * from project_buyer_payment where project_id='"
							+ id
							+ "' and pay_status='1') as table1 "
							+ " INNER join project_buyer_master on project_buyer_master.buyer_id=table1.buyer_id";
				}
				if (flag.equals("buyerEst")) {
					sql = "SELECT sum(buyer_estimate_amount) as estimateSum FROM project_buyer_estimation where project_id='"
							+ id + "' and est_status='1'";
				}
				if (flag.equals("buyerInv")) {
					sql = "SELECT * from( select * from project_investment where project_id='"
							+ id
							+ "') as table1 "
							+ "inner join project_investor_master on project_investor_master.investor_id=table1.investor_id";
				}
				if (flag.equals("totalExpense")) {
					sql = " select * from project_expense where project_id='"
							+ id + "'";
				}
				if (flag.equals("totalRefund")) {
					sql = " select * from (select * from project_investor_refund where project_id='"
							+ id
							+ "') as table1 "
							+ "INNER join project_investor_master on project_investor_master.investor_id=table1.investor_id";
				}
				if (flag.equals("buyerTotal")) {
					sql = "select * from (SELECT * from project_buyer_estimation where est_status='1' and project_id='"
							+ id
							+ "') as table1"
							+ " inner join project_buyer_master on table1.buyer_id=project_buyer_master.buyer_id"
							+ " inner join project_master on table1.project_id=project_master.project_id";
				}
				if (flag.equals("buyerTotalbyId")) {
					sql = "select * from project_buyer_payment where buyer_estimate_id='"
							+ id + "'";
				}
				if (flag.equals("misI")) {
					sql = "SELECT sum(amount) as misSum FROM misincome where project_id='"
							+ id + "'";
				}
				if (flag.equals("mis")) {
					sql = "SELECT sum(amount) as misSum FROM misexpense where project_id='"
							+ id + "'";
				}
				System.out.println(sql);
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				while (res.next()) {
					String misSum;
					ProjectSummeryBean psbean = new ProjectSummeryBean();
					if (flag.equals("buyer")) {
						psbean.setPdate(res.getString("payment_date"));
						psbean.setPamount(res.getString("payment_amount"));
						psbean.setBuyerName(res.getString("buyer_name"));
					}
					if (flag.equals("buyerEst")) {
						System.out.println("best");
						String estimateSum = res.getString("estimateSum");
						try {
							estimateSum.equals(null);
						} catch (Exception e) {
							estimateSum = "0";
						}
						psbean.setBuyerEstimate(estimateSum);
						System.out.println(psbean.getBuyerEstimate());
					}
					if (flag.equals("buyerInv")) {
						psbean.setInvested_amount(res
								.getString("invested_amount"));
						psbean.setInvested_date(res.getString("invested_date"));
						psbean.setPromised_refund_amount(res
								.getString("promised_refund_amount"));
					}
					if (flag.equals("misI")) {
						misSum = res.getString("misSum");
						try {
							misSum.equals(null);
						} catch (Exception e) {
							misSum = "0";
						}
						psbean.setMisI(misSum);
					}
					if (flag.equals("mis")) {
						misSum = res.getString("misSum");
						try {
							misSum.equals(null);
						} catch (Exception e) {
							misSum = "0";
						}
						psbean.setMis(misSum);
					}
					if (flag.equals("totalExpense")) {
						psbean.setExpense_date(res.getString("expense_date"));
						psbean.setExpense_amount(res
								.getString("expense_amount"));
					}
					if (flag.equals("totalRefund")) {
						psbean.setRefunded_date(res.getString("refunded_date"));
						psbean.setRefund_amount(res
								.getString("refunded_amount"));
					}
					if (flag.equals("buyerTotal")) {
						psbean.setBuyerName(res.getString("buyer_name"));
						psbean.setEst_id(res.getString("buyer_estimate_id"));
						psbean.setEst_date(res.getString("buyer_estimate_date"));
						psbean.setEst_amount(res
								.getString("buyer_estimate_amount"));
						psbean.setPro_name(res.getString("project_name"));
					}
					if (flag.equals("buyerTotalbyId")) {
						psbean.setPdate(res.getString("payment_date"));
						psbean.setPamount(res.getString("payment_amount"));
					}
					summeryArrayList.add(psbean);
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
		return summeryArrayList;
	}
}
