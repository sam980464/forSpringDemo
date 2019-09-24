<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


   
<%
int cid= Integer.parseInt(request.getParameter("cid"));
int eid= 0;
double totalpaid=0.0;
double estimatedAmount=0.0;
double receivedTotal=0.0;
if (request.getParameter("eid")!=null){
eid=Integer.parseInt(request.getParameter("eid"));
}

Client client= new Client();
String client_name=client.getClientNameById(cid);
String client_address=client.getClientAddressById(cid);
%>

     
		 
		 
       <div class="row-fluid">
	<div class="widgetbox">           
            

<h4 class="widgettitle">Estimate Summary</h4>
<div class="widgetcontent nopadding">
            <table class="table table-bordered tbl">
               <!--  <colgroup>
                    <col class="con0 width5" />
                    <col class="con1 width5" />
                    <col class="con0 width10" />
                    <col class="con1 width5" />
                    <col class="con0 width20" />
                    <col class="con1 width5" />
                </colgroup> -->
                <thead>
                    <tr>
                        <th class="head0">Date</th>
                        <th class="head1">Estimate Id</th>
                        <th class="head0">For Scheme</th>
                        <th class="head1">Estimated Amount</th>
                        <th class="head0">Amount Received</th>
                         <th class="head0">Estimated By</th>
                    </tr>
                </thead>
                <tbody>
<%
	ArrayList<EstimateBO> estimateList=null;
	Iterator<EstimateBO> estimateIt;
	EstimateBO estimateItem;
	try{
		Estimate estimate= new Estimate();
		
		if(eid<=0){
			estimateList=estimate.getAllItem(cid);
		}
		else{
			estimateList=estimate.getAllItemByEid(eid);
		}
		if(estimateList != null){
			estimateIt = estimateList.iterator();
			while(estimateIt.hasNext()){
				estimateItem = (EstimateBO)estimateIt.next();
				estimatedAmount=estimateItem.getAmount();
%>                
                    <tr>
                        <td><%= estimateItem.getDateCreated()%></td>
                        <td>
						<a href="account_summary_by_eid.jsp?cid=<%=request.getParameter("cid") %>&eid=<%= estimateItem.getId()%>">
						<%= estimateItem.getId()%>
						</a>
						</td>
                        <td class="right">
						<% Scheme scheme= new Scheme(); %>
	                    <%=scheme.getSchemeNameById(estimateItem.getSchemeId())%>
						</td>
                        <td class="right">
						<%=String.format("%.2f", estimateItem.getAmount()) %>
						</td>
                        
                        
                        <td class="right">
                        
                        <table width=100%>
                        	<tr>
	                        	<th>Date Received</th>
	                        	<th>Amount</th>
	                        	<th>Received By</th>
                        	</tr>
<%
	receivedTotal=0.0;
	ArrayList<PaymentBO> paymentList=null;
	Iterator<PaymentBO> paymantIt;
	PaymentBO paymentItem;
	try{
		Payment payment= new Payment();
		paymentList=payment.getAllItemByEId(estimateItem.getId());
		
		if(paymentList != null){
			paymantIt = paymentList.iterator();
			while(paymantIt.hasNext()){
				paymentItem = (PaymentBO)paymantIt.next();
				receivedTotal=receivedTotal+paymentItem.getAmountReceived();
%>                        	
                        	<tr>
	                        	<td><%=paymentItem.getDateReceived() %></td>
	                        	<td> <%=String.format("%.2f", paymentItem.getAmountReceived())%></td>
	                        	<td>
	                        	<% User user= new User(); %>
                        		<%=user.getLoginUserName(paymentItem.getReceivedBy()) %>
	                        	</td>
                        	</tr>

<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>
             <tr>
             	<td><b>Total</b></td>
             	<td><%=String.format("%.2f", receivedTotal)%></td>
             	<td></td>
             </tr>
             <tr>
             	<td><b>Due</b></td>
             	<td><%=String.format("%.2f", estimateItem.getAmount()-receivedTotal)%></td>
             	<td></td>
             </tr>           	
                        </table>
						</td>
                        
                        
                        <td class="right">
						<% User user= new User(); %>
                        <%=user.getLoginUserName(estimateItem.getCreatedBy()) %>
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
                
<h4 class="widgettitle">Expenses For Client</h4>                
                <table class="table table-bordered tbl">
                <!-- <colgroup>
                    <col class="con0 width5" />
                    <col class="con1 width5" />
                    <col class="con0 width5" />
                    <col class="con1 width5" />
                    <col class="con1 width5" />
                    <col class="con0 width20" />
                    <col class="con1 width5" />
                </colgroup> -->
                <thead>
                    <tr>
                        <th class="head0">Date</th>
                        <th class="head1">For Scheme</th>
                        <th class="head0">Supplier</th>
                        <th class="head1">Bill Number</th>
                        <th class="head0">Amount</th>
                        <th class="head1">Paid Details</th>
                        <th class="head0">Expenses By</th>
                    </tr>
                </thead>
                <tbody>
                
<%
double totalPaidExp=0.0;
	ArrayList<ExpensesBO> expensesList=null;
	Iterator<ExpensesBO> expIt;
	ExpensesBO expensesBO;
	try{
		Expenses expenses= new Expenses();
		
		if(eid<=0){
			expensesList=expenses.getAllItemByCid(cid);
		}
		else{
			expensesList=expenses.getAllItemByEstimateid(eid);
		}
		
		
		if(expensesList != null){
			expIt = expensesList.iterator();
			
			while(expIt.hasNext()){
				expensesBO = (ExpensesBO)expIt.next();
%>	                
                    <tr>
                        <td><%=expensesBO.getExpDate() %></td>
                        
                        <td>
                        <%
                        Scheme scheme= new Scheme();
                        %>
                        <%=scheme.getSchemeNameByEstimateId(expensesBO.getEstimateId()) %>
                        </td>
                        <td>
                        <%
                        Supplier supplier=  new Supplier();
                        %>
                        <%=supplier.getSupplierNameById(expensesBO.getSupplierId()) %><br>[ <%=supplier.getSupplierAddressById(expensesBO.getSupplierId()) %>]
                        </td>
                        <td class="right"><%=expensesBO.getBillNumber() %></td>
                        <td class="right"><b><%=String.format("%.2f", expensesBO.getTotalAmount())%></b>   <br><%-- [<%=expensesBO.getUnitPrice() %>X <%=expensesBO.getQty() %>] --%></td>
                        
                        <td class="">
                        
                        
                                               
                        <table width=100%>
                        <tr>
                        	<th>Date Paid</th>
                        	<th>Amount</th>
                        	<th>Paid By</th>
                        </tr>
                        
<%
	
totalpaid=0.0;
	ArrayList<ExpensesPaymentBO> expensesPaymentList=null;
	Iterator<ExpensesPaymentBO> expensesPaymentIt;
	ExpensesPaymentBO expensesPaymentBO;
	try{
		ExpensesPayment expensesPayment= new ExpensesPayment();
		expensesPaymentList=expensesPayment.getAllItemByExpensesId(expensesBO.getId());
		
		if(expensesPaymentList != null){
			expensesPaymentIt = expensesPaymentList.iterator();
			while(expensesPaymentIt.hasNext()){
				expensesPaymentBO = (ExpensesPaymentBO)expensesPaymentIt.next();
				totalpaid=totalpaid+expensesPaymentBO.getAmountReceived();
				totalPaidExp+=totalpaid;
%>                        
                        <tr>
                        	<td>
                        	<%=expensesPaymentBO.getDateTime() %>
                        	</td>
                        	<td>
                        	<%=String.format("%.2f", expensesPaymentBO.getAmountReceived())%>
                        	</td>
                        	
                        	<td>
                        	<% User user= new User(); %>
                        	<%=user.getLoginUserName(expensesPaymentBO.getReceivedBy()) %>
							
							</td>
                        </tr>
<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>         

					<tr>
						<td><b>Total</b></td>
						<td><%=String.format("%.2f",totalpaid )%></td>
						<td></td>
					</tr>
					<tr>
						<td><b>Due</b></td>
						<td><%=String.format("%.2f", expensesBO.getTotalAmount()-totalpaid)%></td>
						<td></td>
					</tr> 

                
                        </table>
                        </td>
                    
                    <td>
                        <% User user= new User(); %>
                        <%=user.getLoginUserName(expensesBO.getUserId()) %>
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
                

	
		
</div>	
			
</div>
</div>			
        

  