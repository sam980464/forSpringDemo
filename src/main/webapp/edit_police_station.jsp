<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

<%
int id=Integer.parseInt(request.getParameter("id"));
PoliceStation policeStation= new PoliceStation();
policeStation.setId(id);
String name=policeStation.getPoliceStationNameById(id);
String address=policeStation.getPoliceStationAddressById(id);



%>


<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Edit Police Station  : <%=name %></h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Police Station Name</span>
							<div>
								<input type="text" value="<%=name %>" name="police_station_name"  required="required">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Address</span>
							<div>
								<input type="text" value="<%=address %>" name="police_station_address" >
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="editPoliceStation"> 
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
