<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="java.util.*"%>
<h4 class="widgettitle"><b>Project Payment List</b></h4>
<table id="" class="" width="900px">
         <tr>
             <th class="head0">Payment ID</th>
             <th class="head1">Paid Amount</th>
             <th class="head0">Date</th>
             <th class="head0">Option</th>
          </tr>
<tbody>
<%
 ProjectDAO pdao=new ProjectDAO();
 ArrayList<ArrayList<String>> payementdetails= pdao.getPaymentBreakUp((String)session.getAttribute("project_id"),request.getParameter("exp_id"));
 for(int i=0;i<payementdetails.size();i++){
 %>
                        <tr class="gradeX">
                            <td>
                              P_00<%=payementdetails.get(i).get(0) %> 	
                            </td>
                            <td>
                              <%=payementdetails.get(i).get(1) %> 	
                            </td>
                            <td>
	                          <%=payementdetails.get(i).get(2) %>
                            </td>
							<td>
							<%if(payementdetails.get(i).get(1).equals("0")){ %> 
							Edit option not available yet.Pay before Edit.
							
							<%}else{ %>
							<a Title="Payment History" href="editProjectSupplierPayment.jsp?p_id=<%=payementdetails.get(i).get(0) %>" class="color cboxElement"><b>Edit</b></a>
							<%} %>
							</td>
                        </tr>
  <%} %>
                    </tbody> 
                </table>