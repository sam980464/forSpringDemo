<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<%
int id=Integer.parseInt(request.getParameter("id"));
District district= new District();
String district_name=district.getDistrictNameById(id);
%>



<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Edit District  :<%=district_name %></h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>District Name</span>
							<div>
								<input type="text" value="<%=district_name %>" name="district_name" required="required">
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="editDistrict"> 
					<input type="hidden" name="id" value="<%= request.getParameter("id") %>">
					<button class="btn btn-primary">Update</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
