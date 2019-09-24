<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%
OfficeExpensesItem oei= new OfficeExpensesItem();
String itemName=oei.getItemNameById(Integer.parseInt(request.getParameter("id")));
%>
<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Edit Office Expenses Item  :: <b><%=itemName %></b></h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Item Name</span>
							<div>
								<input type="text" value="<%=itemName %>" name="i_name" >
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="editOfficeExpensesItem"> 
					<input type="hidden" name="id" value=<%=request.getParameter("id") %>>
					<button class="btn btn-primary">Update</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
