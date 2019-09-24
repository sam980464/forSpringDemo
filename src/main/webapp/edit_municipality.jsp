<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

<%
Municipality municipality= new Municipality();
%>


<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Edit Municipality : <b><%=municipality.getMunicipalityNameById(Integer.parseInt(request.getParameter("id"))) %></b></h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Municipality Name</span>
							<div>
								<input type="text"  name="m_name" value="<%=municipality.getMunicipalityNameById(Integer.parseInt(request.getParameter("id"))) %>">
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="editMunicipality"> 
					<%-- <input type="hidden" name="userid" value='<%=session.getAttribute("id")%>'> --%>
					<input type="hidden" value="<%=request.getParameter("id")%>" name="id"> 
					<button class="btn btn-primary">Update</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
