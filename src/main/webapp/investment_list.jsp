<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="java.util.*"%>
 <%
String proid=request.getParameter("proid"); 
%>             
<h4 class="widgettitle">Investment List <b></b> </h4>
<table id="" class="" width="900px">
         <tr>
             <th class="head0">Investor ID</th>
             <th class="head0">Investor Name</th>
             <th class="head1">Invested Amount</th>
             <th class="head1">Already Refunded</th>
             <th class="head0">Refund Due</th>
             <th class="head0">Promised Refund</th>
             <th class="head0">On Date</th>
			<th class="head1">Option</th>
         </tr>
<tbody>
<%
 ProjectDAO pdao=new ProjectDAO();
 ArrayList<ArrayList<String>> investmentdetails= pdao.getInvestmentList(proid);
 for(int i=0;i<investmentdetails.size();i++){
 %>
                        <tr class="gradeX">
                         <td>
                           INV_00<%=investmentdetails.get(i).get(0) %>                      
                         </td>
                            <td>
                              <%=investmentdetails.get(i).get(1) %> 	
                            </td>
                            <td>
	                            <%=investmentdetails.get(i).get(2) %>
                            </td>
                            <td>
                              <%=investmentdetails.get(i).get(3) %>
                            </td>
                            <td>
                            <%=Long.parseLong(investmentdetails.get(i).get(4))-Long.parseLong(investmentdetails.get(i).get(3)) %>
                            </td>
                            <td>
                            <%=investmentdetails.get(i).get(4) %>
                            </td>
                            <td>
                            <%=investmentdetails.get(i).get(5) %>
                            </td>
							<td><b>
							<a Title="add" href="append_investment.jsp?id=<%=investmentdetails.get(i).get(0) %>&amount=<%=investmentdetails.get(i).get(2) %>&pro_amount=<%=investmentdetails.get(i).get(4) %>" class="color cboxElement">Add<!--<img width="15" height="12" src="resources/images/edit.png" /> --> </a> |
								<a Title="Investment History" href="investment_history.jsp?id=<%=investmentdetails.get(i).get(0) %>" class="color cboxElement">Investment History<!-- <img src="resources/images/money.png" /> --></a>|
								<a Title="Refund" href="investment_refund.jsp?id=<%=investmentdetails.get(i).get(0) %>&amount=<%=investmentdetails.get(i).get(2) %>&pro_amount=<%=investmentdetails.get(i).get(4) %>&total_amount=<%=investmentdetails.get(i).get(3) %>&due_amount=<%=Long.parseLong(investmentdetails.get(i).get(4))-Long.parseLong(investmentdetails.get(i).get(3)) %>" class="color cboxElement">Refund<!-- <img src="resources/images/money.png" /> --></a>
								</b>
							</td>
                        </tr>
  <%} %>
                        
                    </tbody>
                </table>
                