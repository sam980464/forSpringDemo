<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%
Service service= new Service();
%>

<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Add New Supplier  For Service :: <b><%=service.getServiceNameById(Integer.parseInt(request.getParameter("service_id")))  %></b> </h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Company Name</span>
							<div>
								<input type="text" value="" name="company_name">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Address</span>
							<div>
								<input type="text" value="" name="addr">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Phone</span>
							<div>
								<input type="text" value="" name="phn">
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addNewSupplier"> 
					<input type="hidden" name="service_id" value="<%=request.getParameter("service_id") %>" >
					<input type="hidden" name="userid" value="<%=session.getAttribute("id")%>">
					<input type="hidden" name="scheme_id" value="<%=request.getParameter("scheme_id") %>" >
					<button class="btn btn-primary">Add</button>
					<button type="reset" class="btn">Reset Button</button>
					
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>


	<div class="widgetbox">
		<h4 class="widgettitle">Supplier List For Service :: <b><%=service.getServiceNameById(Integer.parseInt(request.getParameter("service_id")))  %></b> </h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="900px" border="1" class="tbl">
					<tr>
						<td><span>Company Name</span></td>
						<td><span>Address</span></td>
						<td><span>Phone Number</span></td>
						<td><span>Option</span></td>
					</tr>
<%
	ArrayList<SupplierBO> supplierList=null;
	Iterator<SupplierBO> supplierIt;
	SupplierBO supplierItem;
	try{
		Supplier supplier= new Supplier();
		supplierList=supplier.getAllItem(Integer.parseInt(request.getParameter("service_id")));
		
		if(supplierList != null){
			supplierIt = supplierList.iterator();
			while(supplierIt.hasNext()){
				supplierItem = (SupplierBO)supplierIt.next();
%>					
					<tr>
						<td>
						<%=supplierItem.getSupplierName() %>
						</td>
						<td><%=supplierItem.getAddress() %></td>
						<td><%=supplierItem.getPhone() %></td>
						<td><b>
						<a class="color cboxElement" href="edit_supplier.jsp?supplier_id=<%=supplierItem.getId() %>">Edit</a> |
						<a class="color cboxElement" href="allDue.jsp?supplier_id=<%=supplierItem.getId() %>">Payment Status</a> |
						 Delete
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
		</div>


</div>
<!--row-fluid-->
