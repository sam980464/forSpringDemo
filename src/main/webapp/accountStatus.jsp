<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<%
Client client= new Client();
%>

<h4 class="widgettitle">Total Account Status For <b><%=client.getClientNameById(Integer.parseInt(request.getParameter("cid"))) %></b></h4>


<table width=900 border=1 class="widgetcontent nopadding">
	<tr>
		<th>
		Amount Received
		</th>
		<th>
		Expenses
		</th>
	</tr>
	
	<tr>
		<td  width=50% >
			<table width=100% border=1>
<%
	int cid= Integer.parseInt(request.getParameter("cid"));
	double receivedTotal=0.0;
	ArrayList<PaymentBO> paymentList=null;
	Iterator<PaymentBO> paymantIt;
	PaymentBO paymentItem;
	try{
		Payment payment= new Payment();
		paymentList=payment.getAllItemByCId(cid);
		
		if(paymentList != null){
			paymantIt = paymentList.iterator();
			while(paymantIt.hasNext()){
				paymentItem = (PaymentBO)paymantIt.next();
				receivedTotal=receivedTotal+paymentItem.getAmountReceived();
%>			
				<tr>
					<td>
					<b><%=paymentItem.getDateReceived() %></b>
					</td>
					<td>
					<%
					Estimate estimate= new Estimate();
					Scheme scheme= new Scheme();
					%>
					<%=scheme.getSchemeNameByEstimateId(paymentItem.getEstimateId()) %>
					</td>
					<td>
					 <%=String.format("%.2f", paymentItem.getAmountReceived())%>
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
				<td>&nbsp;</td>
				<td><b>Total</b></td>
				<td><b><%=String.format("%.2f", receivedTotal) %></b></td>
			</tr>
			</table>
			
		</td>
		<td  width=50% >
			<table width=100% border=1 >
			
<%
	//int cid=Integer.parseInt(request.getParameter("cid"));
	double expTotal=0.0;
	ArrayList<ExpensesBO> expensesList=null;
	Iterator<ExpensesBO> expIt;
	ExpensesBO expensesBO;
	try{
		Expenses expenses= new Expenses();
		expensesList=expenses.getAllItemByCid(cid);
		
		if(expensesList != null){
			expIt = expensesList.iterator();
			while(expIt.hasNext()){
				expensesBO = (ExpensesBO)expIt.next();
				expTotal=expTotal+expensesBO.getTotalAmount();
%>				
				<tr>
					<td>
					<b><%=expensesBO.getExpDate() %></b>
					</td>
					<td>
					<%
					Supplier supplier= new Supplier();
					%>
					<%=supplier.getSupplierNameById(expensesBO.getSupplierId()) %>
					</td>
					<td>
					<%=String.format("%.2f", expensesBO.getTotalAmount()) %>
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
					<td>&nbsp;</td>
					<td><b>Total</b></td>
					<td><b><%=String.format("%.2f", expTotal) %></b></td>
				</tr>
			</table>
		</td>
	</tr>

</table>

<table class="widgetcontent" width=100% border=1 style="border-top:2px solid #D9271D;">
	<tr>
		<td><b>Total Estimate</b> <%
		Estimate estimate = new Estimate();
		%>
		<%=String.format("%.2f", estimate.getTotalEstimateByClientId(cid))%>
		</td>
		<td><b>Total Received</b> <%=String.format("%.2f", receivedTotal) %></td>
		<td><b>Total Due</b> <%=String.format("%.2f", estimate.getTotalEstimateByClientId(cid)-receivedTotal) %></td>
		<td><b>Total Expenses</b> <%=String.format("%.2f", expTotal) %></td>
		<td><b>Total Remains</b> <%=String.format("%.2f", estimate.getTotalEstimateByClientId(cid)-expTotal) %></td>
	</tr>

</table>
