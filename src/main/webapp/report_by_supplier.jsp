<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@ include file="common/head.jsp" %>

<div class="rightpanel">
<ul class="breadcrumbs">
  <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
  <li>Report By Supplier</li>
</ul>

  <input type="submit" value="Export" class=" btn"  style="display: table; float: right; margin: 8px;" onclick="tableToExcel('exportCSV', 'export Table')" >

<div class="widget" id="client_not_selected">
  <h4 class="widgettitle">Search Result</h4>
  <div class="widgetcontent">
    <table id="exportCSV" class="table table-bordered responsive">
      <colgroup>
      <col class="con0" style="align: center; width: 4%" />
      <col class="con1" />
      <col class="con0" />
      <col class="con1" />
      <col class="con0" />
      </colgroup>
      <thead>
        <tr>
          <th class="head0 nosort"></th>
          <th class="head0">No.</th>
          <th class="head0">Supplier Name</th>
          <th class="head1">Details</th>
        </tr>
      </thead>


<%
int i=1;
double paid_amount=0.0;
Client client=new Client();
ExpensesPayment ep= new ExpensesPayment();
	ArrayList<SupplierBO> supplierList=null;
	Iterator<SupplierBO> supplierIt;
	SupplierBO supplierItem;
	try{
		Supplier supplier= new Supplier();
		
		if(request.getParameter("id")==null)
		{
		supplierList=supplier.getAllItem();
		}
		else{
			supplierList=supplier.getAllItembySupplierid(Integer.parseInt(request.getParameter("id")));
		}
		if(supplierList != null){
			supplierIt = supplierList.iterator();
			while(supplierIt.hasNext()){
				supplierItem = (SupplierBO)supplierIt.next();
%>	
      
      <tr>
        <td class="aligncenter"></td>
        <td><%=i %></td>
        <td><a href="report_by_supplier.jsp?id=<%=supplierItem.getId() %>"><%=supplierItem.getSupplierName() %></a></td>
        <td>
			<table>
				<tr>
					<th class="head0 nosort"></th>
					<th>Client Name</th>
					<th>Amount Estimated</th>
					<th>Amount Paid</th>
					<th>Amount Due</th>
				</tr>
				
		<%
		
			ArrayList<SupplierBO> supplierList2=null;
			Iterator<SupplierBO> supplierIt2;
			SupplierBO supplierItem2;
			try{
				Supplier supplier2= new Supplier();
				supplierList2=supplier2.getClientWiseExpensesBySupplier(supplierItem.getId());
				
				if(supplierList2 != null){
					supplierIt2 = supplierList2.iterator();
					while(supplierIt2.hasNext()){
						supplierItem2 = (SupplierBO)supplierIt2.next();
		%>				
					
					<tr>
						<td class="aligncenter"></td>
						<td><%=client.getClientNameById(supplierItem2.getClient_id()) %></td>
						<td><%=supplierItem2.getAmount() %></td>
						<td>
						<% paid_amount=ep.getTotalPaidBySupplierAndClient(supplierItem.getId(),supplierItem2.getClient_id()); %>
						<%= paid_amount %>
						
						</td>
						<td><%=supplierItem2.getAmount()-paid_amount %></td>
					</tr>
					
		<%
		
			}
		}}
		catch(Exception e){
			
			e.printStackTrace();
		}
		%>				
				
			</table>
		</td>
      </tr>
      
<%
	i++;
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%> 


      
    </table>
  </div>
  <!--widgetcontent-->
</div>
<div class="amountdue">
  <h1><span><b>Total Estimate: </b></span></h1>
  <br />
</div>
<%@ include file="common/foot.jsp" %>
