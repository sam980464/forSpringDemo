<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


 <%
Client client=new Client();
%>

                
<h4 class="widgettitle">Estimate For <b><%=client.getClientNameById(Integer.parseInt(request.getParameter("cid"))) %></b> </h4>
<table id="" class="" width="900px">
         <tr>
             <th class="head0">Client Name</th>
             <th class="head1">For Scheme</th>
             <th class="head0">Amount</th>
             <th class="head0">Generated Bill Amount</th>
             <th class="head1">Created By</th>
             <th class="head0">On Date</th>
			<th class="head1">Option</th>
         </tr>
<tbody>
<%
int cid=Integer.parseInt(request.getParameter("cid"));

	ArrayList<EstimateBO> estimateList=null;
	Iterator<EstimateBO> estimateIt;
	EstimateBO estimateItem;
	try{
		Estimate estimate= new Estimate();
		estimateList=estimate.getAllItem(cid);
		
		if(estimateList != null){
			estimateIt = estimateList.iterator();
			while(estimateIt.hasNext()){
				estimateItem = (EstimateBO)estimateIt.next();
%>
                    
                        <tr class="gradeX">
                            <td>
                            	<% Client clientname= new Client(); %>
                            	<%=clientname.getClientNameById(estimateItem.getClientId())%>
                            </td>
                            <td>
	                            <% Scheme scheme= new Scheme(); %>
	                            <%=scheme.getSchemeNameById(estimateItem.getSchemeId())%>
                            </td>
                            <td>
                               	<%
								Payment payment= new Payment();
								Double due=payment.getDueByEstimateId(estimateItem.getId());
								%>
                            
                            <%=String.format("%.2f", estimateItem.getAmount()) %>
                            [Due :<%=String.format("%.2f", due) %>]
                            
                            </td>
                            <%
                             Double generatedBillAmount = estimateItem.getAmount() - due;
                            %>
                            <td>
                            <%=String.format("%.2f", generatedBillAmount) %>	
                            </td>
                            <td>
                            	<% User user= new User(); %>
                            	<%=user.getLoginUserName(estimateItem.getCreatedBy()) %>
                            </td>
                            <td>
                            	<%=estimateItem.getDateCreated()%>

                            </td>
							<td><b>
								<a href="edit_estimate.jsp?eid=<%=estimateItem.getId()%>" class="color cboxElement">Edit<!-- <img src="resources/images/edit.png" /> --></a> | 
								<a Title="Delete Estimate" href="ActionServlet?todo=deleteEstimate&id=<%=estimateItem.getId()%>"  onclick="return confirm('Are you sure?');"> Delete <!-- <img src="resources/images/delete.png" />  --></a>  | 
								<a Title="Payment" href="get_payment.jsp?cid=<%=estimateItem.getClientId() %>&estimateid=<%=estimateItem.getId()%>&edate=<%=estimateItem.getDateCreated() %>" class="color cboxElement">Payment<!-- <img src="resources/images/money.png" /> --></a> | 
								<a Title="Print" href="estimation_received.jsp?cid=<%=estimateItem.getClientId() %>&eid=<%=estimateItem.getId()%>" target="_blank">Print</a>
								</b>
							</td>
                        </tr>
<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>  
  
                        
                    </tbody>
                </table>
                