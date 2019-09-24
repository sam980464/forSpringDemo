<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

<%
Client client= new Client();
%>
                <div class="row-fluid">
                    <div class="widgetbox">
                <h4 class="widgettitle">Expenses List For <b><%=client.getClientNameById(Integer.parseInt(request.getParameter("cid"))) %></b></h4>
                <div class="widgetcontent nopadding">
                    
					<table width="1000px" border="1" class="tbl">
					  <tr>
					  	<th>Bill NO</th>
					  	<th>
							Date
						</th>
					  	<th>
							For Estimate
						</th>
					<!-- 	<th>
							For Scheme
						</th> -->
						<th>
							To Supplier
						</th>
						<th>
							Expenses Amount
						</th>
						
						<th>
							Option
						</th>
					  </tr>
					  
<%
	int cid=Integer.parseInt(request.getParameter("cid"));
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
                        Scheme scheme= new Scheme();
                       %>					  
					  <tr>
					  	<td><a href="order_more_for_same_bill.jsp?cid=<%=request.getParameter("cid")%>&billno=<%=expensesBO.getBillNumber() %>&supplier_id=<%=expensesBO.getSupplierId() %>&eid=<%=expensesBO.getEstimateId()%>&date=<%=expensesBO.getExpDate() %>&sid=<%=scheme.getSchemeNameByEstimateId(expensesBO.getEstimateId()).split(":")[0] %>"><%=expensesBO.getBillNumber() %></a></td>
					  	<td>
					  	<%=expensesBO.getExpDate() %>
					  	</td>
					  	<td>
					  	
	                    <%=scheme.getSchemeNameByEstimateId(expensesBO.getEstimateId()) %>
						</td>
						<%-- <td>
						<%=scheme.getSchemeNameById(expensesBO.getSchemeId())%>
						</td> --%>
						<td>
						<%
						Supplier supplier= new Supplier();
						%>
							<%=supplier.getSupplierNameById(expensesBO.getSupplierId()) %>
						</td>
						<td>
							<%=String.format("%.2f", expensesBO.getTotalAmount()) %>
						</td>
						
						<td><b>
						
						<a href="ActionServlet?todo=deleteBill&billno=<%=expensesBO.getBillNumber() %>&cid=<%=cid %>"  onclick="return confirm('Are you sure?');">Delete<!-- <img src="resources/images/delete.png" /> --></a>
						
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
                