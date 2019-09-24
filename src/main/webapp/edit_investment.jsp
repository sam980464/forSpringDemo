<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.dao.ProjectDAO"%>
<%
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
%>
<script type="text/javascript" src="resources/js/datetimepicker.js"></script>

<h4 class="widgettitle">Edit Investment Details</h4>
 <form class="stdform stdform2" method="post" action="ProjectServlet">
					<table width="100%" border="1" class="tbl">
					  <tr>
					  <td>
					  <span>Investor ID</span>
					  <div><input type="text" name="inv_id" id="inv_id" class="input-large" value="INV_00<%=request.getParameter("id") %>" readonly="readonly"/></div>
					  </td>
					  <td>
					  <span>Investor Name</span>
					  <%
					  ProjectDAO pdao=new ProjectDAO();
					 String name= pdao.getInvestorName(request.getParameter("id"));
					   %>
					  <div><input type="text" name="name" id="name" class="input-large" value="<%=name %>" readonly="readonly"/></div>
					  </td>
					  </tr>
					  <tr>
						<td>
							<span>Total Invested Amount</span>
							<div>
							 <div><input type="text" name="amount" id="amount" class="input-large" value="<%=request.getParameter("amount") %>" required="required"/></div>
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<span>Promised Refund Amount</span>
							<div>
							<input type="text" name="pro_amount" id="pro_amount" class="" value="<%=request.getParameter("pro_amount") %>" required="required"/>
							</div>
						</td>
					  </tr>
					 					  <tr>
						<td rowspan="2">
						<br>
								<span>Date Created</span>
								<div ><input id="datepicker" type="text" name="datecreated" class="input-small datepicker" value="<%= df.format(new java.util.Date()) %>" required="required" /><a href="javascript:NewCal('datepicker','yyyymmdd')" ><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
						  	<b>(YYYY-MM-DD)</b>
						  	</div>	
						</td>					  
					  </tr>
					</table>		                      
					<p class="stdformbutton">
					<br>
					<br>
						<input type="hidden" name="todo" value="updateInvestment">
						<button class="btn btn-primary">Save</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
                    </form>