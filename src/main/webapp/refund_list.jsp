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
             <th class="head0">Refund ID</th>
             <th class="head0">Investor Name</th>
             <th class="head0">Promised Refunded Amount</th>
             <th class="head1">Refunded Amount</th>
             <th class="head1">Payment Method</th>
             <th class="head1">Cheque Number </th>
             <th class="head1">Refunded Against</th>
             <th class="head0">On Date</th>
			<th class="head1">Option</th>
         </tr>
<tbody>
<%
 ProjectDAO pdao=new ProjectDAO();
 ArrayList<ArrayList<String>> investmentdetails= pdao.getRefundBreakUp(proid);
 for(int i=0;i<investmentdetails.size();i++){
 %>
                        <tr class="gradeX">
                         <td>
                           RF_00<%=investmentdetails.get(i).get(0) %>                      
                         </td>
                            <td>
                              <%=investmentdetails.get(i).get(2) %> 	
                            </td>
                            <td>
                              <%=investmentdetails.get(i).get(6) %> 	
                            </td>
                           
                            <td>
	                            <%=investmentdetails.get(i).get(3) %>
                            </td>
                             <td>
                              <%=investmentdetails.get(i).get(7) %> 	
                            </td>
                            <td>
                              <%=investmentdetails.get(i).get(8) %> 	
                            </td>
                            <td>
                              INV_00<%=investmentdetails.get(i).get(1) %>[Rs.:<%=investmentdetails.get(i).get(4) %>]
                            </td>
                            
                            <td>
                            <%=investmentdetails.get(i).get(5) %>
                            </td>
							<td><b>
								<a Title="Edit" class="color cboxElement" href="edit_project_refund.jsp?rid=<%=investmentdetails.get(i).get(0) %>&amount=<%=investmentdetails.get(i).get(3)%>&date=<%=investmentdetails.get(i).get(5)%>&pm=<%=investmentdetails.get(i).get(7)%>&no=<%=investmentdetails.get(i).get(8)%>&bi=<%=investmentdetails.get(i).get(9)%>" target="_blank"><b>Edit</b></a>
								</b>
							</td>
                        </tr>
  <%} %>
                    </tbody>
                </table>
                