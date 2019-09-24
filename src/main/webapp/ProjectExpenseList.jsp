<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="java.util.*"%>
 <%
String proid=request.getParameter("proid"); 
%>             
<h4 class="widgettitle"><b>Project Expense List</b></h4>
<table id="" class="" width="900px">
         <tr>
             <th class="head0">Bill No</th>
             <th></th>
             <th class="head0">Expense ID</th>
             <th class="head1">Expensed For</th>
             <th class="head0">Supplier Name</th>
             <th class="head1">Expensed Amount</th>
             <th class="head1">Total Paid Amount</th>
             <th class="head0">Expensed Date</th>
			<th class="head1">Option</th>
         </tr>
<tbody>
<%
 ProjectDAO pdao=new ProjectDAO();
 ArrayList<ArrayList<String>> expenseDetails= pdao.getExpensePaymentList(proid);
 for(int i=0;i<expenseDetails.size();i++){
 %>
                        <tr class="gradeX">
                            <td>
                          <a href="addExpenseWithBill.jsp?sup_id=<%=expenseDetails.get(i).get(7) %>&bill_no=<%=expenseDetails.get(i).get(0) %>"><%=expenseDetails.get(i).get(0) %></a> 	
                            </td>
                            <td></td>
                         <td>
                          <a href="editProjectExpense.jsp?exp_id=<%=expenseDetails.get(i).get(1) %>&exp_amount=<%=expenseDetails.get(i).get(3) %>&bill_no=<%=expenseDetails.get(i).get(0) %>&sup_id=<%=expenseDetails.get(i).get(7) %>&unit=<%=expenseDetails.get(i).get(9) %>&quan=<%=expenseDetails.get(i).get(10) %>&paidamnt=<%= expenseDetails.get(i).get(4)%>" class="color cboxElement"><!-- <img src="resources/images/edit.png" /> -->EXP_00<%=expenseDetails.get(i).get(1) %></a>                     
                         </td>
                         <td><%=expenseDetails.get(i).get(11) %></td>
                            <td>
                              <%=expenseDetails.get(i).get(2) %> 	
                            </td>
                            <td>
	                          <%=expenseDetails.get(i).get(3) %>
                            </td>
                            <td>
                              <%=expenseDetails.get(i).get(4) %>[Due: <%=Long.parseLong(expenseDetails.get(i).get(3))-Long.parseLong(expenseDetails.get(i).get(4)) %>]
                            </td>
                            <td>
                            <%=expenseDetails.get(i).get(5) %>
                            </td>
                           <!--  <td>
                            <%=expenseDetails.get(i).get(6) %>
                            </td>
                             -->
							<td>
							<b> 
								<a Title="Payment" href="ProjectSupplierPayment.jsp?exp_id=<%=expenseDetails.get(i).get(1) %>&sup_id=<%=expenseDetails.get(i).get(7) %>&exp_amount=<%=expenseDetails.get(i).get(3) %>&total_amount=<%=expenseDetails.get(i).get(4) %>&due_amount=<%=Long.parseLong(expenseDetails.get(i).get(3))-Long.parseLong(expenseDetails.get(i).get(4)) %>&bill_no=<%=expenseDetails.get(i).get(0) %>&p_id=<%=expenseDetails.get(i).get(6)%>" class="color cboxElement">Pay</a> | 
								<a Title="Payment History" href="ProjectSupplierPaymentHistory.jsp?exp_id=<%=expenseDetails.get(i).get(1) %>" class="color cboxElement">History</a> 
							</b>
							</td>
                        </tr>
  <%} %>
                    </tbody> 
                </table>