package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.io.File;

import javax.servlet.http.Part;

import java.util.Collection;
import java.io.InputStream;
import java.io.FileOutputStream;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.dao.AddRole;
import com.dao.AddUser;
import com.dao.Bank;
import com.dao.Client;
import com.dao.District;
import com.dao.Estimate;
import com.dao.Expenses;
import com.dao.ExpensesPayment;
import com.dao.Mouja;
import com.dao.Municipality;
import com.dao.OfficeExpenses;
import com.dao.OfficeExpensesItem;
import com.dao.Payment;
import com.dao.PoliceStation;
import com.dao.PropertyDetails;
import com.dao.Reference;
import com.dao.Scheme;
import com.dao.SchemeService;
import com.dao.Service;
import com.dao.Supplier;
import com.dao.User;
import com.dao.UserLog;
import com.dao.promis;
import com.project.bean.AddBuyerToProjectBean;
import com.project.dao.AddBuyerToProject;
import com.project.dao.Buyer;
import com.project.dao.Developer;
import com.project.dao.Investor;
import com.util.DBUtility;
import com.util.EmailUtility;
import com.dao.Gst;

import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.ServletContext;
@WebServlet("/ActionServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, 	// 2MB
maxFileSize = 1024 * 1024 * 10, 		// 10MB
maxRequestSize = 1024 * 1024 * 50)
public class ActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1;
	private String host;
	private String port;
	private String user;
	private String pass;

	public void init() {
		// reads SMTP server setting from web.xml file
		ServletContext context = getServletContext();
		host = context.getInitParameter("host");
		port = context.getInitParameter("port");
		user = context.getInitParameter("user");
		pass = context.getInitParameter("pass");
	}
	
	private static final Logger logger = LoggerFactory
			.getLogger(DBUtility.class);

	/*
	 * Loose catch block Enabled aggressive exception aggregation
	 */
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		logger.info("Inside ActionServlet :: doGet()::::");
		String note;
		String sql3;
		String newpay;
		promis bank;
		String pid;
		String sql2;
		Investor investor;
		Developer developer;
		
		Buyer buyer;
		String datecreated;
		String sql;
		Expenses expenses;
		Estimate estimate;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet res = null;
		String todo = request.getParameter("todo");
		logger.info("TODO " + todo);
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = null;
		session = request.getSession(true);
		if (todo.equals("deletepromis")) {
			logger.info("Inside  ActionServlet :: doGet()::deletepromis");
			bank = new promis();
			bank.setId(Integer.parseInt(request.getParameter("id")));
			
			if(bank.deletePromis()>0) {
				session.setAttribute("message", "Promis Delete Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting Promis");
			}			
			response.setStatus(302);
			response.setHeader("Location", "projectmisc.jsp");
		}
		
		if (todo.equals("deleteUser")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteUser");
			AddUser addUser = new AddUser();
			addUser.setId(Integer.parseInt(request.getParameter("id")));
			
			if(addUser.deleteUser()>0) {
				session.setAttribute("message", "User Delete Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting User");
			}			
			response.setStatus(302);
			response.setHeader("Location", "user_management.jsp");
		}
		if (todo.equals("addInvestor")) {
			logger.info("Inside  ActionServlet :: doGet()::addInvestor");
			investor = new Investor();
			investor.setInvestor_name(request.getParameter("investor_name"));
			investor.setInvestor_address(request
					.getParameter("investor_address"));
			investor.setInvestor_contactno(request
					.getParameter("investor_contactno"));
			investor.setInvestor_email_id(request
					.getParameter("investor_email_id"));
			investor.setInvestor_details(request
					.getParameter("investor_details"));
			if(investor.addInvestor()>0) {
				session.setAttribute("message", "Investor Added Sucessfully");
			}else {
				session.setAttribute("message", "Error Adding Investor");
			}	
			
			System.out.println("investor panel");
			logger.info("Exit  ActionServlet :: doGet()::addInvestor");
			response.setStatus(302);
			response.setHeader("Location",
					"projects.jsp?proid=" + session.getAttribute("project_id"));
		}
		if (todo.equals("addDeveloper")) {
			logger.info("Inside  ActionServlet :: doGet()::addDeveloper");
			developer = new Developer();
			developer.setDeveloper_name(request.getParameter("developer_name"));
			developer.setDeveloper_address(request
					.getParameter("developer_address"));
			developer.setDeveloper_contactno(request
					.getParameter("developer_contactno"));
			developer.setDeveloper_email_id(request
					.getParameter("developer_email_id"));
			if(developer.addDeveloper()>0) {
				session.setAttribute("message", "Developer Added Sucessfully");
			}else {
				session.setAttribute("message", "Error Adding Developer");
			}	
			System.out.println("developer panel");
			logger.info("Exit  ActionServlet :: doGet()::addDeveloper");
			response.setStatus(302);
			response.setHeader("Location",
					"developer.jsp");
		}
		if (todo.equals("addBuyer")) {
			logger.info("Inside  ActionServlet :: doGet()::addBuyer");
			buyer = new Buyer();
			buyer.setBuyer_name(request.getParameter("buyer_name"));
			buyer.setBuyer_address(request.getParameter("buyer_address"));
			buyer.setBuyer_contactno(request.getParameter("buyer_contactno"));
			buyer.setBuyer_email(request.getParameter("buyer_email"));
			buyer.setBuyer_details(request.getParameter("buyer_details"));
			if(buyer.addBuyer()>0) {
				session.setAttribute("message", "Buyer Added Sucessfully");
			}else {
				session.setAttribute("message", "Error Adding Buyer");
			}			
			System.out.println("investor panel");
			logger.info("Exit  ActionServlet :: doGet()::addBuyer");
			response.setStatus(302);
			response.setHeader("Location",
					"projects.jsp?proid=" + session.getAttribute("project_id"));
		}
		
		if (todo.equals("updateInvestor")) {
			logger.info("Inside  ActionServlet :: doGet()::updateGstNo");
			investor = new Investor();
			investor.setInvestor_id(Integer.parseInt(request
					.getParameter("investor_id")));
			investor.setInvestor_name(request.getParameter("investor_name"));
			investor.setInvestor_address(request
					.getParameter("investor_address"));
			investor.setInvestor_contactno(request
					.getParameter("investor_contactno"));
			investor.setInvestor_email_id(request
					.getParameter("investor_email_id"));
			investor.setInvestor_details(request
					.getParameter("investor_details"));
			if(investor.updateData()>0) {
				session.setAttribute("message", "Investor Updated Sucessfully");
			}else {
				session.setAttribute("message", "Error Updating Investor");
			}	
			
			logger.info("Exit  ActionServlet :: doGet()::updateInvestor");
			response.setStatus(302);
			response.setHeader("Location", "investor.jsp");
			out.close();
		}
		
		if (todo.equals("updateDeveloper")) {
			logger.info("Inside  ActionServlet :: doGet()::updateDeveloper");
			developer = new Developer();
			developer.setDeveloper_id(Integer.parseInt(request
					.getParameter("developer_id")));
			developer.setDeveloper_name(request.getParameter("developer_name"));
			developer.setDeveloper_address(request
					.getParameter("developer_address"));
			developer.setDeveloper_contactno(request
					.getParameter("developer_contactno"));
			developer.setDeveloper_email_id(request
					.getParameter("developer_email_id"));
			if(developer.updateData()>0) {
				session.setAttribute("message", " Developer Details Updated Sucessfully");
			}else {
				session.setAttribute("message", "Error Updating   Developer Details");
			}
			
			logger.info("Exit  ActionServlet :: doGet()::developer");
			response.setStatus(302);
			response.setHeader("Location", "developer.jsp");
			out.close();
		}
		
		if (todo.equals("updateBuyer")) {
			logger.info("Inside  ActionServlet :: doGet()::updateBuyer");
			buyer = new Buyer();
			System.out.println("ID:" + request.getParameter("buyer_id"));
			buyer.setBuyer_id(Integer.parseInt(request.getParameter("buyer_id")));
			buyer.setBuyer_name(request.getParameter("buyer_name"));
			buyer.setBuyer_address(request.getParameter("buyer_address"));
			buyer.setBuyer_contactno(request.getParameter("buyer_contactno"));
			buyer.setBuyer_email(request.getParameter("buyer_email"));
			buyer.setBuyer_details(request.getParameter("buyer_details"));
			if(buyer.updateData()>0) {
				session.setAttribute("message", " Buyer Updated Sucessfully");
			}else {
				session.setAttribute("message", "Error Updating  Buyer");
			}
			
			logger.info("Exit  ActionServlet :: doGet()::updateBuyer");
			response.setStatus(302);
			response.setHeader("Location", "buyer.jsp");
			out.close();
		}
		if (todo.equals("addbuyerforproject")) {
			logger.info("Inside  ActionServlet :: doGet()::addbuyerforproject");
			float paid_amount = 0.0f;
			Buyer buyer2 = new Buyer();
			buyer2.setBuyer_name(request.getParameter("buyer_name"));
			buyer2.setBuyer_address(request.getParameter("buyer_address"));
			buyer2.setBuyer_contactno(request.getParameter("buyer_contactno"));
			buyer2.setBuyer_email(request.getParameter("buyer_email"));
			buyer2.setBuyer_details(request.getParameter("buyer_details"));
			buyer2.addBuyer();
			AddBuyerToProject addtoproject = new AddBuyerToProject();
			addtoproject.setBuyer_id(request.getParameter("buyer"));
			addtoproject.setBuyer_estimate_amount(request
					.getParameter("estamnt"));
			try {
				paid_amount = Float.parseFloat(request.getParameter("pamamnt"));
			} catch (Exception e) {
				paid_amount = 0.0f;
			}
			addtoproject.setPaid_amount("" + paid_amount);
			addtoproject.setBuyer_estimate_date(request
					.getParameter("datecreated"));
			addtoproject
					.setBuyer_estimate_details(request.getParameter("note"));
			addtoproject.setPayment_method(request
					.getParameter("payment_method"));
			addtoproject.setCheque_no(request.getParameter("cheque_no"));
			addtoproject.setBank_list(request.getParameter("bank_list"));
			addtoproject.setProject_id(request.getParameter("pro_id"));
			addtoproject.addBuyerToProject();
			logger.info("Exit  ActionServlet :: doGet()::addbuyerforproject");
			response.setStatus(302);
			response.setHeader("Location",
					"projects.jsp?proid=" + request.getParameter("pro_id"));
		}
		if (todo.equals("getBuyerDetails")) {
			logger.info("Inside  ActionServlet :: doGet()::getBuyerDetails");
			String buyer_id = request.getParameter("bid");
			String proid = request.getParameter("proid");
			ArrayList buyerArrayList = new ArrayList();
			buyerArrayList = new AddBuyerToProject().getAllBuyer(buyer_id,
					proid);
			String total = "";
			total = "<table width=100% id='account_status'><tr><th>Estimate Amount</th><th>Paid Amount</th><th>Due Amount</th></tr><tr><td><input type='text' name='total_estimate' id='total_estimate' readonly value='"
					+ ((AddBuyerToProjectBean) buyerArrayList.get(0))
							.getBuyer_estimate_amount()
					+ "'></td><td><input type='text' name='total_received' id='total_received' readonly value='"
					+ ((AddBuyerToProjectBean) buyerArrayList.get(0))
							.getBuyer_estimate_details()
					+ "'></td>"
					+ "<td><input type='text' name='total_due' id='total_due' readonly value='"
					+ (Integer.parseInt(((AddBuyerToProjectBean) buyerArrayList
							.get(0)).getBuyer_estimate_amount()) - Integer
							.parseInt(((AddBuyerToProjectBean) buyerArrayList
									.get(0)).getBuyer_estimate_details()))
					+ "'></td></tr></table><input type='hidden' name='estid' id='estid' readonly value='"
					+ ((AddBuyerToProjectBean) buyerArrayList.get(0))
							.getBuyer_estimate_id() + "'>";
			logger.info("Exit  ActionServlet :: doGet()::getBuyerDetails");
			out.println(total);
			out.close();
		}
		if (todo.equals("buyerpaymentsubmit")) {
			logger.info("Inside  ActionServlet :: doGet()::buyerpaymentsubmit");
			HttpSession sess = request.getSession();
			String buyer_id = request.getParameter("buyer");
			String buyer_estimate_id = request.getParameter("estid");
			String payment_amount = request.getParameter("new");
			String payment_date = request.getParameter("datecreated");
			String payment_details = request.getParameter("note");
			AddBuyerToProject addbuyerPayment = new AddBuyerToProject();
			addbuyerPayment.setBuyer_id(buyer_id);
			addbuyerPayment.setBuyer_estimate_id(buyer_estimate_id);
			addbuyerPayment.setPaid_amount(payment_amount);
			addbuyerPayment.setBuyer_estimate_date(payment_date);
			addbuyerPayment.setBuyer_estimate_details(payment_details);
			addbuyerPayment.setPayment_method(request
					.getParameter("payment_method"));
			addbuyerPayment.setCheque_no(request.getParameter("cheque_no"));
			addbuyerPayment.setBank_list(request.getParameter("bank_list"));
			addbuyerPayment.addbuyerpaymentsubmit(session.getAttribute(
					"project_id").toString());
			logger.info("Exit  ActionServlet :: doGet()::buyerpaymentsubmit");
			response.setStatus(302);
			response.setHeader("Location",
					"projects.jsp?proid=" + sess.getAttribute("project_id"));
		}
		if (todo.equals("buyerpaymentupdate")) {
			logger.info("Inside  ActionServlet :: doGet()::buyerpaymentupdate");
			datecreated = request.getParameter("datecreated");
			newpay = request.getParameter("new");
			note = request.getParameter("note");
			pid = request.getParameter("pid");
			String pm = request.getParameter("payment_method");
			String no = request.getParameter("cheque_no");
			String bank_list = request.getParameter("bank_list");
			AddBuyerToProject addbuyerPayment = new AddBuyerToProject();
			addbuyerPayment.setPaid_amount(newpay);
			addbuyerPayment.setBuyer_estimate_date(datecreated);
			addbuyerPayment.setBuyer_estimate_details(note);
			addbuyerPayment.setPayment_id(pid);
			addbuyerPayment.setPayment_method(pm);
			addbuyerPayment.setCheque_no(no);
			addbuyerPayment.setBank_list(bank_list);
			addbuyerPayment.updatePayment();
			logger.info("Exit  ActionServlet :: doGet()::buyerpaymentupdate");
			response.setStatus(302);
			response.setHeader("Location",
					"projects.jsp?proid=" + session.getAttribute("project_id"));
		}
		if (todo.equals("buyerEstimateupdate")) {
			logger.info("Inside  ActionServlet :: doGet()::buyerEstimateupdate");
			datecreated = request.getParameter("datecreated");
			newpay = request.getParameter("new");
			note = request.getParameter("note");
			pid = request.getParameter("pid");
			AddBuyerToProject addbuyerPayment = new AddBuyerToProject();
			addbuyerPayment.setPaid_amount(newpay);
			addbuyerPayment.setBuyer_estimate_date(datecreated);
			addbuyerPayment.setBuyer_estimate_details(note);
			addbuyerPayment.setBuyer_estimate_id(pid);
			addbuyerPayment.updateEstimate();
			logger.info("Exit  ActionServlet :: doGet()::buyerEstimateupdate");
			response.setStatus(302);
			response.setHeader("Location",
					"projects.jsp?proid=" + session.getAttribute("project_id"));
		}
		if (todo.equals("deleteProAttrib")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteProAttrib");
			String id = request.getParameter("id");
			String flag = request.getParameter("flag");
			System.out.println("FLAG:" + flag);
			AddBuyerToProject addtopro = new AddBuyerToProject();
			addtopro.deleteProAttrib(id, flag);
			logger.info("Exit  ActionServlet :: doGet()::deleteProAttrib");
			if (flag.equals("inv")) {
				response.setStatus(302);
				response.setHeader("Location", "investor.jsp");
			}
			if (flag.equals("buyer")) {
				response.setStatus(302);
				response.setHeader("Location", "buyer.jsp");
			}
			if (flag.equals("devep")) {
				response.setStatus(302);
				response.setHeader("Location", "developer.jsp");
			}
			if (flag.equals("estdel") || flag.equals("paydel")) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
			}
		}
		if (todo.equals("logout")) {
			System.out.println("Logout::::::::::::::::::::::::::");
			logger.info("Inside  ActionServlet :: doGet()::logout");
			session = null;
			session = request.getSession(true);
			session.setAttribute("userName", (Object) null);
			logger.info("Exit  ActionServlet :: doGet()::logout");
			response.setStatus(302);
			response.setHeader("Location", "index.html");
		}
		if (todo.equals("deleteMunicipality")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteMunicipality");
			Municipality municipality = new Municipality();
			municipality.setId(Integer.parseInt(request.getParameter("id")));
			if(municipality.deleteData()>0) {
				session.setAttribute("message", " Municipality Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting  Municipality");
			}
			
			logger.info("Exit  ActionServlet :: doGet()::deleteMunicipality");
			response.setStatus(302);
			response.setHeader("Location", "municipality.jsp");
		}
		if (todo.equals("deleteClient")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteClient");
			Client client = new Client();
			client.setId(Integer.parseInt(request.getParameter("id")));
			if(client.deleteClient()>0) {
				session.setAttribute("message", " Client Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting  Client");
			}
			
			logger.info("Exit  ActionServlet :: doGet()::deleteClient");
			response.setStatus(302);
			response.setHeader("Location", "client.jsp");
		}
		if (todo.equals("deleteMouja")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteMouja");
			Mouja mouja = new Mouja();
			mouja.setId(Integer.parseInt(request.getParameter("id")));
			if(mouja.deleteData()>0) {
				session.setAttribute("message", " Mouja Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting  Mouja");
			}
			
			logger.info("Exit  ActionServlet :: doGet()::deleteMouja");
			response.setStatus(302);
			response.setHeader("Location", "mouja.jsp");
		}
		if (todo.equals("deleteOfficeExpensesItem")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteOfficeExpensesItem");
			OfficeExpensesItem oei = new OfficeExpensesItem();
			oei.setId(Integer.parseInt(request.getParameter("id")));
			if(oei.deleteData()>0) {
				session.setAttribute("message", " Office Expenses Item Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting  Office Expenses Item");
			}
			oei.deleteData();
			logger.info("Exit  ActionServlet :: doGet()::deleteOfficeExpensesItem");
			response.setStatus(302);
			response.setHeader("Location", "office_expenses_item.jsp");
		}
		if (todo.equals("deleteBank")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteBank");
			Bank bank1 = new Bank();
			bank1.setId(Integer.parseInt(request.getParameter("bank_id")));
			if(bank1.deleteBank()>0) {
				session.setAttribute("message", " Bank Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting  Bank");
			}
			
			logger.info("Exit  ActionServlet :: doGet()::deleteBank");
			response.setStatus(302);
			response.setHeader("Location", "bank.jsp");
		}
		if (todo.equals("deleteSupplier")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteSupplier");
			Supplier supplier = new Supplier();
			supplier.setId(Integer.parseInt(request.getParameter("supplier_id")));
			if(supplier.deleteSupplier()>0) {
				session.setAttribute("message", " Supplier Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting  Supplier");
			}
			
			int scheme_id = Integer.parseInt(request.getParameter("scheme_id"));
			logger.info("Exit  ActionServlet :: doGet()::deleteSupplier");
			response.setStatus(302);
			response.setHeader("Location", "scheme.jsp?scheme_id=" + scheme_id);
		}
		if (todo.equals("deleteExpenses")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteExpenses");
			expenses = new Expenses();
			int cid = Integer.parseInt(request.getParameter("cid"));
			expenses.setId(Integer.parseInt(request.getParameter("exid")));
			if(expenses.deleteExpenses()>0) {
				session.setAttribute("message", " Expenses Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting  Expenses");
			}	
			
			logger.info("Exit  ActionServlet :: doGet()::deleteExpenses");
			response.setStatus(302);
			/*response.setHeader(
					"Location",
					"order_more_for_same_bill.jsp?cid="
							+ request.getParameter("cid") + "&billno="
							+ request.getParameter("billno") + "&supplier_id="
							+ request.getParameter("supplier_id") + "&eid="
							+ request.getParameter("eid"));*/
			response.setHeader("Location", "client.jsp?cid=" + cid);
		}
		if (todo.equals("deleteBill")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteBill");
			expenses = new Expenses();
			expenses.setBillNumber(request.getParameter("billno"));
			if(expenses.deleteExpensesByBill()>0) {
				session.setAttribute("message", " Bill Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting  Bill");
			}			
			int cid = Integer.parseInt(request.getParameter("cid"));
			logger.info("Exit  ActionServlet :: doGet()::deleteBill");
			response.setStatus(302);
			response.setHeader("Location", "client.jsp?cid=" + cid);
		}
		if (todo.equals("deletePayment")) {
			logger.info("Inside  ActionServlet :: doGet()::deletePayment");
			Payment payment = new Payment();
			payment.setId(Integer.parseInt(request.getParameter("pid")));
			if(payment.deletePayment()>0) {
				session.setAttribute("message", " Payment Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting  Payment");
			}
			
			int cid = Integer.parseInt(request.getParameter("cid"));
			logger.info("Exit  ActionServlet :: doGet()::deletePayment");
			response.setStatus(302);
			response.setHeader("Location", "client.jsp?cid=" + cid);
		}
		if (todo.equals("deletePoliceStation")) {
			logger.info("Inside  ActionServlet :: doGet()::deletePoliceStation");
			PoliceStation policeStation = new PoliceStation();
			policeStation.setId(Integer.parseInt(request.getParameter("id")));
			if(policeStation.deleteData()>0) {
				session.setAttribute("message", " Police Station Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting  Police Station");
			}
			
			logger.info("Exit  ActionServlet :: doGet()::deletePoliceStation");
			response.setStatus(302);
			response.setHeader("Location", "police_station.jsp");
		}
		if (todo.equals("deletePaidToSupplier")) {
			logger.info("Inside  ActionServlet :: doGet()::deletePaidToSupplier");
			ExpensesPayment expensesPayment = new ExpensesPayment();
			expensesPayment.setId(Integer.parseInt(request
					.getParameter("paidId")));
			try {
				expensesPayment.deleteData();
				session.setAttribute("message", "Deleted Supplier Payment");
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doGet()::deletePaidToSupplier");
			response.setStatus(302);
			response.setHeader("Location",
					"client.jsp?cid=" + request.getParameter("cid"));
		}
		if (todo.equals("deleteOfficeExpenses")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteOfficeExpenses");
			OfficeExpenses officeExpenses = new OfficeExpenses();
			officeExpenses
					.setId(Integer.parseInt(request.getParameter("oe_id")));
			try {
				officeExpenses.deleteOfficeExpenses();
				session.setAttribute("message", "Office Expenses Deleted");
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doGet()::deleteOfficeExpenses");
			response.setStatus(302);
			response.setHeader("Location", "office_expenses.jsp");
		}
		if (todo.equals("deleteScheme")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteScheme");
			Scheme scheme = new Scheme();
			scheme.setId(Integer.parseInt(request.getParameter("id")));
			if(scheme.deleteScheme()>0) {
				session.setAttribute("message", " Scheme Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting  Scheme");
			}			
			logger.info("Exit  ActionServlet :: doGet()::deleteScheme");
			response.setStatus(302);
			response.setHeader("Location", "scheme.jsp");
		}
		if (todo.equals("deleteDistrict")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteDistrict");
			District district = new District();
			district.setId(Integer.parseInt(request.getParameter("id")));
			if(district.deleteData()>0) {
				session.setAttribute("message", "District Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting District");
			}			
			logger.info("Exit  ActionServlet :: doGet()::deleteDistrict");
			response.setStatus(302);
			response.setHeader("Location", "district.jsp");
		}
		if (todo.equals("deleteServiceFromScheme")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteServiceFromScheme");
			SchemeService schemeService = new SchemeService();
			schemeService.setId(Integer.parseInt(request.getParameter("id")));
			int scheme_id = schemeService.getSchemeIdbyId(Integer
					.parseInt(request.getParameter("id")));
			if(schemeService.deleteSchemeService()>0) {
				session.setAttribute("message", "Sevice From Scheme Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting Sevice From Scheme");
			}
			
			logger.info("Exit  ActionServlet :: doGet()::deleteServiceFromScheme");
			response.setStatus(302);
			response.setHeader("Location", "scheme.jsp?scheme_id=" + scheme_id);
		}
		if (todo.equals("deleteEstimate")) {
			logger.info("Inside  ActionServlet :: doGet()::deleteEstimate");
			int client_id = 0;
			estimate = new Estimate();
			estimate.setId(Integer.parseInt(request.getParameter("id")));			
			
			if(estimate.deleteEstimate()>0) {
				session.setAttribute("message", "Estimate Deleted Sucessfully");
			}else {
				session.setAttribute("message", "Error Deleting Estimate");
			}
			client_id = estimate.getClientIdByEstimateId(Integer
					.parseInt(request.getParameter("id")));
			logger.info("Exit  ActionServlet :: doGet()::deleteEstimate");
			response.setStatus(302);
			response.setHeader("Location", "client.jsp?cid=" + client_id);
		}
		if (todo.equals("getServiceLov")) {
			logger.info("Inside  ActionServlet :: doGet()::getServiceLov");
			block140: {
				int eid = Integer.parseInt(request.getParameter("eid"));
				System.out.println(eid);
				estimate = new Estimate();
				int scheme_id = estimate.getSchemeIDByEstimateId(eid);
				out.println("<option value=''>Select Service</option>");
				try {
					con = DBUtility.getConnection();
					String sql22 = "SELECT `services`.`id`,`services`.`name` FROM `services`,`scheme_service`,`scheme` where  `scheme_service`.`service_id`=`services`.`id` and  `scheme_service`.`scheme_id`=`scheme`.`id` and `scheme`.`id`="
							+ scheme_id + " ORDER by name";
					System.out.println(sql22);
					st = con.prepareStatement(sql22);
					res = st.executeQuery(sql22);
					while (res.next()) {
						out.println("<option value=" + res.getString("id")
								+ ">" + res.getString("name") + "</option>");
					}
				} catch (SQLException s) {
					s.printStackTrace();
					DBUtility.closeConnection(con, st, res);
					break block140;
				} catch (NamingException e) {
					e.printStackTrace();
					break block140;
				} catch (Exception e2) {
					e2.printStackTrace();
					DBUtility.closeConnection(con, st, res);
					break block140;
				} finally {
					DBUtility.closeConnection(con, st, res);
				}

			}
			logger.info("Exit  ActionServlet :: doGet()::getServiceLov");
			out.close();
		}
		if (todo.equals("getServiceLov5")) {
			logger.info("Inside  ActionServlet :: doGet()::getServiceLov5");
			block141: {
				String eid = request.getParameter("eid");
				out.println("<option value=''>Select Service</option>");
				try {
					con = DBUtility.getConnection();
					sql3 = "SELECT `services`.`id`,`services`.`name` FROM `services`,`scheme_service`,`scheme` where  `scheme_service`.`service_id`=`services`.`id` and  `scheme_service`.`scheme_id`=`scheme`.`id` and `scheme`.`id`="
							+ eid + " ORDER by name";
					System.out.println(sql3);
					st = con.prepareStatement(sql3);
					res = st.executeQuery(sql3);
					while (res.next()) {
						out.println("<option value=" + res.getString("id")
								+ ">" + res.getString("name") + "</option>");
					}
				} catch (SQLException s) {
					s.printStackTrace();
					DBUtility.closeConnection(con, st, res);
					break block141;
				} catch (NamingException e) {
					e.printStackTrace();
					break block141;
				} catch (Exception e) {
					e.printStackTrace();

					DBUtility.closeConnection(con, st, res);
					break block141;
				} finally {
					DBUtility.closeConnection(con, st, res);
				}

			}
			logger.info("Exit  ActionServlet :: doGet()::getServiceLov5");
			out.close();
		}
		if (todo.equals("getSchemeLov")) {
			logger.info("Inside  ActionServlet :: doGet()::getSchemeLov");
			block142: {
				ArrayList arr = new ArrayList();
				int cid = Integer.parseInt(request.getParameter("cid"));
				out.println("<option value=''>Select Scheme</option>");
				try {
					con = DBUtility.getConnection();
					String sql4 = "SELECT id,date_created,scheme_id,CONCAT((select  scheme_name   from scheme  where id=scheme_id),'  [',amount,']') as scheme FROM `estimate` WHERE  client_id ="
							+ cid;
					st = con.prepareStatement(sql4);
					res = st.executeQuery(sql4);
					while (res.next()) {
						out.println("<option value=" + res.getString("id")
								+ "_" + res.getString("scheme_id") + "_"
								+ res.getString("date_created") + ">"
								+ res.getString("scheme") + "</option>");
					}
				} catch (SQLException s) {
					s.printStackTrace();
					DBUtility.closeConnection(con, st, res);
					break block142;
				} catch (NamingException e) {
					e.printStackTrace();
					break block142;
				} catch (Exception e) {
					e.printStackTrace();
					DBUtility.closeConnection(con, st, res);
					break block142;
				}

				finally {
					DBUtility.closeConnection(con, st, res);
				}

			}
			logger.info("Exit  ActionServlet :: doGet()::getSchemeLov");
			out.close();
		}
		if (todo.equals("getChildScheme")) {
			logger.info("Inside  ActionServlet :: doGet()::getChildScheme");
			block143: {
				int selectedchild = Integer.parseInt(request
						.getParameter("selectedchild"));
				String option = "";
				int parent = Integer.parseInt(request.getParameter("parent"));
				try {
					con = DBUtility.getConnection();
					sql2 = "SELECT * FROM `scheme` WHERE   status =1 and parent="
							+ parent + " order by scheme_name";
					st = con.prepareStatement(sql2);
					res = st.executeQuery(sql2);
					int i = 0;
					option = "<select name='scheme_child_id' id='scheme_child_id'\tclass='uniformselect' required='required' onchange=getServiceList('1')>";
					while (res.next()) {
						++i;
						option = String.valueOf(option) + "<option ";
						if (res.getInt("id") == selectedchild) {
							option = String.valueOf(option)
									+ "selected=selected";
						}
						option = String.valueOf(option) + " value="
								+ res.getString("id") + ">"
								+ res.getString("scheme_name") + "</option>";
					}
					option = String.valueOf(option) + "</select>";
					if (i == 0) {
						option = "";
					}
					System.out.println(option);
					out.println(option);
				} catch (SQLException s) {
					s.printStackTrace();
					DBUtility.closeConnection(con, st, res);
					break block143;
				} catch (NamingException e) {
					e.printStackTrace();
					break block143;
				} catch (Exception e) {
					e.printStackTrace();

					DBUtility.closeConnection(con, st, res);
					break block143;
				}

				finally {
					DBUtility.closeConnection(con, st, res);
				}

			}
			logger.info("Exit  ActionServlet :: doGet()::getChildScheme");
			out.close();
		}
		if (todo.equals("getChildScheme5")) {
			logger.info("Inside  ActionServlet :: doGet()::getChildScheme5");
			block144: {
				int selectedchild = Integer.parseInt(request
						.getParameter("selectedchild"));
				String option2 = "";
				int parent = Integer.parseInt(request.getParameter("parent"));
				try {
					con = DBUtility.getConnection();
					sql2 = "SELECT * FROM `scheme` WHERE   status =1 and parent="
							+ parent + " order by scheme_name";
					st = con.prepareStatement(sql2);
					res = st.executeQuery(sql2);
					int i = 0;
					option2 = "<select name='scheme_child_id' id='scheme_child_id' style='width: 120px;' required='required' onchange=loadChildSchemeService()>";
					while (res.next()) {
						++i;
						option2 = String.valueOf(option2) + "<option ";
						if (res.getInt("id") == selectedchild) {
							option2 = String.valueOf(option2)
									+ "selected=selected";
						}
						option2 = String.valueOf(option2) + " value="
								+ res.getString("id") + ">"
								+ res.getString("scheme_name") + "</option>";
					}
					option2 = String.valueOf(option2) + "</select>";
					if (i == 0) {
						option2 = "";
					}
					System.out.println(option2);
					out.println(option2);
				} catch (SQLException s) {
					s.printStackTrace();
					DBUtility.closeConnection(con, st, res);
					break block144;
				} catch (NamingException e) {
					e.printStackTrace();
					break block144;
				} catch (Exception e) {
					e.printStackTrace();

					DBUtility.closeConnection(con, st, res);
					break block144;
				}

				finally {
					DBUtility.closeConnection(con, st, res);
				}

			}
			logger.info("Exit  ActionServlet :: doGet()::getChildScheme5");
			out.close();
		}
		if (todo.equals("getBankList")) {
			logger.info("Inside  ActionServlet :: doGet()::");
			block145: {
				try {
					con = DBUtility.getConnection();
					sql = "SELECT * FROM `bank` WHERE  status =1 order by bank_name";
					st = con.prepareStatement(sql);
					res = st.executeQuery(sql);
					while (res.next()) {
						out.println("<option  value=" + res.getString("id")
								+ ">" + res.getString("bank_name") + " ["
								+ res.getString("address") + "]</option>");
					}
				} catch (SQLException s) {
					s.printStackTrace();
					DBUtility.closeConnection(con, st, res);
					break block145;
				} catch (NamingException e) {
					e.printStackTrace();
					break block145;
				} catch (Exception e) {
					e.printStackTrace();

					DBUtility.closeConnection(con, st, res);
					break block145;
				}

				finally {
					DBUtility.closeConnection(con, st, res);
				}

			}
			logger.info("Exit  ActionServlet :: doGet()::");
			out.close();
		}
		if (todo.equals("getBankListWI")) {
			logger.info("Inside  ActionServlet :: doGet()::getBankListWI");
			block146: {
				try {
					con = DBUtility.getConnection();
					sql = "SELECT * FROM `bank` WHERE  status =1";
					st = con.prepareStatement(sql);
					res = st.executeQuery(sql);
					String id = "";
					String sid = request.getParameter("sid");
					String total2 = "";
					while (res.next()) {
						id = res.getString("id");
						total2 = sid.equals(id) ? String.valueOf(total2)
								+ "<option selected='selected' value=" + id
								+ " >" + res.getString("bank_name") + " ["
								+ res.getString("address") + "]</option>"
								: String.valueOf(total2) + "<option  value="
										+ id + ">" + res.getString("bank_name")
										+ " [" + res.getString("address")
										+ "]</option>";
						out.println(total2);
					}
				} catch (SQLException s) {
					s.printStackTrace();
					DBUtility.closeConnection(con, st, res);
					break block146;
				} catch (NamingException e) {
					e.printStackTrace();
					break block146;
				} catch (Exception e) {
					e.printStackTrace();

					DBUtility.closeConnection(con, st, res);
					break block146;
				}

				finally {
					DBUtility.closeConnection(con, st, res);
				}

			}
			logger.info("Exit  ActionServlet :: doGet()::getBankListWI");
			out.close();
		}
		if (todo.equals("getOnOrderStatus")) {
			logger.info("Inside  ActionServlet :: doGet()::getOnOrderStatus");
			block147: {
				try {
					con = DBUtility.getConnection();
					Estimate estimate2 = new Estimate();
					Expenses expenses2 = new Expenses();
					Payment payment = new Payment();
					out.println("<table width=100% id='account_status'><tr><th>Total Estimate</th><th>Total Received</th><th>Total Ordered</th></tr><tr><td><input type='text' name='total_estimate' id='total_estimate' readonly value='"
							+ String.format("%.2f", estimate2
									.getAmountByEstimateId(Integer
											.parseInt(request
													.getParameter("eid"))))
							+ "'></td><td><input type='text' name='total_received' id='total_received' readonly value='"
							+ payment
									.getTotalAmountReceivedByEstimateId(Integer
											.parseInt(request
													.getParameter("eid")))
							+ "'></td>"
							+ "<td><input type='text' name='total_ordered' id='total_ordered' readonly value='"
							+ String.format("%.2f", expenses2
									.getTotalOrderedByExpId(Integer
											.parseInt(request
													.getParameter("eid"))))
							+ "'></td></tr></table>");
				} catch (SQLException s) {
					s.printStackTrace();
					DBUtility.closeConnection(con, st, res);
					break block147;
				} catch (NamingException e) {
					e.printStackTrace();
					break block147;
				} catch (Exception e) {
					e.printStackTrace();

					DBUtility.closeConnection(con, st, res);
					break block147;
				}

				finally {
					DBUtility.closeConnection(con, st, res);
				}

			}
			logger.info("Exit  ActionServlet :: doGet()::getOnOrderStatus");
			out.close();
		}
		if (todo.equals("getSupplierLov")) {
			logger.info("Inside  ActionServlet :: doGet()::getSupplierLov");
			block148: {
				int serviceid = 0;
				if (request.getParameter("serviceid") != null) {
					serviceid = Integer.parseInt(request
							.getParameter("serviceid"));
				}
				sql3 = null;
				try {
					con = DBUtility.getConnection();
					sql3 = serviceid > 0 ? "SELECT supplier.id,supplier.company_name,service_supplier.service_id FROM `supplier`,`service_supplier` WHERE service_supplier.supplier_id = supplier.id and  service_supplier.service_id="
							+ serviceid
							: "SELECT supplier.id,supplier.company_name,service_supplier.service_id FROM `supplier`,`service_supplier` WHERE service_supplier.supplier_id = supplier.id ";
					st = con.prepareStatement(sql3);
					res = st.executeQuery(sql3);
					while (res.next()) {
						out.println("<option value=" + res.getString("id")
								+ ">" + res.getString("company_name")
								+ "</option>");
					}
				} catch (SQLException s) {
					s.printStackTrace();
					DBUtility.closeConnection(con, st, res);
					break block148;
				} catch (NamingException e) {
					e.printStackTrace();
					break block148;
				} catch (Exception e) {
					e.printStackTrace();

					DBUtility.closeConnection(con, st, res);
					break block148;
				}

				finally {
					DBUtility.closeConnection(con, st, res);
				}

			}
			logger.info("Exit  ActionServlet :: doGet()::getSupplierLov");
			out.close();
		}
		if (todo.equals("getPermissionByRoleId")) {
			logger.info("Inside  ActionServlet :: doGet()::getPermissionByRoleId");
			block149: {
				int roleId = 0;
				if (request.getParameter("roleId") != null) {
					roleId = Integer.parseInt(request
							.getParameter("roleId"));
				}
				sql3 = null;
				try {
					con = DBUtility.getConnection();
					sql3 = "SELECT permission FROM `rolepermissions`  WHERE roleId="
							+ roleId;
							
					st = con.prepareStatement(sql3);
					res = st.executeQuery(sql3);
					while (res.next()) {
						out.print(res.getString("permission")+",");
					}
				} catch (SQLException s) {
					s.printStackTrace();
					DBUtility.closeConnection(con, st, res);
					break block149;
				} catch (NamingException e) {
					e.printStackTrace();
					break block149;
				} catch (Exception e) {
					e.printStackTrace();

					DBUtility.closeConnection(con, st, res);
					break block149;
				}

				finally {
					DBUtility.closeConnection(con, st, res);
				}

			}
			logger.info("Exit  ActionServlet :: doGet()::getPermissionByRoleId");
			out.close();
		}
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		logger.info("Inside  ActionServlet :: doPost()::");
		PoliceStation policeStation;
		AddRole addRole;
		AddUser addUser;
		OfficeExpenses officeExp;
		PropertyDetails propertyDetails;
		Payment payment;
		ExpensesPayment expPayment;
		Estimate estimate;
		Expenses expenses;
		Bank bank;
		Scheme scheme;
		Client client;
		Mouja mouja;
		Supplier supplier;
		District district;
		Municipality municipality;
		String todo = request.getParameter("todo");
		String rec = request.getParameter("recipient");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		Gst gst;
		HttpSession session = null;
		session = request.getSession(true);
		if (todo.equals("login")) {
			logger.info("Inside  ActionServlet :: doPost()::login");
			User user = new User();
			user.setUserid(request.getParameter("username"));
			user.setPassswd(request.getParameter("password"));
			 
			System.out.println(String.valueOf(request.getParameter("username"))
					+ ":" + request.getParameter("password"));
			int id = user.Login(request.getParameter("username"),
					request.getParameter("password"));
			String UName = user.getLoginUserName(id);
			String pagename = null;
			if (id == 0) {
				pagename = "index.html";
			} else {
				ArrayList<String> permissions = user.getPermission(id);
				System.out.println(permissions.toString());
				session.setAttribute("id", id);
				session.setAttribute("permissions", permissions);
				session.setAttribute("userName", UName.toString());
				UserLog userLog = new UserLog();
				userLog.setUserId(id);
				userLog.addData();
				pagename = "dashboard.jsp";
			}
			logger.info("Exit  ActionServlet :: doPost()::login");
			response.setStatus(302);
			response.setHeader("Location", pagename);
			out.close();
		}
		if (todo.equals("updateGstNo")) {
			logger.info("Inside  ActionServlet :: doGet()::updateInvestor");
			gst = new Gst();
			gst.setGstNo(request.getParameter("gstNo"));
					
			
			try {
				if(gst.updateGstNo()>0) {
					session.setAttribute("message", "GST Updated Sucessfully");
				}else {
					session.setAttribute("message", "Error Updating GST");
				}
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doGet()::updateGstNo");
			response.setStatus(302);
			response.setHeader("Location", "gst.jsp");
			out.close();
		}
		if (todo.equals("updateGstAmount")) {
			logger.info("Inside  ActionServlet :: doGet()::updateGstAmount");
			gst = new Gst();
			gst.setGst_value(Integer.parseInt(request.getParameter("gst_amount")));
			gst.setScheme_id(Integer.parseInt(request.getParameter("schema_id")));
			if(gst.updateGstValue()>0) {
				session.setAttribute("message", "GST Detail Updated Sucessfully");
			} else {
				session.setAttribute("message", "Error Updating GST Detail");
			}
			logger.info("Exit  ActionServlet :: doGet()::updateGstAmount");
			response.setStatus(302);
			response.setHeader("Location", "gst.jsp");
			out.close();
		}
		if (todo.equals("addClient")) {
			logger.info("Inside  ActionServlet :: doPost()::addClient");
			client = new Client();
			client.setClientName(request.getParameter("name"));
			client.setState_name(request.getParameter("stateName"));
			client.setMrMs(request.getParameter("mr_ms"));
			client.setGuardianRelation(request.getParameter("gar_rel"));
			client.setGuardianName(request.getParameter("gar_name"));
			client.setPresentAddress(request.getParameter("present_addr"));
			client.setPermanentAddress(request.getParameter("per_addr"));
			client.setMunicipality(Integer.parseInt(request
					.getParameter("municipality")));
			client.setWordNo(request.getParameter("word_no"));
			client.setMobile(request.getParameter("mobile_no"));
			client.setLand(request.getParameter("land_no"));
			client.setDateCreated(request.getParameter("datecreated"));
			client.setAssociatedDeveloperId(Integer.parseInt(request.getParameter("developer")));
			if (request.getParameter("ref").isEmpty()) {
				client.setRef(0);
			} else {
				client.setRef(Integer.parseInt(request.getParameter("ref")));
			}
			client.setEmail(request.getParameter("email"));
			client.setEmail1(request.getParameter("email1"));
			try {
				if(client.addData()>0) {
					session.setAttribute("message", "Client Added Sucessfully");
				}				
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			int max = client.getMaxId();
			logger.info("Exit  ActionServlet :: doPost()::addClient");
			response.setStatus(302);
			response.setHeader("Location", "client.jsp?cid=" + max);
			out.close();
		}
		if (todo.equals("addClientProperty")) {
			logger.info("Inside  ActionServlet :: doPost()::addClientProperty");
			propertyDetails = new PropertyDetails();
			propertyDetails
					.setCid(Integer.parseInt(request.getParameter("cid")));
			propertyDetails.setMouja(request.getParameter("mouja"));
			propertyDetails.setDag_no(request.getParameter("dag_no"));
			propertyDetails.setKhatian_no(request.getParameter("khatian"));
			propertyDetails.setJl_no(request.getParameter("jl_no"));
			propertyDetails.setTouji_no(request.getParameter("touji"));
			propertyDetails.setWord_no(request.getParameter("word"));
			propertyDetails.setPolice_station(Integer.parseInt(request
					.getParameter("police")));
			propertyDetails.setDistrict(Integer.parseInt(request
					.getParameter("district")));
			propertyDetails.setBigha(Double.parseDouble(request
					.getParameter("bigha")));
			propertyDetails.setKatha(Double.parseDouble(request
					.getParameter("katha")));
			propertyDetails.setChatak(Double.parseDouble(request
					.getParameter("chatak")));
			propertyDetails.setSq_ft(Double.parseDouble(request
					.getParameter("sq_ft")));
			propertyDetails.setTotal_sq_ft(Double.parseDouble(request
					.getParameter("total_sq_ft")));
			propertyDetails.setTotal_sq_mtr(Double.parseDouble(request
					.getParameter("total_sq_mtr")));
			propertyDetails.setDate_of_deposit(request
					.getParameter("date_of_deposit"));
			propertyDetails.setDate_of_sanction(request
					.getParameter("date_of_sanction"));
			propertyDetails.setRemarks(request.getParameter("remarks"));
			try {
				if(propertyDetails.addData()>0){
					session.setAttribute("message", "Client Property  Added");
				} else{
					session.setAttribute("message", "Error in Adding client Property");
				}
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doPost()::addClientProperty");
			response.setStatus(302);
			response.setHeader("Location",
					"client.jsp?cid=" + request.getParameter("cid"));
			out.close();
		}
		if (todo.equals("updateClientProperty")) {
			logger.info("Inside  ActionServlet :: doPost()::updateClientProperty");
			propertyDetails = new PropertyDetails();
			propertyDetails
					.setCid(Integer.parseInt(request.getParameter("cid")));
			propertyDetails.setMouja(request.getParameter("mouja"));
			propertyDetails.setDag_no(request.getParameter("dag_no"));
			propertyDetails.setKhatian_no(request.getParameter("khatian"));
			propertyDetails.setJl_no(request.getParameter("jl_no"));
			propertyDetails.setTouji_no(request.getParameter("touji"));
			propertyDetails.setWord_no(request.getParameter("word"));
			propertyDetails.setPolice_station(Integer.parseInt(request
					.getParameter("police")));
			propertyDetails.setDistrict(Integer.parseInt(request
					.getParameter("district")));
			propertyDetails.setBigha(Double.parseDouble(request
					.getParameter("bigha")));
			propertyDetails.setKatha(Double.parseDouble(request
					.getParameter("katha")));
			propertyDetails.setChatak(Double.parseDouble(request
					.getParameter("chatak")));
			propertyDetails.setSq_ft(Double.parseDouble(request
					.getParameter("sq_ft")));
			propertyDetails.setTotal_sq_ft(Double.parseDouble(request
					.getParameter("total_sq_ft")));
			propertyDetails.setTotal_sq_mtr(Double.parseDouble(request
					.getParameter("total_sq_mtr")));
			propertyDetails.setDate_of_deposit(request
					.getParameter("date_of_deposit"));
			propertyDetails.setDate_of_sanction(request
					.getParameter("date_of_sanction"));
			propertyDetails.setRemarks(request.getParameter("remarks"));
			try {
				if(propertyDetails.updateData()>0) {
					session.setAttribute("message", "Client Property  Updated");
				}else {
					session.setAttribute("message", "Error in updating client Property");
				}
				
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doPost()::updateClientProperty");
			response.setStatus(302);
			response.setHeader("Location",
					"client.jsp?cid=" + request.getParameter("cid"));
			out.close();
		}
		if (todo.equals("addMunicipality")) {
			logger.info("Inside  ActionServlet :: doPost()::addMunicipality");
			municipality = new Municipality();
			municipality.setMunicipalityName(request.getParameter("m_name"));
			municipality.setStatus(Integer.parseInt(request
					.getParameter("m_status")));
			if(municipality.addData()>0) {
				session.setAttribute("message", "Municipalty Added Successfully");
			}else {
				session.setAttribute("message", "Error in  Adding Municipalty");
			}
			
			logger.info("Exit  ActionServlet :: doPost()::addMunicipality");
			response.setStatus(302);
			response.setHeader("Location", "municipality.jsp");
			out.close();
		}
		if (todo.equals("addDistrict")) {
			logger.info("Inside  ActionServlet :: doPost()::addDistrict");
			district = new District();
			district.setDistrictName(request.getParameter("district_name"));
			if(district.addNew()>0) {
				session.setAttribute("message", "District Added Successfully");
			}else {
				session.setAttribute("message", "Error in  Adding District");
			}
		
			logger.info("Exit  ActionServlet :: doPost()::addDistrict");
			response.setStatus(302);
			response.setHeader("Location", "district.jsp");
			out.close();
		}
		if (todo.equals("addPoliceStation")) {
			logger.info("Inside  ActionServlet :: doPost()::addPoliceStation");
			policeStation = new PoliceStation();
			policeStation.setPoliceStationName(request
					.getParameter("police_station_name"));
			policeStation.setAddress(request
					.getParameter("police_station_address"));
			if(policeStation.addNew()>0) {
				session.setAttribute("message", "Police Station Added Successfully");
			}else {
				session.setAttribute("message", "Error in  Adding Police Station");
			}			
			logger.info("Exit  ActionServlet :: doPost()::addPoliceStation");
			response.setStatus(302);
			response.setHeader("Location", "police_station.jsp");
			out.close();
		}
		if (todo.equals("addRole")) {
			logger.info("Inside  ActionServlet :: doPost()::addRole");
			addRole = new AddRole();
			addRole.setRole(request
					.getParameter("roleName"));
			addRole.setRoleDescription(request
					.getParameter("roleDescription"));
			if(addRole.addNew()>0) {
				session.setAttribute("message", "New Role Added Successfully");
			}else {
				session.setAttribute("message", "Error in  Adding New Role");
			}			
			logger.info("Exit  ActionServlet :: doPost()::addRole");
			response.setStatus(302);
			response.setHeader("Location", "user_management.jsp");
			out.close();
		}
		if (todo.equals("addUser")) {
			logger.info("Inside  ActionServlet :: doPost()::addUser");
			addUser = new AddUser();
			addUser.setUserid(request
					.getParameter("userName"));
			addUser.setPassword(request
					.getParameter("password"));
			addUser.setName(request
					.getParameter("userName"));
			addUser.setEmail(request
					.getParameter("emailId"));
			addUser.setRole(Integer.parseInt(request
					.getParameter("role")));
			addUser.setMobileNo(request
					.getParameter("mobileNumber"));
			addUser.setAddress(request
					.getParameter("address"));
			int returnVal = addUser.addData();
			if(returnVal>0 && returnVal != 99) {
				session.setAttribute("message", "New User Added Successfully");
			}else if(returnVal == 99) {
				session.setAttribute("message", "Error::UserId already exist..");
			}else {
				session.setAttribute("message", "Error in  Adding New User");
			}			
			logger.info("Exit  ActionServlet :: doPost()::addUser");
			response.setStatus(302);
			response.setHeader("Location", "user_management.jsp");
			out.close();
		}
		if (todo.equals("addRolePermission")) {
			logger.info("Inside  ActionServlet :: doPost()::addRolePermission");
			String[] checkedIds = request.getParameterValues("permissionPage");
			int roleId = Integer.parseInt(request
					.getParameter("roleId"));
			String permissions = Arrays.toString(checkedIds);
			System.out.println("Roles::::"+permissions);
			addUser = new AddUser();
			
			if(addUser.addRolePermission(roleId, checkedIds)>0) {
				session.setAttribute("message", "Role Permission Updated Successfully");
			}else {
				session.setAttribute("message", "Error in  Updating Role Permission");
			}	
			logger.info("Exit  ActionServlet :: doPost()::addRolePermission");
			response.setStatus(302);
			response.setHeader("Location", "user_management.jsp");
			out.close();
		}
		
		if (todo.equals("updateUser")) {
			logger.info("Inside  ActionServlet :: doPost()::updateUser");
			addUser = new AddUser();
			addUser.setId(Integer.parseInt(request
					.getParameter("user_id")));
			addUser.setUserid(request
					.getParameter("name"));
			addUser.setPassword(request
					.getParameter("password"));
			addUser.setName(request
					.getParameter("userName"));
			addUser.setEmail(request
					.getParameter("emailId"));
			addUser.setRole(Integer.parseInt(request
					.getParameter("role")));
			addUser.setMobileNo(request
					.getParameter("mobileNumber"));
			addUser.setAddress(request
					.getParameter("address"));
			int returnVal = addUser.updateData();
			if(returnVal>0) {
				session.setAttribute("message", "User Updated Successfully");
			} else 	{
				session.setAttribute("message", "Error in  Updating User");
			}			
			logger.info("Exit  ActionServlet :: doPost()::updateUser");
			response.setStatus(302);
			response.setHeader("Location", "user_management.jsp");
			out.close();
		}
		if (todo.equals("editPoliceStation")) {
			logger.info("Inside  ActionServlet :: doPost()::editPoliceStation");
			policeStation = new PoliceStation();
			policeStation.setId(Integer.parseInt(request.getParameter("id")));
			policeStation.setPoliceStationName(request
					.getParameter("police_station_name"));
			policeStation.setAddress(request
					.getParameter("police_station_address"));
			if(policeStation.updateData()>0) {
				session.setAttribute("message", "Police Station Updated Successfully");
			}else {
				session.setAttribute("message", "Error in  Updating Police Station");
			}			
			logger.info("Exit  ActionServlet :: doPost()::editPoliceStation");
			response.setStatus(302);
			response.setHeader("Location", "police_station.jsp");
			out.close();
		}
		if (todo.equals("addMouja")) {
			logger.info("Inside  ActionServlet :: doPost()::addMouja");
			mouja = new Mouja();
			mouja.setMoujaName(request.getParameter("mouja_name"));
			mouja.setStatus(1);
			if(mouja.addNew()>0) {
				session.setAttribute("message", "Mouja Added Successfully");
			}else {
				session.setAttribute("message", "Error in  Adding Mouja");
			}
			
			logger.info("Exit  ActionServlet :: doPost()::addMouja");
			response.setStatus(302);
			response.setHeader("Location", "mouja.jsp");
			out.close();
		}
		if (todo.equals("editMouja")) {
			logger.info("Inside  ActionServlet :: doPost()::editMouja");
			mouja = new Mouja();
			mouja.setMoujaName(request.getParameter("mouja_name"));
			mouja.setId(Integer.parseInt(request.getParameter("id")));
			if(mouja.updateData()>0) {
				session.setAttribute("message", "Mouja Updated Successfully");
			}else {
				session.setAttribute("message", "Error in  Updating Mouja");
			}			
			logger.info("Exit  ActionServlet :: doPost()::editMouja");
			response.setStatus(302);
			response.setHeader("Location", "mouja.jsp");
			out.close();
		}
		if (todo.equals("editPayment")) {
			logger.info("Inside  ActionServlet :: doPost()::editPayment");
			payment = new Payment();
			payment.setId(Integer.parseInt(request.getParameter("paymentId")));
			payment.setAmountReceived(Double.valueOf(Double.parseDouble(request
					.getParameter("amount_rcv"))));
			payment.setPaymentMethod(request.getParameter("payment_method"));
			if (request.getParameter("bank_list") != null) {
				payment.setBankid(Integer.parseInt(request
						.getParameter("bank_list")));
			}
			payment.setChequeNo(request.getParameter("cheque_no"));
			payment.setDateReceived(request.getParameter("datecreated"));
			
			String addGst = request.getParameter("addGST");
			payment.setAddGst(addGst);
			payment.setGstPercentage(Integer.parseInt(request.getParameter("gstPercentage")));
			if(addGst.equalsIgnoreCase("yes")){
				payment.setGstAmount(Double.parseDouble(request.getParameter("gstAmountRec")));				
			} else {
				payment.setGstAmount(0.00);				
			}
			if(payment.updateData()>0) {
				session.setAttribute("message", "Payment Updated Successfully");
			}else {
				session.setAttribute("message", "Error in  Updating Payment");
			}	
			
			logger.info("Exit  ActionServlet :: doPost()::editPayment");
			response.setStatus(302);
			response.setHeader("Location",
					"client.jsp?cid=" + request.getParameter("cid"));
			out.close();
		}
		if (todo.equals("addOfficeExpenses")) {
			logger.info("Inside  ActionServlet :: doPost()::addOfficeExpenses");
			officeExp = new OfficeExpenses();
			officeExp.setExpensesName(Integer.parseInt(request
					.getParameter("exp_for")));
			officeExp.setExpensesDesc(request.getParameter("exp_desc"));
			officeExp.setAmount(Double.parseDouble(request
					.getParameter("amount")));
			officeExp.setDateTime(request.getParameter("datecreated"));
			officeExp.setChequeNo(request.getParameter("cq_no"));
			officeExp.setBankId(Integer.parseInt(request.getParameter("bank")));
			officeExp
					.setUserId(Integer.parseInt(request.getParameter("userid")));
			try {
				if(officeExp.addData()>0) {
					session.setAttribute("message", "Office Expenses Added Successfully");
				}else {
					session.setAttribute("message", "Error in  Adding Office Expenses");
				}
				
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doPost()::addOfficeExpenses");
			response.setStatus(302);
			response.setHeader("Location", "office_expenses.jsp");
			out.close();
		}
		if (todo.equals("addBank")) {
			logger.info("Inside  ActionServlet :: doPost()::addBank");
			bank = new Bank();
			bank.setBankName(request.getParameter("bank_name"));
			bank.setAddress(request.getParameter("bank_address"));
			if(bank.addData()>0) {
				session.setAttribute("message", "Bank Added Successfully");
			} else {
				session.setAttribute("message", "Error in Adding bank");
			}
			logger.info("Exit  ActionServlet :: doPost()::addBank");
			response.setStatus(302);
			response.setHeader("Location", "bank.jsp");
			out.close();
		}
		if (todo.equals("addReference")) {
			logger.info("Inside  ActionServlet :: doPost()::addReference");
			Reference reference = new Reference();
			reference.setName(request.getParameter("r_name"));
			reference.setAddress(request.getParameter("r_addr"));
			if(reference.addData()>0) {
				session.setAttribute("message", "Reference Added Successfully");
			} else {
				session.setAttribute("message", "Error in Adding Reference");
			}			
			logger.info("Exit  ActionServlet :: doPost()::addReference");
			response.setStatus(302);
			response.setHeader("Location", "reference.jsp");
			out.close();
		}
		if (todo.equals("addSeheme")) {
			logger.info("Inside  ActionServlet :: doPost()::addSeheme");
			scheme = new Scheme();
			scheme.setSchemeName(request.getParameter("s_name"));
			scheme.setParent_scheme_id(Integer.parseInt(request
					.getParameter("parent_scheme_id")));
			if(scheme.addData()>0) {
				session.setAttribute("message", "Scheme Added Successfully");
			} else {
				session.setAttribute("message", "Error in Adding Scheme");
			}				
			logger.info("Exit  ActionServlet :: doPost()::addSeheme");
			response.setStatus(302);
			response.setHeader("Location", "scheme.jsp");
			out.close();
		}
		if (todo.equals("addOfficeExpensesItem")) {
			logger.info("Inside  ActionServlet :: doPost()::addOfficeExpensesItem");
			OfficeExpensesItem officeexpitem = new OfficeExpensesItem();
			officeexpitem.setItemName(request.getParameter("i_name"));
			if(officeexpitem.addData()>0) {
				session.setAttribute("message", "Office Expences Item Added Successfully");
			} else {
				session.setAttribute("message", "Error in Adding Office Expences Item");
			}				
			logger.info("Exit  ActionServlet :: doPost()::addOfficeExpensesItem");
			response.setStatus(302);
			response.setHeader("Location", "office_expenses_item.jsp");
			out.close();
		}
		if (todo.equals("addExpensesPayment")) {
			logger.info("Inside  ActionServlet :: doPost()::addExpensesPayment");
			expPayment = new ExpensesPayment();
			expPayment.setExpensesId(Integer.parseInt(request
					.getParameter("expid")));
			expPayment.setAmountReceived(Double.parseDouble(request
					.getParameter("amount_received")));
			expPayment.setPaymentMethod(request.getParameter("payment_method"));
			if (request.getParameter("payment_method").equals("CHEQUE")) {
				expPayment.setChequeNo(request.getParameter("cheque_no"));
				expPayment.setBankId(Integer.parseInt(request
						.getParameter("bank_list")));
			}
			expPayment.setReceivedBy(Integer.parseInt(request
					.getParameter("userid")));
			expPayment.setDatetime(request.getParameter("datecreated"));
			try {
				if(expPayment.addData()>0) {
					session.setAttribute("message", "Expenses Paid Successfully");
				} else {
					session.setAttribute("message", "Error in Adding Expenses Paid");
				}				
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doPost()::addExpensesPayment");
			response.setStatus(302);
			response.setHeader("Location",
					"client.jsp?cid=" + request.getParameter("cid"));
			out.close();
		}
		if (todo.equals("addExpensesPaymentByBill")) {
			logger.info("Inside  ActionServlet :: doPost()::addExpensesPaymentByBill");
			expPayment = new ExpensesPayment();
			String bill_number = request.getParameter("bill_number");
			expPayment.setBill_number(bill_number);
			expPayment.setPaymentMethod(request.getParameter("payment_method"));
			expPayment.setDatetime(request.getParameter("datecreated"));
			if (request.getParameter("payment_method").equals("CHEQUE")) {
				expPayment.setChequeNo(request.getParameter("cheque_no"));
				expPayment.setBankId(Integer.parseInt(request
						.getParameter("bank_list")));
			}
			expPayment.setReceivedBy(Integer.parseInt(request
					.getParameter("userid")));
			expPayment.setDatetime(request.getParameter("datecreated"));
			try {
				if(expPayment.getPaidByBillNo()>0) {
					session.setAttribute("message", "Expenses Paid By Bill Successfully");
				} else {
					session.setAttribute("message", "Error in Adding Expenses Paid By Bill");
				}
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doPost()::addExpensesPaymentByBill");
			response.setStatus(302);
			response.setHeader("Location",
					"client.jsp?cid=" + request.getParameter("cid"));
			out.close();
		}
		if (todo.equals("updateScheme")) {
			logger.info("Inside  ActionServlet :: doPost()::updateScheme");
			scheme = new Scheme();
			scheme.setId(Integer.parseInt(request.getParameter("id")));
			scheme.setSchemeName(request.getParameter("scheme_name"));
			try {
				if(scheme.updateData()>0) {
					session.setAttribute("message", "Scheme Updated Successfully");
				} else {
					session.setAttribute("message", "Error in Updating Scheme Updated");
				}
				
				session.setAttribute("message", "Scheme Updated");
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doPost()::updateScheme");
			response.setStatus(302);
			response.setHeader("Location",
					"scheme.jsp?scheme_id=" + request.getParameter("id"));
			out.close();
		}
		if (todo.equals("editOfficeExpensesItem")) {
			logger.info("Inside  ActionServlet :: doPost()::editOfficeExpensesItem");
			OfficeExpensesItem oei = new OfficeExpensesItem();
			oei.setId(Integer.parseInt(request.getParameter("id")));
			oei.setItemName(request.getParameter("i_name"));
			if(oei.updateData()>0) {
				session.setAttribute("message", "Office Expenses Item Updated Successfully");
			} else {
				session.setAttribute("message", "Error in Updating Office Expenses Item");
			}			
			logger.info("Exit  ActionServlet :: doPost()::editOfficeExpensesItem");
			response.setStatus(302);
			response.setHeader("Location", "office_expenses_item.jsp");
			out.close();
		}
		if (todo.equals("addOldService")) {
			logger.info("Inside  ActionServlet :: doPost()::addOldService");
			SchemeService schemeservice = new SchemeService();
			schemeservice.setSchemeId(Integer.parseInt(request
					.getParameter("scheme_id")));
			schemeservice.setServiceId(Integer.parseInt(request
					.getParameter("service_id")));
			if(schemeservice.addSchemeService()>0) {
				session.setAttribute("message", "Old Services Added Successfully");
			} else {
				session.setAttribute("message", "Error in Adding Old Service");
			}	
			
			logger.info("Exit  ActionServlet :: doPost()::addOldService");
			response.setStatus(302);
			response.setHeader("Location",
					"scheme.jsp?scheme_id=" + request.getParameter("scheme_id"));
			out.close();
		}
		if (todo.equals("editDistrict")) {
			logger.info("Inside  ActionServlet :: doPost()::editDistrict");
			district = new District();
			district.setId(Integer.parseInt(request.getParameter("id")));
			district.setDistrictName(request.getParameter("district_name"));
			if(district.updateData()>0) {
				session.setAttribute("message", "District Edited Successfully");
			} else {
				session.setAttribute("message", "Error in Editing District");
			}	
			
			logger.info("Exit  ActionServlet :: doPost()::editDistrict");
			response.setStatus(302);
			response.setHeader("Location", "district.jsp");
		}
		if (todo.equals("addNewService")) {
			logger.info("Inside  ActionServlet :: doPost()::addNewService");
			Service service = new Service();
			service.setName(request.getParameter("s_name"));
			service.addData();
			int service_id = service.getMaxId();
			SchemeService schemeservice = new SchemeService();
			schemeservice.setSchemeId(Integer.parseInt(request
					.getParameter("scheme_id")));
			schemeservice.setServiceId(service_id);
			if(schemeservice.addSchemeService()>0) {
				session.setAttribute("message", "Service Added Successfully");
			} else {
				session.setAttribute("message", "Error in Adding Service");
			}				
			logger.info("Exit  ActionServlet :: doPost()::addNewService");
			response.setStatus(302);
			response.setHeader("Location",
					"scheme.jsp?scheme_id=" + request.getParameter("scheme_id"));
			out.close();
		}
		if (todo.equals("addNewSupplier")) {
			logger.info("Inside  ActionServlet :: doPost()::addNewSupplier");
			supplier = new Supplier();
			supplier.setSupplierName(request.getParameter("company_name"));
			supplier.setServiceId(Integer.parseInt(request
					.getParameter("service_id")));
			supplier.setAddress(request.getParameter("addr"));
			supplier.setPhone(request.getParameter("phn"));
			supplier.setCreatedBy(Integer.parseInt(request
					.getParameter("userid")));
			if(supplier.addData()>0) {
				session.setAttribute("message", "Supplier Added Successfully");
			} else {
				session.setAttribute("message", "Error in Adding Supplier");
			}				
			logger.info("Exit  ActionServlet :: doPost()::addNewSupplier");
			response.setStatus(302);
			response.setHeader("Location",
					"scheme.jsp?scheme_id=" + request.getParameter("scheme_id"));
			out.close();
		}
		if (todo.equals("addOldSupplier")) {
			logger.info("Inside  ActionServlet :: doPost():::addOldSupplier");
			supplier = new Supplier();
			supplier.setSupplier_id(Integer.parseInt(request
					.getParameter("supplier_id")));
			supplier.setServiceId(Integer.parseInt(request
					.getParameter("service_id")));
			supplier.setCreatedBy(Integer.parseInt(request
					.getParameter("userid")));
			if(supplier.addDataServiceSupplier()>0) {
				session.setAttribute("message", "Old Supplier Added Successfully");
			} else {
				session.setAttribute("message", "Error in Adding Old Supplier");
			}			
			logger.info("Exit  ActionServlet :: doPost():::addOldSupplier");
			response.setStatus(302);
			response.setHeader("Location",
					"scheme.jsp?scheme_id=" + request.getParameter("scheme_id"));
			out.close();
		}
		if (todo.equals("updateClient")) {
			logger.info("Inside  ActionServlet :: doGet():::updateClient");
			
			client = new Client();
			client.setId(Integer.parseInt(request.getParameter("id")));
			client.setMrMs(request.getParameter("mr_ms"));
			client.setClientName(request.getParameter("name"));
			client.setGuardianRelation(request.getParameter("gar_rel"));
			client.setGuardianName(request.getParameter("gar_name"));
			client.setPresentAddress(request.getParameter("present_addr"));
			client.setPermanentAddress(request.getParameter("per_addr"));
			client.setMunicipality(Integer.parseInt(request
					.getParameter("municipality")));
			client.setWordNo(request.getParameter("word_no"));
			client.setMobile(request.getParameter("mobile_no"));
			client.setLand(request.getParameter("land_no"));
			client.setRef(Integer.parseInt(request.getParameter("ref")));
			client.setEmail(request.getParameter("email"));
			client.setEmail1(request.getParameter("email1"));
			client.setDateCreated(request.getParameter("datecreated"));
			client.setState_name(request.getParameter("stateName"));
			client.setAssociatedDeveloperId(Integer.parseInt(request.getParameter("developer")));
			try {
				if(client.updateData()>0) {
					session.setAttribute("message", "Client Updated Successfully");
				} else {
					session.setAttribute("message", "Error in Updating Old Supplier");
				}					
				session.setAttribute("message", "Client Updated");
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doGet():::updateClient");
			response.setStatus(302);
			response.setHeader("Location",
					"client.jsp?cid=" + request.getParameter("id"));
			out.close();
		}
		if (todo.equals("updateOfficeExpenses")) {
			logger.info("Inside  ActionServlet :: doPost():::updateOfficeExpenses");
			officeExp = new OfficeExpenses();
			officeExp.setId(Integer.parseInt(request.getParameter("id")));
			officeExp.setExpensesName(Integer.parseInt(request
					.getParameter("exp_for")));
			officeExp.setExpensesDesc(request.getParameter("exp_desc"));
			officeExp.setAmount(Double.parseDouble(request
					.getParameter("amount")));
			officeExp.setBankId(Integer.parseInt(request.getParameter("bank")));
			officeExp.setChequeNo(request.getParameter("cq_no"));
			officeExp.setDateTime(request.getParameter("date_time"));
			try {
				if(officeExp.updateData()>0) {
					session.setAttribute("message", "Office Expenses Updated Successfully");
				} else {
					session.setAttribute("message", "Error in Updating Office Expenses");
				}			
				
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doPost():::updateOfficeExpenses");
			response.setStatus(302);
			response.setHeader("Location", "office_expenses.jsp");
			out.close();
		}
		if (todo.equals("addEstimate")) {
			logger.info("Inside  ActionServlet :: doPost():::addEstimate");
			estimate = new Estimate();
			estimate.setClientId(Integer.parseInt(request
					.getParameter("client")));
			if (request.getParameter("scheme_child_id") == null) {
				estimate.setSchemeId(Integer.parseInt(request
						.getParameter("scheme_parent_id")));
			} else {
				estimate.setSchemeId(Integer.parseInt(request
						.getParameter("scheme_child_id")));
			}
			estimate.setAmount(Double.parseDouble(request
					.getParameter("amount")));
			estimate.setEstimateNote(request.getParameter("note"));
			estimate.setCreatedBy(Integer.parseInt(request
					.getParameter("userid")));
			estimate.setDateCreated(request.getParameter("datecreated"));
			try {
				if(estimate.addData()>0) {
					session.setAttribute("message", "Estimate Created Successfully");
				} else {
					session.setAttribute("message", "Error in Creating Estimate");
				}	
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doPost():::addEstimate");
			response.setStatus(302);
			response.setHeader("Location",
					"client.jsp?cid=" + request.getParameter("client"));
			out.close();
		}
		if (todo.equals("updateBank")) {
			logger.info("Inside  ActionServlet :: doPost():::updateBank");
			bank = new Bank();
			bank.setId(Integer.parseInt(request.getParameter("bank_id")));
			bank.setBankName(request.getParameter("bank_name"));
			bank.setAddress(request.getParameter("bank_address"));
			if(bank.updateData()>0) {
				session.setAttribute("message", "Bank Updated Successfully");
			} else {
				session.setAttribute("message", "Error in Updating Bank");
			}	
			logger.info("Exit  ActionServlet :: doPost():::updateBank");
			response.setStatus(302);
			response.setHeader("Location", "bank.jsp");
			out.close();
		}
		if (todo.equals("editExpensesPayment")) {
			logger.info("Inside  ActionServlet :: doPost():::editExpensesPayment");
			ExpensesPayment expensesPayment = new ExpensesPayment();
			expensesPayment.setId(Integer.parseInt(request
					.getParameter("payment_id")));
			expensesPayment.setAmountReceived(Double.parseDouble(request
					.getParameter("amount_received")));
			if (request.getParameter("payment_method").equals("CHEQUE")) {
				expensesPayment.setBankId(Integer.parseInt(request
						.getParameter("bank_list")));
				expensesPayment.setPaymentMethod(request
						.getParameter("payment_method"));
			}
			expensesPayment.setChequeNo(request.getParameter("cheque_no"));
			expensesPayment.setDatetime(request.getParameter("date_paid"));
			try {
				if(expensesPayment.updateData()>0) {
					session.setAttribute("message", "Payment Updated Successfully");
				} else {
					session.setAttribute("message", "Error in Updating Payment");
				}
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doPost():::editExpensesPayment");
			response.setStatus(302);
			response.setHeader("Location",
					"client.jsp?cid=" + request.getParameter("cid"));
			out.close();
		}
		if (todo.equals("updateSupplier")) {
			logger.info("Inside  ActionServlet :: doPost():::updateSupplier");
			supplier = new Supplier();
			supplier.setId(Integer.parseInt(request.getParameter("supplier_id")));
			supplier.setSupplierName(request.getParameter("company_name"));
			supplier.setAddress(request.getParameter("addr"));
			supplier.setPhone(request.getParameter("phn"));
			if(supplier.updateData()>0) {
				session.setAttribute("message", "Supplier Updated");
			} else {
				session.setAttribute("message", "Error in Supplier Updated");
			}
			
			if (request.getParameter("scheme_id").equals(null)) {
				int scheme_id = Integer.parseInt(request
						.getParameter("scheme_id"));
				response.setStatus(302);
				response.setHeader("Location", "scheme.jsp?scheme_id="
						+ scheme_id);
			} else {
				response.setStatus(302);
				response.setHeader("Location", "supplier.jsp");
			}
			logger.info("Exit  ActionServlet :: doPost():::updateSupplier");
			out.close();
		}
		if (todo.equals("editEstimate")) {
			logger.info("Inside  ActionServlet :: doPost():::editEstimate");
			estimate = new Estimate();
			estimate.setId(Integer.parseInt(request.getParameter("id")));
			estimate.setClientId(Integer.parseInt(request
					.getParameter("client")));
			if (request.getParameter("scheme_child_id") == null) {
				estimate.setSchemeId(Integer.parseInt(request
						.getParameter("scheme_parent_id")));
			} else {
				estimate.setSchemeId(Integer.parseInt(request
						.getParameter("scheme_child_id")));
			}
			estimate.setAmount(Double.parseDouble(request
					.getParameter("amount")));
			estimate.setEstimateNote(request.getParameter("note"));
			estimate.setCreatedBy(Integer.parseInt(request
					.getParameter("userid")));
			estimate.setDateCreated(request.getParameter("estimate_date"));
			try {
				if(estimate.updateData()>0) {
					session.setAttribute("message", "Estimate Updated");
				} else {
					session.setAttribute("message", "Error Estimate Updated");
				}
				
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			response.setStatus(302);
			response.setHeader("Location",
					"client.jsp?cid=" + request.getParameter("client"));
			logger.info("Exit  ActionServlet :: doPost():::editEstimate");
			out.close();
		}
		if (todo.equals("addPayment")) {
			logger.info("Inside  ActionServlet :: doPost():::addPayment");
			payment = new Payment();
			payment.setClientId(Integer.parseInt(request.getParameter("client")));
			payment.setEstimateId(Integer.parseInt(request
					.getParameter("estimateId")));
			payment.setPaymentMethod(request.getParameter("payment_method"));
			payment.setDateReceived(request.getParameter("datecreated"));
			String addGst = request.getParameter("addGST");
			payment.setAddGst(addGst);
			if(addGst.equalsIgnoreCase("yes")){
				payment.setGstAmount(Double.parseDouble(request.getParameter("gstAmountRec")));
				payment.setGstPercentage(Integer.parseInt(request.getParameter("gstPercentage")));
			} else {
				payment.setGstAmount(0.00);
				payment.setGstPercentage(0);
			}
			
			
			if (request.getParameter("payment_method").equals("CHEQUE")) {
				payment.setChequeNo(request.getParameter("cheque_no"));
				payment.setBankid(Integer.parseInt(request
						.getParameter("bank_list")));
			}
			payment.setAmountReceived(Double.valueOf(Double.parseDouble(request
					.getParameter("amount_rcv"))));
			payment.setReceivedBy(Integer.parseInt(request
					.getParameter("userid")));
			try {
				if(payment.addData()>0) {
					session.setAttribute("message", "Payment Received");
				} else {
					session.setAttribute("message", "Error in Payment Received");
				}
				
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doPost():::addPayment");
			response.setStatus(302);
			
			response.setHeader("Location",
					"client.jsp?cid=" + request.getParameter("client"));
			out.close();
		}
		if (todo.equals("addOrder")) {
			logger.info("Inside  ActionServlet :: doPost():::addOrder");
			expenses = new Expenses();
			expenses.setClientId(Integer.parseInt(request
					.getParameter("client")));
			expenses.setEstimateId(Integer.parseInt(request.getParameter(
					"estimate").split("_")[0]));
			expenses.setServices_id(Integer.parseInt(request
					.getParameter("service")));
			System.out.print(request.getParameter("service"));
			if (request.getParameter("qty").isEmpty()) {
				expenses.setQty(0.0);
			} else {
				expenses.setQty(Double.parseDouble(request.getParameter("qty")));
			}
			if (request.getParameter("per_unit_price").isEmpty()) {
				expenses.setUnitPrice(0.0);
			} else {
				expenses.setUnitPrice(Double.parseDouble(request
						.getParameter("per_unit_price")));
			}
			expenses.setTotalAmount(Double.parseDouble(request
					.getParameter("amount")));
			expenses.setSupplierId(Integer.parseInt(request
					.getParameter("supplier")));
			expenses.setBillNumber(request.getParameter("bill_number"));
			expenses.setExpDate(request.getParameter("datecreated"));
			expenses.setNote(request.getParameter("note"));
			expenses.setUserId(Integer.parseInt(request.getParameter("userid")));
			try {
				expenses.addData();
				session.setAttribute("message", "Ordered To Supplier");
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			response.setStatus(302);
			System.out.print(request.getParameter("more_item_on_bill"));
			if (request.getParameter("more_item_on_bill") == null) {
				session.setAttribute("isSuccess", "true");
				response.setHeader("Location",
						"client.jsp?cid=" + request.getParameter("client"));
			} else {
				response.setHeader(
						"Location",
						"order_more_for_same_bill.jsp?cid="
								+ request.getParameter("client")
								+ "&billno="
								+ request.getParameter("bill_number")
								+ "&supplier_id="
								+ request.getParameter("supplier")
								+ "&eid="
								+ request.getParameter("estimate")
								+ "&date="
								+ request.getParameter("datecreated")
								+ "&sid="
								+ request.getParameter("estimate").split("_")[1]);
			}
			logger.info("Exit  ActionServlet :: doPost():::addOrder");
			out.close();
		}
		if (todo.equals("updateOrder")) {
			logger.info("Inside  ActionServlet :: doPost():::updateOrder");
			expenses = new Expenses();
			expenses.setClientId(Integer.parseInt(request
					.getParameter("client")));
			expenses.setEstimateId(Integer.parseInt(request
					.getParameter("estimate")));
			if (request.getParameter("qty").isEmpty()) {
				expenses.setQty(0.0);
			} else {
				expenses.setQty(Double.parseDouble(request.getParameter("qty")));
			}
			if (request.getParameter("per_unit_price").isEmpty()) {
				expenses.setUnitPrice(0.0);
			} else {
				expenses.setUnitPrice(Double.parseDouble(request
						.getParameter("per_unit_price")));
			}
			expenses.setTotalAmount(Double.parseDouble(request
					.getParameter("amount")));
			expenses.setBillNumber(request.getParameter("bill_number"));
			expenses.setExpDate(request.getParameter("exp_date"));
			expenses.setSupplierId(Integer.parseInt(request
					.getParameter("supplier")));
			expenses.setServices_id(Integer.parseInt(request
					.getParameter("service")));
			expenses.setUserId(Integer.parseInt(request.getParameter("userid")));
			expenses.setId(Integer.parseInt(request.getParameter("exid")));
			expenses.setNote(request.getParameter("note"));
			try {
				expenses.updateData();
				session.setAttribute("message", "Order Updated");
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doPost():::updateOrder");
			response.setStatus(302);
			response.setHeader(
					"Location",
					"order_more_for_same_bill.jsp?cid="
							+ request.getParameter("client")
							+ "&billno="
							+ request.getParameter("bill_number")
							+ "&supplier_id="
							+ Integer.parseInt(request.getParameter("supplier"))
							+ "&eid="
							+ Integer.parseInt(request.getParameter("estimate"))
							+ "&date=" + request.getParameter("exp_date"));
			out.close();
		}
		if (todo.equals("editMunicipality")) {
			logger.info("Inside  ActionServlet :: doPost():::editMunicipality");
			municipality = new Municipality();
			municipality.setId(Integer.parseInt(request.getParameter("id")));
			municipality.setMunicipalityName(request.getParameter("m_name"));
			try {
				if(municipality.updateData()>0) {
					session.setAttribute("message", "Municipality Updated Successfully");
				} else {
					session.setAttribute("message", "Error Updating Municipality");
				}
				
			} catch (Exception e) {
				session.setAttribute("message", e);
			}
			logger.info("Exit  ActionServlet :: doPost():::editMunicipality");
			response.setStatus(302);
			response.setHeader("Location", "municipality.jsp");
			out.close();
		}
		if (todo.equals("addPromis")) {
			logger.info("Inside  ActionServlet :: doPost():::addPromis");
			promis bank12 = new promis();
			bank12.setPromisName(request.getParameter("mis_name"));
			if(bank12.addData()>0) {
				session.setAttribute("message", "Promis Added Sucessfully");
			}else {
				session.setAttribute("message", "Error Adding Promis");
			}
			
			logger.info("Exit  ActionServlet :: doPost():::addPromis");
			response.setStatus(302);
			response.setHeader("Location", "projectmisc.jsp");
			out.close();
		}
		System.out.println(111);
		if (todo.equals("updatepromis")) {
			logger.info("Inside  ActionServlet :: doPost():::updatepromis");
			promis bank23 = new promis();
			bank23.setId(Integer.parseInt(request.getParameter("promisid")));
			bank23.setPromisName(request.getParameter("promisname"));
			if(bank23.updatePromis()>0) {
				session.setAttribute("message", "Promis Updated Sucessfully");
			}else {
				session.setAttribute("message", "Error Updating Promis");
			}
			
			logger.info("Exit  ActionServlet :: doPost():::updatepromis");
			response.setStatus(302);
			response.setHeader("Location", "projectmisc.jsp");
			out.close();
		}
		if (todo.equals("sendMail")) {
			List<File> uploadedFiles = saveUploadedFiles(request);
			
			String recipient = request.getParameter("recipient");
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");

			String resultMessage = "";

			try {
				EmailUtility.sendEmailWithAttachment(host, port, user, pass,
						recipient, subject, content, uploadedFiles);
				
				resultMessage = "The e-mail was sent successfully";
			} catch (Exception ex) {
				ex.printStackTrace();
				resultMessage = "There were an error: " + ex.getMessage();
			} finally {
				deleteUploadFiles(uploadedFiles);
				logger.info("Exit  ActionServlet :: doPost():::updatepromis");
				response.setStatus(302);
				response.setHeader("Location", "emailSender.jsp");
				out.close();
			}
		
			
		}
	}
	/**
	 * Saves files uploaded from the client and return a list of these files
	 * which will be attached to the e-mail message.
	 */
	private List<File> saveUploadedFiles(HttpServletRequest request)
			throws IllegalStateException, IOException, ServletException {
		List<File> listFiles = new ArrayList<File>();
		byte[] buffer = new byte[4096];
		int bytesRead = -1;
		Collection<Part> multiparts = request.getParts();
		if (multiparts.size() > 0) {
			for (Part part : request.getParts()) {
				// creates a file to be saved
				String fileName = extractFileName(part);
				if (fileName == null || fileName.equals("")) {
					// not attachment part, continue
					continue;
				}
				
				File saveFile = new File(fileName);
				System.out.println("saveFile: " + saveFile.getAbsolutePath());
				FileOutputStream outputStream = new FileOutputStream(saveFile);
				
				// saves uploaded file
				InputStream inputStream = part.getInputStream();
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outputStream.write(buffer, 0, bytesRead);
				}
				outputStream.close();
				inputStream.close();
				
				listFiles.add(saveFile);
			}
		}
		return listFiles;
	}

	/**
	 * Retrieves file name of a upload part from its HTTP header
	 */
	private String extractFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		return null;
	}
	
	/**
	 * Deletes all uploaded files, should be called after the e-mail was sent.
	 */
	private void deleteUploadFiles(List<File> listFiles) {
		if (listFiles != null && listFiles.size() > 0) {
			for (File aFile : listFiles) {
				aFile.delete();
			}
		}
	}
}
