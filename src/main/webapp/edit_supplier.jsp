<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<%
int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));

Supplier supplier= new Supplier();



%>



<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Edit Supplier</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Company Name</span>
							<div>
								<input type="text" value="<%=supplier.getSupplierNameById(supplier_id) %>" name="company_name">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Address</span>
							<div>
							<textarea rows="" cols="" name="addr"><%=supplier.getSupplierAddressById(supplier_id) %></textarea>
							</div>
						</td>
					</tr>
					<td><span>Phone</span>
							<div>
								<input type="text" value="<%=supplier.getSupplierPhoneById(supplier_id) %>" name="phn">
							</div>
						</td>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="updateSupplier"> 
					<input type="hidden" name="supplier_id" value="<%=request.getParameter("supplier_id")%>">
					<input type="hidden" name="scheme_id" value="<%=request.getParameter("scheme_id")%>">
					<button class="btn btn-primary">Update</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
