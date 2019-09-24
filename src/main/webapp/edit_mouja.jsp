<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%
Mouja mouja= new Mouja();
%>
<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Edit Mouja  :  <%=mouja.getMoujaNameById(Integer.parseInt(request.getParameter("id")))%></h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Mouja Name</span>
							<div>
								<input type="text" name="mouja_name" required="required" value="<%=mouja.getMoujaNameById(Integer.parseInt(request.getParameter("id")))%>">
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="editMouja">
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
