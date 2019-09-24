package com.controller;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;

import com.project.bean.Project;
import com.project.dao.ProjectDAO;

@Controller
public class ProjectServlet extends javax.servlet.http.HttpServlet {
	public ProjectServlet() {
	}

	@Override
	public void destroy() {
		super.destroy();
	}

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, java.io.IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		ProjectDAO pdao = null;
		HttpSession session = request.getSession();
		String todo = request.getParameter("todo");
		int status = 0;
		if (todo.equals("getServiceList")) {
			String scheme = request.getParameter("scheme");
			pdao = new ProjectDAO();
			ArrayList servicelist = pdao.getServiceList(scheme);
			System.out.println(servicelist);
			String str = "<select style='width:290px;' name='service_id' id='service_id' class='uniformselect' required='required' onchange=getSupplierList(this.id);><option value='' selected='selected'>Select Service</option>";
			for (int i = 0; i < ((ArrayList) servicelist.get(0)).size(); i++) {
				str = str + "<option value='"
						+ (String) ((ArrayList) servicelist.get(0)).get(i)
						+ "'>"
						+ (String) ((ArrayList) servicelist.get(1)).get(i)
						+ "</option>";
			}
			str = str + "</select>";
			System.out.println(str);
			out.print(str);
		}
		if (todo.equals("getServiceList1")) {
			String scheme = request.getParameter("scheme");
			pdao = new ProjectDAO();
			ArrayList servicelist = pdao.getServiceList(scheme);
			System.out.println(servicelist);
			String str = "<select style='width:290px;' name='service_id' id='service_id' class='uniformselect' required='required' onchange=getSupplierList(this.id);><option value='' selected='selected'>Select Service</option>";
			for (int i = 0; i < ((ArrayList) servicelist.get(0)).size(); i++) {
				str = str + "<option value='"
						+ (String) ((ArrayList) servicelist.get(0)).get(i)
						+ "_"
						+ (String) ((ArrayList) servicelist.get(1)).get(i)
						+ "'>"
						+ (String) ((ArrayList) servicelist.get(1)).get(i)
						+ "</option>";
			}
			str = str + "</select>";
			System.out.println(str);
			out.print(str);
		}

		if (todo.equals("getSupplierList")) {
			String service = request.getParameter("service");
			pdao = new ProjectDAO();
			ArrayList supplierlist = pdao.getSupplierList(service);
			String str = "<select style='width:290px;' name='supplier_id' id='supplier_id' class='uniformselect' required='required'>";
			for (int i = 0; i < ((ArrayList) supplierlist.get(0)).size(); i++) {
				str = str + "<option value='"
						+ (String) ((ArrayList) supplierlist.get(0)).get(i)
						+ "'>"
						+ (String) ((ArrayList) supplierlist.get(1)).get(i)
						+ "</option>";
			}
			str = str + "</select>";
			System.out.println(str);
			out.print(str);
		}
		if (todo.equals("getSupplierList1")) {
			String service = request.getParameter("service");
			pdao = new ProjectDAO();
			System.out.println("getSupplierList1");
			ArrayList supplierlist = pdao.getSupplierList(service);
			String str = "<select style='width:290px;' name='supplier_id' id='supplier_id' class='uniformselect' required='required'>";
			for (int i = 0; i < ((ArrayList) supplierlist.get(0)).size(); i++) {
				str = str + "<option value='"
						+ (String) ((ArrayList) supplierlist.get(0)).get(i)
						+ "_"
						+ (String) ((ArrayList) supplierlist.get(1)).get(i)
						+ "'>"
						+ (String) ((ArrayList) supplierlist.get(1)).get(i)
						+ "</option>";
			}
			str = str + "</select>";
			System.out.println(str);
			out.print(str);
		}
		if (todo.equals("fromReport")) {
			session.setAttribute("project_id", request.getParameter("proid"));
			response.setStatus(302);
			response.setHeader("Location",
					"projects.jsp?proid=" + request.getParameter("proid"));
			out.close();
		}
	}

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, java.io.IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		ProjectDAO pdao = null;
		int status = 0;
		String todo = request.getParameter("todo");

		HttpSession session = request.getSession();
		if (todo.equals("addProject")) {
			Project project = new Project();
			project.setPro_name(request.getParameter("pro_name"));
			String mr_ms = request.getParameter("mr_ms");

			String word_no = request.getParameter("word_no");
			String municipality = request.getParameter("municipality");
			String gar_rel = request.getParameter("gar_rel");
			String gar_name = request.getParameter("gar_name");
			project.setC_name(mr_ms + "." + request.getParameter("c_name"));
			project.setSite_addr(request.getParameter("site_addr"));
			project.setSite_no_floors(request.getParameter("site_no_floors"));
			project.setSite_no_units(request.getParameter("site_no_units"));
			project.setSite_details(request.getParameter("site_note"));
			project.setDate(request.getParameter("datecreated"));
			project.setGar_rel(gar_rel);
			project.setGar_name(gar_name);
			project.setMunicipality(municipality);
			project.setWord_no(word_no);
			project.setPro_typ(request.getParameter("project-type"));
			project.setMunicipality(request.getParameter("municipality"));
			project.setWord_no(request.getParameter("word_no"));
			project.setEmail1(request.getParameter("Email1"));
			project.setEmail2(request.getParameter("Email2"));
			project.setContact1(request.getParameter("Contact1"));
			project.setContact2(request.getParameter("Contact2"));
			pdao = new ProjectDAO();
			status = pdao.addProject(project);
			System.out.println(status);
			if (status > 0) {
				response.setStatus(302);
				response.setHeader("Location",
						"projects.jsp?proid=" + project.getMaxId());
				out.close();
			}
		}

		if (todo.equals("updateProjectDetails")) {
			String word_no = request.getParameter("word_no");
			String municipality = request.getParameter("municipality");
			String gar_rel = request.getParameter("gar_rel");
			String gar_name = request.getParameter("gar_name");
			Project project = new Project();
			project.setPro_name(request.getParameter("pro_name"));
			project.setC_name(request.getParameter("c_name"));
			project.setSite_addr(request.getParameter("site_addr"));
			project.setSite_no_floors(request.getParameter("site_no_floors"));
			project.setSite_no_units(request.getParameter("site_no_units"));
			project.setSite_details(request.getParameter("site_note"));
			project.setDate(request.getParameter("datecreated"));
			project.setId(session.getAttribute("project_id").toString());
			project.setPro_typ(request.getParameter("project-type"));
			project.setContact1(request.getParameter("mobile_no"));
			project.setContact2(request.getParameter("land_no"));
			project.setEmail1(request.getParameter("email"));
			project.setEmail2(request.getParameter("email1"));
			System.out.println(124 + project.getPro_typ());

			project.setGar_rel(gar_rel);
			project.setGar_name(gar_name);
			project.setMunicipality(municipality);
			project.setWord_no(word_no);
			pdao = new ProjectDAO();
			status = pdao.updateProjectDetails(project);
			System.out.println(status);
			if (status > 0) {
				response.setStatus(302);
				response.setHeader("Location",
						"projects.jsp?proid=" + project.getMaxId());
				out.close();
			}
		}

		if (todo.equals("updateInvestment")) {
			String inv_id = request.getParameter("inv_id");
			String inv_amount = request.getParameter("amount");
			String pro_amount = request.getParameter("pro_amount");
			String datecreated = request.getParameter("datecreated");

			pdao = new ProjectDAO();
			status = pdao.updateInvestment(inv_id.split("INV_00")[1],
					inv_amount, pro_amount,
					(String) session.getAttribute("project_id"), datecreated,
					"", "", "", "");
			if (status > 0) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
				out.close();
			}
		}

		if (todo.equals("appendInvestment")) {
			String inv_id = request.getParameter("inv_id");
			long inv_amount = 0L;
			long pro_amount = 0L;
			String pm = request.getParameter("payment_method");
			String no = request.getParameter("cheque_no");
			String bank_list = request.getParameter("bank_list");
			try {
				inv_amount = Long.parseLong(request.getParameter("new_amount"));
			} catch (Exception e) {
				inv_amount = 0L;
			}
			try {
				pro_amount = Long.parseLong(request
						.getParameter("new_pro_amount"));
			} catch (Exception e) {
				pro_amount = 0L;
			}
			String datecreated = request.getParameter("datecreated");
			pdao = new ProjectDAO();
			status = pdao.appendInvestment(inv_id.split("INV_00")[1],
					Long.toString(inv_amount), Long.toString(pro_amount),
					(String) session.getAttribute("project_id"), datecreated,
					pm, no, bank_list);
			if (status > 0) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
				out.close();
			}
		}

		if (todo.equals("updateInvestmentUnit")) {
			String inv_id = request.getParameter("id").split("INVST_00")[1];
			long inv_amount = 0L;
			long pro_amount = 0L;
			String pm = request.getParameter("payment_method");
			String no = request.getParameter("cheque_no");
			String bank_list = request.getParameter("bank_list");
			try {
				inv_amount = Long.parseLong(request.getParameter("amount"));
			} catch (Exception e) {
				inv_amount = 0L;
			}
			try {
				pro_amount = Long.parseLong(request.getParameter("pro_amount"));
			} catch (Exception e) {
				pro_amount = 0L;
			}
			String datecreated = request.getParameter("datecreated");
			String note = request.getParameter("note");
			pdao = new ProjectDAO();
			status = pdao.updateInvestment(inv_id, Long.toString(inv_amount),
					Long.toString(pro_amount),
					(String) session.getAttribute("project_id"), datecreated,
					note, pm, no, bank_list);
			if (status > 0) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
				out.close();
			}
		}

		if (todo.equals("addInvestment")) {
			String inv_id = request.getParameter("inv_id");
			String inv_amount = request.getParameter("amount");
			String pro_amount = request.getParameter("pro_amount");
			String date = request.getParameter("datecreated");
			String pm = request.getParameter("payment_method");
			String no = request.getParameter("cheque_no");
			String bank_list = request.getParameter("bank_list");
			pdao = new ProjectDAO();
			status = pdao.addInvestment(inv_id.split("INV_00")[1], inv_amount,
					pro_amount, (String) session.getAttribute("project_id"),
					date, pm, no, bank_list);
			if (status > 0) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
				out.close();
			}
		}

		if (todo.equals("investmentRefund")) {
			String inv_id = request.getParameter("inv_id").split("INV_00")[1];
			String inv_name = request.getParameter("inv_name");
			String amount = request.getParameter("amount");
			String pro_amount = request.getParameter("pro_amount");
			String total_amount = request.getParameter("total_amount");
			String due_amount = request.getParameter("due_amount");
			String new_amount = request.getParameter("new_amount");
			String note = request.getParameter("note");
			String pm = request.getParameter("payment_method");
			String no = request.getParameter("cheque_no");
			String bi = request.getParameter("bank_list");
			pdao = new ProjectDAO();
			long total_refunded = Long.parseLong(new_amount);
			pdao.addInvestmentRefund(
					(String) session.getAttribute("project_id"), inv_id,
					Long.toString(total_refunded),
					request.getParameter("datecreated"), note, pm, no, bi);

			response.setStatus(302);
			response.setHeader("Location",
					"projects.jsp?proid=" + session.getAttribute("project_id"));
			out.close();
		}

		if (todo.equals("addProjectExpense")) {
			String unit = request.getParameter("unit_price");
			String quantity = request.getParameter("quan");
			String supplier_id = request.getParameter("supplier_id");
			String expense_amount = request.getParameter("total_amount");
			String date = request.getParameter("date");
			String details = request.getParameter("note");
			String billno = request.getParameter("bill_no");
			String bill_status = request.getParameter("status");
			String service_id = request.getParameter("service_id");
			pdao = new ProjectDAO();
			status = pdao.addProjectExpense(supplier_id, expense_amount, date,
					(String) session.getAttribute("project_id"), details,
					billno, unit, quantity, service_id);
			try {
				if ((status > 0) && (bill_status.equals("on"))) {
					int expenseId = pdao.getMaxRow("expense_id",
							"project_expense");
					status = pdao.addPaymentRow(Integer.toString(expenseId),
							supplier_id,
							(String) session.getAttribute("project_id"), "0",
							"null", billno);
					response.setStatus(302);
					response.setHeader("Location",
							"addExpenseWithBill.jsp?sup_id=" + supplier_id
									+ "&bill_no=" + billno + "&date1=" + date);
					out.close();
				}
			} catch (Exception e) {
				int expenseId = pdao.getMaxRow("expense_id", "project_expense");

				status = pdao.addPaymentRow(Integer.toString(expenseId),
						supplier_id,
						(String) session.getAttribute("project_id"), "0",
						"null", billno);
				if (status > 0) {
					response.setStatus(302);
					response.setHeader("Location", "projects.jsp?proid="
							+ session.getAttribute("project_id"));
					out.close();
				}
			}
		}

		if (todo.equals("addProjectExpensesPaymentByBill")) {
			String sup_id = request.getParameter("sup_id");
			String bill_no = request.getParameter("bill_no");
			String date = request.getParameter("datecreated");
			String payment_method = request.getParameter("payment_method");
			String cheque_no = request.getParameter("cheque_no");
			String bank_list = request.getParameter("bank_list");
			float due_amount = 0.0F;
			pdao = new ProjectDAO();
			ArrayList expenseDetails = pdao.getExpenseListByBillNo(
					(String) session.getAttribute("project_id"), sup_id,
					bill_no);
			for (int i = 0; i < expenseDetails.size(); i++) {
				try {
					due_amount = Float
							.parseFloat((String) ((ArrayList) expenseDetails
									.get(i)).get(2))
							- Float.parseFloat((String) ((ArrayList) expenseDetails
									.get(i)).get(3));
					status = pdao
							.addFullpayment(
									(String) ((ArrayList) expenseDetails.get(i))
											.get(1),
									sup_id,
									(String) session.getAttribute("project_id"),
									Float.toString(due_amount),
									(String) ((ArrayList) expenseDetails.get(i))
											.get(3), date, bill_no,
									payment_method, cheque_no, bank_list);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (status > 0) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
				out.close();
			}
		}
		if (todo.equals("addSupplierPayment")) {
			String p_id = request.getParameter("p_id");
			String exp_id = request.getParameter("exp_id");
			String paid_amount = request.getParameter("paid_amount");
			String due_amount = request.getParameter("due_amount");
			String amount_received = request.getParameter("amount_received");
			String sup_id = request.getParameter("sup_id");
			String payment_method = request.getParameter("payment_method");
			String bank_id = request.getParameter("bank_list");
			String cheque_no = request.getParameter("cheque_no");
			String notes = request.getParameter("notes");
			String datecreated = request.getParameter("datecreated");
			try {
				pdao = new ProjectDAO();
				status = pdao.addSupplierPayment(p_id,
						exp_id.split("EXP_00")[1], paid_amount,
						amount_received, sup_id, payment_method, bank_id,
						cheque_no, notes, datecreated,
						(String) session.getAttribute("project_id"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (status > 0) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
				out.close();
			}
		}
		if (todo.equals("updateProjectExpense")) {
			String exp_id = request.getParameter("exp_id").split("EXP_00")[1];
			String bill_no = request.getParameter("bill_no");
			String exp_amount = request.getParameter("exp_amount");
			String date = request.getParameter("datecreated");
			String note = request.getParameter("note");
			pdao = new ProjectDAO();
			try {
				status = pdao.updateProjectExpense(exp_id, exp_amount, bill_no,
						date, note);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (status > 0) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
				out.close();
			}
		}
		if (todo.equals("editSupplierPayment")) {
			String p_id = request.getParameter("p_id").split("P_00")[1];
			String paid_amount = request.getParameter("paid_amount");
			String payment_method = request.getParameter("payment_method");
			String cheque_no = request.getParameter("cheque_no");
			if (payment_method.equals("CASH"))
				cheque_no = "";
			String bank_list = request.getParameter("bank_list");
			String note = request.getParameter("notes");
			String datecreated = request.getParameter("datecreated");
			try {
				pdao = new ProjectDAO();
				status = pdao
						.editSupplierPayment(p_id, paid_amount, payment_method,
								cheque_no, bank_list, note, datecreated);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (status > 0) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
				out.close();
			}
		}
		if (todo.equals("editInvestmentRefund")) {
			String rid = request.getParameter("rid").split("RF_00")[1];
			String amount = request.getParameter("amount");
			String note = request.getParameter("note");
			String datecreated = request.getParameter("datecreated");
			String payment_method = request.getParameter("payment_method");
			String cheque_no = request.getParameter("cheque_no");
			String bank_list = request.getParameter("bank_list");
			pdao = new ProjectDAO();
			try {
				status = pdao.editInvestmentRefund(rid, amount, note,
						datecreated, payment_method, cheque_no, bank_list);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (status > 0) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
				out.close();
			}
		}
		if (todo.equals("editmisin")) {
			String rid = request.getParameter("inv_id");
			String amount = request.getParameter("amount");

			String datecreated = request.getParameter("datecreated");
			String payment_method = request.getParameter("payment_method");
			String cheque_no = request.getParameter("cheque_no");
			String bank_list = request.getParameter("bank_list");
			pdao = new ProjectDAO();
			try {
				status = pdao.editInvestmentMisI(rid, amount, datecreated,
						payment_method, cheque_no, bank_list,
						request.getParameter("misid"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (status > 0) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
				out.close();
			}
		}
		if (todo.equals("editmis")) {
			String rid = request.getParameter("inv_id");
			String amount = request.getParameter("amount");

			String datecreated = request.getParameter("datecreated");
			String payment_method = request.getParameter("payment_method");
			String cheque_no = request.getParameter("cheque_no");
			String bank_list = request.getParameter("bank_list");
			pdao = new ProjectDAO();
			try {
				status = pdao.editInvestmentMis(rid, amount, datecreated,
						payment_method, cheque_no, bank_list,
						request.getParameter("misid"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (status > 0) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
				out.close();
			}
		}
		if (todo.equals("addMisIncome")) {
			String inv_id = request.getParameter("inv_id");
			String inv_amount = request.getParameter("amount");
			String date = request.getParameter("datecreated");
			String pm = request.getParameter("payment_method");
			String no = request.getParameter("cheque_no");
			String bank_list = request.getParameter("bank_list");
			pdao = new ProjectDAO();
			status = pdao.addmInvestment(inv_id, inv_amount,
					(String) session.getAttribute("project_id"), date, pm, no,
					bank_list);
			if (status > 0) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
				out.close();
			}
		}
		if (todo.equals("addMisExpense")) {
			String inv_id = request.getParameter("inv_id");
			String inv_amount = request.getParameter("amount");
			String date = request.getParameter("datecreated");
			String pm = request.getParameter("payment_method");
			String no = request.getParameter("cheque_no");
			String bank_list = request.getParameter("bank_list");
			pdao = new ProjectDAO();
			status = pdao.addeInvestment(inv_id, inv_amount,
					(String) session.getAttribute("project_id"), date, pm, no,
					bank_list);
			if (status > 0) {
				response.setStatus(302);
				response.setHeader(
						"Location",
						"projects.jsp?proid="
								+ session.getAttribute("project_id"));
				out.close();
			}
		}
	}

	@Override
	public void init() throws ServletException {
	}
}