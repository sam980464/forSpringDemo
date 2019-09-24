<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Payment Due Status for Supplier Id <%=request.getParameter("supplier_id") %></h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="800px" border="1" class="tbl">
				<tr>
					<th>Expenses Id</th>
					<th>Estimate Id</th>
					<th>Client Name</th>
					<th>Scheme Name</th>
					<th>Bill Number</th>
					<th>Amount Billed</th>
					<th>Due Payment</th>
				</tr>
<%
	int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
	ArrayList<ExpensesBO> expensesList=null;
	Iterator<ExpensesBO> expIt;
	ExpensesBO expensesBO;
	try{
		Expenses expenses= new Expenses();
		expensesList=expenses.getAllItemBySupplierId(supplier_id);
		
		if(expensesList != null){
			expIt = expensesList.iterator();
			while(expIt.hasNext()){
				expensesBO = (ExpensesBO)expIt.next();
%>

				
				<tr>
					<td><%=expensesBO.getId()%></td>
					<td><%=expensesBO.getEstimateId() %></td>
					<td>
					<%
					Client client = new Client();
					%>
					<%=client.getClientNameById(expensesBO.getClientId()) %>
					</td>
					<td>
					<%
					Scheme scheme= new Scheme();
					%>
					<%=scheme.getSchemeNameByEstimateId(expensesBO.getEstimateId()) %>
					</td>
					<td><%=expensesBO.getBillNumber() %></td>
					<td><%=expensesBO.getTotalAmount() %></td>
					<td>
					<%
					ExpensesPayment exp_payment= new ExpensesPayment();
					double paid=exp_payment.getPaidAmountForExp(expensesBO.getId());
					%>
					<%=expensesBO.getTotalAmount()-paid %>
					</td>
				</tr>

<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%> 
				
				</table>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
