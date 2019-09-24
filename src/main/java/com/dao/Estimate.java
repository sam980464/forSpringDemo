package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.bo.EstimateBO;
import com.util.DBUtility;

public class Estimate {
	int id;
	int clientId;
	int schemeId;
	double amount;
	int createdBy;
	String dateCreated;
	String dateModified;
	String estimateNote;
	String schemeName;
	double sumtotal;
	String startdate;
	String enddate;

	public double getSumtotal() {
		return this.sumtotal;
	}

	public void setSumtotal(double sumtotal) {
		this.sumtotal = sumtotal;
	}

	public String getStartdate() {
		return this.startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return this.enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public String getSchemeName() {
		return this.schemeName;
	}

	public void setSchemeName(String schemeName) {
		this.schemeName = schemeName;
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

	public int getSchemeId() {
		return this.schemeId;
	}

	public void setSchemeId(int schemeId) {
		this.schemeId = schemeId;
	}

	public double getAmount() {
		return this.amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public int getCreatedBy() {
		return this.createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	public String getDateCreated() {
		return this.dateCreated;
	}

	public void setDateCreated(String dateCreated) {
		this.dateCreated = dateCreated;
	}

	public String getDateModified() {
		return this.dateModified;
	}

	public void setDateModified(String dateModified) {
		this.dateModified = dateModified;
	}

	public String getEstimateNote() {
		return this.estimateNote;
	}

	public void setEstimateNote(String estimateNote) {
		estimateNote = estimateNote.replace("'", " ");
		this.estimateNote = estimateNote = estimateNote.replace("@", " at ");
	}

	public int updateData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "UPDATE `estimate` SET `client_id` = "
						+ this.getClientId() + ", " + "`scheme_id` = "
						+ this.getSchemeId() + ",  date_created ='"
						+ this.getDateCreated()
						+ "', date_modifed =sysdate(), " + "`amount` = "
						+ this.getAmount() + ", " + "`estimate_note` = '"
						+ this.getEstimateNote() + "' " + "WHERE "
						+ "`estimate`.`id` = " + this.getId();
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

	public double getAmountByEstimateId(int eid) {
		double amount;
		amount = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT amount  FROM `estimate` WHERE `id` = " + eid;
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
					amount = Double.parseDouble(res.getString("amount"));
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount;
	}

	public double getTotalEstimateByClientId(int cid) {
		double amount;
		amount = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT sum(amount) as amount  FROM `estimate` WHERE status = 1 and `client_id` = "
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
					amount = res.getDouble("amount");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount;
	}

	public double getTotalEstimateByClientId(int cid, int scheme_id) {
		double amount;
		amount = 0.0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT sum(amount) as amount  FROM `estimate` WHERE `client_id` = "
				+ cid + " and  scheme_id=" + scheme_id;
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
					amount = res.getDouble("amount");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return amount;
	}

	public String getEstimateDateByEstimateId(int eid) {
		String date_created;
		date_created = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT  date_created  FROM `estimate` WHERE `id` = " + eid;
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
					date_created = res.getString("date_created");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return date_created;
	}

	public String getNoteByEstimateId(int eid) {
		String estimate_note;
		estimate_note = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT estimate_note  FROM `estimate` WHERE `id` = " + eid;
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
					estimate_note = res.getString("estimate_note");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return estimate_note;
	}

	public int getSchemeIDByEstimateId(int eid) {
		int scheme_id;
		scheme_id = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT scheme_id  FROM `estimate` WHERE `id` = " + eid;
		System.out.println(sql);
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
					scheme_id = Integer.parseInt(res.getString("scheme_id"));
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return scheme_id;
	}
	
	public String getSchemeNameByEstimateId(int eid) {
		String scheme_name;
		scheme_name = null;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT s.scheme_name  FROM `estimate` e,`scheme` s WHERE e.`id` = " + eid +" and e.`scheme_id`=s.`id`";
		System.out.println(sql);
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
					scheme_name = res.getString("scheme_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
				DBUtility.closeConnection(con, st, res);
			}
		} finally {
			DBUtility.closeConnection(con, st, res);
		}
		return scheme_name;
	}

	public int getClientIdByEstimateId(int id) {
		int client_id;
		client_id = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT client_id  FROM `estimate` WHERE `id` = " + id;
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

	public int getMaxId() {
		int max;
		max = 0;
		Connection con = null;
		PreparedStatement st = null;
		String sql = null;
		ResultSet res = null;
		sql = "SELECT max(id) max FROM `estimate` ";
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

	public int addData() {
		Connection con = null;
		Statement st = null;
		int returnVal = 0;
		try {
			try {
				con = DBUtility.getConnection();
				st = con.createStatement();
				String sql = "INSERT INTO `estimate` (`client_id`, `scheme_id`, `amount`, `created_by`, `date_created`, `date_modifed`, `estimate_note`) VALUES ("
						+ this.getClientId()
						+ ","
						+ this.getSchemeId()
						+ ", "
						+ this.getAmount()
						+ ", "
						+ this.getCreatedBy()
						+ ", '"
						+ this.getDateCreated()
						+ "', CURDATE(), '"
						+ this.getEstimateNote() + "')";
				if (!Integer.toString(this.getClientId()).equals("")) {
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

	public int deleteEstimate() {
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
				String sql = "UPDATE `estimate` SET `status` = '0' WHERE `estimate`.`id` ="
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
	public ArrayList<EstimateBO> getAllItem() {
		ArrayList<EstimateBO> estimateBOList;
		estimateBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `estimate` where status=1 order by  date_created  desc";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				estimateBOList = this.populateItemList(res);
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
		return estimateBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<EstimateBO> getAllItemByEid(int eid) {
		ArrayList<EstimateBO> estimateBOList;
		estimateBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `estimate` where id=" + eid;
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				estimateBOList = this.populateItemList(res);
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
		return estimateBOList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<EstimateBO> getAllItem(int cid) {
		ArrayList<EstimateBO> estimateBOList;
		estimateBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "SELECT * FROM  `estimate` where client_id=" + cid
						+ " and  status=1 order by  date_created  desc";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				estimateBOList = this.populateItemList(res);
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
		return estimateBOList;
	}

	private ArrayList<EstimateBO> populateItemList(ResultSet res) {
		ArrayList<EstimateBO> estimateList = null;
		EstimateBO estimateBO = null;
		if (res != null) {
			estimateList = new ArrayList<EstimateBO>();
			try {
				while (res.next()) {
					estimateBO = new EstimateBO();
					estimateBO.setId(res.getInt("id"));
					estimateBO.setClientId(res.getInt("client_id"));
					estimateBO.setSchemeId(res.getInt("scheme_id"));
					estimateBO.setAmount(res.getDouble("amount"));
					estimateBO.setCreatedBy(res.getInt("created_by"));
					estimateBO.setDateCreated(res.getString("date_created"));
					estimateBO.setDateModified(res.getString("date_modifed"));
					estimateBO.setEstimateNote(res.getString("estimate_note"));
					estimateList.add(estimateBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return estimateList;
	}

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	public ArrayList<EstimateBO> getAllItemForReport() {
		ArrayList<EstimateBO> estimateBOList;
		estimateBOList = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		try {
			try {
				con = DBUtility.getConnection();
				String sql = "";
				sql = this.getSchemeId() != 0 ? "SELECT *,sum(`amount`) sumtotal FROM `estimate` WHERE status=1 and `scheme_id`="
						+ this.getSchemeId()
						+ " AND `date_created` BETWEEN '"
						+ this.getStartdate()
						+ "' AND '"
						+ this.getEnddate()
						+ "' "
						+ "group by `client_id` order by date_created desc"
						: "SELECT *,sum(`amount`) sumtotal FROM `estimate` WHERE status=1  AND `date_created` BETWEEN '"
								+ this.getStartdate()
								+ "' AND '"
								+ this.getEnddate()
								+ "' "
								+ "group by `client_id` order by date_created desc";
				st = con.prepareStatement(sql);
				res = st.executeQuery(sql);
				estimateBOList = this.populateItemListReport(res);
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
		return estimateBOList;
	}

	private ArrayList<EstimateBO> populateItemListReport(ResultSet res) {
		ArrayList<EstimateBO> estimateList = null;
		EstimateBO estimateBO = null;
		if (res != null) {
			estimateList = new ArrayList<EstimateBO>();
			try {
				while (res.next()) {
					estimateBO = new EstimateBO();
					estimateBO.setId(res.getInt("id"));
					estimateBO.setClientId(res.getInt("client_id"));
					estimateBO.setSchemeId(res.getInt("scheme_id"));
					estimateBO.setAmount(res.getDouble("amount"));
					estimateBO.setSumtotal(res.getDouble("sumtotal"));
					estimateBO.setCreatedBy(res.getInt("created_by"));
					estimateBO.setDateCreated(res.getString("date_created"));
					estimateBO.setDateModified(res.getString("date_modifed"));
					estimateBO.setEstimateNote(res.getString("estimate_note"));
					estimateList.add(estimateBO);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return estimateList;
	}
}