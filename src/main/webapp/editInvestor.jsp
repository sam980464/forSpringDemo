<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="com.project.bean.*"%>

<%
String investorid=request.getParameter("investor_id");
Investor investor=new Investor();
ArrayList<InvestorBean> investorList = new ArrayList<InvestorBean>();

%>




<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Edit Investor</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="get" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Investor Name</span>
							<div>
								<input type="text" value="<%=investor.getAllInvestor(investorid).get(0).getInvestor_name() %>" name="investor_name">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Mobile</span>
							<div>
							<input type="text" name="investor_contactno" value="<%=investor.getAllInvestor(investorid).get(0).getInvestor_contactno()%>"/>
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Email Id</span>
							<div>
							<input type="text" name="investor_email_id" value="<%=investor.getAllInvestor(investorid).get(0).getInvestor_email_id()%>"/>
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Address</span>
							<div>
							<input type="text" name="investor_address" value="<%=investor.getAllInvestor(investorid).get(0).getInvestor_address()%>"/>
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Investor Details</span>
							<div>
							<textarea rows="" cols="" name="investor_details"><%=investor.getAllInvestor(investorid).get(0).getInvestor_details()%></textarea>
							</div>
						</td>
					</tr>
					
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="updateInvestor"> 
					<input type="hidden" name="investor_id" value="<%=request.getParameter("investor_id")%>">
					<button class="btn btn-primary">Update</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
