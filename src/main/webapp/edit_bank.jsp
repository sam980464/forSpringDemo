<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

<%
int bank_id=Integer.parseInt(request.getParameter("bank_id"));
Bank bank= new Bank();
%>




<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Edit Bank</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Bank Name</span>
							<div>
								<input type="text" value="<%=bank.getBankNameById(bank_id) %>" name="bank_name">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Address</span>
							<div>
							<textarea rows="" cols="" name="bank_address"><%=bank.getBankAddressById(bank_id)%></textarea>
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="updateBank"> 
					<input type="hidden" name="bank_id" value="<%=request.getParameter("bank_id")%>">
					<button class="btn btn-primary">Update</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
