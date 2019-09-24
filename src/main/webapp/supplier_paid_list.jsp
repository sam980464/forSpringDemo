<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

<%
Client client= new Client();
%>
                <div class="row-fluid">
                    <div class="widgetbox">
                <h4 class="widgettitle">Supplier Paid List For <b><%=client.getClientNameById(Integer.parseInt(request.getParameter("cid"))) %></b></h4>
                <div class="widgetcontent nopadding">
                    
					<table width="1000px" border="1" class="tbl">
					  <tr>
					  	
					  	<th>
							Date
						</th>
						<th>
							Expensed Amount
						</th>
					  	<th>
							Amount Received
						</th>
						<th>
							Payment Method
						</th>
						<th>Bank</th>
						<th>
							Received By
						</th>
						<th>
							Option
						</th>
					  </tr>
					  
<%
	int cid=Integer.parseInt(request.getParameter("cid"));
	ArrayList<ExpensesPaymentBO> expensesPaymentList=null;
	Iterator<ExpensesPaymentBO> expensesPaymentIt;
	ExpensesPaymentBO expensesPaymentBO;
	try{
		ExpensesPayment expensesPayment= new ExpensesPayment();
		expensesPaymentList=expensesPayment.getAllItem(cid);
		
		if(expensesPaymentList != null){
			expensesPaymentIt = expensesPaymentList.iterator();
			while(expensesPaymentIt.hasNext()){
				expensesPaymentBO = (ExpensesPaymentBO)expensesPaymentIt.next();
%>					  
					  <tr>
					  	<td>
						<%
						String string1=expensesPaymentBO.getDateTime();
						String[] str1 = string1.split(" ");
						%>
					  	<%=str1[0] %>
					  	</td>
					  	<td>
					  <%=	 expensesPaymentBO.getTotal_amount()%>
					  	</td>
					  	<td>
	                    <%=String.format("%.2f", expensesPaymentBO.getAmountReceived()) %>
						</td>
						<td>
							<%=expensesPaymentBO.getPaymentMethod() %>
						</td>
						<td>
						<%
						if(expensesPaymentBO.getPaymentMethod().equals("CHEQUE")){
						Bank bank = new Bank();
						%>
						<%=expensesPaymentBO.getChequeNo() %>   [<%=bank.getBankNameWithAddressById(expensesPaymentBO.getBankId()) %>]
						<%} %>
						</td>
						<td>
						<%
						User user= new User();
						
						%>
							<%=user.getLoginUserName(expensesPaymentBO.getReceivedBy()) %>
						</td>
						<td><b>
						<a href="payment_to_supplier_edit.jsp?cid=<%=request.getParameter("cid") %>&payment_id=<%=expensesPaymentBO.getId()%>" class="color cboxElement">Edit<!-- <img src="resources/images/edit.png" /> --></a> |
						<a href="ActionServlet?todo=deletePaidToSupplier&cid=<%=request.getParameter("cid") %>&paidId=<%=expensesPaymentBO.getId()%>"  onclick="return confirm('Are you sure?');">Delete<!-- <img src="resources/images/delete.png" /> --></a> 
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

					</table>		                      
					
                    </form>
                </div><!--widgetcontent-->
            </div>
                </div><!--row-fluid-->
                