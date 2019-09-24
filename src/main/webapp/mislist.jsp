<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="java.util.*"%>
 <%
String proid=request.getParameter("proid"); 
%>             
<h4 class="widgettitle">Miscellaneous Income List<b></b> </h4>
<table id="" class="" width="900px">
         <tr>
             <th class="head0">Item Name</th>
             <th class="head0">Amount</th>
             <th class="head0">On Date</th>
             <th class="head1">Payment Method</th>
             <th class="head1">Cheque Number </th>
            <th class="head1">Option</th>
         </tr>
<tbody>
<%
 ProjectDAO pdao=new ProjectDAO();
 ArrayList<ArrayList<String>> investmentdetails= pdao.getMisIList(proid);
 for(int i=0;i<investmentdetails.size();i++){
 %>
                        <tr class="gradeX">
                         <td>
                           <%=investmentdetails.get(i).get(0) %>                      
                         </td>
                            <td>
                              <%=investmentdetails.get(i).get(1) %> 	
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
								<a Title="Edit" class="color cboxElement" href="editmisInc.jsp?amount=<%=investmentdetails.get(i).get(1)%>&date=<%=investmentdetails.get(i).get(5)%>&pm=<%=investmentdetails.get(i).get(2)%>&no=<%=investmentdetails.get(i).get(3)%>&bi=<%=investmentdetails.get(i).get(4)%>&promis=<%=investmentdetails.get(i).get(7)%>&misid=<%=investmentdetails.get(i).get(6)%>" target="_blank"><b>Edit</b></a>
								</b>
							</td>
                        </tr>
  <%} %>
                    </tbody>
                </table>
                