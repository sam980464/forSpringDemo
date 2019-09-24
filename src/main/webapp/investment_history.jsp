<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="java.util.*"%>
 <%
String proid=request.getParameter("proid"); 
%>             
<h4 class="widgettitle">Refund List<b></b> </h4>
<table id="" class="" width="900px">
         <tr>
             <th class="head0">Investment ID</th>
             <th class="head0">Invested Amount</th>
             <th class="head0">Payment Method</th>
             <th class="head0">CHEQUE No </th>
             <th class="head0">Promised Refunded Amount</th>
             <th class="head0">On Date</th>
			 <th class="head1">Option</th>
         </tr>
<tbody>
<%
 ProjectDAO pdao=new ProjectDAO();
 ArrayList<ArrayList<String>> investmentdetails= pdao.getInvestmentBreakUp(request.getParameter("id"),session.getAttribute("project_id").toString());
 for(int i=0;i<investmentdetails.size();i++){
 %>
                        <tr class="gradeX">
                         <td>
                           <b>INVST_00<%=investmentdetails.get(i).get(0) %></b>                      
                         </td>
                            <td>
                              <%=investmentdetails.get(i).get(1) %> 	
                            </td>
                            <td>
                              <%=investmentdetails.get(i).get(4) %> 	
                            </td>
                            <td>
                              <%=investmentdetails.get(i).get(5) %> 	
                            </td>
                            <td>
                              <%=investmentdetails.get(i).get(2) %> 	
                            </td>
                            <td>
	                            <%=investmentdetails.get(i).get(3) %>
                            </td>               
                            <td><b>
								<a Title="Edit" class="color cboxElement" href="edit_investment_unit.jsp?id=<%=investmentdetails.get(i).get(0) %>&amount=<%=investmentdetails.get(i).get(1)%>&pro_amount=<%=investmentdetails.get(i).get(2)%>&date=<%=investmentdetails.get(i).get(3) %>&pm=<%=investmentdetails.get(i).get(4) %>&no=<%=investmentdetails.get(i).get(5) %>&bi=<%=investmentdetails.get(i).get(6) %>" target="_blank"><b>Edit</b></a>
								</b>
							</td>
                        </tr>
  <%} %>
                    </tbody>
                </table>
                